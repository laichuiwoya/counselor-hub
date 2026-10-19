package com.counselor.service.impl;

import com.counselor.common.PageResult;
import com.counselor.entity.Student;
import com.counselor.mapper.StudentMapper;
import com.counselor.service.StudentService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class StudentServiceImpl implements StudentService {

    @Autowired
    private StudentMapper studentMapper;

    @Override
    public Student findById(Long id) {
        return studentMapper.selectByPrimaryKey(id);
    }

    @Override
    public PageResult<Student> page(int pageNum, int pageSize, Student query) {
        PageHelper.startPage(pageNum, pageSize);
        List<Student> list = studentMapper.selectList(query);
        PageInfo<Student> info = new PageInfo<>(list);
        return new PageResult<>(info.getList(), info.getTotal(), info.getPageNum(), info.getPageSize());
    }

    @Override
    public List<Student> list(Student query) {
        return studentMapper.selectList(query);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean save(Student student) {
        if (student.getStatus() == null || student.getStatus().isEmpty()) {
            student.setStatus("在读");
        }
        return studentMapper.insert(student) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean update(Student student) {
        return studentMapper.updateByPrimaryKey(student) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean deleteById(Long id) {
        return studentMapper.deleteByPrimaryKey(id) > 0;
    }
}
