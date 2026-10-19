<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="isEdit" value="${not empty emp.id}"/>
<fmt:formatDate value="${emp.trackDate}" pattern="yyyy-MM-dd" var="trackDateStr"/>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="ctx" content="${ctx}">
    <title>${isEdit ? '编辑' : '新增'}就业跟踪 - 辅导员管理系统</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${ctx}/static/css/style.css?v=20261019b">
</head>
<body class="system-page form-page">
<div class="content page-container">
    <div class="card">
        <div class="card-header">
            <span class="card-title"><i class="fa fa-briefcase"></i>${isEdit ? '编辑就业跟踪' : '新增就业跟踪'}</span>
            <a href="${ctx}/employment/list" class="btn btn-default btn-sm"><i class="fa fa-arrow-left"></i>返回列表</a>
        </div>
        <div class="card-body">
            <form action="${ctx}/employment/save" method="post" id="employmentForm">
                <c:if test="${isEdit}"><input type="hidden" name="id" value="${emp.id}"></c:if>
                <input type="hidden" name="counselorId" value="${emp.counselorId}">

                <div class="form-section-title">基本信息</div>
                <div class="form-row-3">
                    <div class="form-group">
                        <label>学生 <span class="req">*</span></label>
                        <input type="hidden" name="studentId" id="studentId" value="${emp.studentId}"><div class="student-picker"><input type="text" class="form-control" id="selectedStudent" value="<c:out value='${emp.studentName}'/>" readonly placeholder="请选择学生"><button type="button" class="btn btn-default" data-pick-student>选择学生</button></div>
                    </div>
                    <div class="form-group">
                        <label>就业状态 <span class="req">*</span></label>
                        <select class="form-control" name="employmentStatus" id="employmentStatus">
                            <option value="已就业" ${emp.employmentStatus eq '已就业' ? 'selected':''}>已就业</option>
                            <option value="升学" ${emp.employmentStatus eq '升学' ? 'selected':''}>升学</option>
                            <option value="考公" ${emp.employmentStatus eq '考公' ? 'selected':''}>考公</option>
                            <option value="创业" ${emp.employmentStatus eq '创业' ? 'selected':''}>创业</option>
                            <option value="未就业" ${empty emp.employmentStatus or emp.employmentStatus eq '未就业' ? 'selected':''}>未就业</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>跟踪日期 <span class="req">*</span></label>
                        <input type="date" class="form-control" name="trackDate" value="${trackDateStr}" required>
                    </div>
                </div>

                <div class="form-section-title">就业信息</div>
                <div class="form-row">
                    <div class="form-group">
                        <label>就业单位</label>
                        <input type="text" class="form-control" name="company" value="${emp.company}" placeholder="请输入就业单位">
                    </div>
                    <div class="form-group">
                        <label>岗位</label>
                        <input type="text" class="form-control" name="position" value="${emp.position}" placeholder="请输入岗位">
                    </div>
                </div>
                <div class="form-row-3">
                    <div class="form-group">
                        <label>薪资</label>
                        <input type="number" step="0.01" class="form-control" name="salary" value="${emp.salary}" placeholder="请输入薪资">
                    </div>
                    <div class="form-group">
                        <label>城市</label>
                        <input type="text" class="form-control" name="city" value="${emp.city}" placeholder="请输入城市">
                    </div>
                    <div class="form-group">
                        <label>跟踪人</label>
                        <input type="text" class="form-control" value="${emp.counselorName}" readonly style="background:#f7f9fc;">
                    </div>
                </div>

                <div class="form-section-title">升学信息</div>
                <div class="form-row">
                    <div class="form-group">
                        <label>升学学校</label>
                        <input type="text" class="form-control" name="school" value="${emp.school}" placeholder="请输入升学学校">
                    </div>
                    <div class="form-group">
                        <label>升学专业</label>
                        <input type="text" class="form-control" name="major" value="${emp.major}" placeholder="请输入升学专业">
                    </div>
                </div>

                <div class="form-section-title">其他</div>
                <div class="form-group">
                    <label>备注</label>
                    <textarea class="form-control" name="remark" rows="4" placeholder="请输入备注">${emp.remark}</textarea>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-primary"><i class="fa fa-check"></i>保存</button>
                    <a href="${ctx}/employment/list" class="btn btn-default"><i class="fa fa-times"></i>取消</a>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="${ctx}/static/js/common.js?v=20261019b"></script>
</body>
</html>
