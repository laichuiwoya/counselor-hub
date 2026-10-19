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
    <link rel="stylesheet" href="${ctx}/static/css/style.css">
</head>
<body>
<div class="content">
    <!-- 欢迎横幅 -->
    <div class="welcome-banner">
        <h3>${user.realName}，欢迎回来！<span style="font-size:14px;font-weight:400;opacity:.85;margin-left:10px;">${user.role eq 'admin' ? '系统管理员' : '辅导员'}</span></h3>
        <p>当前共有 <b>${vo.studentCount}</b> 名在读学生，待办工作提示 <b>${vo.reminderTodoCount}</b> 项，已累计记录工作流程纪要 <b>${vo.workflowCount}</b> 篇。</p>
        <span class="date-tag"><i class="fa fa-calendar-day"></i> <fmt:formatDate value="<%= new java.util.Date() %>" pattern="yyyy年MM月dd日 EEEE"/></span>
    </div>

    <!-- 统计卡片 -->
    <div class="stat-row">
        <div class="stat-card blue">
            <div class="stat-icon"><i class="fa fa-users"></i></div>
            <div class="stat-label">在读学生</div>
            <div class="stat-value" id="cntStudent">${vo.studentCount}</div>
            <div class="stat-foot">学生基本管理</div>
        </div>
        <div class="stat-card green">
            <div class="stat-icon"><i class="fa fa-trophy"></i></div>
            <div class="stat-label">奖励记录</div>
            <div class="stat-value">${vo.rewardCount}</div>
            <div class="stat-foot">生效奖励数</div>
        </div>
        <div class="stat-card orange">
            <div class="stat-icon"><i class="fa fa-gavel"></i></div>
            <div class="stat-label">处分记录</div>
            <div class="stat-value">${vo.punishCount}</div>
            <div class="stat-foot">生效处分数</div>
        </div>
        <div class="stat-card purple">
            <div class="stat-icon"><i class="fa fa-bell"></i></div>
            <div class="stat-label">待办工作</div>
            <div class="stat-value">${vo.reminderTodoCount}</div>
            <div class="stat-foot">待办+进行中</div>
        </div>
        <div class="stat-card teal">
            <div class="stat-icon"><i class="fa fa-clipboard-list"></i></div>
            <div class="stat-label">工作流程纪要</div>
            <div class="stat-value">${vo.workflowCount}</div>
            <div class="stat-foot">累计篇数</div>
        </div>
        <div class="stat-card pink">
            <div class="stat-icon"><i class="fa fa-folder-open"></i></div>
            <div class="stat-label">学生档案</div>
            <div class="stat-value">${vo.archiveCount}</div>
            <div class="stat-foot">已归档份数</div>
        </div>
        <div class="stat-card" style="background:linear-gradient(135deg,#0ea5e9,#3b82f6);color:#fff;">
            <div class="stat-icon"><i class="fa fa-circle-check"></i></div>
            <div class="stat-label">已完成工作</div>
            <div class="stat-value">${vo.reminderDoneCount}</div>
            <div class="stat-foot">已完成提示数</div>
        </div>
        <div class="stat-card" style="background:linear-gradient(135deg,#475569,#64748b);color:#fff;">
            <div class="stat-icon"><i class="fa fa-chart-pie"></i></div>
            <div class="stat-label">学院数</div>
            <div class="stat-value">${fn:length(vo.collegeStat)}</div>
            <div class="stat-foot">覆盖学院</div>
        </div>
        <div class="stat-card" style="background:linear-gradient(135deg,#e11d48,#f43f5e);color:#fff;">
            <div class="stat-icon"><i class="fa fa-calendar-times"></i></div>
            <div class="stat-label">待审批请假</div>
            <div class="stat-value">${vo.leavePendingCount}</div>
            <div class="stat-foot">请假管理</div>
        </div>
        <div class="stat-card" style="background:linear-gradient(135deg,#0369a1,#0ea5e9);color:#fff;">
            <div class="stat-icon"><i class="fa fa-user-plus"></i></div>
            <div class="stat-label">在访人员</div>
            <div class="stat-value">${vo.visitorCount}</div>
            <div class="stat-foot">访客登记</div>
        </div>
        <div class="stat-card" style="background:linear-gradient(135deg,#be185d,#ec4899);color:#fff;">
            <div class="stat-icon"><i class="fa fa-hand-holding-heart"></i></div>
            <div class="stat-label">待审核资助</div>
            <div class="stat-value">${vo.aidPendingCount}</div>
            <div class="stat-foot">困难资助</div>
        </div>
        <div class="stat-card" style="background:linear-gradient(135deg,#15803d,#22c55e);color:#fff;">
            <div class="stat-icon"><i class="fa fa-briefcase"></i></div>
            <div class="stat-label">已就业人数</div>
            <div class="stat-value">${vo.employedCount}</div>
            <div class="stat-foot">就业跟踪</div>
        </div>
    </div>

    <!-- 图表区 -->
    <div style="display:grid;grid-template-columns:1fr 1fr 1fr;gap:18px;margin-bottom:18px;">
        <div class="card">
            <div class="card-header"><span class="card-title"><i class="fa fa-building"></i>各学院学生分布</span></div>
            <div class="card-body"><div id="chartCollege" style="height:280px;"></div></div>
        </div>
        <div class="card">
            <div class="card-header"><span class="card-title"><i class="fa fa-venus-mars"></i>性别构成</span></div>
            <div class="card-body"><div id="chartGender" style="height:280px;"></div></div>
        </div>
        <div class="card">
            <div class="card-header"><span class="card-title"><i class="fa fa-flag"></i>政治面貌</span></div>
            <div class="card-body"><div id="chartPolitical" style="height:280px;"></div></div>
        </div>
    </div>

    <!-- 最近记录 -->
    <div style="display:grid;grid-template-columns:1fr 1fr;gap:18px;">
        <div class="card">
            <div class="card-header">
                <span class="card-title"><i class="fa fa-bell"></i>近期工作提示</span>
                <a href="javascript:parent.nav('${ctx}/reminder/list','工作提示','日常 / 工作提示')" class="btn-link">查看全部 <i class="fa fa-angle-right"></i></a>
            </div>
            <div class="card-body">
                <ul class="todo-list">
                    <c:forEach var="r" items="${reminders}">
                        <li>
                            <span class="pri-dot ${r.priority eq '高' ? 'high' : r.priority eq '低' ? 'low' : 'mid'}"></span>
                            <div class="info">
                                <div class="t">${r.title}</div>
                                <div class="d">截止：<fmt:formatDate value="${r.dueDate}" pattern="yyyy-MM-dd"/> · 状态：${r.status}</div>
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
                <span class="card-title"><i class="fa fa-clipboard-list"></i>近期工作纪要</span>
                <a href="javascript:parent.nav('${ctx}/workflow/list','工作流程纪要','日常 / 流程纪要')" class="btn-link">查看全部 <i class="fa fa-angle-right"></i></a>
            </div>
            <div class="card-body">
                <ul class="todo-list">
                    <c:forEach var="w" items="${workflows}">
                        <li>
                            <span class="pri-dot mid"></span>
                            <div class="info">
                                <div class="t">${w.title}</div>
                                <div class="d">${w.category} · <fmt:formatDate value="${w.meetingDate}" pattern="yyyy-MM-dd"/> · ${w.location}</div>
                            </div>
                            <a href="${ctx}/workflow/detail?id=${w.id}" target="_blank" class="btn-link btn-sm">查看</a>
                        </li>
                    </c:forEach>
                    <c:if test="${empty workflows}">
                        <li style="justify-content:center;color:var(--text-muted);">暂无工作纪要</li>
                    </c:if>
                </ul>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://cdn.bootcdn.net/ajax/libs/echarts/5.4.3/echarts.min.js"></script>
<script src="${ctx}/static/js/common.js"></script>
<script>
    $(function () {
        var colorPalette = ['#2b5aed','#16a34a','#f59e0b','#dc2626','#0ea5e9','#7c3aed','#db2777','#0d9488','#475569','#ea580c'];
        <jsp:useBean id="jsonUtil" class="com.counselor.common.JsonUtil" scope="page"/>
        var collegeData = <c:out value="${jsonUtil.toJson(vo.collegeStat)}" escapeXml="false"/> || [];
        var genderData = <c:out value="${jsonUtil.toJson(vo.genderStat)}" escapeXml="false"/> || [];
        var politicalData = <c:out value="${jsonUtil.toJson(vo.politicalStat)}" escapeXml="false"/> || [];

        // 学院柱状图
        var c1 = echarts.init(document.getElementById('chartCollege'));
        c1.setOption({
            color: colorPalette,
            tooltip: { trigger: 'item', formatter: '{b}: {c} 人' },
            grid: { left: 10, right: 20, top: 20, bottom: 10, containLabel: true },
            xAxis: { type: 'category', data: collegeData.map(function(d){return d.name;}), axisLabel: { interval: 0, rotate: collegeData.length > 4 ? 20 : 0, fontSize: 11 } },
            yAxis: { type: 'value', minInterval: 1 },
            series: [{ type: 'bar', data: collegeData.map(function(d){return d.value;}), barWidth: '45%',
                itemStyle: { borderRadius: [6,6,0,0],
                    color: new echarts.graphic.LinearGradient(0,0,0,1,[{offset:0,color:'#4f7dff'},{offset:1,color:'#2b5aed'}]) },
                label: { show: true, position: 'top', fontSize: 11 } }]
        });

        // 性别饼图
        var c2 = echarts.init(document.getElementById('chartGender'));
        c2.setOption({
            color: ['#2b5aed','#db2777'],
            tooltip: { trigger: 'item', formatter: '{b}: {c} 人 ({d}%)' },
            legend: { bottom: 5, icon: 'circle' },
            series: [{ type: 'pie', radius: ['45%','70%'], center: ['50%','45%'],
                data: genderData.map(function(d){return {name:d.name, value:d.value};}),
                label: { formatter: '{b}\n{d}%', fontSize: 12 },
                itemStyle: { borderColor: '#fff', borderWidth: 2 } }]
        });

        // 政治面貌环形图
        var c3 = echarts.init(document.getElementById('chartPolitical'));
        c3.setOption({
            color: ['#dc2626','#f59e0b','#16a34a','#0ea5e9','#7c3aed','#64748b'],
            tooltip: { trigger: 'item', formatter: '{b}: {c} 人 ({d}%)' },
            legend: { type: 'scroll', bottom: 5, icon: 'circle' },
            series: [{ type: 'pie', radius: '65%', center: ['50%','45%'],
                data: politicalData.map(function(d){return {name:d.name, value:d.value};}),
                label: { fontSize: 11 } }]
        });

        window.addEventListener('resize', function () { c1.resize(); c2.resize(); c3.resize(); });

        // 数字滚动动画
        $('.stat-value').each(function () {
            var $t = $(this), end = parseInt($t.text());
            if (isNaN(end)) return;
            var cur = 0, step = Math.max(1, Math.ceil(end / 30));
            $t.text(0);
            var timer = setInterval(function () {
                cur += step;
                if (cur >= end) { cur = end; clearInterval(timer); }
                $t.text(cur);
            }, 25);
        });
    });
</script>
</body>
</html>
