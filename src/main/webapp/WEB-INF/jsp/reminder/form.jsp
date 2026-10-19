<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="isEdit" value="${not empty reminder.id}"/>
<fmt:formatDate value="${reminder.dueDate}" pattern="yyyy-MM-dd" var="dueDateStr"/>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="ctx" content="${ctx}">
    <title>${isEdit ? '编辑' : '新增'}工作提示 - 辅导员管理系统</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${ctx}/static/css/style.css">
</head>
<body>
<div class="content" style="max-width:920px;">
    <div class="card">
        <div class="card-header">
            <span class="card-title"><i class="fa fa-bell"></i>${isEdit ? '编辑工作提示' : '新增工作提示'}</span>
            <a href="${ctx}/reminder/list" class="btn btn-default btn-sm"><i class="fa fa-arrow-left"></i>返回列表</a>
        </div>
        <div class="card-body">
            <form action="${ctx}/reminder/save" method="post" id="reminderForm">
                <c:if test="${isEdit}"><input type="hidden" name="id" value="${reminder.id}"></c:if>
                <input type="hidden" name="counselorId" value="${reminder.counselorId}">

                <div class="form-section-title">基本信息</div>
                <div class="form-row">
                    <div class="form-group">
                        <label>标题 <span class="req">*</span></label>
                        <input type="text" class="form-control" name="title" value="${reminder.title}" required placeholder="请输入提示标题">
                    </div>
                    <div class="form-group">
                        <label>负责人</label>
                        <input type="text" class="form-control" value="${reminder.counselorName}" readonly style="background:#f7f9fc;">
                    </div>
                </div>
                <div class="form-row-3">
                    <div class="form-group">
                        <label>类型 <span class="req">*</span></label>
                        <select class="form-control" name="type">
                            <option value="会议" ${reminder.type eq '会议' ? 'selected':''}>会议</option>
                            <option value="材料" ${reminder.type eq '材料' ? 'selected':''}>材料</option>
                            <option value="谈话" ${reminder.type eq '谈话' ? 'selected':''}>谈话</option>
                            <option value="检查" ${reminder.type eq '检查' ? 'selected':''}>检查</option>
                            <option value="其他" ${reminder.type eq '其他' ? 'selected':''}>其他</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>优先级 <span class="req">*</span></label>
                        <select class="form-control" name="priority">
                            <option value="高" ${reminder.priority eq '高' ? 'selected':''}>高</option>
                            <option value="中" ${empty reminder.priority or reminder.priority eq '中' ? 'selected':''}>中</option>
                            <option value="低" ${reminder.priority eq '低' ? 'selected':''}>低</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>截止日期</label>
                        <input type="date" class="form-control" name="dueDate" value="${dueDateStr}">
                    </div>
                </div>
                <div class="form-group">
                    <label>状态</label>
                    <select class="form-control" name="status">
                        <option value="待办" ${empty reminder.status or reminder.status eq '待办' ? 'selected':''}>待办</option>
                        <option value="进行中" ${reminder.status eq '进行中' ? 'selected':''}>进行中</option>
                        <option value="已完成" ${reminder.status eq '已完成' ? 'selected':''}>已完成</option>
                    </select>
                </div>

                <div class="form-section-title">内容详情</div>
                <div class="form-group">
                    <label>提示内容</label>
                    <textarea class="form-control" name="content" rows="6" placeholder="请输入提示详细内容">${reminder.content}</textarea>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-primary"><i class="fa fa-check"></i>保 存</button>
                    <a href="${ctx}/reminder/list" class="btn btn-default"><i class="fa fa-times"></i>取 消</a>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="${ctx}/static/js/common.js"></script>
</body>
</html>
