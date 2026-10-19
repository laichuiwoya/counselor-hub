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
    <title>访客登记详情 - ${visitor.visitorName}</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${ctx}/static/css/style.css?v=20261019b">
</head>
<body class="system-page detail-page">
<div class="content page-container">
    <div class="record-heading">
        <div style="display:flex;align-items:center;gap:16px;position:relative;z-index:2;">
            <div class="record-mark"><i class="fa fa-user-plus"></i></div>
            <div>
                <h3 style="margin:0 0 6px;">${visitor.visitorName}
                    <span class="badge ${visitor.status eq '在访' ? 'badge-warning' : 'badge-secondary'}">${visitor.status}</span>
                </h3>
                <p style="margin:0;opacity:.92;">来访事由：${visitor.visitPurpose} · 被访对象：${visitor.visitObject} · 登记人：${visitor.counselorName}</p>
            </div>
            <div style="margin-left:auto;">
                <a href="${ctx}/visitor/edit?id=${visitor.id}" class="btn btn-default btn-sm"><i class="fa fa-edit"></i>编辑</a>
                <a href="${ctx}/visitor/list" class="btn btn-default btn-sm"><i class="fa fa-arrow-left"></i>返回</a>
            </div>
        </div>
    </div>

    <div class="card">
        <div class="card-header"><span class="card-title"><i class="fa fa-info-circle"></i>访客详情</span></div>
        <div class="card-body">
            <ul class="detail-list">
                <li><span class="label">访客姓名</span><span class="value">${visitor.visitorName}</span></li>
                <li><span class="label">联系电话</span><span class="value">${visitor.phone}</span></li>
                <li><span class="label">证件号</span><span class="value">${visitor.idCard}</span></li>
                <li><span class="label">来访事由</span><span class="value">${visitor.visitPurpose}</span></li>
                <li><span class="label">被访对象</span><span class="value">${visitor.visitObject}</span></li>
                <li><span class="label">来访时间</span><span class="value"><fmt:formatDate value="${visitor.visitTime}" pattern="yyyy-MM-dd HH:mm"/></span></li>
                <li><span class="label">离开时间</span><span class="value"><fmt:formatDate value="${visitor.leaveTime}" pattern="yyyy-MM-dd HH:mm"/></span></li>
                <li><span class="label">状态</span><span class="value">${visitor.status}</span></li>
                <li><span class="label">登记人</span><span class="value">${visitor.counselorName}</span></li>
                <li><span class="label">创建时间</span><span class="value"><fmt:formatDate value="${visitor.createTime}" pattern="yyyy-MM-dd HH:mm"/></span></li>
            </ul>
        </div>
    </div>
<div class="card"><div class="record-actions"><c:if test="${visitor.status eq '在访'}"><button type="button" class="btn btn-default" onclick="App.changeRecordStatus('/visitor/changeStatus',${visitor.id},'已离开')">登记离开</button></c:if><a href="${ctx}/visitor/list" class="btn btn-default">返回列表</a></div></div>
</div>
<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="${ctx}/static/js/common.js?v=20261019b"></script>
</body>
</html>
