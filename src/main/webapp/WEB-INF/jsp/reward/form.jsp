<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="isEdit" value="${not empty rp.id}"/>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="ctx" content="${ctx}">
    <title>${isEdit ? '编辑' : '新增'}奖惩 - 辅导员管理系统</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${ctx}/static/css/style.css?v=20261019b">
</head>
<body class="system-page form-page">
<div class="content page-container">
    <div class="card">
        <div class="card-header">
            <span class="card-title"><i class="fa fa-trophy"></i>${isEdit ? '编辑奖惩记录' : '新增奖惩记录'}</span>
            <a href="${ctx}/reward/list" class="btn btn-default btn-sm"><i class="fa fa-arrow-left"></i>返回列表</a>
        </div>
        <div class="card-body">
            <form action="${ctx}/reward/save" method="post" id="rpForm">
                <c:if test="${isEdit}"><input type="hidden" name="id" value="${rp.id}"></c:if>
                <input type="hidden" name="studentId" id="studentId" value="${rp.studentId}">

                <div class="form-section-title">学生信息</div>
                <div class="form-row">
                    <div class="form-group">
                        <label>学号 <span class="req">*</span></label>
                        <div style="display:flex;gap:8px;">
                            <input type="text" class="form-control" id="studentNoShow"
                                   value="${rp.studentNo}" placeholder="点击右侧按钮选择学生" readonly
                                   style="background:#f7f9fc;flex:1;">
                            <button type="button" class="btn btn-default btn-sm" id="pickStudentBtn" title="选择学生">
                                <i class="fa fa-user-search"></i>选择学生
                            </button>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>姓名</label>
                        <input type="text" class="form-control" id="studentNameShow"
                               value="${rp.studentName}" readonly placeholder="选择学生后自动带出"
                               style="background:#f7f9fc;">
                        <div id="studentTip" style="font-size:12px;margin-top:4px;color:var(--text-secondary);">
                            <c:choose>
                                <c:when test="${not empty rp.studentId}">
                                    <i class="fa fa-check-circle" style="color:var(--success);"></i> 已关联学生：${rp.studentName}（${rp.className}）
                                </c:when>
                                <c:otherwise>
                                    <i class="fa fa-info-circle"></i> 请点击"选择学生"按钮从学生列表中挑选
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>

                <div class="form-section-title">奖惩信息</div>
                <div class="form-row-3">
                    <div class="form-group">
                        <label>类型 <span class="req">*</span></label>
                        <select class="form-control" name="type" id="typeSel">
                            <option value="">请选择</option>
                            <option value="奖励" ${rp.type eq '奖励' ? 'selected':''}>奖励</option>
                            <option value="处分" ${rp.type eq '处分' ? 'selected':''}>处分</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>级别 <span class="req">*</span></label>
                        <input type="text" class="form-control" name="level" value="${rp.level}" placeholder="如 校级一等奖学金/警告/记过" required>
                    </div>
                    <div class="form-group">
                        <label>状态 <span class="req">*</span></label>
                        <select class="form-control" name="status">
                            <option value="生效" ${empty rp.status or rp.status eq '生效' ? 'selected':''}>生效</option>
                            <option value="撤销" ${rp.status eq '撤销' ? 'selected':''}>撤销</option>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label>奖惩名称 <span class="req">*</span></label>
                        <input type="text" class="form-control" name="name" value="${rp.name}" placeholder="如 三好学生/警告处分" required>
                    </div>
                    <div class="form-group">
                        <label>发生日期 <span class="req">*</span></label>
                        <input type="date" class="form-control" name="occurDate"
                               value="<fmt:formatDate value="${rp.occurDate}" pattern="yyyy-MM-dd"/>" required>
                    </div>
                </div>
                <div class="form-group">
                    <label>事由</label>
                    <textarea class="form-control" name="reason" rows="3" placeholder="请填写奖惩事由说明">${rp.reason}</textarea>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label>经办人</label>
                        <input type="text" class="form-control" name="operator" value="${rp.operator}" placeholder="如 张老师">
                    </div>
                    <div class="form-group">
                        <label>&nbsp;</label>
                        <div style="color:var(--text-secondary);font-size:12px;line-height:38px;">
                            <i class="fa fa-info-circle"></i> 经办人指负责登记或处理该奖惩事项的教师
                        </div>
                    </div>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-primary"><i class="fa fa-check"></i>保存</button>
                    <a href="${ctx}/reward/list" class="btn btn-default"><i class="fa fa-times"></i>取消</a>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="${ctx}/static/js/common.js?v=20261019b"></script>
<script>
    // 父窗口被学生列表弹窗调用，回填学生信息
    window.setStudent = function (id, no, name, cls) {
        $('#studentId').val(id);
        $('#studentNoShow').val(no);
        $('#studentNameShow').val(name);
        $('#studentTip').html('<i class="fa fa-check-circle" style="color:var(--success);"></i> 已关联学生：' + name + '（' + cls + '）');
    };

    // 打开学生列表选择弹窗
    $('#pickStudentBtn').on('click', function () {
        window.open('${ctx}/student/list?pick=1', '_blank', 'width=1000,height=600');
    });

    // 表单提交前校验学生已选择
    $('#rpForm').on('submit', function (e) {
        var sid = $('#studentId').val();
        if (!sid) {
            e.preventDefault();
            App.toast('请先选择学生', 'error');
            return false;
        }
        var type = $('#typeSel').val();
        if (!type) {
            e.preventDefault();
            App.toast('请选择奖惩类型', 'error');
            return false;
        }
    });
</script>
</body>
</html>
