package com.counselor.controller;

import com.counselor.common.PageResult;
import com.counselor.common.Result;
import com.counselor.entity.Student;
import com.counselor.entity.SysUser;
import com.counselor.service.StudentService;
import com.counselor.service.SysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/student")
public class StudentController {

    @Autowired
    private StudentService studentService;
    @Autowired
    private SysUserService sysUserService;

    private static final int PAGE_SIZE = 10;

    @GetMapping("/list")
    public String list(@RequestParam(defaultValue = "1") int pageNum,
                       Student query,
                       Model model) {
        PageResult<Student> page = studentService.page(pageNum, PAGE_SIZE, query);
        model.addAttribute("page", page);
        model.addAttribute("query", query);
        return "student/list";
    }

    @GetMapping("/add")
    public String addPage(Model model) {
        List<SysUser> counselors = sysUserService.list(null);
        model.addAttribute("counselors", counselors);
        model.addAttribute("student", new Student());
        return "student/form";
    }

    @GetMapping("/edit")
    public String editPage(@RequestParam Long id, Model model) {
        Student student = studentService.findById(id);
        List<SysUser> counselors = sysUserService.list(null);
        model.addAttribute("student", student);
        model.addAttribute("counselors", counselors);
        return "student/form";
    }

    @PostMapping("/save")
    public String save(Student student) {
        if (student.getId() == null) {
            studentService.save(student);
        } else {
            studentService.update(student);
        }
        return "redirect:/student/list";
    }

    @PostMapping("/delete")
    @ResponseBody
    public Result<Void> delete(@RequestParam Long id) {
        return studentService.deleteById(id) ? Result.success() : Result.fail("删除失败");
    }

    @GetMapping("/detail")
    public String detail(@RequestParam Long id, Model model) {
        model.addAttribute("student", studentService.findById(id));
        return "student/detail";
    }

    @GetMapping("/search")
    @ResponseBody
    public Result<List<Student>> search(@RequestParam(required = false) String keyword) {
        Student query = new Student();
        if (keyword != null && !keyword.isEmpty()) {
            // 学号或姓名模糊
            query.setName(keyword);
        }
        return Result.success(studentService.list(query));
    }
}
