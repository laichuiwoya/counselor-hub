package com.counselor.service.impl;

import com.counselor.common.PageResult;
import com.counselor.entity.WorkflowMinutes;
import com.counselor.mapper.WorkflowMinutesMapper;
import com.counselor.service.WorkflowMinutesService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class WorkflowMinutesServiceImpl implements WorkflowMinutesService {

    @Autowired
    private WorkflowMinutesMapper workflowMinutesMapper;

    @Override
    public WorkflowMinutes findById(Long id) {
        return workflowMinutesMapper.selectByPrimaryKey(id);
    }

    @Override
    public PageResult<WorkflowMinutes> page(int pageNum, int pageSize, WorkflowMinutes query) {
        PageHelper.startPage(pageNum, pageSize);
        List<WorkflowMinutes> list = workflowMinutesMapper.selectList(query);
        PageInfo<WorkflowMinutes> info = new PageInfo<>(list);
        return new PageResult<>(info.getList(), info.getTotal(), info.getPageNum(), info.getPageSize());
    }

    @Override
    public List<WorkflowMinutes> listRecent(int limit) {
        PageHelper.startPage(1, limit);
        return workflowMinutesMapper.selectList(null);
    }

    @Override
    public boolean save(WorkflowMinutes record) {
        return workflowMinutesMapper.insert(record) > 0;
    }

    @Override
    public boolean update(WorkflowMinutes record) {
        return workflowMinutesMapper.updateByPrimaryKey(record) > 0;
    }

    @Override
    public boolean deleteById(Long id) {
        return workflowMinutesMapper.deleteByPrimaryKey(id) > 0;
    }
}
