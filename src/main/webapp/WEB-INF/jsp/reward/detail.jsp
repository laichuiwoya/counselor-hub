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
    <title>奖惩详情 - ${rp.name}</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${ctx}/static/css/style.css">
</head>
<body>
<div class="content" style="max-width:920px;">
    <div class="welcome-banner" style="background:linear-gradient(135deg,#2b5aed,#5b3fd6);padding:24px 26px;">
        <div style="display:flex;align-items:center;gap:16px;position:relative;z-index:2;">
            <div style="width:64px;height:64px;border-radius:14px;background:rgba(255,255,255,0.25);display:flex;align-items:center;justify-content:center;font-size:28px;color:#fff;">
                <i class="fa fa-trophy"></i>
            </div>
            <div>
                <h3 style="margin:0 0 6px;">
                    ${rp.name}
                    <span class="badge ${rp.type eq '奖励' ? 'badge-success' : 'badge-danger'}" style="background:rgba(255,255,255,0.25);color:#fff;">${rp.type}</span>
                    <span class="badge ${rp.status eq '生效' ? 'badge-success' : 'badge-secondary'}" style="background:rgba(255,255,255,0.25);color:#fff;">${rp.status}</span>
                </h3>
                <p style="margin:0;opacity:.92;">${rp.studentNo} · ${rp.studentName} · ${rp.className}</p>
            </div>
            <div style="margin-left:auto;">
                <a href="${ctx}/reward/edit?id=${rp.id}" class="btn btn-default btn-sm"><i class="fa fa-edit"></i>编辑</a>
                <a href="${ctx}/reward/list" class="btn btn-default btn-sm"><i class="fa fa-arrow-left"></i>返回</a>
            </div>
        </div>
    </div>

    <div style="display:grid;grid-template-columns:1fr 1fr;gap:18px;">
        <div class="card">
            <div class="card-header"><span class="card-title"><i class="fa fa-user-graduate"></i>学生信息</span></div>
            <div class="card-body">
                <ul class="detail-list">
                    <li><span class="label">学号</span><span class="value">${rp.studentNo}</span></li>
                    <li><span class="label">姓名</span><span class="value">${rp.studentName}</span></li>
                    <li><span class="label">班级</span><span class="value">${rp.className}</span></li>
                </ul>
            </div>
        </div>
        <div class="card">
            <div class="card-header"><span class="card-title"><i class="fa fa-trophy"></i>奖惩信息</span></div>
            <div class="card-body">
                <ul class="detail-list">
                    <li><span class="label">奖惩名称</span><span class="value">${rp.name}</span></li>
                    <li><span class="label">类型</span><span class="value">
                        <span class="badge ${rp.type eq '奖励' ? 'badge-success' : 'badge-danger'}">${rp.type}</span>
                    </span></li>
                    <li><span class="label">级别</span><span class="value">${rp.level}</span></li>
                    <li><span class="label">状态</span><span class="value">
                        <span class="badge ${rp.status eq '生效' ? 'badge-success' : 'badge-secondary'}">${rp.status}</span>
                    </span></li>
                </ul>
            </div>
        </div>
        <div class="card">
            <div class="card-header"><span class="card-title"><i class="fa fa-calendar-day"></i>办理信息</span></div>
            <div class="card-body">
                <ul class="detail-list">
                    <li><span class="label">发生日期</span><span class="value"><fmt:formatDate value="${rp.occurDate}" pattern="yyyy-MM-dd"/></span></li>
                    <li><span class="label">经办人</span><span class="value">${rp.operator}</span></li>
                    <li><span class="label">登记时间</span><span class="value"><fmt:formatDate value="${rp.createTime}" pattern="yyyy-MM-dd HH:mm"/></span></li>
                </ul>
            </div>
        </div>
        <div class="card">
            <div class="card-header"><span class="card-title"><i class="fa fa-align-left"></i>奖惩事由</span></div>
            <div class="card-body">
                <div style="line-height:1.8;color:var(--text-primary);min-height:80px;white-space:pre-wrap;">${rp.reason}</div>
            </div>
        </div>
    </div>

    <div style="margin-top:18px;text-align:center;">
        <a href="${ctx}/reward/list" class="btn btn-default"><i class="fa fa-arrow-left"></i>返回奖惩列表</a>
    </div>
</div>
</body>
</html>
