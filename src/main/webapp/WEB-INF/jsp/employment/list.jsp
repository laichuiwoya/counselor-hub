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
    <title>就业跟踪 - 辅导员管理系统</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${ctx}/static/css/style.css?v=20261019b">
</head>
<body class="system-page list-page">
<div class="content page-container">
    <header class="page-heading"><h1>就业跟踪</h1><span class="page-count">共 <strong>${page.total}</strong> 条记录</span><div class="page-heading-actions"><a href="${ctx}/employment/add" class="btn btn-primary btn-sm"><i class="fa fa-plus"></i>新增跟踪</a></div></header>
    <div class="card">
        <form method="get" action="${ctx}/employment/list" id="searchForm">
            <div class="table-toolbar">
                <div class="filter-group">
                    <input type="text" class="filter-input" name="studentName" placeholder="学生姓名" value="${query.studentName}">
                    <select class="filter-input" name="employmentStatus">
                        <option value="">全部状态</option>
                        <option value="已就业" ${query.employmentStatus eq '已就业' ? 'selected':''}>已就业</option>
                        <option value="升学" ${query.employmentStatus eq '升学' ? 'selected':''}>升学</option>
                        <option value="考公" ${query.employmentStatus eq '考公' ? 'selected':''}>考公</option>
                        <option value="创业" ${query.employmentStatus eq '创业' ? 'selected':''}>创业</option>
                        <option value="未就业" ${query.employmentStatus eq '未就业' ? 'selected':''}>未就业</option>
                    </select>
                    <button type="submit" class="btn btn-primary btn-sm"><i class="fa fa-search"></i>查询</button>
                    <a href="${ctx}/employment/list" class="btn btn-default btn-sm"><i class="fa fa-rotate-left"></i>重置</a>
                </div>

            </div>
        </form>

        <div style="overflow-x:auto;">
        <table class="data-table">
            <thead>
                <tr>
                    <th class="row-idx">#</th>
                    <th>学生姓名</th>
                    <th>学号</th>
                    <th>就业状态</th>
                    <th>就业单位/升学学校</th>
                    <th>岗位/专业</th>
                    <th>城市</th>
                    <th>薪资</th>
                    <th>跟踪日期</th>
                    <th class="actions">操作</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="e" items="${page.list}" varStatus="vs">
                <tr>
                    <td class="row-idx">${(page.pageNum-1)*page.pageSize + vs.index + 1}</td>
                    <td><a href="${ctx}/employment/detail?id=${e.id}">${e.studentName}</a></td>
                    <td>${e.studentNo}</td>
                    <td>
                        <span class="badge ${e.employmentStatus eq '已就业' ? 'badge-success' : e.employmentStatus eq '升学' ? 'badge-info' : e.employmentStatus eq '考公' ? 'badge-primary' : e.employmentStatus eq '创业' ? 'badge-warning' : 'badge-secondary'}">${e.employmentStatus}</span>
                    </td>
                    <td>${e.employmentStatus eq '升学' ? e.school : e.company}</td>
                    <td>${e.employmentStatus eq '升学' ? e.major : e.position}</td>
                    <td>${e.city}</td>
                    <td>
                        <c:if test="${not empty e.salary}">¥<fmt:formatNumber value="${e.salary}" pattern="#,##0.00"/></c:if>
                    </td>
                    <td><fmt:formatDate value="${e.trackDate}" pattern="yyyy-MM-dd"/></td>
                    <td class="actions">
                        <a href="${ctx}/employment/detail?id=${e.id}" class="btn-link btn-sm" title="详情"><i class="fa fa-eye"></i></a>
                        <a href="${ctx}/employment/edit?id=${e.id}" class="btn-link btn-sm" title="编辑"><i class="fa fa-edit"></i></a>
                        <button type="button" class="btn-link danger btn-sm" title="删除" onclick="delEmp(${e.id})"><i class="fa fa-trash"></i></button>
                    </td>
                </tr>
                </c:forEach>
                <c:if test="${empty page.list}">
                <tr><td colspan="10">
                    <div class="table-empty"><i class="fa fa-inbox"></i>暂无就业跟踪数据</div>
                </td></tr>
                </c:if>
            </tbody>
        </table>
        </div>

        <div class="pagination">
            <div class="info">共 <b>${page.total}</b> 条记录，第 ${page.pageNum}/${page.pages} 页</div>
            <div class="pager">
                <c:url var="base" value="/employment/list">
                    <c:param name="studentName" value="${query.studentName}"/>
                    <c:param name="employmentStatus" value="${query.employmentStatus}"/>
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
    function delEmp(id) {
        App.del('/employment/delete', id, function () { location.reload(); });
    }
</script>
</body>
</html>
