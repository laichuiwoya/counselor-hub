<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="isEdit" value="${not empty workflow.id}"/>
<fmt:formatDate value="${workflow.meetingDate}" pattern="yyyy-MM-dd" var="meetingDateStr"/>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="ctx" content="${ctx}">
    <title>${isEdit ? '编辑' : '新增'}工作流程纪要 - 辅导员管理系统</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${ctx}/static/css/style.css?v=20261019b">
</head>
<body class="system-page form-page">
<div class="content page-container">
    <div class="card">
        <div class="card-header">
            <span class="card-title"><i class="fa fa-clipboard-list"></i>${isEdit ? '编辑工作流程纪要' : '新增工作流程纪要'}</span>
            <a href="${ctx}/workflow/list" class="btn btn-default btn-sm"><i class="fa fa-arrow-left"></i>返回列表</a>
        </div>
        <div class="card-body">
            <form action="${ctx}/workflow/save" method="post" id="workflowForm">
                <c:if test="${isEdit}"><input type="hidden" name="id" value="${workflow.id}"></c:if>
                <input type="hidden" name="counselorId" value="${workflow.counselorId}">

                <div class="form-section-title">会议信息</div>
                <div class="form-group">
                    <label>主题 <span class="req">*</span></label>
                    <input type="text" class="form-control" name="title" value="${workflow.title}" required placeholder="请输入会议/活动主题">
                </div>
                <div class="form-row-3">
                    <div class="form-group">
                        <label>类别 <span class="req">*</span></label>
                        <select class="form-control" name="category">
                            <option value="主题班会" ${workflow.category eq '主题班会' ? 'selected':''}>主题班会</option>
                            <option value="学生谈话" ${workflow.category eq '学生谈话' ? 'selected':''}>学生谈话</option>
                            <option value="走访宿舍" ${workflow.category eq '走访宿舍' ? 'selected':''}>走访宿舍</option>
                            <option value="专题会议" ${workflow.category eq '专题会议' ? 'selected':''}>专题会议</option>
                            <option value="其他" ${workflow.category eq '其他' ? 'selected':''}>其他</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>会议日期</label>
                        <input type="date" class="form-control" name="meetingDate" value="${meetingDateStr}">
                    </div>
                    <div class="form-group">
                        <label>负责人</label>
                        <input type="text" class="form-control" value="${workflow.counselorName}" readonly style="background:#f7f9fc;">
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label>地点</label>
                        <input type="text" class="form-control" name="location" value="${workflow.location}" placeholder="如 教学楼A301">
                    </div>
                    <div class="form-group">
                        <label>参与人员</label>
                        <input type="text" class="form-control" name="participants" value="${workflow.participants}" placeholder="多名人员以逗号分隔">
                    </div>
                </div>

                <div class="form-section-title">纪要内容</div>
                <div class="form-group">
                    <label>详细内容</label>
                    <textarea class="form-control" name="content" rows="8" placeholder="请输入会议/活动详细过程记录">${workflow.content}</textarea>
                </div>
                <div class="form-group">
                    <label>纪要小结</label>
                    <textarea class="form-control" name="summary" rows="4" placeholder="请输入本次纪要的总结概括">${workflow.summary}</textarea>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-primary"><i class="fa fa-check"></i>保存</button>
                    <a href="${ctx}/workflow/list" class="btn btn-default"><i class="fa fa-times"></i>取消</a>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="${ctx}/static/js/common.js?v=20261019b"></script>
</body>
</html>
