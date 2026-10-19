<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head><meta charset="UTF-8"><title>请检查填写内容</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css"></head>
<body><main style="max-width:640px;margin:60px auto;padding:24px;background:white;border-radius:12px">
    <h2>操作未完成</h2>
    <p><c:out value="${message}"/></p>
    <button type="button" class="btn btn-primary" onclick="history.back()">返回修改</button>
</main></body></html>
