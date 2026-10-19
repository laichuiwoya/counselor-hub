package com.counselor.controller;

import com.counselor.common.Constants;
import com.counselor.common.PageResult;
import com.counselor.common.Result;
import com.counselor.entity.Student;
import com.counselor.entity.StudentArchive;
import com.counselor.entity.SysUser;
import com.counselor.service.StudentArchiveService;
import com.counselor.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/archive")
public class StudentArchiveController {

    @Autowired
    private StudentArchiveService studentArchiveService;
    @Autowired
    private StudentService studentService;

    private static final int PAGE_SIZE = 10;

    @GetMapping("/list")
    public String list(@RequestParam(defaultValue = "1") int pageNum,
                       StudentArchive query,
                       Model model) {
        PageResult<StudentArchive> page = studentArchiveService.page(pageNum, PAGE_SIZE, query);
        model.addAttribute("page", page);
        model.addAttribute("query", query);
        return "archive/list";
    }

    @GetMapping("/add")
    public String addPage(@RequestParam(required = false) Long studentId, Model model, HttpSession session) {
        StudentArchive a = new StudentArchive();
        SysUser user = (SysUser) session.getAttribute(Constants.SESSION_USER);
        if (user != null) {
            a.setOperator(user.getRealName());
        }
        if (studentId != null) {
            Student s = studentService.findById(studentId);
            if (s != null) {
                a.setStudentId(studentId);
                a.setStudentNo(s.getStudentNo());
                a.setStudentName(s.getName());
            }
        }
        model.addAttribute("archive", a);
        return "archive/form";
    }

    @GetMapping("/edit")
    public String editPage(@RequestParam Long id, Model model) {
        model.addAttribute("archive", studentArchiveService.findById(id));
        return "archive/form";
    }

    @PostMapping("/save")
    public String save(StudentArchive archive,
                       @RequestParam(value = "file", required = false) MultipartFile file) {
        if (archive.getId() == null) {
            studentArchiveService.save(archive, file);
        } else {
            studentArchiveService.update(archive, file);
        }
        return "redirect:/archive/list";
    }

    @PostMapping("/delete")
    @ResponseBody
    public Result<Void> delete(@RequestParam Long id) {
        return studentArchiveService.deleteById(id) ? Result.success() : Result.fail("删除失败");
    }

    @GetMapping("/detail")
    public String detail(@RequestParam Long id, Model model) {
        model.addAttribute("archive", studentArchiveService.findById(id));
        return "archive/detail";
    }
}
