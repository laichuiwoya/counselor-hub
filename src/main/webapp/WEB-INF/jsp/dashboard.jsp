<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="user" value="${sessionScope.loginUser}"/>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="ctx" content="${ctx}">
    <title>工作台 - 辅导员管理系统</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${ctx}/static/css/style.css?v=20261019b">
    <link rel="stylesheet" href="${ctx}/static/css/dashboard.css?v=20261019c">
</head>
<body>
<div class="content desk">
    <header class="page-heading"><h1>工作台</h1><time class="page-date"><fmt:formatDate value="<%= new java.util.Date() %>" pattern="yyyy年MM月dd日 EEEE"/></time></header>
    <section class="desk-metrics" aria-label="核心数据">
        <a class="desk-metric" href="${ctx}/student/list?status=在读" data-title="学生基本管理"><span class="desk-icon"><i class="fa fa-users"></i></span><div><span>在读学生</span><strong>${vo.studentCount}</strong></div><i class="fa fa-angle-right"></i></a>
        <a class="desk-metric" href="${ctx}/archive/list" data-title="学生档案管理"><span class="desk-icon"><i class="fa fa-folder-open"></i></span><div><span>学生档案管理</span><strong>${vo.archiveCount}</strong></div><i class="fa fa-angle-right"></i></a>
        <a class="desk-metric" href="${ctx}/workflow/list" data-title="工作流程纪要"><span class="desk-icon"><i class="fa fa-clipboard-list"></i></span><div><span>工作流程纪要</span><strong>${vo.workflowCount}</strong></div><i class="fa fa-angle-right"></i></a>
        <a class="desk-metric" href="${ctx}/reminder/list?status=已完成" data-title="工作提示"><span class="desk-icon"><i class="fa fa-circle-check"></i></span><div><span>已完成工作</span><strong>${vo.reminderDoneCount}</strong></div><i class="fa fa-angle-right"></i></a>
    </section>
    <div class="desk-section-heading"><div><h2>待处理</h2></div></div>
    <section class="desk-priorities" aria-label="待处理事务">
        <a class="desk-metric desk-priority" href="${ctx}/reminder/list?status=未完成" data-title="工作提示"><span class="desk-icon"><i class="fa fa-bell"></i></span><div><span>工作提示</span><strong>${vo.reminderTodoCount}<small>项</small></strong></div><i class="fa fa-angle-right"></i></a>
        <a class="desk-metric desk-priority" href="${ctx}/leave/list?status=待审批" data-title="请假管理"><span class="desk-icon"><i class="fa fa-calendar-check"></i></span><div><span>请假管理</span><strong>${vo.leavePendingCount}<small>项</small></strong></div><i class="fa fa-angle-right"></i></a>
        <a class="desk-metric desk-priority" href="${ctx}/aid/list?status=待审核" data-title="困难资助"><span class="desk-icon"><i class="fa fa-hand-holding-heart"></i></span><div><span>困难资助</span><strong>${vo.aidPendingCount}<small>项</small></strong></div><i class="fa fa-angle-right"></i></a>
        <a class="desk-metric desk-priority" href="${ctx}/visitor/list?status=在访" data-title="访客登记"><span class="desk-icon"><i class="fa fa-user-plus"></i></span><div><span>访客登记</span><strong>${vo.visitorCount}<small>人</small></strong></div><i class="fa fa-angle-right"></i></a>
    </section>
    <div class="desk-section-heading"><div><h2>最近动态</h2></div></div>
    <!-- 最近记录 -->
    <div class="desk-records">
        <div class="card">
            <div class="card-header">
                <span class="card-title"><i class="fa fa-bell"></i>近期工作提示</span>
                <a href="${ctx}/reminder/list" data-title="工作提示" class="btn-link">查看全部 <i class="fa fa-angle-right"></i></a>
            </div>
            <div class="card-body">
                <ul class="todo-list">
                    <c:forEach var="r" items="${reminders}">
                        <li>
                            <span class="pri-dot ${r.priority eq '高' ? 'high' : r.priority eq '低' ? 'low' : 'mid'}"></span>
                            <div class="info">
                                <div class="t"><a href="${ctx}/reminder/detail?id=${r.id}" data-title="工作提示"><c:out value="${r.title}"/></a></div>
                                <div class="d">截止：<fmt:formatDate value="${r.dueDate}" pattern="yyyy-MM-dd"/></div>
                            </div>
                            <span class="badge ${r.status eq '已完成' ? 'badge-success' : r.status eq '进行中' ? 'badge-warning' : 'badge-secondary'}">${r.status}</span>
                        </li>
                    </c:forEach>
                    <c:if test="${empty reminders}">
                        <li style="justify-content:center;color:var(--text-muted);">暂无工作提示</li>
                    </c:if>
                </ul>
            </div>
        </div>
        <div class="card">
            <div class="card-header">
                <span class="card-title"><i class="fa fa-clipboard-list"></i>近期工作流程纪要</span>
                <a href="${ctx}/workflow/list" data-title="工作流程纪要" class="btn-link">查看全部 <i class="fa fa-angle-right"></i></a>
            </div>
            <div class="card-body">
                <ul class="todo-list">
                    <c:forEach var="w" items="${workflows}">
                        <li>
                            <span class="pri-dot mid"></span>
                            <div class="info">
                                <div class="t"><c:out value="${w.title}"/></div>
                                <div class="d"><c:out value="${w.category}"/> · <fmt:formatDate value="${w.meetingDate}" pattern="yyyy-MM-dd"/> · <c:out value="${w.location}"/></div>
                            </div>
                            <a href="${ctx}/workflow/detail?id=${w.id}" data-title="工作流程纪要" class="btn-link btn-sm">查看</a>
                        </li>
                    </c:forEach>
                    <c:if test="${empty workflows}">
                        <li style="justify-content:center;color:var(--text-muted);">暂无工作流程纪要</li>
                    </c:if>
                </ul>
            </div>
        </div>
    </div>
</div>

<script>
    document.querySelectorAll('.desk a[data-title]').forEach(function (link) {
        link.addEventListener('click', function (event) {
            if (event.ctrlKey || event.metaKey || event.shiftKey || event.altKey) return;
            if (window.parent !== window && typeof window.parent.nav === 'function') {
                event.preventDefault();
                window.parent.nav(link.getAttribute('href'), link.dataset.title, link.dataset.title);
            }
        });
    });
</script>
</body>
</html>
