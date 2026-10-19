package com.counselor.controller;

import com.counselor.common.Constants;
import com.counselor.common.PageResult;
import com.counselor.common.Result;
import com.counselor.entity.FinancialAid;
import com.counselor.entity.SysUser;
import com.counselor.service.FinancialAidService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/aid")
public class FinancialAidController {

    @Autowired
    private FinancialAidService financialAidService;

    private static final int PAGE_SIZE = 10;

    @GetMapping("/list")
    public String list(@RequestParam(defaultValue = "1") int pageNum,
                       FinancialAid query,
                       Model model) {
        PageResult<FinancialAid> page = financialAidService.page(pageNum, PAGE_SIZE, query);
        model.addAttribute("page", page);
        model.addAttribute("query", query);
        return "aid/list";
    }

    @GetMapping("/add")
    public String addPage(Model model, HttpSession session) {
        FinancialAid f = new FinancialAid();
        SysUser user = (SysUser) session.getAttribute(Constants.SESSION_USER);
        if (user != null) {
            f.setCounselorId(user.getId());
            f.setCounselorName(user.getRealName());
        }
        model.addAttribute("aid", f);
        return "aid/form";
    }

    @GetMapping("/edit")
    public String editPage(@RequestParam Long id, Model model) {
        model.addAttribute("aid", financialAidService.findById(id));
        return "aid/form";
    }

    @PostMapping("/save")
    public String save(FinancialAid aid) {
        if (aid.getId() == null) {
            financialAidService.save(aid);
        } else {
            financialAidService.update(aid);
        }
        return "redirect:/aid/list";
    }

    @PostMapping("/changeStatus")
    @ResponseBody
    public Result<Void> changeStatus(@RequestParam Long id, @RequestParam String status) {
        return financialAidService.changeStatus(id, status) ? Result.success() : Result.fail("状态更新失败");
    }

    @PostMapping("/delete")
    @ResponseBody
    public Result<Void> delete(@RequestParam Long id) {
        return financialAidService.deleteById(id) ? Result.success() : Result.fail("删除失败");
    }

    @GetMapping("/detail")
    public String detail(@RequestParam Long id, Model model) {
        model.addAttribute("aid", financialAidService.findById(id));
        return "aid/detail";
    }
}
