<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="statusBadge" value="${emp.employmentStatus eq '已就业' ? 'badge-success' : emp.employmentStatus eq '升学' ? 'badge-info' : emp.employmentStatus eq '考公' ? 'badge-primary' : emp.employmentStatus eq '创业' ? 'badge-warning' : 'badge-secondary'}"/>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="ctx" content="${ctx}">
    <title>就业跟踪详情 - ${emp.studentName}</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${ctx}/static/css/style.css">
</head>
<body>
<div class="content" style="max-width:920px;">
    <div class="welcome-banner" style="background:linear-gradient(135deg,#2b5aed,#5b3fd6);padding:24px 26px;">
        <div style="display:flex;align-items:center;gap:16px;position:relative;z-index:2;">
            <div style="width:64px;height:64px;border-radius:14px;background:rgba(255,255,255,0.25);display:flex;align-items:center;justify-content:center;font-size:28px;font-weight:600;"><i class="fa fa-briefcase"></i></div>
            <div>
                <h3 style="margin:0 0 6px;">${emp.studentName}
                    <span class="badge ${statusBadge}">${emp.employmentStatus}</span>
                </h3>
                <p style="margin:0;opacity:.92;">学号：${emp.studentNo} · 跟踪日期：<fmt:formatDate value="${emp.trackDate}" pattern="yyyy-MM-dd"/> · 跟踪人：${emp.counselorName}</p>
            </div>
            <div style="margin-left:auto;">
                <a href="${ctx}/employment/edit?id=${emp.id}" class="btn btn-default btn-sm"><i class="fa fa-edit"></i>编辑</a>
                <a href="${ctx}/employment/list" class="btn btn-default btn-sm"><i class="fa fa-arrow-left"></i>返回</a>
            </div>
        </div>
    </div>

    <div class="card">
        <div class="card-header"><span class="card-title"><i class="fa fa-info-circle"></i>跟踪详情</span></div>
        <div class="card-body">
            <ul class="detail-list">
                <li><span class="label">学生姓名</span><span class="value">${emp.studentName}</span></li>
                <li><span class="label">学号</span><span class="value">${emp.studentNo}</span></li>
                <li><span class="label">就业状态</span><span class="value"><span class="badge ${statusBadge}">${emp.employmentStatus}</span></span></li>
                <li><span class="label">跟踪日期</span><span class="value"><fmt:formatDate value="${emp.trackDate}" pattern="yyyy-MM-dd"/></span></li>
                <li><span class="label">${emp.employmentStatus eq '升学' ? '升学学校' : '就业单位'}</span><span class="value">${emp.employmentStatus eq '升学' ? emp.school : emp.company}</span></li>
                <li><span class="label">${emp.employmentStatus eq '升学' ? '升学专业' : '岗位'}</span><span class="value">${emp.employmentStatus eq '升学' ? emp.major : emp.position}</span></li>
                <li><span class="label">城市</span><span class="value">${emp.city}</span></li>
                <li><span class="label">薪资</span><span class="value"><c:if test="${not empty emp.salary}">¥<fmt:formatNumber value="${emp.salary}" pattern="#,##0.00"/></c:if></span></li>
                <li><span class="label">跟踪人</span><span class="value">${emp.counselorName}</span></li>
                <li><span class="label">创建时间</span><span class="value"><fmt:formatDate value="${emp.createTime}" pattern="yyyy-MM-dd HH:mm"/></span></li>
            </ul>
        </div>
    </div>

    <div class="card">
        <div class="card-header"><span class="card-title"><i class="fa fa-file-lines"></i>备注</span></div>
        <div class="card-body">
            <div style="white-space:pre-wrap;line-height:1.8;">${emp.remark}</div>
        </div>
    </div>
</div>
</body>
</html>
