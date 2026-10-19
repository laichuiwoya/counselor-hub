<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="isEdit" value="${not empty leave.id}"/>
<fmt:formatDate value="${leave.startDate}" pattern="yyyy-MM-dd" var="startDateStr"/>
<fmt:formatDate value="${leave.endDate}" pattern="yyyy-MM-dd" var="endDateStr"/>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="ctx" content="${ctx}">
    <title>${isEdit ? '编辑' : '新增'}请假 - 辅导员管理系统</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${ctx}/static/css/style.css?v=20261019b">
</head>
<body class="system-page form-page">
<div class="content page-container">
    <div class="card">
        <div class="card-header">
            <span class="card-title"><i class="fa fa-calendar-times"></i>${isEdit ? '编辑请假' : '新增请假'}</span>
            <a href="${ctx}/leave/list" class="btn btn-default btn-sm"><i class="fa fa-arrow-left"></i>返回列表</a>
        </div>
        <div class="card-body">
            <form action="${ctx}/leave/save" method="post" id="leaveForm">
                <c:if test="${isEdit}"><input type="hidden" name="id" value="${leave.id}"></c:if>
                <input type="hidden" name="counselorId" value="${leave.counselorId}">

                <div class="form-section-title">基本信息</div>
                <div class="form-row">
                    <div class="form-group">
                        <label>学生 <span class="req">*</span></label>
                        <input type="hidden" name="studentId" id="studentId" value="${leave.studentId}"><div class="student-picker"><input type="text" class="form-control" id="selectedStudent" value="<c:out value='${leave.studentName}'/>" readonly placeholder="请选择学生"><button type="button" class="btn btn-default" data-pick-student>选择学生</button></div>
                    </div>
                    <div class="form-group">
                        <label>审批人</label>
                        <input type="text" class="form-control" value="${leave.counselorName}" readonly style="background:#f7f9fc;">
                    </div>
                </div>
                <div class="form-row-3">
                    <div class="form-group">
                        <label>请假类型 <span class="req">*</span></label>
                        <select class="form-control" name="leaveType">
                            <option value="病假" ${leave.leaveType eq '病假' ? 'selected':''}>病假</option>
                            <option value="事假" ${leave.leaveType eq '事假' ? 'selected':''}>事假</option>
                            <option value="公假" ${leave.leaveType eq '公假' ? 'selected':''}>公假</option>
                            <option value="其他" ${leave.leaveType eq '其他' ? 'selected':''}>其他</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>开始日期</label>
                        <input type="date" class="form-control" name="startDate" value="${startDateStr}">
                    </div>
                    <div class="form-group">
                        <label>结束日期</label>
                        <input type="date" class="form-control" name="endDate" value="${endDateStr}">
                    </div>
                </div>
                <div class="form-row-3">
                    <div class="form-group">
                        <label>天数</label>
                        <input type="number" step="0.1" class="form-control" name="days" value="${leave.days}" placeholder="请输入请假天数">
                    </div>
                    <div class="form-group">
                        <label>状态</label>
                        <select class="form-control" name="status">
                            <option value="待审批" ${empty leave.status or leave.status eq '待审批' ? 'selected':''}>待审批</option>
                            <option value="已批准" ${leave.status eq '已批准' ? 'selected':''}>已批准</option>
                            <option value="已驳回" ${leave.status eq '已驳回' ? 'selected':''}>已驳回</option>
                            <option value="已销假" ${leave.status eq '已销假' ? 'selected':''}>已销假</option>
                        </select>
                    </div>
                    <div class="form-group"></div>
                </div>

                <div class="form-section-title">请假事由</div>
                <div class="form-group">
                    <label>请假事由</label>
                    <textarea class="form-control" name="reason" rows="6" placeholder="请输入请假事由">${leave.reason}</textarea>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-primary"><i class="fa fa-check"></i>保存</button>
                    <a href="${ctx}/leave/list" class="btn btn-default"><i class="fa fa-times"></i>取消</a>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="${ctx}/static/js/common.js?v=20261019b"></script>
</body>
</html>
