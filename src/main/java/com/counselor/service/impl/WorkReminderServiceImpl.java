package com.counselor.service.impl;

import com.counselor.common.PageResult;
import com.counselor.entity.WorkReminder;
import com.counselor.mapper.WorkReminderMapper;
import com.counselor.service.WorkReminderService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class WorkReminderServiceImpl implements WorkReminderService {

    @Autowired
    private WorkReminderMapper workReminderMapper;

    @Override
    public WorkReminder findById(Long id) {
        return workReminderMapper.selectByPrimaryKey(id);
    }

    @Override
    public PageResult<WorkReminder> page(int pageNum, int pageSize, WorkReminder query) {
        PageHelper.startPage(pageNum, pageSize);
        List<WorkReminder> list = workReminderMapper.selectList(query);
        PageInfo<WorkReminder> info = new PageInfo<>(list);
        return new PageResult<>(info.getList(), info.getTotal(), info.getPageNum(), info.getPageSize());
    }

    @Override
    public List<WorkReminder> listRecent(int limit) {
        PageHelper.startPage(1, limit);
        List<WorkReminder> list = workReminderMapper.selectList(null);
        return list;
    }

    @Override
    public boolean save(WorkReminder record) {
        if (record.getStatus() == null || record.getStatus().isEmpty()) {
            record.setStatus("待办");
        }
        if (record.getPriority() == null || record.getPriority().isEmpty()) {
            record.setPriority("中");
        }
        return workReminderMapper.insert(record) > 0;
    }

    @Override
    public boolean update(WorkReminder record) {
        return workReminderMapper.updateByPrimaryKey(record) > 0;
    }

    @Override
    public boolean changeStatus(Long id, String status) {
        WorkReminder r = new WorkReminder();
        r.setId(id);
        r.setStatus(status);
        return workReminderMapper.updateByPrimaryKey(r) > 0;
    }

    @Override
    public boolean deleteById(Long id) {
        return workReminderMapper.deleteByPrimaryKey(id) > 0;
    }
}
