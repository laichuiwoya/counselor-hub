<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="isEdit" value="${not empty visitor.id}"/>
<fmt:formatDate value="${visitor.visitTime}" pattern="yyyy-MM-dd'T'HH:mm" var="visitTimeStr"/>
<fmt:formatDate value="${visitor.leaveTime}" pattern="yyyy-MM-dd'T'HH:mm" var="leaveTimeStr"/>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="ctx" content="${ctx}">
    <title>${isEdit ? '编辑' : '新增'}访客登记 - 辅导员管理系统</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${ctx}/static/css/style.css">
</head>
<body>
<div class="content" style="max-width:920px;">
    <div class="card">
        <div class="card-header">
            <span class="card-title"><i class="fa fa-user-plus"></i>${isEdit ? '编辑访客登记' : '新增访客登记'}</span>
            <a href="${ctx}/visitor/list" class="btn btn-default btn-sm"><i class="fa fa-arrow-left"></i>返回列表</a>
        </div>
        <div class="card-body">
            <form action="${ctx}/visitor/save" method="post" id="visitorForm">
                <c:if test="${isEdit}"><input type="hidden" name="id" value="${visitor.id}"></c:if>
                <input type="hidden" name="counselorId" value="${visitor.counselorId}">

                <div class="form-section-title">基本信息</div>
                <div class="form-row-3">
                    <div class="form-group">
                        <label>访客姓名 <span class="req">*</span></label>
                        <input type="text" class="form-control" name="visitorName" value="${visitor.visitorName}" required placeholder="请输入访客姓名">
                    </div>
                    <div class="form-group">
                        <label>联系电话</label>
                        <input type="text" class="form-control" name="phone" value="${visitor.phone}" placeholder="请输入联系电话">
                    </div>
                    <div class="form-group">
                        <label>证件号</label>
                        <input type="text" class="form-control" name="idCard" value="${visitor.idCard}" placeholder="请输入证件号">
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label>来访事由</label>
                        <input type="text" class="form-control" name="visitPurpose" value="${visitor.visitPurpose}" placeholder="请输入来访事由">
                    </div>
                    <div class="form-group">
                        <label>被访对象</label>
                        <input type="text" class="form-control" name="visitObject" value="${visitor.visitObject}" placeholder="请输入被访对象">
                    </div>
                </div>
                <div class="form-row-3">
                    <div class="form-group">
                        <label>来访时间</label>
                        <input type="datetime-local" class="form-control" name="visitTime" value="${visitTimeStr}">
                    </div>
                    <div class="form-group">
                        <label>离开时间</label>
                        <input type="datetime-local" class="form-control" name="leaveTime" value="${leaveTimeStr}">
                    </div>
                    <div class="form-group">
                        <label>状态</label>
                        <select class="form-control" name="status">
                            <option value="在访" ${empty visitor.status or visitor.status eq '在访' ? 'selected':''}>在访</option>
                            <option value="已离开" ${visitor.status eq '已离开' ? 'selected':''}>已离开</option>
                        </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label>登记人</label>
                        <input type="text" class="form-control" value="${visitor.counselorName}" readonly style="background:#f7f9fc;">
                    </div>
                    <div class="form-group"></div>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-primary"><i class="fa fa-check"></i>保 存</button>
                    <a href="${ctx}/visitor/list" class="btn btn-default"><i class="fa fa-times"></i>取 消</a>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="${ctx}/static/js/common.js"></script>
</body>
</html>
