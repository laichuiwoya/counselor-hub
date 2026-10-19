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
    <title>档案详情 - ${archive.archiveName}</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${ctx}/static/css/style.css?v=20261019b">
</head>
<body class="system-page detail-page">
<div class="content page-container">
    <div class="record-heading">
        <div style="display:flex;align-items:center;gap:16px;position:relative;z-index:2;">
            <div class="record-mark">
                <i class="fa fa-folder-open"></i>
            </div>
            <div>
                <h3 style="margin:0 0 6px;">
                    ${archive.archiveName}
                    <c:choose>
                        <c:when test="${archive.archiveType eq '入学登记表'}"><span class="badge badge-primary" style="background:rgba(255,255,255,0.25);color:#fff;">${archive.archiveType}</span></c:when>
                        <c:when test="${archive.archiveType eq '成绩单'}"><span class="badge badge-info" style="background:rgba(255,255,255,0.25);color:#fff;">${archive.archiveType}</span></c:when>
                        <c:when test="${archive.archiveType eq '奖惩材料'}"><span class="badge badge-warning" style="background:rgba(255,255,255,0.25);color:#fff;">${archive.archiveType}</span></c:when>
                        <c:when test="${archive.archiveType eq '实习材料'}"><span class="badge badge-success" style="background:rgba(255,255,255,0.25);color:#fff;">${archive.archiveType}</span></c:when>
                        <c:when test="${archive.archiveType eq '毕业材料'}"><span class="badge badge-purple" style="background:rgba(255,255,255,0.25);color:#fff;">${archive.archiveType}</span></c:when>
                        <c:otherwise><span class="badge badge-secondary" style="background:rgba(255,255,255,0.25);color:#fff;">${archive.archiveType}</span></c:otherwise>
                    </c:choose>
                </h3>
                <p style="margin:0;opacity:.92;">${archive.studentNo} · ${archive.studentName} · ${archive.className}</p>
            </div>
            <div style="margin-left:auto;">
                <a href="${ctx}/archive/edit?id=${archive.id}" class="btn btn-default btn-sm"><i class="fa fa-edit"></i>编辑</a>
                <a href="${ctx}/archive/list" class="btn btn-default btn-sm"><i class="fa fa-arrow-left"></i>返回</a>
            </div>
        </div>
    </div>

    <div style="display:grid;grid-template-columns:1fr 1fr;gap:18px;">
        <div class="card">
            <div class="card-header"><span class="card-title"><i class="fa fa-user-graduate"></i>学生信息</span></div>
            <div class="card-body">
                <ul class="detail-list">
                    <li><span class="label">学号</span><span class="value">${archive.studentNo}</span></li>
                    <li><span class="label">姓名</span><span class="value">${archive.studentName}</span></li>
                    <li><span class="label">班级</span><span class="value">${archive.className}</span></li>
                </ul>
            </div>
        </div>
        <div class="card">
            <div class="card-header"><span class="card-title"><i class="fa fa-folder-open"></i>档案信息</span></div>
            <div class="card-body">
                <ul class="detail-list">
                    <li><span class="label">档案名称</span><span class="value">${archive.archiveName}</span></li>
                    <li><span class="label">档案类型</span><span class="value">
                        <c:choose>
                            <c:when test="${archive.archiveType eq '入学登记表'}"><span class="badge badge-primary">${archive.archiveType}</span></c:when>
                            <c:when test="${archive.archiveType eq '成绩单'}"><span class="badge badge-info">${archive.archiveType}</span></c:when>
                            <c:when test="${archive.archiveType eq '奖惩材料'}"><span class="badge badge-warning">${archive.archiveType}</span></c:when>
                            <c:when test="${archive.archiveType eq '实习材料'}"><span class="badge badge-success">${archive.archiveType}</span></c:when>
                            <c:when test="${archive.archiveType eq '毕业材料'}"><span class="badge badge-purple">${archive.archiveType}</span></c:when>
                            <c:otherwise><span class="badge badge-secondary">${archive.archiveType}</span></c:otherwise>
                        </c:choose>
                    </span></li>
                    <li><span class="label">归档日期</span><span class="value"><fmt:formatDate value="${archive.uploadDate}" pattern="yyyy-MM-dd"/></span></li>
                    <li><span class="label">经办人</span><span class="value">${archive.operator}</span></li>
                    <li><span class="label">登记时间</span><span class="value"><fmt:formatDate value="${archive.createTime}" pattern="yyyy-MM-dd HH:mm"/></span></li>
                </ul>
            </div>
        </div>
        <div class="card" style="grid-column:1 / span 2;">
            <div class="card-header"><span class="card-title"><i class="fa fa-align-left"></i>档案说明</span></div>
            <div class="card-body">
                <div style="line-height:1.8;color:var(--text-primary);min-height:80px;white-space:pre-wrap;">${archive.description}</div>
            </div>
        </div>
        <div class="card" style="grid-column:1 / span 2;">
            <div class="card-header"><span class="card-title"><i class="fa fa-paperclip"></i>档案文件</span></div>
            <div class="card-body">
                <c:choose>
                    <c:when test="${not empty archive.filePath}">
                        <div style="display:flex;align-items:center;gap:14px;flex-wrap:wrap;">
                            <div style="flex:1;min-width:200px;">
                                <i class="fa fa-file" style="color:var(--primary);margin-right:8px;"></i>
                                <a href="${ctx}${archive.filePath}" target="_blank" style="color:var(--primary);text-decoration:underline;">${archive.filePath}</a>
                            </div>
                            <a href="${ctx}${archive.filePath}" target="_blank" class="btn btn-primary btn-sm"><i class="fa fa-download"></i>下载/预览文件</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div style="color:var(--text-secondary);"><i class="fa fa-info-circle"></i> 该档案暂未上传文件</div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <div style="margin-top:18px;text-align:center;">
        <a href="${ctx}/archive/list" class="btn btn-default"><i class="fa fa-arrow-left"></i>返回档案列表</a>
    </div>
</div>
</body>
</html>
