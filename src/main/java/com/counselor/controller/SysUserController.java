package com.counselor.controller;

import com.counselor.common.PageResult;
import com.counselor.common.Result;
import com.counselor.entity.SysUser;
import com.counselor.service.SysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/user")
public class SysUserController {

    @Autowired
    private SysUserService sysUserService;

    private static final int PAGE_SIZE = 10;

    @GetMapping("/list")
    public String list(@RequestParam(defaultValue = "1") int pageNum,
                       @RequestParam(required = false) String keyword,
                       Model model) {
        // 此处简化为全量返回（数据量小）
        java.util.List<SysUser> all = sysUserService.list(keyword);
        PageResult<SysUser> page = new PageResult<>(all, (long) all.size(), 1, PAGE_SIZE);
        model.addAttribute("page", page);
        model.addAttribute("users", all);
        model.addAttribute("keyword", keyword);
        return "user/list";
    }

    @GetMapping("/add")
    public String addPage(Model model) {
        SysUser u = new SysUser();
        u.setStatus(1);
        u.setRole("counselor");
        model.addAttribute("user", u);
        return "user/form";
    }

    @GetMapping("/edit")
    public String editPage(@RequestParam Long id, Model model) {
        model.addAttribute("user", sysUserService.findById(id));
        return "user/form";
    }

    @PostMapping("/save")
    public String save(SysUser user) {
        if (user.getId() == null) {
            sysUserService.save(user);
        } else {
            sysUserService.update(user);
        }
        return "redirect:/user/list";
    }

    @PostMapping("/delete")
    @ResponseBody
    public Result<Void> delete(@RequestParam Long id) {
        return sysUserService.deleteById(id) ? Result.success() : Result.fail("删除失败");
    }

    @PostMapping("/resetPwd")
    @ResponseBody
    public Result<Void> resetPwd(@RequestParam Long id) {
        SysUser u = new SysUser();
        u.setId(id);
        u.setPassword("123456");
        return sysUserService.update(u) ? Result.success("已重置为初始密码 123456", null) : Result.fail("重置失败");
    }
}
