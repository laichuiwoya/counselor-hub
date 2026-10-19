<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>辅导员管理系统 - 登录</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
<div class="login-wrap">
    <div class="login-aside">
        <div class="brand"><i class="fa fa-graduation-cap"></i>辅导员工作管理系统</div>
        <div class="slogan">数字化赋能辅导员日常工作，让管理更高效、更专业</div>
        <ul class="feature-list">
            <li><i class="fa fa-users"></i>学生基本信息全生命周期管理</li>
            <li><i class="fa fa-trophy"></i>奖惩记录留痕，可追溯可查询</li>
            <li><i class="fa fa-bell"></i>工作提醒，重要事项不错过</li>
            <li><i class="fa fa-clipboard-list"></i>工作流程纪要，过程有据</li>
            <li><i class="fa fa-folder-open"></i>学生档案电子化归档</li>
        </ul>
        <div class="copy">© 2026 某某大学学生工作处 · 辅导员管理系统 v1.0</div>
    </div>
    <div class="login-main">
        <h2>欢迎登录</h2>
        <div class="sub">请输入您的账号和密码</div>
        <form class="login-form" id="loginForm">
            <div class="form-group">
                <label>账号</label>
                <div class="login-input">
                    <i class="fa fa-user"></i>
                    <input type="text" id="username" name="username" placeholder="请输入登录账号" autocomplete="off" value="admin">
                </div>
            </div>
            <div class="form-group">
                <label>密码</label>
                <div class="login-input">
                    <i class="fa fa-lock"></i>
                    <input type="password" id="password" name="password" placeholder="请输入密码" value="123456">
                </div>
            </div>
            <div class="login-options">
                <label><input type="checkbox" checked> 记住账号</label>
                <a href="javascript:App.toast('请联系管理员重置密码','info')">忘记密码？</a>
            </div>
            <button type="submit" class="btn-login" id="loginBtn">登 录</button>
        </form>
        <div class="login-tip">
            <i class="fa fa-info-circle"></i>
            系统初始账号：<code>admin</code> / <code>zhanglaoshi</code> 等辅导员账号，统一密码 <code>123456</code>
        </div>
    </div>
</div>

<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/common.js"></script>
<script>
    $(function () {
        var ctx = '${pageContext.request.contextPath}';
        var submitting = false;

        $('#loginForm').on('submit', function (e) {
            e.preventDefault();
            if (submitting) return;
            var u = $('#username').val().trim();
            var p = $('#password').val();
            if (!u) { App.toast('请输入账号', 'error'); return; }
            if (!p) { App.toast('请输入密码', 'error'); return; }
            submitting = true;
            var $btn = $('#loginBtn');
            var oldText = $btn.text();
            $btn.text('登录中...').prop('disabled', true);
            $.ajax({
                url: ctx + '/doLogin',
                type: 'POST',
                data: { username: u, password: p },
                dataType: 'json',
                success: function (res) {
                    if (res.code === 200) {
                        $btn.text('登录成功，正在跳转...');
                        App.toast('欢迎回来，' + res.data.realName, 'success');
                        setTimeout(function () { location.href = ctx + '/index'; }, 600);
                    } else {
                        App.toast(res.msg || '登录失败', 'error');
                        submitting = false;
                        $btn.text(oldText).prop('disabled', false);
                    }
                },
                error: function () {
                    App.toast('网络异常，请稍后重试', 'error');
                    submitting = false;
                    $btn.text(oldText).prop('disabled', false);
                }
            });
        });
    });
</script>
</body>
</html>
