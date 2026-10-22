<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="isEdit" value="${not empty aid.id}"/>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="ctx" content="${ctx}">
    <title>${isEdit ? '编辑' : '新增'}困难资助 - 辅导员管理系统</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${ctx}/static/css/style.css?v=20261019b">
</head>
<body class="system-page form-page">
<div class="content page-container">
    <div class="card">
        <div class="card-header">
            <span class="card-title"><i class="fa fa-hand-holding-heart"></i>${isEdit ? '编辑困难资助' : '新增困难资助'}</span>
            <a href="${ctx}/aid/list" class="btn btn-default btn-sm"><i class="fa fa-arrow-left"></i>返回列表</a>
        </div>
        <div class="card-body">
            <form action="${ctx}/aid/save" method="post" id="aidForm">
                <c:if test="${isEdit}"><input type="hidden" name="id" value="${aid.id}"></c:if>
                <input type="hidden" name="counselorId" value="${aid.counselorId}">

                <div class="form-section-title">基本信息</div>
                <div class="form-row">
                    <div class="form-group">
                        <label>学生 <span class="req">*</span></label>
                        <input type="hidden" name="studentId" id="studentId" value="${aid.studentId}"><div class="student-picker"><input type="text" class="form-control" id="selectedStudent" value="<c:out value='${aid.studentName}'/>" readonly placeholder="请选择学生"><button type="button" class="btn btn-default" data-pick-student>选择学生</button></div>
                    </div>
                    <div class="form-group">
                        <label>审核人</label>
                        <input type="text" class="form-control" value="${aid.counselorName}" readonly style="background:#f7f9fc;">
                    </div>
                </div>
                <div class="form-row-3">
                    <div class="form-group">
                        <label>资助类型 <span class="req">*</span></label>
                        <select class="form-control" name="aidType">
                            <option value="助学金" ${aid.aidType eq '助学金' ? 'selected':''}>助学金</option>
                            <option value="助学贷款" ${aid.aidType eq '助学贷款' ? 'selected':''}>助学贷款</option>
                            <option value="困难补助" ${aid.aidType eq '困难补助' ? 'selected':''}>困难补助</option>
                            <option value="勤工助学" ${aid.aidType eq '勤工助学' ? 'selected':''}>勤工助学</option>
                            <option value="学费减免" ${aid.aidType eq '学费减免' ? 'selected':''}>学费减免</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>金额</label>
                        <input type="number" step="0.01" class="form-control" name="amount" value="${aid.amount}" placeholder="请输入金额">
                    </div>
                    <div class="form-group">
                        <label>学期</label>
                        <input type="text" class="form-control" name="semester" value="${aid.semester}" placeholder="如 2025-2026-2">
                    </div>
                </div>
                <div class="form-row-3">
                    <div class="form-group">
                        <label>家庭收入情况</label>
                        <input type="text" class="form-control" name="familyIncome" value="${aid.familyIncome}" placeholder="请输入家庭收入情况">
                    </div>
                    <div class="form-group">
                        <label>困难等级</label>
                        <select class="form-control" name="difficultyLevel">
                            <option value="一般" ${empty aid.difficultyLevel or aid.difficultyLevel eq '一般' ? 'selected':''}>一般</option>
                            <option value="困难" ${aid.difficultyLevel eq '困难' ? 'selected':''}>困难</option>
                            <option value="特别困难" ${aid.difficultyLevel eq '特别困难' ? 'selected':''}>特别困难</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>状态</label>
                        <select class="form-control" name="status">
                            <option value="待审核" ${empty aid.status or aid.status eq '待审核' ? 'selected':''}>待审核</option>
                            <option value="已通过" ${aid.status eq '已通过' ? 'selected':''}>已通过</option>
                            <option value="已驳回" ${aid.status eq '已驳回' ? 'selected':''}>已驳回</option>
                            <option value="已发放" ${aid.status eq '已发放' ? 'selected':''}>已发放</option>
                        </select>
                    </div>
                </div>

                <div class="form-section-title">申请理由</div>
                <div class="form-group">
                    <label>申请理由</label>
                    <textarea class="form-control" name="reason" rows="6" placeholder="请输入申请理由">${aid.reason}</textarea>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-primary"><i class="fa fa-check"></i>保存</button>
                    <a href="${ctx}/aid/list" class="btn btn-default"><i class="fa fa-times"></i>取消</a>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="${ctx}/static/js/common.js?v=20261022a"></script>
<style>
    #studentPickerModal .modal-box { width: min(1200px, 96vw); max-width: 96vw; display: flex; flex-direction: column; }
    #studentPickerModal iframe { width: 100%; height: 70vh; border: 0; border-radius: 0 0 12px 12px; }
</style>
<div id="studentPickerModal" class="modal-mask" role="dialog" aria-modal="true" aria-labelledby="studentPickerTitle">
    <div class="modal-box">
        <div class="modal-head"><span class="title" id="studentPickerTitle">选择学生</span><button type="button" class="close btn-cancel" aria-label="关闭学生选择">×</button></div>
        <iframe title="学生筛选与选择"></iframe>
    </div>
</div>
<script>
    $(function () {
        $('[data-pick-student]').attr('data-pick-student-modal', '');
        var modal = $('#studentPickerModal');
        var trigger;
        var previousOverflow;
        function closePicker() {
            modal.removeClass('open');
            document.body.style.overflow = previousOverflow;
            if (trigger) trigger.focus();
        }
        window.openStudentPicker = function (button) {
            trigger = button;
            previousOverflow = document.body.style.overflow;
            document.body.style.overflow = 'hidden';
            modal.addClass('open');
            if (!modal.find('iframe').attr('src')) {
                modal.find('iframe').attr('src', App.ctx() + '/student/list?pick=1&embedded=1');
            }
            modal.find('.btn-cancel').trigger('focus');
        };
        window.selectAidStudent = function (id, no, name) {
            window.setStudent(id, no, name);
            closePicker();
        };
        modal.find('.btn-cancel').on('click', closePicker);
        modal.on('click', function (event) { if (event.target === this) closePicker(); });
        modal.on('keydown', function (event) {
            if (event.key === 'Tab') {
                var close = modal.find('.btn-cancel')[0];
                if (event.shiftKey && event.target === close) {
                    event.preventDefault(); modal.find('iframe')[0].focus();
                }
            }
        });
    });
</script>
</body>
</html>
