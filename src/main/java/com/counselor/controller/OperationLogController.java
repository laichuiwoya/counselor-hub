package com.counselor.controller;

import com.counselor.audit.OperationLogStore;
import com.counselor.common.Constants;
import com.counselor.entity.SysUser;
import jakarta.servlet.http.HttpSession;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.server.ResponseStatusException;

@Controller
public class OperationLogController {
    private final OperationLogStore store;
    public OperationLogController(OperationLogStore store) { this.store = store; }

    @GetMapping("/operation-log/list")
    public String list(@RequestParam(defaultValue = "1") int pageNum,
                       @RequestParam(required = false) String keyword,
                       @RequestParam(required = false) String outcome,
                       HttpSession session, Model model) {
        Object actor = session.getAttribute(Constants.SESSION_USER);
        if (!(actor instanceof SysUser user) || !"admin".equals(user.getRole())) {
            throw new ResponseStatusException(HttpStatus.FORBIDDEN, "仅管理员可查看操作日志");
        }
        model.addAttribute("page", store.page(pageNum, keyword, outcome));
        model.addAttribute("keyword", keyword);
        model.addAttribute("outcome", outcome);
        return "operation-log/list";
    }
}
