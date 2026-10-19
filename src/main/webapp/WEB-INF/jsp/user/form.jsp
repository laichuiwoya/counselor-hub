<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="isEdit" value="${not empty user.id}"/>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="ctx" content="${ctx}">
    <title>${isEdit ? '编辑' : '新增'}用户 - 辅导员管理系统</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${ctx}/static/css/style.css">
</head>
<body>
<div class="content" style="max-width:920px;">
    <div class="card">
        <div class="card-header">
            <span class="card-title"><i class="fa fa-user-cog"></i>${isEdit ? '编辑用户信息' : '新增用户信息'}</span>
            <a href="${ctx}/user/list" class="btn btn-default btn-sm"><i class="fa fa-arrow-left"></i>返回列表</a>
        </div>
        <div class="card-body">
            <form action="${ctx}/user/save" method="post" id="userForm">
                <c:if test="${isEdit}"><input type="hidden" name="id" value="${user.id}"></c:if>

                <div class="form-section-title">账号信息</div>
                <div class="form-row">
                    <div class="form-group">
                        <label>账号 <span class="req">*</span></label>
                        <input type="text" class="form-control" name="username" id="usernameInput"
                               value="${user.username}" required
                               ${isEdit and user.username eq 'admin' ? 'readonly style="background:#f7f9fc;"' : ''}
                               placeholder="请输入登录账号">
                    </div>
                    <div class="form-group">
                        <label>真实姓名 <span class="req">*</span></label>
                        <input type="text" class="form-control" name="realName" value="${user.realName}" required placeholder="请输入真实姓名">
                    </div>
                </div>
                <div class="form-row-3">
                    <div class="form-group">
                        <label>角色 <span class="req">*</span></label>
                        <select class="form-control" name="role">
                            <option value="counselor" ${user.role eq 'counselor' ? 'selected':''}>辅导员</option>
                            <option value="admin" ${user.role eq 'admin' ? 'selected':''}>管理员</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>状态 <span class="req">*</span></label>
                        <select class="form-control" name="status">
                            <option value="1" ${user.status eq 1 ? 'selected':''}>启用</option>
                            <option value="0" ${user.status eq 0 ? 'selected':''}>禁用</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>密码</label>
                        <input type="password" class="form-control" name="password"
                               value="${isEdit ? '' : '123456'}"
                               placeholder="${isEdit ? '留空表示不修改密码' : ''}">
                        <div style="font-size:12px;margin-top:4px;color:var(--text-secondary);">
                            <i class="fa fa-info-circle"></i>
                            <c:choose>
                                <c:when test="${isEdit}">留空表示不修改密码</c:when>
                                <c:otherwise>新增用户默认密码为 123456</c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>

                <div class="form-section-title">联系方式</div>
                <div class="form-row">
                    <div class="form-group">
                        <label>手机号</label>
                        <input type="text" class="form-control" name="phone" value="${user.phone}" maxlength="11" placeholder="请输入手机号">
                    </div>
                    <div class="form-group">
                        <label>邮箱</label>
                        <input type="email" class="form-control" name="email" value="${user.email}" placeholder="请输入邮箱">
                    </div>
                </div>

                <c:if test="${!isEdit}">
                <div style="background:#f0f7ff;border:1px solid var(--primary-light);border-radius:8px;padding:10px 14px;margin-bottom:16px;font-size:13px;color:var(--text-secondary);">
                    <i class="fa fa-info-circle" style="color:var(--primary);"></i> 提示：新增用户默认密码为 <b style="color:var(--primary);">123456</b>，建议用户登录后及时修改。
                </div>
                </c:if>

                <div class="form-actions">
                    <button type="submit" class="btn btn-primary"><i class="fa fa-check"></i>保 存</button>
                    <a href="${ctx}/user/list" class="btn btn-default"><i class="fa fa-times"></i>取 消</a>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="${ctx}/static/js/common.js"></script>
</body>
</html>
