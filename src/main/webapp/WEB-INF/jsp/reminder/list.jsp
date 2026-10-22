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
    <title>工作提示 - 辅导员管理系统</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${ctx}/static/css/style.css?v=20261019b">
</head>
<body class="system-page list-page">
<div class="content page-container">
    <header class="page-heading"><h1>工作提示</h1><span class="page-count">共 <strong>${page.total}</strong> 条记录</span><div class="page-heading-actions"><a href="${ctx}/reminder/add" class="btn btn-primary btn-sm"><i class="fa fa-plus"></i>新增提示</a></div></header>
    <p class="list-sort-hint" style="color:#64748b;font-size:13px;margin:0 0 12px;">默认排序：未完成优先，再按优先级从高到低、截止日期从早到晚（无截止日期排后）。</p>
    <div class="card">
<nav class="status-tabs" aria-label="状态筛选"><a href="${ctx}/reminder/list" class="${empty query.status ? 'active' : ''}">全部</a><a href="${ctx}/reminder/list?status=未完成" class="${query.status eq '未完成' ? 'active' : ''}">未完成</a><a href="${ctx}/reminder/list?status=待办" class="${query.status eq '待办' ? 'active' : ''}">待办</a><a href="${ctx}/reminder/list?status=进行中" class="${query.status eq '进行中' ? 'active' : ''}">进行中</a><a href="${ctx}/reminder/list?status=已完成" class="${query.status eq '已完成' ? 'active' : ''}">已完成</a></nav>
        <form method="get" action="${ctx}/reminder/list" id="searchForm">
            <div class="table-toolbar">
                <div class="filter-group">
                    <input type="text" class="filter-input" name="title" placeholder="标题" value="${query.title}">
                    <select class="filter-input" name="type">
                        <option value="">全部类型</option>
                        <option value="会议" ${query.type eq '会议' ? 'selected':''}>会议</option>
                        <option value="材料" ${query.type eq '材料' ? 'selected':''}>材料</option>
                        <option value="谈话" ${query.type eq '谈话' ? 'selected':''}>谈话</option>
                        <option value="检查" ${query.type eq '检查' ? 'selected':''}>检查</option>
                        <option value="其他" ${query.type eq '其他' ? 'selected':''}>其他</option>
                    </select>
                    <select class="filter-input" name="priority">
                        <option value="">全部优先级</option>
                        <option value="高" ${query.priority eq '高' ? 'selected':''}>高</option>
                        <option value="中" ${query.priority eq '中' ? 'selected':''}>中</option>
                        <option value="低" ${query.priority eq '低' ? 'selected':''}>低</option>
                    </select>
                    <select class="filter-input" name="status">
                        <option value="">全部状态</option>
                        <option value="未完成" ${query.status eq '未完成' ? 'selected':''}>未完成（待办、进行中）</option>
                        <option value="待办" ${query.status eq '待办' ? 'selected':''}>待办</option>
                        <option value="进行中" ${query.status eq '进行中' ? 'selected':''}>进行中</option>
                        <option value="已完成" ${query.status eq '已完成' ? 'selected':''}>已完成</option>
                    </select>
                    <button type="submit" class="btn btn-primary btn-sm"><i class="fa fa-search"></i>查询</button>
                    <a href="${ctx}/reminder/list" class="btn btn-default btn-sm"><i class="fa fa-rotate-left"></i>重置</a>
                </div>

            </div>
        </form>

        <div style="overflow-x:auto;">
        <table class="data-table">
            <thead>
                <tr>
                    <th class="row-idx">#</th>
                    <th>标题</th>
                    <th>类型</th>
                    <th>优先级</th>
                    <th>截止日期</th>
                    <th>状态</th>
                    <th>负责人</th>
                    <th class="actions">操作</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="r" items="${page.list}" varStatus="vs">
                <tr>
                    <td class="row-idx">${(page.pageNum-1)*page.pageSize + vs.index + 1}</td>
                    <td><a href="${ctx}/reminder/detail?id=${r.id}">${r.title}</a></td>
                    <td>${r.type}</td>
                    <td>
                        <span class="badge ${r.priority eq '高' ? 'badge-danger' : r.priority eq '中' ? 'badge-warning' : 'badge-secondary'}">${r.priority}</span>
                    </td>
                    <td><fmt:formatDate value="${r.dueDate}" pattern="yyyy-MM-dd"/></td>
                    <td>
                        <span class="badge ${r.status eq '待办' ? 'badge-secondary' : r.status eq '进行中' ? 'badge-warning' : 'badge-success'}">${r.status}</span>
                    </td>
                    <td>${r.counselorName}</td>
                    <td class="actions">
                        <a href="${ctx}/reminder/detail?id=${r.id}" class="btn-link btn-sm" title="详情"><i class="fa fa-eye"></i></a>
                        <a href="${ctx}/reminder/edit?id=${r.id}" class="btn-link btn-sm" title="编辑"><i class="fa fa-edit"></i></a>
                        <button type="button" class="btn-link btn-sm" title="开始" onclick="changeStatus(${r.id}, '进行中')"><i class="fa fa-play"></i></button>
                        <button type="button" class="btn-link btn-sm" title="完成" onclick="changeStatus(${r.id}, '已完成')"><i class="fa fa-check"></i></button>
                        <button type="button" class="btn-link btn-sm" title="重置为待办" onclick="changeStatus(${r.id}, '待办')"><i class="fa fa-rotate-left"></i></button>
                        <button type="button" class="btn-link danger btn-sm" title="删除" onclick="delReminder(${r.id})"><i class="fa fa-trash"></i></button>
                    </td>
                </tr>
                </c:forEach>
                <c:if test="${empty page.list}">
                <tr><td colspan="8">
                    <div class="table-empty"><i class="fa fa-inbox"></i>暂无工作提示数据</div>
                </td></tr>
                </c:if>
            </tbody>
        </table>
        </div>

        <div class="pagination">
            <div class="info">共 <b>${page.total}</b> 条记录，第 ${page.pageNum}/${page.pages} 页</div>
            <div class="pager">
                <c:url var="base" value="/reminder/list">
                    <c:param name="title" value="${query.title}"/>
                    <c:param name="type" value="${query.type}"/>
                    <c:param name="priority" value="${query.priority}"/>
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
    function delReminder(id) {
        App.del('/reminder/delete', id, function () { location.reload(); });
    }
    function changeStatus(id, status) {
        App.post('/reminder/changeStatus', {id: id, status: status}, function () { location.reload(); });
    }
</script>
</body>
</html>
