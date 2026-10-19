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
    <title>系统用户管理 - 辅导员管理系统</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${ctx}/static/css/style.css?v=20261019b">
</head>
<body class="system-page list-page">
<div class="content page-container">
    <header class="page-heading"><h1>系统用户</h1><span class="page-count">共 <strong>${page.total}</strong> 条记录</span><div class="page-heading-actions"><a href="${ctx}/user/add" class="btn btn-primary btn-sm"><i class="fa fa-user-plus"></i>新增用户</a></div></header>
    <div class="card">
        <form method="get" action="${ctx}/user/list" id="searchForm">
            <div class="table-toolbar">
                <div class="filter-group">
                    <input type="text" class="filter-input" name="keyword" placeholder="账号/姓名/手机" value="${keyword}">
                    <button type="submit" class="btn btn-primary btn-sm"><i class="fa fa-search"></i>查询</button>
                    <a href="${ctx}/user/list" class="btn btn-default btn-sm"><i class="fa fa-rotate-left"></i>重置</a>
                </div>

            </div>
        </form>

        <div style="overflow-x:auto;">
        <table class="data-table">
            <thead>
                <tr>
                    <th class="row-idx">#</th>
                    <th>账号</th>
                    <th>真实姓名</th>
                    <th>角色</th>
                    <th>手机号</th>
                    <th>邮箱</th>
                    <th>状态</th>
                    <th>创建时间</th>
                    <th class="actions">操作</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="u" items="${users}" varStatus="vs">
                <tr>
                    <td class="row-idx">${vs.index + 1}</td>
                    <td>${u.username}</td>
                    <td>${u.realName}</td>
                    <td>
                        <span class="badge ${u.role eq 'admin' ? 'badge-purple' : 'badge-primary'}">
                            ${u.role eq 'admin' ? '管理员' : '辅导员'}
                        </span>
                    </td>
                    <td>${u.phone}</td>
                    <td>${u.email}</td>
                    <td>
                        <span class="badge ${u.status eq 1 ? 'badge-success' : 'badge-secondary'}">
                            ${u.status eq 1 ? '启用' : '禁用'}
                        </span>
                    </td>
                    <td><fmt:formatDate value="${u.createTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                    <td class="actions">
                        <a href="${ctx}/user/edit?id=${u.id}" class="btn-link btn-sm" title="编辑"><i class="fa fa-edit"></i></a>
                        <button type="button" class="btn-link btn-sm" title="重置密码" onclick="resetPwd(${u.id})"><i class="fa fa-key"></i></button>
                        <button type="button" class="btn-link danger btn-sm" title="删除" onclick="delUser(${u.id}, '${u.username}')"><i class="fa fa-trash"></i></button>
                    </td>
                </tr>
                </c:forEach>
                <c:if test="${empty users}">
                <tr><td colspan="9">
                    <div class="table-empty"><i class="fa fa-inbox"></i>暂无用户数据</div>
                </td></tr>
                </c:if>
            </tbody>
        </table>
        </div>

        <div class="pagination">
            <div class="info">共 <b>${users.size()}</b> 条记录</div>
            <div class="pager"></div>
        </div>
    </div>
</div>

<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="${ctx}/static/js/common.js?v=20261019b"></script>
<script>
    function resetPwd(id) {
        App.post('/user/resetPwd', { id: id }, function () {
            App.toast('已重置为123456', 'success');
        });
    }
    function delUser(id, username) {
        if (username === 'admin') {
            App.toast('admin 账号不可删除', 'error');
            return;
        }
        App.del('/user/delete', id, function () { location.reload(); });
    }
</script>
</body>
</html>
