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
    <title>工作提示详情 - ${reminder.title}</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${ctx}/static/css/style.css">
</head>
<body>
<div class="content" style="max-width:920px;">
    <div class="welcome-banner" style="background:linear-gradient(135deg,#2b5aed,#5b3fd6);padding:24px 26px;">
        <div style="display:flex;align-items:center;gap:16px;position:relative;z-index:2;">
            <div style="width:64px;height:64px;border-radius:14px;background:rgba(255,255,255,0.25);display:flex;align-items:center;justify-content:center;font-size:28px;font-weight:600;"><i class="fa fa-bell"></i></div>
            <div>
                <h3 style="margin:0 0 6px;">${reminder.title}
                    <span class="badge ${reminder.priority eq '高' ? 'badge-danger' : reminder.priority eq '中' ? 'badge-warning' : 'badge-secondary'}">${reminder.priority}</span>
                    <span class="badge ${reminder.status eq '待办' ? 'badge-secondary' : reminder.status eq '进行中' ? 'badge-warning' : 'badge-success'}">${reminder.status}</span>
                </h3>
                <p style="margin:0;opacity:.92;">类型：${reminder.type} · 截止：<fmt:formatDate value="${reminder.dueDate}" pattern="yyyy-MM-dd"/> · 负责人：${reminder.counselorName}</p>
            </div>
            <div style="margin-left:auto;">
                <a href="${ctx}/reminder/edit?id=${reminder.id}" class="btn btn-default btn-sm"><i class="fa fa-edit"></i>编辑</a>
                <a href="${ctx}/reminder/list" class="btn btn-default btn-sm"><i class="fa fa-arrow-left"></i>返回</a>
            </div>
        </div>
    </div>

    <div class="card">
        <div class="card-header"><span class="card-title"><i class="fa fa-info-circle"></i>提示详情</span></div>
        <div class="card-body">
            <ul class="detail-list">
                <li><span class="label">标题</span><span class="value">${reminder.title}</span></li>
                <li><span class="label">类型</span><span class="value">${reminder.type}</span></li>
                <li><span class="label">优先级</span><span class="value">${reminder.priority}</span></li>
                <li><span class="label">状态</span><span class="value">${reminder.status}</span></li>
                <li><span class="label">截止日期</span><span class="value"><fmt:formatDate value="${reminder.dueDate}" pattern="yyyy-MM-dd"/></span></li>
                <li><span class="label">负责人</span><span class="value">${reminder.counselorName}</span></li>
                <li><span class="label">创建时间</span><span class="value"><fmt:formatDate value="${reminder.createTime}" pattern="yyyy-MM-dd HH:mm"/></span></li>
            </ul>
        </div>
    </div>

    <div class="card">
        <div class="card-header"><span class="card-title"><i class="fa fa-file-lines"></i>提示内容</span></div>
        <div class="card-body">
            <div style="white-space:pre-wrap;line-height:1.8;">${reminder.content}</div>
        </div>
    </div>
</div>
</body>
</html>
