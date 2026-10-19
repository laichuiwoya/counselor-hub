package com.counselor.controller;

import com.counselor.common.Constants;
import com.counselor.common.Result;
import com.counselor.entity.SysUser;
import com.counselor.service.SysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpSession;

@Controller
public class LoginController {

    @Autowired
    private SysUserService sysUserService;

    @RequestMapping(value = {"/", "/login"}, method = RequestMethod.GET)
    public String loginPage() {
        return "login";
    }

    @RequestMapping(value = "/doLogin", method = RequestMethod.POST)
    @ResponseBody
    public Result<SysUser> doLogin(@RequestParam String username,
                                   @RequestParam String password,
                                   HttpSession session) {
        SysUser user = sysUserService.login(username, password);
        if (user == null) {
            return Result.fail("用户名或密码错误，或账号已被禁用");
        }
        session.setAttribute(Constants.SESSION_USER, user);
        // 不返回密码
        user.setPassword(null);
        return Result.success("登录成功", user);
    }

    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }

    @RequestMapping(value = "/changePwd", method = RequestMethod.POST)
    @ResponseBody
    public Result<Void> changePwd(@RequestParam String oldPwd,
                                   @RequestParam String newPwd,
                                   HttpSession session) {
        SysUser user = (SysUser) session.getAttribute(Constants.SESSION_USER);
        if (user == null) {
            return Result.fail("登录已过期，请重新登录");
        }
        if (newPwd == null || newPwd.length() < 6) {
            return Result.fail("新密码长度不能少于6位");
        }
        boolean ok = sysUserService.updatePassword(user.getId(), oldPwd, newPwd);
        if (!ok) {
            return Result.fail("原密码不正确");
        }
        return Result.success();
    }
}
