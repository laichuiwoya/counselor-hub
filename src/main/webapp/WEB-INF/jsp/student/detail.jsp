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
    <title>学生详情 - ${student.name}</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${ctx}/static/css/style.css">
</head>
<body>
<div class="content" style="max-width:920px;">
    <div class="welcome-banner" style="background:linear-gradient(135deg,#2b5aed,#5b3fd6);padding:24px 26px;">
        <div style="display:flex;align-items:center;gap:16px;position:relative;z-index:2;">
            <div style="width:64px;height:64px;border-radius:14px;background:rgba(255,255,255,0.25);display:flex;align-items:center;justify-content:center;font-size:28px;font-weight:600;">${student.name eq null ? '' : student.name.substring(0,1)}</div>
            <div>
                <h3 style="margin:0 0 6px;">${student.name}
                    <span class="badge" style="background:rgba(255,255,255,0.25);color:#fff;">${student.gender}</span>
                    <span class="badge" style="background:rgba(255,255,255,0.25);color:#fff;">${student.status}</span>
                </h3>
                <p style="margin:0;opacity:.92;">${student.studentNo} · ${student.college} · ${student.major} · ${student.className}</p>
            </div>
            <div style="margin-left:auto;">
                <a href="${ctx}/student/edit?id=${student.id}" class="btn btn-default btn-sm"><i class="fa fa-edit"></i>编辑</a>
                <a href="${ctx}/student/list" class="btn btn-default btn-sm"><i class="fa fa-arrow-left"></i>返回</a>
            </div>
        </div>
    </div>

    <div style="display:grid;grid-template-columns:1fr 1fr;gap:18px;">
        <div class="card">
            <div class="card-header"><span class="card-title"><i class="fa fa-id-card"></i>基本信息</span></div>
            <div class="card-body">
                <ul class="detail-list">
                    <li><span class="label">学号</span><span class="value">${student.studentNo}</span></li>
                    <li><span class="label">姓名</span><span class="value">${student.name}</span></li>
                    <li><span class="label">性别</span><span class="value">${student.gender}</span></li>
                    <li><span class="label">身份证号</span><span class="value">${student.idCard}</span></li>
                    <li><span class="label">籍贯</span><span class="value">${student.nativePlace}</span></li>
                    <li><span class="label">政治面貌</span><span class="value">${student.politicalStatus}</span></li>
                </ul>
            </div>
        </div>
        <div class="card">
            <div class="card-header"><span class="card-title"><i class="fa fa-school"></i>学业信息</span></div>
            <div class="card-body">
                <ul class="detail-list">
                    <li><span class="label">学院</span><span class="value">${student.college}</span></li>
                    <li><span class="label">专业</span><span class="value">${student.major}</span></li>
                    <li><span class="label">班级</span><span class="value">${student.className}</span></li>
                    <li><span class="label">年级</span><span class="value">${student.grade}</span></li>
                    <li><span class="label">所属辅导员</span><span class="value">${student.counselorName}</span></li>
                    <li><span class="label">学生状态</span><span class="value">${student.status}</span></li>
                </ul>
            </div>
        </div>
        <div class="card">
            <div class="card-header"><span class="card-title"><i class="fa fa-house"></i>住宿联系</span></div>
            <div class="card-body">
                <ul class="detail-list">
                    <li><span class="label">宿舍楼</span><span class="value">${student.dormBuilding}</span></li>
                    <li><span class="label">宿舍号</span><span class="value">${student.dormRoom}</span></li>
                    <li><span class="label">手机号</span><span class="value">${student.phone}</span></li>
                    <li><span class="label">录入时间</span><span class="value"><fmt:formatDate value="${student.createTime}" pattern="yyyy-MM-dd HH:mm"/></span></li>
                </ul>
            </div>
        </div>
        <div class="card">
            <div class="card-header"><span class="card-title"><i class="fa fa-bolt"></i>快捷操作</span></div>
            <div class="card-body">
                <div style="display:flex;flex-direction:column;gap:10px;">
                    <a href="${ctx}/reward/add?studentId=${student.id}" class="btn btn-ghost"><i class="fa fa-trophy"></i>登记奖惩记录</a>
                    <a href="${ctx}/archive/add?studentId=${student.id}" class="btn btn-ghost"><i class="fa fa-folder-open"></i>归档学生档案</a>
                    <a href="${ctx}/student/edit?id=${student.id}" class="btn btn-default"><i class="fa fa-edit"></i>编辑学生信息</a>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
