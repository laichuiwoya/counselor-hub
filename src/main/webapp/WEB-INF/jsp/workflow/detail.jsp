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
    <title>工作流程纪要详情 - ${workflow.title}</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${ctx}/static/css/style.css">
</head>
<body>
<div class="content" style="max-width:920px;">
    <div class="welcome-banner" style="background:linear-gradient(135deg,#2b5aed,#5b3fd6);padding:24px 26px;">
        <div style="display:flex;align-items:center;gap:16px;position:relative;z-index:2;">
            <div style="width:64px;height:64px;border-radius:14px;background:rgba(255,255,255,0.25);display:flex;align-items:center;justify-content:center;font-size:28px;font-weight:600;"><i class="fa fa-clipboard-list"></i></div>
            <div>
                <h3 style="margin:0 0 6px;">${workflow.title}
                    <span class="badge ${workflow.category eq '主题班会' ? 'badge-primary' : workflow.category eq '学生谈话' ? 'badge-info' : workflow.category eq '走访宿舍' ? 'badge-success' : workflow.category eq '专题会议' ? 'badge-purple' : 'badge-secondary'}">${workflow.category}</span>
                </h3>
                <p style="margin:0;opacity:.92;">日期：<fmt:formatDate value="${workflow.meetingDate}" pattern="yyyy-MM-dd"/> · 地点：${workflow.location} · 负责人：${workflow.counselorName}</p>
            </div>
            <div style="margin-left:auto;">
                <a href="${ctx}/workflow/edit?id=${workflow.id}" class="btn btn-default btn-sm"><i class="fa fa-edit"></i>编辑</a>
                <a href="${ctx}/workflow/list" class="btn btn-default btn-sm"><i class="fa fa-arrow-left"></i>返回</a>
            </div>
        </div>
    </div>

    <div class="card">
        <div class="card-header"><span class="card-title"><i class="fa fa-info-circle"></i>纪要信息</span></div>
        <div class="card-body">
            <ul class="detail-list">
                <li><span class="label">主题</span><span class="value">${workflow.title}</span></li>
                <li><span class="label">类别</span><span class="value">${workflow.category}</span></li>
                <li><span class="label">会议日期</span><span class="value"><fmt:formatDate value="${workflow.meetingDate}" pattern="yyyy-MM-dd"/></span></li>
                <li><span class="label">地点</span><span class="value">${workflow.location}</span></li>
                <li><span class="label">参与人员</span><span class="value">${workflow.participants}</span></li>
                <li><span class="label">负责人</span><span class="value">${workflow.counselorName}</span></li>
                <li><span class="label">登记时间</span><span class="value"><fmt:formatDate value="${workflow.createTime}" pattern="yyyy-MM-dd HH:mm"/></span></li>
            </ul>
        </div>
    </div>

    <div class="card">
        <div class="card-header"><span class="card-title"><i class="fa fa-file-lines"></i>详细内容</span></div>
        <div class="card-body">
            <div style="white-space:pre-wrap;line-height:1.8;">${workflow.content}</div>
        </div>
    </div>

    <div class="card">
        <div class="card-header"><span class="card-title"><i class="fa fa-clipboard-check"></i>纪要小结</span></div>
        <div class="card-body">
            <div style="white-space:pre-wrap;line-height:1.8;">${workflow.summary}</div>
        </div>
    </div>
</div>
</body>
</html>
