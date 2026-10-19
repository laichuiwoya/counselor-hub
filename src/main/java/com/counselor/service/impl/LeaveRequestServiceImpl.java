package com.counselor.service.impl;

import com.counselor.common.PageResult;
import com.counselor.entity.LeaveRequest;
import com.counselor.mapper.LeaveRequestMapper;
import com.counselor.service.LeaveRequestService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class LeaveRequestServiceImpl implements LeaveRequestService {

    @Autowired
    private LeaveRequestMapper leaveRequestMapper;

    @Override
    public LeaveRequest findById(Long id) {
        return leaveRequestMapper.selectByPrimaryKey(id);
    }

    @Override
    public PageResult<LeaveRequest> page(int pageNum, int pageSize, LeaveRequest query) {
        PageHelper.startPage(pageNum, pageSize);
        List<LeaveRequest> list = leaveRequestMapper.selectList(query);
        PageInfo<LeaveRequest> info = new PageInfo<>(list);
        return new PageResult<>(info.getList(), info.getTotal(), info.getPageNum(), info.getPageSize());
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean save(LeaveRequest record) {
        if (record.getStatus() == null || record.getStatus().isEmpty()) {
            record.setStatus("待审批");
        }
        return leaveRequestMapper.insert(record) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean update(LeaveRequest record) {
        return leaveRequestMapper.updateByPrimaryKey(record) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean changeStatus(Long id, String status) {
        LeaveRequest r = new LeaveRequest();
        r.setId(id);
        r.setStatus(status);
        return leaveRequestMapper.updateByPrimaryKey(r) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean deleteById(Long id) {
        return leaveRequestMapper.deleteByPrimaryKey(id) > 0;
    }
}
