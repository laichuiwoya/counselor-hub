<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="isEdit" value="${not empty archive.id}"/>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="ctx" content="${ctx}">
    <title>${isEdit ? '编辑' : '新增'}档案 - 辅导员管理系统</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${ctx}/static/css/style.css?v=20261019b">
</head>
<body class="system-page form-page">
<div class="content page-container">
    <div class="card">
        <div class="card-header">
            <span class="card-title"><i class="fa fa-folder-open"></i>${isEdit ? '编辑档案信息' : '新增档案信息'}</span>
            <a href="${ctx}/archive/list" class="btn btn-default btn-sm"><i class="fa fa-arrow-left"></i>返回列表</a>
        </div>
        <div class="card-body">
            <form action="${ctx}/archive/save" method="post" enctype="multipart/form-data" id="archiveForm">
                <c:if test="${isEdit}"><input type="hidden" name="id" value="${archive.id}"></c:if>
                <input type="hidden" name="studentId" id="studentId" value="${archive.studentId}">
                <c:if test="${isEdit and not empty archive.filePath}">
                    <input type="hidden" name="filePath" value="${archive.filePath}">
                </c:if>

                <div class="form-section-title">学生选择</div>
                <div class="form-row">
                    <div class="form-group">
                        <label>学号 <span class="req">*</span></label>
                        <div style="display:flex;gap:8px;">
                            <input type="text" class="form-control" id="studentNoShow"
                                   value="${archive.studentNo}" placeholder="点击右侧按钮选择学生" readonly
                                   style="background:#f7f9fc;flex:1;">
                            <button type="button" class="btn btn-default btn-sm" id="pickStudentBtn" title="选择学生">
                                <i class="fa fa-user-search"></i>选择学生
                            </button>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>姓名</label>
                        <input type="text" class="form-control" id="studentNameShow"
                               value="${archive.studentName}" readonly placeholder="选择学生后自动带出"
                               style="background:#f7f9fc;">
                        <div id="studentTip" style="font-size:12px;margin-top:4px;color:var(--text-secondary);">
                            <c:choose>
                                <c:when test="${not empty archive.studentId}">
                                    <i class="fa fa-check-circle" style="color:var(--success);"></i> 已关联学生：${archive.studentName}（${archive.className}）
                                </c:when>
                                <c:otherwise>
                                    <i class="fa fa-info-circle"></i> 请点击"选择学生"按钮从学生列表中挑选
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>

                <div class="form-section-title">档案信息</div>
                <div class="form-row-3">
                    <div class="form-group">
                        <label>档案类型 <span class="req">*</span></label>
                        <select class="form-control" name="archiveType" id="archiveTypeSel">
                            <option value="">请选择</option>
                            <option value="入学登记表" ${archive.archiveType eq '入学登记表' ? 'selected':''}>入学登记表</option>
                            <option value="成绩单" ${archive.archiveType eq '成绩单' ? 'selected':''}>成绩单</option>
                            <option value="奖惩材料" ${archive.archiveType eq '奖惩材料' ? 'selected':''}>奖惩材料</option>
                            <option value="实习材料" ${archive.archiveType eq '实习材料' ? 'selected':''}>实习材料</option>
                            <option value="毕业材料" ${archive.archiveType eq '毕业材料' ? 'selected':''}>毕业材料</option>
                            <option value="其他" ${archive.archiveType eq '其他' ? 'selected':''}>其他</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>档案名称 <span class="req">*</span></label>
                        <input type="text" class="form-control" name="archiveName" value="${archive.archiveName}" placeholder="如 入学登记表-张三" required>
                    </div>
                    <div class="form-group">
                        <label>归档日期 <span class="req">*</span></label>
                        <input type="date" class="form-control" name="uploadDate"
                               value="<fmt:formatDate value="${archive.uploadDate}" pattern="yyyy-MM-dd"/>" required>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label>经办人</label>
                        <input type="text" class="form-control" name="operator" value="${archive.operator}" placeholder="如 张老师">
                    </div>
                    <div class="form-group">
                        <label>&nbsp;</label>
                        <div style="color:var(--text-secondary);font-size:12px;line-height:38px;">
                            <i class="fa fa-info-circle"></i> 经办人指负责归档该档案的教师
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label>说明</label>
                    <textarea class="form-control" name="description" rows="3" placeholder="请填写档案说明">${archive.description}</textarea>
                </div>

                <div class="form-section-title">文件上传</div>
                <div class="form-group">
                    <label>档案文件</label>
                    <input type="file" class="form-control" name="file">
                    <c:if test="${isEdit and not empty archive.filePath}">
                        <div style="font-size:12px;margin-top:6px;color:var(--text-secondary);">
                            <i class="fa fa-paperclip"></i> 已上传文件：
                            <a href="${ctx}${archive.filePath}" target="_blank" style="color:var(--primary);text-decoration:underline;">${archive.filePath}</a>
                        </div>
                    </c:if>
                    <c:if test="${!isEdit}">
                        <div style="font-size:12px;margin-top:6px;color:var(--text-secondary);">
                            <i class="fa fa-info-circle"></i> 支持上传 PDF、图片、Word 等常见格式文件
                        </div>
                    </c:if>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-primary"><i class="fa fa-check"></i>保存</button>
                    <a href="${ctx}/archive/list" class="btn btn-default"><i class="fa fa-times"></i>取消</a>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="${ctx}/static/js/common.js?v=20261019b"></script>
<script>
    // 父窗口被学生列表弹窗调用，回填学生信息
    window.setStudent = function (id, no, name, cls) {
        $('#studentId').val(id);
        $('#studentNoShow').val(no);
        $('#studentNameShow').val(name);
        $('#studentTip').html('<i class="fa fa-check-circle" style="color:var(--success);"></i> 已关联学生：' + name + '（' + cls + '）');
    };

    // 打开学生列表选择弹窗
    $('#pickStudentBtn').on('click', function () {
        window.open('${ctx}/student/list?pick=1', '_blank', 'width=1000,height=600');
    });

    // 表单提交前校验学生已选择
    $('#archiveForm').on('submit', function (e) {
        var sid = $('#studentId').val();
        if (!sid) {
            e.preventDefault();
            App.toast('请先选择学生', 'error');
            return false;
        }
        var type = $('#archiveTypeSel').val();
        if (!type) {
            e.preventDefault();
            App.toast('请选择档案类型', 'error');
            return false;
        }
    });
</script>
</body>
</html>
