<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>操作日志 - 辅导员管理系统</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${ctx}/static/css/style.css?v=20261019b">
    <style>
        .audit-operation { min-width: 360px; max-width: 620px; white-space: normal; }
        .audit-operation strong { display: block; margin-bottom: 8px; }
        .audit-details { white-space: pre-wrap; overflow-wrap: anywhere; line-height: 1.8; color: #52627b; font-size: 13px; }
        .audit-legacy { color: #8793a5; font-size: 12px; }
    </style>
</head>
<body class="system-page list-page">
<div class="content page-container">
    <header class="page-heading"><h1>操作日志</h1><span class="page-count">共 <strong>${page.total}</strong> 条记录</span></header>
    <div class="card">
        <form method="get" action="${ctx}/operation-log/list">
            <div class="table-toolbar"><div class="filter-group">
                <input class="filter-input" type="text" name="keyword" placeholder="账号 / 姓名 / 标题 / 记录编号" value="<c:out value='${keyword}'/>">
                <select class="filter-input" name="outcome" aria-label="操作结果">
                    <option value="">全部结果</option>
                    <option value="SUCCESS" ${outcome eq 'SUCCESS' ? 'selected' : ''}>成功</option>
                    <option value="REJECTED" ${outcome eq 'REJECTED' ? 'selected' : ''}>未生效</option>
                    <option value="ERROR" ${outcome eq 'ERROR' ? 'selected' : ''}>异常</option>
                </select>
                <button class="btn btn-primary btn-sm" type="submit"><i class="fa fa-search"></i>查询</button>
                <a class="btn btn-default btn-sm" href="${ctx}/operation-log/list">重置</a>
            </div></div>
        </form>
        <div style="overflow-x:auto;">
            <table class="data-table">
                <thead><tr><th class="row-idx">#</th><th>操作时间</th><th>操作账号</th><th>用户 ID</th><th>操作内容</th><th>结果</th><th>耗时</th><th>异常类型</th></tr></thead>
                <tbody>
                <c:forEach var="log" items="${page.list}" varStatus="vs">
                    <tr>
                        <td class="row-idx">${(page.pageNum - 1) * page.pageSize + vs.index + 1}</td>
                        <td><fmt:formatDate value="${log.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                        <td><c:out value="${empty log.username ? '系统/未知用户' : log.username}"/></td>
                        <td><c:out value="${log.userId}" default="—"/></td>
                        <td class="audit-operation">
                            <strong><c:out value="${log.operation}"/></strong>
                            <c:choose>
                                <c:when test="${not empty log.details}"><div class="audit-details"><c:out value="${log.details}"/></div></c:when>
                                <c:otherwise><div class="audit-legacy">历史记录未保存操作对象和变更详情</div></c:otherwise>
                            </c:choose>
                        </td>
                        <td><c:choose>
                            <c:when test="${log.outcome eq 'SUCCESS'}"><span class="badge badge-success">成功</span></c:when>
                            <c:when test="${log.outcome eq 'REJECTED'}"><span class="badge badge-secondary">未生效</span></c:when>
                            <c:otherwise><span class="badge badge-danger">异常</span></c:otherwise>
                        </c:choose></td>
                        <td>${log.durationMs} ms</td>
                        <td><c:out value="${empty log.errorType ? '—' : log.errorType}"/></td>
                    </tr>
                </c:forEach>
                <c:if test="${empty page.list}"><tr><td colspan="8"><div class="table-empty"><i class="fa fa-inbox"></i>暂无操作日志</div></td></tr></c:if>
                </tbody>
            </table>
        </div>
        <div class="pagination">
            <div class="info">共 <b>${page.total}</b> 条记录，每页 ${page.pageSize} 条</div>
            <div class="pager">
                <c:if test="${page.pageNum > 1}">
                    <c:url var="prev" value="/operation-log/list"><c:param name="keyword" value="${keyword}"/><c:param name="outcome" value="${outcome}"/><c:param name="pageNum" value="${page.pageNum - 1}"/></c:url>
                    <a href="<c:out value='${prev}'/>">上一页</a>
                </c:if>
                <span class="active">${page.pageNum} / ${page.pages > 0 ? page.pages : 1}</span>
                <c:if test="${page.pageNum < page.pages}">
                    <c:url var="next" value="/operation-log/list"><c:param name="keyword" value="${keyword}"/><c:param name="outcome" value="${outcome}"/><c:param name="pageNum" value="${page.pageNum + 1}"/></c:url>
                    <a href="<c:out value='${next}'/>">下一页</a>
                </c:if>
            </div>
        </div>
    </div>
</div>
</body>
</html>
