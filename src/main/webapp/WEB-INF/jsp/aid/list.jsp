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
    <title>困难资助 - 辅导员管理系统</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${ctx}/static/css/style.css">
</head>
<body>
<div class="content">
    <div class="card">
        <form method="get" action="${ctx}/aid/list" id="searchForm">
            <div class="table-toolbar">
                <div class="filter-group">
                    <input type="text" class="filter-input" name="studentName" placeholder="学生姓名" value="${query.studentName}">
                    <select class="filter-input" name="aidType">
                        <option value="">全部类型</option>
                        <option value="助学金" ${query.aidType eq '助学金' ? 'selected':''}>助学金</option>
                        <option value="助学贷款" ${query.aidType eq '助学贷款' ? 'selected':''}>助学贷款</option>
                        <option value="困难补助" ${query.aidType eq '困难补助' ? 'selected':''}>困难补助</option>
                        <option value="勤工助学" ${query.aidType eq '勤工助学' ? 'selected':''}>勤工助学</option>
                        <option value="学费减免" ${query.aidType eq '学费减免' ? 'selected':''}>学费减免</option>
                    </select>
                    <select class="filter-input" name="difficultyLevel">
                        <option value="">全部困难等级</option>
                        <option value="一般" ${query.difficultyLevel eq '一般' ? 'selected':''}>一般</option>
                        <option value="困难" ${query.difficultyLevel eq '困难' ? 'selected':''}>困难</option>
                        <option value="特别困难" ${query.difficultyLevel eq '特别困难' ? 'selected':''}>特别困难</option>
                    </select>
                    <select class="filter-input" name="status">
                        <option value="">全部状态</option>
                        <option value="待审核" ${query.status eq '待审核' ? 'selected':''}>待审核</option>
                        <option value="已通过" ${query.status eq '已通过' ? 'selected':''}>已通过</option>
                        <option value="已驳回" ${query.status eq '已驳回' ? 'selected':''}>已驳回</option>
                        <option value="已发放" ${query.status eq '已发放' ? 'selected':''}>已发放</option>
                    </select>
                    <button type="submit" class="btn btn-primary btn-sm"><i class="fa fa-search"></i>查询</button>
                    <a href="${ctx}/aid/list" class="btn btn-default btn-sm"><i class="fa fa-rotate-left"></i>重置</a>
                </div>
                <div class="right">
                    <a href="${ctx}/aid/add" class="btn btn-primary btn-sm"><i class="fa fa-plus"></i>新增资助</a>
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
                    <th>资助类型</th>
                    <th>金额</th>
                    <th>学期</th>
                    <th>困难等级</th>
                    <th>状态</th>
                    <th>审核人</th>
                    <th class="actions">操作</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="a" items="${page.list}" varStatus="vs">
                <tr>
                    <td class="row-idx">${(page.pageNum-1)*page.pageSize + vs.index + 1}</td>
                    <td><a href="${ctx}/aid/detail?id=${a.id}">${a.studentName}</a></td>
                    <td>${a.studentNo}</td>
                    <td>${a.aidType}</td>
                    <td><c:choose><c:when test="${not empty a.amount}">¥<fmt:formatNumber value="${a.amount}" pattern="#,##0.00"/></c:when><c:otherwise>-</c:otherwise></c:choose></td>
                    <td>${a.semester}</td>
                    <td>
                        <span class="badge ${a.difficultyLevel eq '一般' ? 'badge-secondary' : a.difficultyLevel eq '困难' ? 'badge-warning' : 'badge-danger'}">${a.difficultyLevel}</span>
                    </td>
                    <td>
                        <span class="badge ${a.status eq '待审核' ? 'badge-warning' : a.status eq '已通过' ? 'badge-success' : a.status eq '已驳回' ? 'badge-danger' : 'badge-info'}">${a.status}</span>
                    </td>
                    <td>${a.counselorName}</td>
                    <td class="actions">
                        <a href="${ctx}/aid/detail?id=${a.id}" class="btn-link btn-sm" title="详情"><i class="fa fa-eye"></i></a>
                        <a href="${ctx}/aid/edit?id=${a.id}" class="btn-link btn-sm" title="编辑"><i class="fa fa-edit"></i></a>
                        <button type="button" class="btn-link btn-sm" title="通过" onclick="changeStatus(${a.id}, '已通过')"><i class="fa fa-check"></i></button>
                        <button type="button" class="btn-link btn-sm" title="驳回" onclick="changeStatus(${a.id}, '已驳回')"><i class="fa fa-ban"></i></button>
                        <button type="button" class="btn-link btn-sm" title="发放" onclick="changeStatus(${a.id}, '已发放')"><i class="fa fa-money-bill-wave"></i></button>
                        <button type="button" class="btn-link danger btn-sm" title="删除" onclick="delAid(${a.id})"><i class="fa fa-trash"></i></button>
                    </td>
                </tr>
                </c:forEach>
                <c:if test="${empty page.list}">
                <tr><td colspan="10">
                    <div class="table-empty"><i class="fa fa-inbox"></i>暂无困难资助数据</div>
                </td></tr>
                </c:if>
            </tbody>
        </table>
        </div>

        <div class="pagination">
            <div class="info">共 <b>${page.total}</b> 条记录，第 ${page.pageNum}/${page.pages} 页</div>
            <div class="pager">
                <c:url var="base" value="/aid/list">
                    <c:param name="studentName" value="${query.studentName}"/>
                    <c:param name="aidType" value="${query.aidType}"/>
                    <c:param name="difficultyLevel" value="${query.difficultyLevel}"/>
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
<script src="${ctx}/static/js/common.js"></script>
<script>
    function delAid(id) {
        App.del('/aid/delete', id, function () { location.reload(); });
    }
    function changeStatus(id, status) {
        App.post('/aid/changeStatus', {id: id, status: status}, function () { location.reload(); });
    }
</script>
</body>
</html>
