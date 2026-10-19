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
    <title>困难资助详情 - ${aid.studentName}</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${ctx}/static/css/style.css?v=20261019b">
</head>
<body class="system-page detail-page">
<div class="content page-container">
    <div class="record-heading">
        <div style="display:flex;align-items:center;gap:16px;position:relative;z-index:2;">
            <div class="record-mark"><i class="fa fa-hand-holding-heart"></i></div>
            <div>
                <h3 style="margin:0 0 6px;">${aid.studentName}
                    <span class="badge badge-info">${aid.aidType}</span>
                    <span class="badge ${aid.difficultyLevel eq '一般' ? 'badge-secondary' : aid.difficultyLevel eq '困难' ? 'badge-warning' : 'badge-danger'}">${aid.difficultyLevel}</span>
                    <span class="badge ${aid.status eq '待审核' ? 'badge-warning' : aid.status eq '已通过' ? 'badge-success' : aid.status eq '已驳回' ? 'badge-danger' : 'badge-info'}">${aid.status}</span>
                </h3>
                <p style="margin:0;opacity:.92;">学号：${aid.studentNo} · 学期：${aid.semester} · 审核人：${aid.counselorName}</p>
            </div>
            <div style="margin-left:auto;">
                <a href="${ctx}/aid/edit?id=${aid.id}" class="btn btn-default btn-sm"><i class="fa fa-edit"></i>编辑</a>
                <a href="${ctx}/aid/list" class="btn btn-default btn-sm"><i class="fa fa-arrow-left"></i>返回</a>
            </div>
        </div>
    </div>

    <div class="card">
        <div class="card-header"><span class="card-title"><i class="fa fa-info-circle"></i>资助详情</span></div>
        <div class="card-body">
            <ul class="detail-list">
                <li><span class="label">学生姓名</span><span class="value">${aid.studentName}</span></li>
                <li><span class="label">学号</span><span class="value">${aid.studentNo}</span></li>
                <li><span class="label">资助类型</span><span class="value">${aid.aidType}</span></li>
                <li><span class="label">金额</span><span class="value"><c:choose><c:when test="${not empty aid.amount}">¥<fmt:formatNumber value="${aid.amount}" pattern="#,##0.00"/></c:when><c:otherwise>-</c:otherwise></c:choose></span></li>
                <li><span class="label">学期</span><span class="value">${aid.semester}</span></li>
                <li><span class="label">家庭收入情况</span><span class="value">${aid.familyIncome}</span></li>
                <li><span class="label">困难等级</span><span class="value">${aid.difficultyLevel}</span></li>
                <li><span class="label">状态</span><span class="value">${aid.status}</span></li>
                <li><span class="label">审核人</span><span class="value">${aid.counselorName}</span></li>
                <li><span class="label">创建时间</span><span class="value"><fmt:formatDate value="${aid.createTime}" pattern="yyyy-MM-dd HH:mm"/></span></li>
            </ul>
        </div>
    </div>

    <div class="card">
        <div class="card-header"><span class="card-title"><i class="fa fa-file-lines"></i>申请理由</span></div>
        <div class="card-body">
            <div style="white-space:pre-wrap;line-height:1.8;">${aid.reason}</div>
        </div>
    </div>
<div class="card"><div class="record-actions"><c:if test="${aid.status eq '待审核'}"><button type="button" class="btn btn-default" onclick="App.changeRecordStatus('/aid/changeStatus',${aid.id},'已通过')">通过审核</button></c:if><c:if test="${aid.status eq '待审核'}"><button type="button" class="btn btn-default" onclick="App.changeRecordStatus('/aid/changeStatus',${aid.id},'已驳回')">驳回</button></c:if><c:if test="${aid.status eq '已通过'}"><button type="button" class="btn btn-default" onclick="App.changeRecordStatus('/aid/changeStatus',${aid.id},'已发放')">确认发放</button></c:if><a href="${ctx}/aid/list" class="btn btn-default">返回列表</a></div></div>
</div>
<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="${ctx}/static/js/common.js?v=20261019b"></script>
</body>
</html>
