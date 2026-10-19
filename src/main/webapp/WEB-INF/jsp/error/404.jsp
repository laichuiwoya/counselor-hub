<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="ctx" content="${ctx}">
    <title>404 - 页面未找到 - 辅导员管理系统</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${ctx}/static/css/style.css?v=20261019b">
</head>
<body>
<div class="content" style="display:flex;align-items:center;justify-content:center;min-height:78vh;">
    <div class="card" style="max-width:560px;text-align:center;padding:50px 40px;">
        <div style="width:120px;height:120px;margin:0 auto 18px;border-radius:50%;background:#eef6ff;display:flex;align-items:center;justify-content:center;">
            <i class="fa fa-compass" style="font-size:64px;color:var(--primary);"></i>
        </div>
        <div style="font-size:96px;font-weight:700;color:var(--primary);line-height:1;margin:0 0 6px;">404</div>
        <h2 style="margin:0 0 12px;color:var(--text-main);font-size:22px;">页面未找到</h2>
        <p style="color:var(--text-secondary);margin:0 0 26px;font-size:14px;line-height:1.7;">
            抱歉，您访问的页面不存在或已被移除。<br>请检查地址是否正确，或返回首页继续操作。
        </p>
        <div style="display:flex;gap:10px;justify-content:center;">
            <a href="${ctx}/index" class="btn btn-primary"><i class="fa fa-house"></i>返回首页</a>
            <a href="javascript:history.back();" class="btn btn-default"><i class="fa fa-arrow-left"></i>返回上一页</a>
        </div>
    </div>
</div>
</body>
</html>
