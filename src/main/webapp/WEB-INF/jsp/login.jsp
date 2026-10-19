<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>辅导员管理系统 - 登录</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css?v=20261019b">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/login.css?v=20261019a">
</head>
<body class="signin-page">
<header class="signin-brand"><span class="signin-logo"><i class="fa fa-graduation-cap" aria-hidden="true"></i></span><span>辅导员管理系统</span></header>
<main class="signin-layout">
    <section class="signin-card" aria-labelledby="signinTitle">
        <div class="signin-heading"><h1 id="signinTitle">登录</h1><p>欢迎回到工作台</p></div>
        <form id="loginForm" class="signin-form">
            <div class="signin-field">
                <label for="username">账号</label>
                <input type="text" id="username" name="username" placeholder="请输入账号" autocomplete="username" required maxlength="100">
            </div>
            <div class="signin-field">
                <label for="password">密码</label>
                <div class="signin-password"><input type="password" id="password" name="password" placeholder="请输入密码" autocomplete="current-password" required><button type="button" id="togglePassword" aria-label="显示密码" aria-pressed="false"><i class="fa fa-eye" aria-hidden="true"></i></button></div>
            </div>
            <div class="signin-options"><label for="rememberAccount"><input type="checkbox" id="rememberAccount">记住账号</label><button type="button" class="signin-help" id="passwordHelp">忘记密码？</button></div>
            <button type="submit" class="signin-submit" id="loginBtn">登录</button>
            <p class="signin-feedback" id="loginFeedback" role="status" aria-live="polite"></p>
        </form>
    </section>
</main>
<footer class="signin-footer">辅导员管理系统</footer>

<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/common.js?v=20261019b"></script>
<script>
    $(function () {
        var ctx = '${pageContext.request.contextPath}';
        var submitting = false;
        var accountKey = 'counselor.rememberedAccount';
        try {
            var remembered = localStorage.getItem(accountKey);
            if (remembered) { $('#username').val(remembered); $('#rememberAccount').prop('checked', true); }
        } catch (error) { /* Login remains available when storage is disabled. */ }
        $('#rememberAccount').on('change', function () {
            if (!this.checked) { try { localStorage.removeItem(accountKey); } catch (error) {} }
        });
        $('#togglePassword').on('click', function () {
            var visible = $('#password').attr('type') === 'password';
            $('#password').attr('type', visible ? 'text' : 'password');
            $(this).attr('aria-label', visible ? '隐藏密码' : '显示密码').attr('aria-pressed', String(visible));
            $(this).find('i').toggleClass('fa-eye', !visible).toggleClass('fa-eye-slash', visible);
        });
        $('#passwordHelp').on('click', function () { $('#loginFeedback').text('请联系系统管理员重置密码'); });

        $('#loginForm').on('submit', function (e) {
            e.preventDefault();
            if (submitting) return;
            $('#loginFeedback').text('');
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
                        try {
                            if ($('#rememberAccount').prop('checked')) localStorage.setItem(accountKey, u);
                            else localStorage.removeItem(accountKey);
                        } catch (error) {}
                        $btn.text('登录成功，正在跳转...');
                        App.toast('欢迎回来，' + res.data.realName, 'success');
                        setTimeout(function () { location.href = ctx + '/index'; }, 600);
                    } else {
                        $('#loginFeedback').text(res.msg || '登录失败，请重试');
                        submitting = false;
                        $btn.text(oldText).prop('disabled', false);
                    }
                },
                error: function () {
                    $('#loginFeedback').text('网络异常，请稍后重试');
                    submitting = false;
                    $btn.text(oldText).prop('disabled', false);
                }
            });
        });
    });
</script>
</body>
</html>
