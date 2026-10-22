<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="ctx" content="${ctx}">
    <title>学生基本管理 - 辅导员管理系统</title>
    <link rel="stylesheet" href="https://cdn.bootcdn.net/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="${ctx}/static/css/style.css?v=20261019b">
    <c:if test="${param.pick eq '1'}"><script>window.PICK_MODE=true;</script></c:if>
    <c:if test="${param.embedded eq '1'}"><style>.page-heading-actions { display: none; } .page-container { padding: 20px; }</style></c:if>
</head>
<body class="system-page list-page">
<div class="content page-container">
    <header class="page-heading"><h1>学生基本管理</h1><span class="page-count">共 <strong>${page.total}</strong> 条记录</span><div class="page-heading-actions"><a href="${ctx}/student/add" class="btn btn-primary btn-sm"><i class="fa fa-plus"></i>新增学生</a></div></header>
    <p class="list-sort-hint" style="color:#64748b;font-size:13px;margin:0 0 12px;">默认排序：学号升序。</p>
    <div class="card">
        <form method="get" action="${ctx}/student/list" id="searchForm">
            <c:if test="${param.pick eq '1'}"><input type="hidden" name="pick" value="1"></c:if>
            <c:if test="${param.embedded eq '1'}"><input type="hidden" name="embedded" value="1"></c:if>
            <div class="table-toolbar">
                <div class="filter-group">
                    <input type="text" class="filter-input" name="studentNo" placeholder="学号" value="${query.studentNo}">
                    <input type="text" class="filter-input" name="name" placeholder="姓名" value="${query.name}">
                    <select class="filter-input" name="gender">
                        <option value="">全部性别</option>
                        <option value="男" ${query.gender eq '男' ? 'selected':''}>男</option>
                        <option value="女" ${query.gender eq '女' ? 'selected':''}>女</option>
                    </select>
                    <input type="text" class="filter-input" name="college" placeholder="学院" value="${query.college}">
                    <input type="text" class="filter-input" name="className" placeholder="班级" value="${query.className}">
                    <select class="filter-input" name="status">
                        <option value="">全部状态</option>
                        <option value="在读" ${query.status eq '在读' ? 'selected':''}>在读</option>
                        <option value="休学" ${query.status eq '休学' ? 'selected':''}>休学</option>
                        <option value="毕业" ${query.status eq '毕业' ? 'selected':''}>毕业</option>
                        <option value="退学" ${query.status eq '退学' ? 'selected':''}>退学</option>
                    </select>
                    <button type="submit" class="btn btn-primary btn-sm"><i class="fa fa-search"></i>查询</button>
                    <a href="${ctx}/student/list${param.pick eq '1' ? '?pick=1' : ''}${param.pick eq '1' and param.embedded eq '1' ? '&amp;embedded=1' : ''}" class="btn btn-default btn-sm"><i class="fa fa-rotate-left"></i>重置</a>
                </div>

            </div>
        </form>

        <div style="overflow-x:auto;">
        <table class="data-table">
            <thead>
                <tr>
                    <th class="row-idx">#</th>
                    <th>学号</th>
                    <th>姓名</th>
                    <th>性别</th>
                    <th>学院</th>
                    <th>专业</th>
                    <th>班级</th>
                    <th>宿舍</th>
                    <th>政治面貌</th>
                    <th>辅导员</th>
                    <th>状态</th>
                    <th class="actions">操作</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="s" items="${page.list}" varStatus="vs">
                <tr>
                    <td class="row-idx">${(page.pageNum-1)*page.pageSize + vs.index + 1}</td>
                    <td>${s.studentNo}</td>
                    <td><c:choose><c:when test="${param.embedded eq '1'}"><c:out value="${s.name}"/></c:when><c:otherwise><a href="${ctx}/student/detail?id=${s.id}">${s.name}</a></c:otherwise></c:choose></td>
                    <td>
                        <span class="badge ${s.gender eq '男' ? 'badge-info' : 'badge-purple'}">${s.gender}</span>
                    </td>
                    <td>${s.college}</td>
                    <td>${s.major}</td>
                    <td>${s.className}</td>
                    <td>${s.dormBuilding} ${s.dormRoom}</td>
                    <td>${s.politicalStatus}</td>
                    <td>${s.counselorName}</td>
                    <td>
                        <span class="badge ${s.status eq '在读' ? 'badge-success' : s.status eq '休学' ? 'badge-warning' : 'badge-secondary'}">${s.status}</span>
                    </td>
                    <td class="actions">
                        <c:if test="${param.pick eq '1'}">
                            <button type="button" class="btn-link btn-sm" title="选择该学生" data-student-id="${s.id}" data-student-no="<c:out value='${s.studentNo}'/>" data-student-name="<c:out value='${s.name}'/>" data-student-class="<c:out value='${s.className}'/>" onclick="pickStudent(this.dataset.studentId, this.dataset.studentNo, this.dataset.studentName, this.dataset.studentClass)"><i class="fa fa-check-circle"></i>选择</button>
                        </c:if>
                        <c:if test="${param.pick ne '1'}">
                            <a href="${ctx}/reward/add?studentId=${s.id}" class="btn-link btn-sm" title="奖惩"><i class="fa fa-trophy"></i></a>
                            <a href="${ctx}/archive/add?studentId=${s.id}" class="btn-link btn-sm" title="档案"><i class="fa fa-folder-open"></i></a>
                            <a href="${ctx}/student/detail?id=${s.id}" class="btn-link btn-sm" title="详情"><i class="fa fa-eye"></i></a>
                            <a href="${ctx}/student/edit?id=${s.id}" class="btn-link btn-sm" title="编辑"><i class="fa fa-edit"></i></a>
                            <button type="button" class="btn-link danger btn-sm" title="删除" onclick="delStudent(${s.id})"><i class="fa fa-trash"></i></button>
                        </c:if>
                    </td>
                </tr>
                </c:forEach>
                <c:if test="${empty page.list}">
                <tr><td colspan="12">
                    <div class="table-empty"><i class="fa fa-inbox"></i>暂无学生数据</div>
                </td></tr>
                </c:if>
            </tbody>
        </table>
        </div>

        <div class="pagination">
            <div class="info">共 <b>${page.total}</b> 条记录，第 ${page.pageNum}/${page.pages} 页</div>
            <div class="pager">
                <c:url var="base" value="/student/list">
                    <c:param name="studentNo" value="${query.studentNo}"/>
                    <c:param name="name" value="${query.name}"/>
                    <c:param name="gender" value="${query.gender}"/>
                    <c:param name="college" value="${query.college}"/>
                    <c:param name="className" value="${query.className}"/>
                    <c:param name="status" value="${query.status}"/>
                    <c:if test="${param.pick eq '1'}"><c:param name="pick" value="1"/></c:if>
                    <c:if test="${param.embedded eq '1'}"><c:param name="embedded" value="1"/></c:if>
                </c:url>
                <c:choose>
                    <c:when test="${page.pageNum > 1}">
                        <a href="${base}&pageNum=1">首页</a>
                        <a href="${base}&pageNum=${page.pageNum-1}"><i class="fa fa-angle-left"></i></a>
                    </c:when>
                    <c:otherwise>
                        <span class="disabled">首页</span>
                        <span class="disabled"><i class="fa fa-angle-left"></i></span>
                    </c:otherwise>
                </c:choose>
                <c:forEach begin="${page.pageNum-2 > 1 ? page.pageNum-2 : 1}" end="${page.pageNum+2 < page.pages ? page.pageNum+2 : page.pages}" var="i">
                    <a href="${base}&pageNum=${i}" class="${i eq page.pageNum ? 'active':''}">${i}</a>
                </c:forEach>
                <c:choose>
                    <c:when test="${page.pageNum < page.pages}">
                        <a href="${base}&pageNum=${page.pageNum+1}"><i class="fa fa-angle-right"></i></a>
                        <a href="${base}&pageNum=${page.pages}">末页</a>
                    </c:when>
                    <c:otherwise>
                        <span class="disabled"><i class="fa fa-angle-right"></i></span>
                        <span class="disabled">末页</span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.bootcdn.net/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="${ctx}/static/js/common.js?v=20261019b"></script>
<script>
    function delStudent(id) {
        App.confirm({
            title: '移除学生',
            content: '确认将该学生从学生列表和学生选择中移除？已有档案、奖惩、请假、资助和就业记录将保留。',
            okText: '确认移除',
            danger: true,
            onOk: function () {
                App.post('/student/delete', {id: id}, function () {
                    App.toast('已移除学生，历史业务记录保留', 'success');
                    location.reload();
                });
            }
        });
    }
    function pickStudent(id, no, name, cls) {
        if (window.parent !== window && typeof window.parent.selectAidStudent === 'function') {
            window.parent.selectAidStudent(id, no, name);
            return;
        }
        if (window.opener && typeof window.opener.setStudent === 'function') {
            window.opener.setStudent(id, no, name, cls);
            window.close();
        } else {
            App.toast('未找到父窗口，请通过奖惩表单页打开本页', 'error');
        }
    }
    document.addEventListener('keydown', function (event) {
        if (event.key === 'Escape' && window.parent !== window && typeof window.parent.selectAidStudent === 'function') {
            window.parent.document.querySelector('#studentPickerModal .btn-cancel').click();
        }
    });
</script>
</body>
</html>
