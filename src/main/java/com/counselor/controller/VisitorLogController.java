package com.counselor.controller;

import com.counselor.common.Constants;
import com.counselor.common.PageResult;
import com.counselor.common.Result;
import com.counselor.entity.SysUser;
import com.counselor.entity.VisitorLog;
import com.counselor.service.VisitorLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/visitor")
public class VisitorLogController {

    @Autowired
    private VisitorLogService visitorLogService;

    private static final int PAGE_SIZE = 10;

    @GetMapping("/list")
    public String list(@RequestParam(defaultValue = "1") int pageNum,
                       VisitorLog query,
                       Model model) {
        PageResult<VisitorLog> page = visitorLogService.page(pageNum, PAGE_SIZE, query);
        model.addAttribute("page", page);
        model.addAttribute("query", query);
        return "visitor/list";
    }

    @GetMapping("/add")
    public String addPage(Model model, HttpSession session) {
        VisitorLog v = new VisitorLog();
        SysUser user = (SysUser) session.getAttribute(Constants.SESSION_USER);
        if (user != null) {
            v.setCounselorId(user.getId());
            v.setCounselorName(user.getRealName());
        }
        model.addAttribute("visitor", v);
        return "visitor/form";
    }

    @GetMapping("/edit")
    public String editPage(@RequestParam Long id, Model model) {
        model.addAttribute("visitor", visitorLogService.findById(id));
        return "visitor/form";
    }

    @PostMapping("/save")
    public String save(VisitorLog visitor) {
        if (visitor.getId() == null) {
            visitorLogService.save(visitor);
        } else {
            visitorLogService.update(visitor);
        }
        return "redirect:/visitor/list";
    }

    @PostMapping("/changeStatus")
    @ResponseBody
    public Result<Void> changeStatus(@RequestParam Long id, @RequestParam String status) {
        return visitorLogService.changeStatus(id, status) ? Result.success() : Result.fail("状态更新失败");
    }

    @PostMapping("/delete")
    @ResponseBody
    public Result<Void> delete(@RequestParam Long id) {
        return visitorLogService.deleteById(id) ? Result.success() : Result.fail("删除失败");
    }

    @GetMapping("/detail")
    public String detail(@RequestParam Long id, Model model) {
        model.addAttribute("visitor", visitorLogService.findById(id));
        return "visitor/detail";
    }
}
