package com.counselor.audit;

import org.aspectj.lang.ProceedingJoinPoint;
import org.springframework.beans.BeanWrapperImpl;
import java.text.SimpleDateFormat;
import java.util.*;
import java.math.BigDecimal;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/** Only explicitly selected identification and business fields enter the audit trail. */
final class OperationDetails {
    private static final Map<String, String> FIELDS = new LinkedHashMap<>();
    static {
        String[][] fields = {
                {"title", "标题"}, {"archiveName", "档案名称"}, {"name", "名称"},
                {"username", "账号"}, {"realName", "姓名"}, {"visitorName", "访客姓名"},
                {"studentName", "学生姓名"}, {"studentNo", "学号"}, {"studentId", "学生编号"},
                {"status", "状态"}, {"employmentStatus", "就业状态"}, {"leaveType", "请假类型"},
                {"startDate", "开始日期"}, {"endDate", "结束日期"}, {"days", "天数"},
                {"type", "类型"}, {"priority", "优先级"}, {"dueDate", "截止日期"},
                {"aidType", "资助类型"}, {"amount", "金额"}, {"semester", "学期"},
                {"archiveType", "档案类型"}, {"level", "级别"}, {"occurDate", "发生日期"},
                {"college", "学院"}, {"major", "专业"}, {"className", "班级"}, {"grade", "年级"},
                {"company", "单位"}, {"position", "岗位"}, {"city", "城市"}, {"school", "学校"},
                {"category", "类别"}, {"meetingDate", "会议日期"}, {"location", "地点"},
                {"visitObject", "来访对象"}, {"visitTime", "来访时间"}, {"leaveTime", "离开时间"},
                {"role", "角色"}, {"counselorId", "辅导员编号"}
        };
        for (String[] field : fields) FIELDS.put(field[0], field[1]);
    }

    record Snapshot(Long id, Map<String, String> fields, boolean found, Map<String, String> fingerprints) { }

    static Snapshot before(ProceedingJoinPoint call) {
        return load(call, id(call));
    }

    static String describe(ProceedingJoinPoint call, Snapshot before, boolean success) {
        String method = call.getSignature().getName();
        Long id = id(call);
        Snapshot after = success && !"deleteById".equals(method) ? load(call, id) : before;
        if (success && Set.of("update", "changeStatus", "updatePassword").contains(method)
                && before.found() && after.found() && before.fingerprints().equals(after.fingerprints())) {
            return null;
        }
        Map<String, String> input = input(call);
        Map<String, String> identity = before.found() ? before.fields()
                : after.found() ? after.fields() : input;
        StringBuilder text = new StringBuilder("记录编号：").append(id == null ? "未生成" : id);
        for (String name : List.of("title", "archiveName", "name", "username", "realName", "visitorName",
                "studentName", "studentNo", "studentId")) {
            if (identity.containsKey(name)) text.append("；").append(FIELDS.get(name)).append("：").append(identity.get(name));
        }
        text.append('\n');
        if (!success) {
            text.append("本次操作未完成，未确认任何变更。");
            if ("changeStatus".equals(method) && call.getArgs().length > 1)
                text.append("尝试设置状态为：").append(value(call.getArgs()[1]));
        } else if ("deleteById".equals(method)) {
            text.append(before.found() ? "已删除；删除前信息：" + summary(before.fields()) : "已删除；未读取到删除前信息。");
        } else if ("updatePassword".equals(method)) {
            text.append("密码已修改（不记录密码内容）。");
        } else if ("save".equals(method)) {
            text.append("新增信息：").append(summary(after.found() ? after.fields() : input));
        } else if (before.found() && after.found()) {
            List<String> changes = new ArrayList<>();
            FIELDS.forEach((field, label) -> {
                String oldValue = before.fields().get(field);
                String newValue = after.fields().get(field);
                if (!Objects.equals(oldValue, newValue))
                    changes.add(label + "：" + Objects.toString(oldValue, "空") + " → " + Objects.toString(newValue, "空"));
            });
            text.append(changes.isEmpty() ? "正文、附件或其他未展示字段已更新（内容不记录）。" : String.join("；", changes));
        } else {
            text.append("操作已完成；未能读取完整变更前后信息。");
        }
        String details = text.toString();
        return details.length() > 4000 ? details.substring(0, 3980) + "…（摘要已截断）" : details;
    }

    private static Snapshot load(ProceedingJoinPoint call, Long id) {
        if (id != null) {
            try {
                Object record = call.getTarget().getClass().getMethod("findById", Long.class).invoke(call.getTarget(), id);
                if (record != null) return new Snapshot(id, fields(record), true, fingerprints(record));
            } catch (ReflectiveOperationException | RuntimeException ignored) {
                // Snapshot lookup must not prevent the original business operation.
            }
        }
        return new Snapshot(id, Map.of(), false, Map.of());
    }

    // Compare full values, including private fields, without persisting their contents.
    private static Map<String, String> fingerprints(Object record) {
        Map<String, String> result = new TreeMap<>();
        var bean = new BeanWrapperImpl(record);
        for (var property : bean.getPropertyDescriptors()) {
            String name = property.getName();
            if (Set.of("class", "createTime").contains(name) || !bean.isReadableProperty(name)) continue;
            Object data = bean.getPropertyValue(name);
            String canonical = data == null ? "null" : "value:" + (data instanceof Date date ? date.getTime()
                    : data instanceof BigDecimal decimal ? decimal.stripTrailingZeros().toPlainString() : data.toString());
            try {
                result.put(name, HexFormat.of().formatHex(MessageDigest.getInstance("SHA-256")
                        .digest(canonical.getBytes(StandardCharsets.UTF_8))));
            } catch (NoSuchAlgorithmException impossible) {
                throw new IllegalStateException(impossible);
            }
        }
        return result;
    }

    private static Long id(ProceedingJoinPoint call) {
        if (call.getArgs().length == 0 || call.getArgs()[0] == null) return null;
        Object first = call.getArgs()[0];
        if (first instanceof Long number) return number;
        var bean = new BeanWrapperImpl(first);
        return bean.isReadableProperty("id") && bean.getPropertyValue("id") instanceof Long number ? number : null;
    }

    private static Map<String, String> input(ProceedingJoinPoint call) {
        if (call.getArgs().length == 0 || call.getArgs()[0] == null || call.getArgs()[0] instanceof Long) return Map.of();
        return fields(call.getArgs()[0]);
    }

    private static Map<String, String> fields(Object record) {
        Map<String, String> result = new LinkedHashMap<>();
        var bean = new BeanWrapperImpl(record);
        FIELDS.forEach((field, label) -> {
            if (bean.isReadableProperty(field)) {
                Object data = bean.getPropertyValue(field);
                if (data != null && !data.toString().isBlank()) result.put(field, value(data));
            }
        });
        return result;
    }

    private static String value(Object value) {
        if (value == null) return "空";
        String text = value instanceof Date date ? new SimpleDateFormat("yyyy-MM-dd HH:mm").format(date) : value.toString();
        text = text.replaceAll("[\\r\\n\\t]", " ");
        return text.length() > 100 ? text.substring(0, 100) + "…" : text;
    }

    private static String summary(Map<String, String> fields) {
        List<String> summary = new ArrayList<>();
        fields.forEach((field, value) -> summary.add(FIELDS.get(field) + "：" + value));
        return summary.isEmpty() ? "暂无可记录的摘要" : String.join("；", summary);
    }
}
