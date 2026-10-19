<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="ctx" content="${ctx}">
    <title>请假详情 - ${leave.studentName}</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${ctx}/static/css/style.css">
</head>
<body>
<div class="content" style="max-width:920px;">
    <div class="welcome-banner" style="background:linear-gradient(135deg,#2b5aed,#5b3fd6);padding:24px 26px;">
        <div style="display:flex;align-items:center;gap:16px;position:relative;z-index:2;">
            <div style="width:64px;height:64px;border-radius:14px;background:rgba(255,255,255,0.25);display:flex;align-items:center;justify-content:center;font-size:28px;font-weight:600;"><i class="fa fa-calendar-times"></i></div>
            <div>
                <h3 style="margin:0 0 6px;">${leave.studentName}
                    <span class="badge badge-info">${leave.leaveType}</span>
                    <span class="badge ${leave.status eq '待审批' ? 'badge-warning' : leave.status eq '已批准' ? 'badge-success' : leave.status eq '已驳回' ? 'badge-danger' : 'badge-secondary'}">${leave.status}</span>
                </h3>
                <p style="margin:0;opacity:.92;">学号：${leave.studentNo} · 天数：${leave.days} · 审批人：${leave.counselorName}</p>
            </div>
            <div style="margin-left:auto;">
                <a href="${ctx}/leave/edit?id=${leave.id}" class="btn btn-default btn-sm"><i class="fa fa-edit"></i>编辑</a>
                <a href="${ctx}/leave/list" class="btn btn-default btn-sm"><i class="fa fa-arrow-left"></i>返回</a>
            </div>
        </div>
    </div>

    <div class="card">
        <div class="card-header"><span class="card-title"><i class="fa fa-info-circle"></i>请假详情</span></div>
        <div class="card-body">
            <ul class="detail-list">
                <li><span class="label">学生姓名</span><span class="value">${leave.studentName}</span></li>
                <li><span class="label">学号</span><span class="value">${leave.studentNo}</span></li>
                <li><span class="label">请假类型</span><span class="value">${leave.leaveType}</span></li>
                <li><span class="label">开始日期</span><span class="value"><fmt:formatDate value="${leave.startDate}" pattern="yyyy-MM-dd"/></span></li>
                <li><span class="label">结束日期</span><span class="value"><fmt:formatDate value="${leave.endDate}" pattern="yyyy-MM-dd"/></span></li>
                <li><span class="label">天数</span><span class="value">${leave.days}</span></li>
                <li><span class="label">状态</span><span class="value">${leave.status}</span></li>
                <li><span class="label">审批人</span><span class="value">${leave.counselorName}</span></li>
                <li><span class="label">审批时间</span><span class="value"><fmt:formatDate value="${leave.approveTime}" pattern="yyyy-MM-dd HH:mm"/></span></li>
                <li><span class="label">创建时间</span><span class="value"><fmt:formatDate value="${leave.createTime}" pattern="yyyy-MM-dd HH:mm"/></span></li>
            </ul>
        </div>
    </div>

    <div class="card">
        <div class="card-header"><span class="card-title"><i class="fa fa-file-lines"></i>请假事由</span></div>
        <div class="card-body">
            <div style="white-space:pre-wrap;line-height:1.8;">${leave.reason}</div>
        </div>
    </div>
</div>
</body>
</html>
