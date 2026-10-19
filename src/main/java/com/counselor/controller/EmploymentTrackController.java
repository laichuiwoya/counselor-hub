package com.counselor.controller;

import com.counselor.common.Constants;
import com.counselor.common.PageResult;
import com.counselor.common.Result;
import com.counselor.entity.EmploymentTrack;
import com.counselor.entity.SysUser;
import com.counselor.service.EmploymentTrackService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/employment")
public class EmploymentTrackController {

    @Autowired
    private EmploymentTrackService employmentTrackService;

    private static final int PAGE_SIZE = 10;

    @GetMapping("/list")
    public String list(@RequestParam(defaultValue = "1") int pageNum,
                       EmploymentTrack query,
                       Model model) {
        PageResult<EmploymentTrack> page = employmentTrackService.page(pageNum, PAGE_SIZE, query);
        model.addAttribute("page", page);
        model.addAttribute("query", query);
        return "employment/list";
    }

    @GetMapping("/add")
    public String addPage(Model model, HttpSession session) {
        EmploymentTrack e = new EmploymentTrack();
        SysUser user = (SysUser) session.getAttribute(Constants.SESSION_USER);
        if (user != null) {
            e.setCounselorId(user.getId());
            e.setCounselorName(user.getRealName());
        }
        model.addAttribute("emp", e);
        return "employment/form";
    }

    @GetMapping("/edit")
    public String editPage(@RequestParam Long id, Model model) {
        model.addAttribute("emp", employmentTrackService.findById(id));
        return "employment/form";
    }

    @PostMapping("/save")
    public String save(EmploymentTrack emp) {
        if (emp.getId() == null) {
            employmentTrackService.save(emp);
        } else {
            employmentTrackService.update(emp);
        }
        return "redirect:/employment/list";
    }

    @PostMapping("/delete")
    @ResponseBody
    public Result<Void> delete(@RequestParam Long id) {
        return employmentTrackService.deleteById(id) ? Result.success() : Result.fail("删除失败");
    }

    @GetMapping("/detail")
    public String detail(@RequestParam Long id, Model model) {
        model.addAttribute("emp", employmentTrackService.findById(id));
        return "employment/detail";
    }
}
