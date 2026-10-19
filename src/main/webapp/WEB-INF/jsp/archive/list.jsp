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
    <title>学生档案管理 - 辅导员管理系统</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${ctx}/static/css/style.css?v=20261019b">
</head>
<body class="system-page list-page">
<div class="content page-container">
    <header class="page-heading"><h1>学生档案管理</h1><span class="page-count">共 <strong>${page.total}</strong> 条记录</span><div class="page-heading-actions"><a href="${ctx}/archive/add" class="btn btn-primary btn-sm"><i class="fa fa-folder-plus"></i>归档新档案</a></div></header>
    <div class="card">
        <form method="get" action="${ctx}/archive/list" id="searchForm">
            <div class="table-toolbar">
                <div class="filter-group">
                    <input type="text" class="filter-input" name="studentNo" placeholder="学号" value="${query.studentNo}">
                    <input type="text" class="filter-input" name="studentName" placeholder="姓名" value="${query.studentName}">
                    <select class="filter-input" name="archiveType">
                        <option value="">全部类型</option>
                        <option value="入学登记表" ${query.archiveType eq '入学登记表' ? 'selected':''}>入学登记表</option>
                        <option value="成绩单" ${query.archiveType eq '成绩单' ? 'selected':''}>成绩单</option>
                        <option value="奖惩材料" ${query.archiveType eq '奖惩材料' ? 'selected':''}>奖惩材料</option>
                        <option value="实习材料" ${query.archiveType eq '实习材料' ? 'selected':''}>实习材料</option>
                        <option value="毕业材料" ${query.archiveType eq '毕业材料' ? 'selected':''}>毕业材料</option>
                        <option value="其他" ${query.archiveType eq '其他' ? 'selected':''}>其他</option>
                    </select>
                    <input type="text" class="filter-input" name="operator" placeholder="经办人" value="${query.operator}">
                    <button type="submit" class="btn btn-primary btn-sm"><i class="fa fa-search"></i>查询</button>
                    <a href="${ctx}/archive/list" class="btn btn-default btn-sm"><i class="fa fa-rotate-left"></i>重置</a>
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
                    <th>档案类型</th>
                    <th>档案名称</th>
                    <th>归档日期</th>
                    <th>经办人</th>
                    <th class="actions">操作</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="a" items="${page.list}" varStatus="vs">
                <tr>
                    <td class="row-idx">${(page.pageNum-1)*page.pageSize + vs.index + 1}</td>
                    <td>${a.studentNo}</td>
                    <td>${a.studentName}</td>
                    <td>${a.className}</td>
                    <td>
                        <c:choose>
                            <c:when test="${a.archiveType eq '入学登记表'}"><span class="badge badge-primary">${a.archiveType}</span></c:when>
                            <c:when test="${a.archiveType eq '成绩单'}"><span class="badge badge-info">${a.archiveType}</span></c:when>
                            <c:when test="${a.archiveType eq '奖惩材料'}"><span class="badge badge-warning">${a.archiveType}</span></c:when>
                            <c:when test="${a.archiveType eq '实习材料'}"><span class="badge badge-success">${a.archiveType}</span></c:when>
                            <c:when test="${a.archiveType eq '毕业材料'}"><span class="badge badge-purple">${a.archiveType}</span></c:when>
                            <c:otherwise><span class="badge badge-secondary">${a.archiveType}</span></c:otherwise>
                        </c:choose>
                    </td>
                    <td>${a.archiveName}</td>
                    <td><fmt:formatDate value="${a.uploadDate}" pattern="yyyy-MM-dd"/></td>
                    <td>${a.operator}</td>
                    <td class="actions">
                        <a href="${ctx}/archive/detail?id=${a.id}" class="btn-link btn-sm" title="详情"><i class="fa fa-eye"></i></a>
                        <a href="${ctx}/archive/edit?id=${a.id}" class="btn-link btn-sm" title="编辑"><i class="fa fa-edit"></i></a>
                        <button type="button" class="btn-link danger btn-sm" title="删除" onclick="delArchive(${a.id})"><i class="fa fa-trash"></i></button>
                    </td>
                </tr>
                </c:forEach>
                <c:if test="${empty page.list}">
                <tr><td colspan="9">
                    <div class="table-empty"><i class="fa fa-inbox"></i>暂无档案数据</div>
                </td></tr>
                </c:if>
            </tbody>
        </table>
        </div>

        <div class="pagination">
            <div class="info">共 <b>${page.total}</b> 条记录，第 ${page.pageNum}/${page.pages} 页</div>
            <div class="pager">
                <c:url var="base" value="/archive/list">
                    <c:param name="studentNo" value="${query.studentNo}"/>
                    <c:param name="studentName" value="${query.studentName}"/>
                    <c:param name="archiveType" value="${query.archiveType}"/>
                    <c:param name="operator" value="${query.operator}"/>
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
    function delArchive(id) {
        App.del('/archive/delete', id, function () { location.reload(); });
    }
</script>
</body>
</html>
