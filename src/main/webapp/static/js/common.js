/* 辅导员管理系统 - 公共脚本 */

var App = (function () {

    // 获取项目根路径
    function ctx() {
        return $('meta[name="ctx"]').attr('content') || '';
    }

    // 显示 toast
    function toast(msg, type) {
        type = type || 'info';
        var icon = type === 'success' ? 'fa-check-circle'
                : type === 'error' ? 'fa-times-circle'
                : 'fa-info-circle';
        var $box = $('#toastBox');
        if ($box.length === 0) {
            $box = $('<div id="toastBox" class="toast-box"></div>').appendTo('body');
        }
        var $item = $('<div class="toast-item ' + type + '"><i class="fa ' + icon + '"></i><span class="msg"></span></div>');
        $item.find('.msg').text(msg);
        $box.append($item);
        setTimeout(function () {
            $item.fadeOut(300, function () { $item.remove(); });
        }, 2600);
    }

    // 确认弹窗
    function confirm(opts) {
        var $mask = $('#confirmMask');
        if ($mask.length === 0) {
            $mask = $(
                '<div id="confirmMask" class="modal-mask">' +
                '  <div class="modal-box">' +
                '    <div class="modal-head"><span class="title"></span></div>' +
                '    <div class="modal-body"></div>' +
                '    <div class="modal-foot">' +
                '      <button class="btn btn-default btn-cancel">取消</button>' +
                '      <button class="btn btn-primary btn-ok">确定</button>' +
                '    </div>' +
                '  </div>' +
                '</div>'
            ).appendTo('body');
        }
        $mask.find('.title').text(opts.title || '提示');
        $mask.find('.modal-body').html(opts.content || '确定执行该操作？');
        var okBtn = $mask.find('.btn-ok').off('click').text(opts.okText || '确定');
        var cancelBtn = $mask.find('.btn-cancel').off('click');
        if (opts.danger) {
            okBtn.removeClass('btn-primary').addClass('btn-danger');
        } else {
            okBtn.removeClass('btn-danger').addClass('btn-primary');
        }
        $mask.addClass('open');
        okBtn.on('click', function () {
            $mask.removeClass('open');
            if (typeof opts.onOk === 'function') opts.onOk();
        });
        cancelBtn.on('click', function () {
            $mask.removeClass('open');
            if (typeof opts.onCancel === 'function') opts.onCancel();
        });
    }

    // POST 请求
    function post(url, data, okCb, errCb) {
        $.ajax({
            url: ctx() + url,
            type: 'POST',
            data: data,
            dataType: 'json',
            success: function (res) {
                if (res && res.code === 200) {
                    if (typeof okCb === 'function') okCb(res);
                } else {
                    toast((res && res.msg) || '操作失败', 'error');
                    if (typeof errCb === 'function') errCb(res);
                }
            },
            error: function (xhr) {
                if (xhr.status === 401) {
                    toast('登录已过期，正在跳转登录页...', 'error');
                    setTimeout(function () { location.href = ctx() + '/login'; }, 1200);
                    return;
                }
                toast('网络异常，请稍后重试', 'error');
                if (typeof errCb === 'function') errCb();
            }
        });
    }

    // 删除确认
    function del(url, id, okCb) {
        confirm({
            title: '删除确认',
            content: '<i class="fa fa-exclamation-triangle text-danger" style="margin-right:8px;"></i>确定要删除该记录吗？此操作不可恢复。',
            okText: '确认删除',
            danger: true,
            onOk: function () {
                post(url, { id: id }, function () {
                    toast('删除成功', 'success');
                    if (typeof okCb === 'function') okCb();
                });
            }
        });
    }

    return {
        ctx: ctx,
        toast: toast,
        confirm: confirm,
        post: post,
        del: del
    };
})();

// 公共初始化
$(function () {
    // 用户下拉
    $(document).on('click', '.user-dropdown .head', function (e) {
        e.stopPropagation();
        $(this).parent().toggleClass('open');
    });
    $(document).on('click', function () {
        $('.user-dropdown').removeClass('open');
    });

    // 侧边栏折叠
    $(document).on('click', '.menu-toggle', function () {
        $('.app').toggleClass(window.matchMedia('(max-width: 768px)').matches ? 'sidebar-open' : 'sidebar-collapsed');
    });

});

App.changeRecordStatus = function (url, id, status) {
    App.confirm({title: '确认操作', content: '将状态更新为“' + status + '”？', onOk: function () {
        App.post(url, {id: id, status: status}, function () { window.location.reload(); });
    }});
};

$(function () {
    $('[data-pick-student]').on('click', function () {
        if ($(this).is('[data-pick-student-modal]')) {
            window.openStudentPicker(this);
            return;
        }
        var picker = window.open(App.ctx() + '/student/list?pick=1', 'studentPicker', 'width=1100,height=720');
        if (!picker) App.toast('请允许弹出学生选择窗口', 'error');
    });
    if ($('[data-pick-student]').length) {
        window.setStudent = function (id, no, name) {
            $('#studentId').val(id);
            $('#selectedStudent').val(name + ' · ' + no);
        };
    }
    $('form[method="post"]').on('submit', function (event) {
        var student = this.querySelector('input[name="studentId"]');
        if (student && !student.value) {
            event.preventDefault(); App.toast('请选择学生', 'error'); return;
        }
        var start = this.querySelector('[name="startDate"]');
        var end = this.querySelector('[name="endDate"]');
        if (start && end && start.value && end.value && end.value < start.value) {
            event.preventDefault(); App.toast('结束日期不能早于开始日期', 'error'); end.focus();
        }
    });
    $('.data-table .actions [title]').each(function () {
        $(this).attr('aria-label', this.title);
    });
    $('.form-group').each(function (index) {
        var label = $(this).children('label').first();
        var control = $(this).find('input:not([type="hidden"]),select,textarea').first();
        if (label.length && control.length) {
            if (!control.attr('id')) control.attr('id', 'field-' + index);
            label.attr('for', control.attr('id'));
        }
    });
    $('.filter-input').each(function () {
        if (!this.getAttribute('aria-label')) this.setAttribute('aria-label', this.placeholder || (this.options && this.options[0].text) || this.name);
    });
    $(document).on('keydown', function (event) {
        if (event.key === 'Escape') $('.modal-mask.open .btn-cancel').trigger('click');
    });
});
