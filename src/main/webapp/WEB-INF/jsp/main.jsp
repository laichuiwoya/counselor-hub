<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="user" value="${sessionScope.loginUser}"/>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="ctx" content="${ctx}">
    <title>辅导员管理系统</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${ctx}/static/css/style.css">
</head>
<body>
<div class="app" id="app">
    <!-- 侧边栏 -->
    <aside class="sidebar">
        <div class="sidebar-brand">
            <span class="logo-mark"><i class="fa fa-graduation-cap"></i></span>
            <span class="label-hide">辅导员管理系统</span>
        </div>
        <div class="sidebar-user">
            <div class="avatar">${fn:substring(user.realName, 0, 1)}</div>
            <div class="info label-hide">
                <div class="name">${user.realName}</div>
                <div class="role">${user.role eq 'admin' ? '系统管理员' : '辅导员'}</div>
            </div>
        </div>
        <ul class="sidebar-menu" id="sideMenu">
            <li class="nav-header label-hide">工作台</li>
            <li><a href="javascript:nav('${ctx}/dashboard','工作台','工作台')"><i class="fa fa-tachometer-alt"></i><span class="label-hide">工作台</span></a></li>
            <li class="nav-header label-hide">学生管理</li>
            <li><a href="javascript:nav('${ctx}/student/list','学生基本管理','学生 / 基本管理')"><i class="fa fa-users"></i><span class="label-hide">学生基本管理</span></a></li>
            <li><a href="javascript:nav('${ctx}/reward/list','学生奖惩管理','学生 / 奖惩管理')"><i class="fa fa-trophy"></i><span class="label-hide">学生奖惩管理</span></a></li>
            <li><a href="javascript:nav('${ctx}/archive/list','学生档案管理','学生 / 档案管理')"><i class="fa fa-folder-open"></i><span class="label-hide">学生档案管理</span></a></li>
            <li class="nav-header label-hide">日常工作</li>
            <li><a href="javascript:nav('${ctx}/reminder/list','工作提示','日常 / 工作提示')"><i class="fa fa-bell"></i><span class="label-hide">工作提示</span></a></li>
            <li><a href="javascript:nav('${ctx}/workflow/list','工作流程纪要','日常 / 流程纪要')"><i class="fa fa-clipboard-list"></i><span class="label-hide">工作流程纪要</span></a></li>
            <li><a href="javascript:nav('${ctx}/leave/list','请假管理','日常 / 请假管理')"><i class="fa fa-calendar-times"></i><span class="label-hide">请假管理</span></a></li>
            <li><a href="javascript:nav('${ctx}/visitor/list','访客登记','日常 / 访客登记')"><i class="fa fa-user-plus"></i><span class="label-hide">访客登记</span></a></li>
            <li class="nav-header label-hide">资助与就业</li>
            <li><a href="javascript:nav('${ctx}/aid/list','困难资助','资助 / 困难资助')"><i class="fa fa-hand-holding-heart"></i><span class="label-hide">困难资助</span></a></li>
            <li><a href="javascript:nav('${ctx}/employment/list','就业跟踪','就业 / 就业跟踪')"><i class="fa fa-briefcase"></i><span class="label-hide">就业跟踪</span></a></li>
            <c:if test="${user.role eq 'admin'}">
                <li class="nav-header label-hide">系统</li>
                <li><a href="javascript:nav('${ctx}/user/list','系统用户','系统 / 用户管理')"><i class="fa fa-user-cog"></i><span class="label-hide">系统用户</span></a></li>
            </c:if>
        </ul>
    </aside>

    <!-- 主区域 -->
    <div class="main-area">
        <nav class="navbar">
            <i class="fa fa-bars menu-toggle"></i>
            <span class="page-title" id="pageTitle">工作台</span>
            <span class="breadcrumb-mini" id="pageCrumb">工作台</span>
            <div class="navbar-right">
                <div class="nav-icon" title="刷新" onclick="refreshFrame()"><i class="fa fa-rotate-right"></i></div>
                <div class="nav-icon" title="全屏" onclick="toggleFullscreen()"><i class="fa fa-expand"></i></div>
                <div class="nav-icon" title="消息" onclick="App.toast('暂无新消息','info')">
                    <i class="fa fa-bell"></i>
                    <span class="dot"></span>
                </div>
                <div class="user-dropdown">
                    <div class="head">
                        <span class="avatar">${fn:substring(user.realName, 0, 1)}</span>
                        <span class="name">${user.realName}</span>
                        <i class="fa fa-caret-down caret"></i>
                    </div>
                    <div class="menu">
                        <a href="javascript:changePwd()"><i class="fa fa-key"></i>修改密码</a>
                        <a href="javascript:nav('${ctx}/dashboard','工作台','工作台')"><i class="fa fa-tachometer-alt"></i>工作台</a>
                        <div class="divider"></div>
                        <a href="${ctx}/logout" style="color:#dc2626"><i class="fa fa-right-from-bracket"></i>退出登录</a>
                    </div>
                </div>
            </div>
        </nav>
        <iframe id="contentFrame" name="contentFrame" src="${ctx}/dashboard" class="content-frame"
                style="border:none;width:100%;flex:1;display:block;"></iframe>
    </div>
</div>

<!-- 修改密码弹窗 -->
<div class="modal-mask" id="pwdMask">
    <div class="modal-box">
        <div class="modal-head">
            <span class="title">修改密码</span>
            <button class="close" onclick="$('#pwdMask').removeClass('open')">&times;</button>
        </div>
        <div class="modal-body">
            <div class="form-group">
                <label>原密码 <span class="req">*</span></label>
                <input type="password" class="form-control" id="oldPwd" placeholder="请输入原密码">
            </div>
            <div class="form-group">
                <label>新密码 <span class="req">*</span></label>
                <input type="password" class="form-control" id="newPwd" placeholder="6位以上新密码">
            </div>
            <div class="form-group">
                <label>确认新密码 <span class="req">*</span></label>
                <input type="password" class="form-control" id="newPwd2" placeholder="再次输入新密码">
            </div>
        </div>
        <div class="modal-foot">
            <button class="btn btn-default" onclick="$('#pwdMask').removeClass('open')">取消</button>
            <button class="btn btn-primary" onclick="submitPwd()">确认修改</button>
        </div>
    </div>
</div>

<style>
.content-frame { background: var(--content-bg); }
</style>
<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="${ctx}/static/js/common.js"></script>
<script>
    function nav(url, title, crumb) {
        document.getElementById('contentFrame').src = url;
        $('#pageTitle').text(title);
        $('#pageCrumb').text(crumb || title);
        $('#sideMenu li a').removeClass('active');
        $('#sideMenu li a').each(function () {
            if ($(this).attr('onclick') && $(this).attr('onclick').indexOf(url) > -1) {
                $(this).addClass('active');
            }
        });
        // 移动端收起
        $('.app').removeClass('sidebar-open');
    }
    function refreshFrame() {
        document.getElementById('contentFrame').contentWindow.location.reload();
    }
    function toggleFullscreen() {
        if (!document.fullscreenElement) {
            document.documentElement.requestFullscreen();
        } else {
            document.exitFullscreen();
        }
    }
    function changePwd() {
        $('#oldPwd,#newPwd,#newPwd2').val('');
        $('#pwdMask').addClass('open');
    }
    function submitPwd() {
        var o = $('#oldPwd').val(), n = $('#newPwd').val(), n2 = $('#newPwd2').val();
        if (!o || !n || !n2) { App.toast('请填写完整', 'error'); return; }
        if (n !== n2) { App.toast('两次新密码不一致', 'error'); return; }
        if (n.length < 6) { App.toast('新密码至少6位', 'error'); return; }
        App.post('/changePwd', { oldPwd: o, newPwd: n }, function () {
            App.toast('密码修改成功，请重新登录', 'success');
            $('#pwdMask').removeClass('open');
            setTimeout(function () { location.href = '${ctx}/logout'; }, 1200);
        });
    }
    $(function () {
        // 初始激活工作台
        $('#sideMenu li a').first().addClass('active');
    });
</script>
</body>
</html>
