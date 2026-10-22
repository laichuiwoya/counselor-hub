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
    <title>学生奖惩管理 - 辅导员管理系统</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${ctx}/static/css/style.css?v=20261019b">
</head>
<body class="system-page list-page">
<div class="content page-container">
    <header class="page-heading"><h1>学生奖惩管理</h1><span class="page-count">共 <strong>${page.total}</strong> 条记录</span><div class="page-heading-actions"><a href="${ctx}/reward/add" class="btn btn-primary btn-sm"><i class="fa fa-plus"></i>新增奖惩</a></div></header>
    <p class="list-sort-hint" style="color:#64748b;font-size:13px;margin:0 0 12px;">默认排序：发生日期从新到旧。</p>
    <div class="card">
        <form method="get" action="${ctx}/reward/list" id="searchForm">
            <div class="table-toolbar">
                <div class="filter-group">
                    <input type="text" class="filter-input" name="studentNo" placeholder="学号" value="${query.studentNo}">
                    <input type="text" class="filter-input" name="studentName" placeholder="姓名" value="${query.studentName}">
                    <select class="filter-input" name="type">
                        <option value="">全部类型</option>
                        <option value="奖励" ${query.type eq '奖励' ? 'selected':''}>奖励</option>
                        <option value="处分" ${query.type eq '处分' ? 'selected':''}>处分</option>
                    </select>
                    <select class="filter-input" name="status">
                        <option value="">全部状态</option>
                        <option value="生效" ${query.status eq '生效' ? 'selected':''}>生效</option>
                        <option value="撤销" ${query.status eq '撤销' ? 'selected':''}>撤销</option>
                    </select>
                    <button type="submit" class="btn btn-primary btn-sm"><i class="fa fa-search"></i>查询</button>
                    <a href="${ctx}/reward/list" class="btn btn-default btn-sm"><i class="fa fa-rotate-left"></i>重置</a>
                </div>

            </div>
        </form>

        <div style="overflow-x:auto;">
        <table class="data-table">
            <thead>
                <tr>
                    <th class="row-idx">#</th>
                    <th>学号</th>
                    <th>姓名</th>
                    <th>班级</th>
                    <th>类型</th>
                    <th>级别</th>
                    <th>名称</th>
                    <th>发生日期</th>
                    <th>经办人</th>
                    <th>状态</th>
                    <th class="actions">操作</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="r" items="${page.list}" varStatus="vs">
                <tr>
                    <td class="row-idx">${(page.pageNum-1)*page.pageSize + vs.index + 1}</td>
                    <td>${r.studentNo}</td>
                    <td>${r.studentName}</td>
                    <td>${r.className}</td>
                    <td>
                        <span class="badge ${r.type eq '奖励' ? 'badge-success' : 'badge-danger'}">${r.type}</span>
                    </td>
                    <td>${r.level}</td>
                    <td>${r.name}</td>
                    <td><fmt:formatDate value="${r.occurDate}" pattern="yyyy-MM-dd"/></td>
                    <td>${r.operator}</td>
                    <td>
                        <span class="badge ${r.status eq '生效' ? 'badge-success' : 'badge-secondary'}">${r.status}</span>
                    </td>
                    <td class="actions">
                        <a href="${ctx}/reward/detail?id=${r.id}" class="btn-link btn-sm" title="详情"><i class="fa fa-eye"></i></a>
                        <a href="${ctx}/reward/edit?id=${r.id}" class="btn-link btn-sm" title="编辑"><i class="fa fa-edit"></i></a>
                        <button type="button" class="btn-link danger btn-sm" title="删除" onclick="delReward(${r.id})"><i class="fa fa-trash"></i></button>
                    </td>
                </tr>
                </c:forEach>
                <c:if test="${empty page.list}">
                <tr><td colspan="11">
                    <div class="table-empty"><i class="fa fa-inbox"></i>暂无奖惩数据</div>
                </td></tr>
                </c:if>
            </tbody>
        </table>
        </div>

        <div class="pagination">
            <div class="info">共 <b>${page.total}</b> 条记录，第 ${page.pageNum}/${page.pages} 页</div>
            <div class="pager">
                <c:url var="base" value="/reward/list">
                    <c:param name="studentNo" value="${query.studentNo}"/>
                    <c:param name="studentName" value="${query.studentName}"/>
                    <c:param name="type" value="${query.type}"/>
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
    function delReward(id) {
        App.del('/reward/delete', id, function () { location.reload(); });
    }
</script>
</body>
</html>
