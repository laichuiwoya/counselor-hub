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
    <title>请假管理 - 辅导员管理系统</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${ctx}/static/css/style.css?v=20261019b">
</head>
<body class="system-page list-page">
<div class="content page-container">
    <header class="page-heading"><h1>请假管理</h1><span class="page-count">共 <strong>${page.total}</strong> 条记录</span><div class="page-heading-actions"><a href="${ctx}/leave/add" class="btn btn-primary btn-sm"><i class="fa fa-plus"></i>新增请假</a></div></header>
    <p class="list-sort-hint" style="color:#64748b;font-size:13px;margin:0 0 12px;">默认排序：待审批、已批准优先，同组按申请时间从新到旧。</p>
    <div class="card">
<nav class="status-tabs" aria-label="状态筛选"><a href="${ctx}/leave/list" class="${empty query.status ? 'active' : ''}">全部</a><a href="${ctx}/leave/list?status=待审批" class="${query.status eq '待审批' ? 'active' : ''}">待审批</a><a href="${ctx}/leave/list?status=已批准" class="${query.status eq '已批准' ? 'active' : ''}">已批准</a><a href="${ctx}/leave/list?status=已销假" class="${query.status eq '已销假' ? 'active' : ''}">已销假</a><a href="${ctx}/leave/list?status=已驳回" class="${query.status eq '已驳回' ? 'active' : ''}">已驳回</a></nav>
        <form method="get" action="${ctx}/leave/list" id="searchForm">
            <div class="table-toolbar">
                <div class="filter-group">
                    <input type="text" class="filter-input" name="studentName" placeholder="学生姓名" value="${query.studentName}">
                    <select class="filter-input" name="leaveType">
                        <option value="">全部类型</option>
                        <option value="病假" ${query.leaveType eq '病假' ? 'selected':''}>病假</option>
                        <option value="事假" ${query.leaveType eq '事假' ? 'selected':''}>事假</option>
                        <option value="公假" ${query.leaveType eq '公假' ? 'selected':''}>公假</option>
                        <option value="其他" ${query.leaveType eq '其他' ? 'selected':''}>其他</option>
                    </select>
                    <select class="filter-input" name="status">
                        <option value="">全部状态</option>
                        <option value="待审批" ${query.status eq '待审批' ? 'selected':''}>待审批</option>
                        <option value="已批准" ${query.status eq '已批准' ? 'selected':''}>已批准</option>
                        <option value="已驳回" ${query.status eq '已驳回' ? 'selected':''}>已驳回</option>
                        <option value="已销假" ${query.status eq '已销假' ? 'selected':''}>已销假</option>
                    </select>
                    <button type="submit" class="btn btn-primary btn-sm"><i class="fa fa-search"></i>查询</button>
                    <a href="${ctx}/leave/list" class="btn btn-default btn-sm"><i class="fa fa-rotate-left"></i>重置</a>
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
                    <th>请假类型</th>
                    <th>开始日期</th>
                    <th>结束日期</th>
                    <th>天数</th>
                    <th>状态</th>
                    <th>审批人</th>
                    <th class="actions">操作</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="r" items="${page.list}" varStatus="vs">
                <tr>
                    <td class="row-idx">${(page.pageNum-1)*page.pageSize + vs.index + 1}</td>
                    <td><a href="${ctx}/leave/detail?id=${r.id}">${r.studentName}</a></td>
                    <td>${r.studentNo}</td>
                    <td>${r.leaveType}</td>
                    <td><fmt:formatDate value="${r.startDate}" pattern="yyyy-MM-dd"/></td>
                    <td><fmt:formatDate value="${r.endDate}" pattern="yyyy-MM-dd"/></td>
                    <td>${r.days}</td>
                    <td>
                        <span class="badge ${r.status eq '待审批' ? 'badge-warning' : r.status eq '已批准' ? 'badge-success' : r.status eq '已驳回' ? 'badge-danger' : 'badge-secondary'}">${r.status}</span>
                    </td>
                    <td>${r.counselorName}</td>
                    <td class="actions">
                        <a href="${ctx}/leave/detail?id=${r.id}" class="btn-link btn-sm" title="详情"><i class="fa fa-eye"></i></a>
                        <a href="${ctx}/leave/edit?id=${r.id}" class="btn-link btn-sm" title="编辑"><i class="fa fa-edit"></i></a>
                        <c:if test="${r.status eq '待审批'}"><button type="button" class="btn-link btn-sm" title="批准" onclick="changeStatus(${r.id}, '已批准')"><i class="fa fa-check"></i></button></c:if>
                        <c:if test="${r.status eq '待审批'}"><button type="button" class="btn-link btn-sm" title="驳回" onclick="changeStatus(${r.id}, '已驳回')"><i class="fa fa-ban"></i></button></c:if>
                        <c:if test="${r.status eq '已批准'}"><button type="button" class="btn-link btn-sm" title="销假" onclick="changeStatus(${r.id}, '已销假')"><i class="fa fa-rotate-left"></i></button></c:if>
                        <button type="button" class="btn-link danger btn-sm" title="删除" onclick="delLeave(${r.id})"><i class="fa fa-trash"></i></button>
                    </td>
                </tr>
                </c:forEach>
                <c:if test="${empty page.list}">
                <tr><td colspan="10">
                    <div class="table-empty"><i class="fa fa-inbox"></i>暂无请假记录</div>
                </td></tr>
                </c:if>
            </tbody>
        </table>
        </div>

        <div class="pagination">
            <div class="info">共 <b>${page.total}</b> 条记录，第 ${page.pageNum}/${page.pages} 页</div>
            <div class="pager">
                <c:url var="base" value="/leave/list">
                    <c:param name="studentName" value="${query.studentName}"/>
                    <c:param name="leaveType" value="${query.leaveType}"/>
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
    function delLeave(id) {
        App.del('/leave/delete', id, function () { location.reload(); });
    }
    function changeStatus(id, status) {
        App.changeRecordStatus('/leave/changeStatus', id, status);
    }
</script>
</body>
</html>
