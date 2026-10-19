package com.counselor.controller;

import com.counselor.common.Constants;
import com.counselor.entity.DashboardVO;
import com.counselor.entity.SysUser;
import com.counselor.service.DashboardService;
import com.counselor.service.WorkReminderService;
import com.counselor.service.WorkflowMinutesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpSession;

@Controller
public class DashboardController {

    @Autowired
    private DashboardService dashboardService;
    @Autowired
    private WorkReminderService workReminderService;
    @Autowired
    private WorkflowMinutesService workflowMinutesService;

    @RequestMapping("/index")
    public String index() {
        return "main";
    }

    @RequestMapping("/dashboard")
    public String dashboard(Model model, HttpSession session) {
        SysUser user = (SysUser) session.getAttribute(Constants.SESSION_USER);
        DashboardVO vo = dashboardService.load();
        model.addAttribute("vo", vo);
        model.addAttribute("reminders", workReminderService.listRecent(5));
        model.addAttribute("workflows", workflowMinutesService.listRecent(5));
        model.addAttribute("user", user);
        return "dashboard";
    }
}
