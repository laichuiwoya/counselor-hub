package com.counselor.controller;

import com.counselor.common.Constants;
import com.counselor.common.PageResult;
import com.counselor.common.Result;
import com.counselor.entity.SysUser;
import com.counselor.entity.WorkReminder;
import com.counselor.service.WorkReminderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/reminder")
public class WorkReminderController {

    @Autowired
    private WorkReminderService workReminderService;

    private static final int PAGE_SIZE = 10;

    @GetMapping("/list")
    public String list(@RequestParam(defaultValue = "1") int pageNum,
                       WorkReminder query,
                       Model model) {
        PageResult<WorkReminder> page = workReminderService.page(pageNum, PAGE_SIZE, query);
        model.addAttribute("page", page);
        model.addAttribute("query", query);
        return "reminder/list";
    }

    @GetMapping("/add")
    public String addPage(Model model, HttpSession session) {
        WorkReminder r = new WorkReminder();
        SysUser user = (SysUser) session.getAttribute(Constants.SESSION_USER);
        if (user != null) {
            r.setCounselorId(user.getId());
            r.setCounselorName(user.getRealName());
        }
        model.addAttribute("reminder", r);
        return "reminder/form";
    }

    @GetMapping("/edit")
    public String editPage(@RequestParam Long id, Model model) {
        model.addAttribute("reminder", workReminderService.findById(id));
        return "reminder/form";
    }

    @PostMapping("/save")
    public String save(WorkReminder reminder) {
        if (reminder.getId() == null) {
            workReminderService.save(reminder);
        } else {
            workReminderService.update(reminder);
        }
        return "redirect:/reminder/list";
    }

    @PostMapping("/changeStatus")
    @ResponseBody
    public Result<Void> changeStatus(@RequestParam Long id, @RequestParam String status) {
        return workReminderService.changeStatus(id, status) ? Result.success() : Result.fail("状态更新失败");
    }

    @PostMapping("/delete")
    @ResponseBody
    public Result<Void> delete(@RequestParam Long id) {
        return workReminderService.deleteById(id) ? Result.success() : Result.fail("删除失败");
    }

    @GetMapping("/detail")
    public String detail(@RequestParam Long id, Model model) {
        model.addAttribute("reminder", workReminderService.findById(id));
        return "reminder/detail";
    }
}
