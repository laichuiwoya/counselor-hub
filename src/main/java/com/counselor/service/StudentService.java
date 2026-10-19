package com.counselor.service;

import com.counselor.common.PageResult;
import com.counselor.entity.Student;

import java.util.List;

public interface StudentService {

    Student findById(Long id);

    PageResult<Student> page(int pageNum, int pageSize, Student query);

    List<Student> list(Student query);

    boolean save(Student student);

    boolean update(Student student);

    boolean deleteById(Long id);
}
