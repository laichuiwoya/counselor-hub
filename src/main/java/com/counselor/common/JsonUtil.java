package com.counselor.common;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;

/**
 * JSON 工具（基于 Jackson）
 * 供 JSP 中将对象渲染为 JSON 字符串使用
 */
public class JsonUtil {

    private static final ObjectMapper MAPPER = new ObjectMapper();

    static {
        MAPPER.configure(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS, false);
        // 日期格式
        MAPPER.setDateFormat(new java.text.SimpleDateFormat("yyyy-MM-dd"));
    }

    /**
     * 转为 JSON 字符串，异常时返回 "[]"
     */
    public static String toJson(Object obj) {
        if (obj == null) {
            return "[]";
        }
        try {
            String json = MAPPER.writeValueAsString(obj);
            // 转义 JSP 中可能的 </script> 问题
            return json.replace("</", "<\\/");
        } catch (Exception e) {
            return "[]";
        }
    }
}
