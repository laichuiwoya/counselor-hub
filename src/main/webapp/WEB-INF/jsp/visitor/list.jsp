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
    <title>访客登记 - 辅导员管理系统</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${ctx}/static/css/style.css?v=20261019b">
</head>
<body class="system-page list-page">
<div class="content page-container">
    <header class="page-heading"><h1>访客登记</h1><span class="page-count">共 <strong>${page.total}</strong> 条记录</span><div class="page-heading-actions"><a href="${ctx}/visitor/add" class="btn btn-primary btn-sm"><i class="fa fa-plus"></i>新增登记</a></div></header>
    <div class="card">
<nav class="status-tabs" aria-label="状态筛选"><a href="${ctx}/visitor/list" class="${empty query.status ? 'active' : ''}">全部</a><a href="${ctx}/visitor/list?status=在访" class="${query.status eq '在访' ? 'active' : ''}">在访</a><a href="${ctx}/visitor/list?status=已离开" class="${query.status eq '已离开' ? 'active' : ''}">已离开</a></nav>
        <form method="get" action="${ctx}/visitor/list" id="searchForm">
            <div class="table-toolbar">
                <div class="filter-group">
                    <input type="text" class="filter-input" name="visitorName" placeholder="访客姓名" value="${query.visitorName}">
                    <select class="filter-input" name="status">
                        <option value="">全部状态</option>
                        <option value="在访" ${query.status eq '在访' ? 'selected':''}>在访</option>
                        <option value="已离开" ${query.status eq '已离开' ? 'selected':''}>已离开</option>
                    </select>
                    <button type="submit" class="btn btn-primary btn-sm"><i class="fa fa-search"></i>查询</button>
                    <a href="${ctx}/visitor/list" class="btn btn-default btn-sm"><i class="fa fa-rotate-left"></i>重置</a>
                </div>

            </div>
        </form>

        <div style="overflow-x:auto;">
        <table class="data-table">
            <thead>
                <tr>
                    <th class="row-idx">#</th>
                    <th>访客姓名</th>
                    <th>联系电话</th>
                    <th>来访事由</th>
                    <th>被访对象</th>
                    <th>来访时间</th>
                    <th>离开时间</th>
                    <th>状态</th>
                    <th>登记人</th>
                    <th class="actions">操作</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="v" items="${page.list}" varStatus="vs">
                <tr>
                    <td class="row-idx">${(page.pageNum-1)*page.pageSize + vs.index + 1}</td>
                    <td><a href="${ctx}/visitor/detail?id=${v.id}">${v.visitorName}</a></td>
                    <td>${v.phone}</td>
                    <td>${v.visitPurpose}</td>
                    <td>${v.visitObject}</td>
                    <td><fmt:formatDate value="${v.visitTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                    <td><fmt:formatDate value="${v.leaveTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                    <td>
                        <span class="badge ${v.status eq '在访' ? 'badge-warning' : 'badge-secondary'}">${v.status}</span>
                    </td>
                    <td>${v.counselorName}</td>
                    <td class="actions">
                        <a href="${ctx}/visitor/detail?id=${v.id}" class="btn-link btn-sm" title="详情"><i class="fa fa-eye"></i></a>
                        <a href="${ctx}/visitor/edit?id=${v.id}" class="btn-link btn-sm" title="编辑"><i class="fa fa-edit"></i></a>
                        <c:if test="${v.status eq '在访'}">
                        <button type="button" class="btn-link btn-sm" title="离开" onclick="leaveVisitor(${v.id})"><i class="fa fa-door-open"></i></button>
                        </c:if>
                        <button type="button" class="btn-link danger btn-sm" title="删除" onclick="delVisitor(${v.id})"><i class="fa fa-trash"></i></button>
                    </td>
                </tr>
                </c:forEach>
                <c:if test="${empty page.list}">
                <tr><td colspan="10">
                    <div class="table-empty"><i class="fa fa-inbox"></i>暂无访客登记数据</div>
                </td></tr>
                </c:if>
            </tbody>
        </table>
        </div>

        <div class="pagination">
            <div class="info">共 <b>${page.total}</b> 条记录，第 ${page.pageNum}/${page.pages} 页</div>
            <div class="pager">
                <c:url var="base" value="/visitor/list">
                    <c:param name="visitorName" value="${query.visitorName}"/>
                    <c:param name="status" value="${query.status}"/>
                </c:url>
                <c:choose>
                    <c:when test="${page.pageNum > 1}">
                        <a href="${base}&pageNum=1">首页</a>
                        <a href="${base}&pageNum=${page.pageNum-1}"><i class="fa fa-angle-left"></i></a>
                    </c:when>
                    <c:otherwise>
                        <span class="disabled">首页</span>
                        <span class="disabled"><i class="fa fa-angle-left"></i></span>
                    </c:otherwise>
                </c:choose>
                <c:forEach begin="${page.pageNum-2 > 1 ? page.pageNum-2 : 1}" end="${page.pageNum+2 < page.pages ? page.pageNum+2 : page.pages}" var="i">
                    <a href="${base}&pageNum=${i}" class="${i eq page.pageNum ? 'active':''}">${i}</a>
                </c:forEach>
                <c:choose>
                    <c:when test="${page.pageNum < page.pages}">
                        <a href="${base}&pageNum=${page.pageNum+1}"><i class="fa fa-angle-right"></i></a>
                        <a href="${base}&pageNum=${page.pages}">末页</a>
                    </c:when>
                    <c:otherwise>
                        <span class="disabled"><i class="fa fa-angle-right"></i></span>
                        <span class="disabled">末页</span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="${ctx}/static/js/common.js?v=20261019b"></script>
<script>
    function delVisitor(id) {
        App.del('/visitor/delete', id, function () { location.reload(); });
    }
    function leaveVisitor(id) {
        App.post('/visitor/changeStatus', {id: id, status: '已离开'}, function () { location.reload(); });
    }
</script>
</body>
</html>
