package com.counselor.controller;

import com.counselor.common.Constants;
import com.counselor.common.PageResult;
import com.counselor.common.Result;
import com.counselor.entity.SysUser;
import com.counselor.entity.WorkflowMinutes;
import com.counselor.service.WorkflowMinutesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/workflow")
public class WorkflowMinutesController {

    @Autowired
    private WorkflowMinutesService workflowMinutesService;

    private static final int PAGE_SIZE = 10;

    @GetMapping("/list")
    public String list(@RequestParam(defaultValue = "1") int pageNum,
                       WorkflowMinutes query,
                       Model model) {
        PageResult<WorkflowMinutes> page = workflowMinutesService.page(pageNum, PAGE_SIZE, query);
        model.addAttribute("page", page);
        model.addAttribute("query", query);
        return "workflow/list";
    }

    @GetMapping("/add")
    public String addPage(Model model, HttpSession session) {
        WorkflowMinutes w = new WorkflowMinutes();
        SysUser user = (SysUser) session.getAttribute(Constants.SESSION_USER);
        if (user != null) {
            w.setCounselorId(user.getId());
            w.setCounselorName(user.getRealName());
        }
        model.addAttribute("workflow", w);
        return "workflow/form";
    }

    @GetMapping("/edit")
    public String editPage(@RequestParam Long id, Model model) {
        model.addAttribute("workflow", workflowMinutesService.findById(id));
        return "workflow/form";
    }

    @PostMapping("/save")
    public String save(WorkflowMinutes workflow) {
        if (workflow.getId() == null) {
            workflowMinutesService.save(workflow);
        } else {
            workflowMinutesService.update(workflow);
        }
        return "redirect:/workflow/list";
    }

    @PostMapping("/delete")
    @ResponseBody
    public Result<Void> delete(@RequestParam Long id) {
        return workflowMinutesService.deleteById(id) ? Result.success() : Result.fail("删除失败");
    }

    @GetMapping("/detail")
    public String detail(@RequestParam Long id, Model model) {
        model.addAttribute("workflow", workflowMinutesService.findById(id));
        return "workflow/detail";
    }
}
