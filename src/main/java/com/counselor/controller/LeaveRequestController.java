package com.counselor.controller;

import com.counselor.common.Constants;
import com.counselor.common.PageResult;
import com.counselor.common.Result;
import com.counselor.entity.LeaveRequest;
import com.counselor.entity.SysUser;
import com.counselor.service.LeaveRequestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/leave")
public class LeaveRequestController {

    @Autowired
    private LeaveRequestService leaveRequestService;

    private static final int PAGE_SIZE = 10;

    @GetMapping("/list")
    public String list(@RequestParam(defaultValue = "1") int pageNum,
                       LeaveRequest query,
                       Model model) {
        PageResult<LeaveRequest> page = leaveRequestService.page(pageNum, PAGE_SIZE, query);
        model.addAttribute("page", page);
        model.addAttribute("query", query);
        return "leave/list";
    }

    @GetMapping("/add")
    public String addPage(Model model, HttpSession session) {
        LeaveRequest r = new LeaveRequest();
        SysUser user = (SysUser) session.getAttribute(Constants.SESSION_USER);
        if (user != null) {
            r.setCounselorId(user.getId());
            r.setCounselorName(user.getRealName());
        }
        model.addAttribute("leave", r);
        return "leave/form";
    }

    @GetMapping("/edit")
    public String editPage(@RequestParam Long id, Model model) {
        model.addAttribute("leave", leaveRequestService.findById(id));
        return "leave/form";
    }

    @PostMapping("/save")
    public String save(LeaveRequest leave) {
        if (leave.getId() == null) {
            leaveRequestService.save(leave);
        } else {
            leaveRequestService.update(leave);
        }
        return "redirect:/leave/list";
    }

    @PostMapping("/changeStatus")
    @ResponseBody
    public Result<Void> changeStatus(@RequestParam Long id, @RequestParam String status) {
        return leaveRequestService.changeStatus(id, status) ? Result.success() : Result.fail("状态更新失败");
    }

    @PostMapping("/delete")
    @ResponseBody
    public Result<Void> delete(@RequestParam Long id) {
        return leaveRequestService.deleteById(id) ? Result.success() : Result.fail("删除失败");
    }

    @GetMapping("/detail")
    public String detail(@RequestParam Long id, Model model) {
        model.addAttribute("leave", leaveRequestService.findById(id));
        return "leave/detail";
    }
}
