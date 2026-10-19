<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="isEdit" value="${not empty student.id}"/>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="ctx" content="${ctx}">
    <title>${isEdit ? '编辑' : '新增'}学生 - 辅导员管理系统</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${ctx}/static/css/style.css">
</head>
<body>
<div class="content" style="max-width:920px;">
    <div class="card">
        <div class="card-header">
            <span class="card-title"><i class="fa fa-user-edit"></i>${isEdit ? '编辑学生信息' : '新增学生信息'}</span>
            <a href="${ctx}/student/list" class="btn btn-default btn-sm"><i class="fa fa-arrow-left"></i>返回列表</a>
        </div>
        <div class="card-body">
            <form action="${ctx}/student/save" method="post" id="stuForm">
                <c:if test="${isEdit}"><input type="hidden" name="id" value="${student.id}"></c:if>

                <div class="form-section-title">基本信息</div>
                <div class="form-row">
                    <div class="form-group">
                        <label>学号 <span class="req">*</span></label>
                        <input type="text" class="form-control" name="studentNo" value="${student.studentNo}" required>
                    </div>
                    <div class="form-group">
                        <label>姓名 <span class="req">*</span></label>
                        <input type="text" class="form-control" name="name" value="${student.name}" required>
                    </div>
                </div>
                <div class="form-row-3">
                    <div class="form-group">
                        <label>性别 <span class="req">*</span></label>
                        <select class="form-control" name="gender">
                            <option value="男" ${student.gender eq '男' ? 'selected':''}>男</option>
                            <option value="女" ${student.gender eq '女' ? 'selected':''}>女</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>出生日期</label>
                        <input type="text" class="form-control" placeholder="无需填写" disabled style="background:#f7f9fc;">
                    </div>
                    <div class="form-group">
                        <label>身份证号</label>
                        <input type="text" class="form-control" name="idCard" value="${student.idCard}" maxlength="18">
                    </div>
                </div>

                <div class="form-section-title">学院专业</div>
                <div class="form-row-3">
                    <div class="form-group">
                        <label>学院 <span class="req">*</span></label>
                        <select class="form-control" name="college" id="selCollege">
                            <option value="">请选择</option>
                            <option value="信息工程学院" ${student.college eq '信息工程学院' ? 'selected':''}>信息工程学院</option>
                            <option value="经济管理学院" ${student.college eq '经济管理学院' ? 'selected':''}>经济管理学院</option>
                            <option value="外国语学院" ${student.college eq '外国语学院' ? 'selected':''}>外国语学院</option>
                            <option value="其他" ${student.college eq '其他' ? 'selected':''}>其他</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>专业 <span class="req">*</span></label>
                        <input type="text" class="form-control" name="major" value="${student.major}" required>
                    </div>
                    <div class="form-group">
                        <label>班级 <span class="req">*</span></label>
                        <input type="text" class="form-control" name="className" value="${student.className}" required>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label>年级</label>
                        <input type="text" class="form-control" name="grade" value="${student.grade}" placeholder="如 2022级">
                    </div>
                    <div class="form-group">
                        <label>所属辅导员</label>
                        <select class="form-control" name="counselorId">
                            <option value="">无</option>
                            <c:forEach var="c" items="${counselors}">
                                <option value="${c.id}" ${student.counselorId eq c.id ? 'selected':''}>${c.realName}（${c.role eq 'admin' ? '管理员':'辅导员'}）</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <div class="form-section-title">住宿与联系</div>
                <div class="form-row-3">
                    <div class="form-group">
                        <label>宿舍楼</label>
                        <input type="text" class="form-control" name="dormBuilding" value="${student.dormBuilding}" placeholder="如 1号楼">
                    </div>
                    <div class="form-group">
                        <label>宿舍号</label>
                        <input type="text" class="form-control" name="dormRoom" value="${student.dormRoom}" placeholder="如 101">
                    </div>
                    <div class="form-group">
                        <label>手机号</label>
                        <input type="text" class="form-control" name="phone" value="${student.phone}" maxlength="11">
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label>籍贯</label>
                        <input type="text" class="form-control" name="nativePlace" value="${student.nativePlace}" placeholder="如 北京市朝阳区">
                    </div>
                    <div class="form-group">
                        <label>政治面貌</label>
                        <select class="form-control" name="politicalStatus">
                            <option value="">请选择</option>
                            <option value="群众" ${student.politicalStatus eq '群众' ? 'selected':''}>群众</option>
                            <option value="共青团员" ${student.politicalStatus eq '共青团员' ? 'selected':''}>共青团员</option>
                            <option value="中共党员" ${student.politicalStatus eq '中共党员' ? 'selected':''}>中共党员</option>
                            <option value="中共预备党员" ${student.politicalStatus eq '中共预备党员' ? 'selected':''}>中共预备党员</option>
                        </select>
                    </div>
                </div>

                <c:if test="${isEdit}">
                <div class="form-group">
                    <label>学生状态</label>
                    <select class="form-control" name="status">
                        <option value="在读" ${student.status eq '在读' ? 'selected':''}>在读</option>
                        <option value="休学" ${student.status eq '休学' ? 'selected':''}>休学</option>
                        <option value="毕业" ${student.status eq '毕业' ? 'selected':''}>毕业</option>
                        <option value="退学" ${student.status eq '退学' ? 'selected':''}>退学</option>
                    </select>
                </div>
                </c:if>
                <c:if test="${!isEdit}">
                <input type="hidden" name="status" value="在读">
                </c:if>

                <div class="form-actions">
                    <button type="submit" class="btn btn-primary"><i class="fa fa-check"></i>保 存</button>
                    <a href="${ctx}/student/list" class="btn btn-default"><i class="fa fa-times"></i>取 消</a>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="${ctx}/static/js/common.js"></script>
</body>
</html>
