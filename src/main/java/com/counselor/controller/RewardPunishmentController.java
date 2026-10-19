package com.counselor.controller;

import com.counselor.common.PageResult;
import com.counselor.common.Result;
import com.counselor.entity.RewardPunishment;
import com.counselor.entity.Student;
import com.counselor.service.RewardPunishmentService;
import com.counselor.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/reward")
public class RewardPunishmentController {

    @Autowired
    private RewardPunishmentService rewardPunishmentService;
    @Autowired
    private StudentService studentService;

    private static final int PAGE_SIZE = 10;

    @GetMapping("/list")
    public String list(@RequestParam(defaultValue = "1") int pageNum,
                       RewardPunishment query,
                       Model model) {
        PageResult<RewardPunishment> page = rewardPunishmentService.page(pageNum, PAGE_SIZE, query);
        model.addAttribute("page", page);
        model.addAttribute("query", query);
        return "reward/list";
    }

    @GetMapping("/add")
    public String addPage(@RequestParam(required = false) Long studentId, Model model) {
        RewardPunishment rp = new RewardPunishment();
        if (studentId != null) {
            Student s = studentService.findById(studentId);
            if (s != null) {
                rp.setStudentId(studentId);
                rp.setStudentNo(s.getStudentNo());
                rp.setStudentName(s.getName());
            }
        }
        model.addAttribute("rp", rp);
        return "reward/form";
    }

    @GetMapping("/edit")
    public String editPage(@RequestParam Long id, Model model) {
        RewardPunishment rp = rewardPunishmentService.findById(id);
        model.addAttribute("rp", rp);
        return "reward/form";
    }

    @PostMapping("/save")
    public String save(RewardPunishment rp) {
        if (rp.getId() == null) {
            rewardPunishmentService.save(rp);
        } else {
            rewardPunishmentService.update(rp);
        }
        return "redirect:/reward/list";
    }

    @PostMapping("/delete")
    @ResponseBody
    public Result<Void> delete(@RequestParam Long id) {
        return rewardPunishmentService.deleteById(id) ? Result.success() : Result.fail("删除失败");
    }

    @GetMapping("/detail")
    public String detail(@RequestParam Long id, Model model) {
        model.addAttribute("rp", rewardPunishmentService.findById(id));
        return "reward/detail";
    }
}
