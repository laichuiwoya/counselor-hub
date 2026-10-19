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
    <title>工作流程纪要 - 辅导员管理系统</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${ctx}/static/css/style.css?v=20261019b">
</head>
<body class="system-page list-page">
<div class="content page-container">
    <header class="page-heading"><h1>工作流程纪要</h1><span class="page-count">共 <strong>${page.total}</strong> 条记录</span><div class="page-heading-actions"><a href="${ctx}/workflow/add" class="btn btn-primary btn-sm"><i class="fa fa-plus"></i>新增纪要</a></div></header>
    <div class="card">
        <form method="get" action="${ctx}/workflow/list" id="searchForm">
            <div class="table-toolbar">
                <div class="filter-group">
                    <input type="text" class="filter-input" name="title" placeholder="主题" value="${query.title}">
                    <select class="filter-input" name="category">
                        <option value="">全部类别</option>
                        <option value="主题班会" ${query.category eq '主题班会' ? 'selected':''}>主题班会</option>
                        <option value="学生谈话" ${query.category eq '学生谈话' ? 'selected':''}>学生谈话</option>
                        <option value="走访宿舍" ${query.category eq '走访宿舍' ? 'selected':''}>走访宿舍</option>
                        <option value="专题会议" ${query.category eq '专题会议' ? 'selected':''}>专题会议</option>
                        <option value="其他" ${query.category eq '其他' ? 'selected':''}>其他</option>
                    </select>
                    <input type="text" class="filter-input" name="location" placeholder="地点" value="${query.location}">
                    <button type="submit" class="btn btn-primary btn-sm"><i class="fa fa-search"></i>查询</button>
                    <a href="${ctx}/workflow/list" class="btn btn-default btn-sm"><i class="fa fa-rotate-left"></i>重置</a>
                </div>

            </div>
        </form>

        <div style="overflow-x:auto;">
        <table class="data-table">
            <thead>
                <tr>
                    <th class="row-idx">#</th>
                    <th>主题</th>
                    <th>类别</th>
                    <th>会议日期</th>
                    <th>地点</th>
                    <th>参与人员</th>
                    <th>负责人</th>
                    <th>登记时间</th>
                    <th class="actions">操作</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="w" items="${page.list}" varStatus="vs">
                <tr>
                    <td class="row-idx">${(page.pageNum-1)*page.pageSize + vs.index + 1}</td>
                    <td><a href="${ctx}/workflow/detail?id=${w.id}">${w.title}</a></td>
                    <td>
                        <span class="badge ${w.category eq '主题班会' ? 'badge-primary' : w.category eq '学生谈话' ? 'badge-info' : w.category eq '走访宿舍' ? 'badge-success' : w.category eq '专题会议' ? 'badge-purple' : 'badge-secondary'}">${w.category}</span>
                    </td>
                    <td><fmt:formatDate value="${w.meetingDate}" pattern="yyyy-MM-dd"/></td>
                    <td>${w.location}</td>
                    <td>${not empty w.participants and w.participants.length() > 20 ? w.participants.substring(0,20).concat('...') : w.participants}</td>
                    <td>${w.counselorName}</td>
                    <td><fmt:formatDate value="${w.createTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                    <td class="actions">
                        <a href="${ctx}/workflow/detail?id=${w.id}" class="btn-link btn-sm" title="详情"><i class="fa fa-eye"></i></a>
                        <a href="${ctx}/workflow/edit?id=${w.id}" class="btn-link btn-sm" title="编辑"><i class="fa fa-edit"></i></a>
                        <button type="button" class="btn-link danger btn-sm" title="删除" onclick="delWorkflow(${w.id})"><i class="fa fa-trash"></i></button>
                    </td>
                </tr>
                </c:forEach>
                <c:if test="${empty page.list}">
                <tr><td colspan="9">
                    <div class="table-empty"><i class="fa fa-inbox"></i>暂无工作流程纪要数据</div>
                </td></tr>
                </c:if>
            </tbody>
        </table>
        </div>

        <div class="pagination">
            <div class="info">共 <b>${page.total}</b> 条记录，第 ${page.pageNum}/${page.pages} 页</div>
            <div class="pager">
                <c:url var="base" value="/workflow/list">
                    <c:param name="title" value="${query.title}"/>
                    <c:param name="category" value="${query.category}"/>
                    <c:param name="location" value="${query.location}"/>
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
    function delWorkflow(id) {
        App.del('/workflow/delete', id, function () { location.reload(); });
    }
</script>
</body>
</html>
