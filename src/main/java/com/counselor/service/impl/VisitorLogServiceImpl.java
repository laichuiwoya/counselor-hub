package com.counselor.service.impl;

import com.counselor.common.PageResult;
import com.counselor.entity.VisitorLog;
import com.counselor.mapper.VisitorLogMapper;
import com.counselor.service.VisitorLogService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
public class VisitorLogServiceImpl implements VisitorLogService {

    @Autowired
    private VisitorLogMapper visitorLogMapper;

    @Override
    public VisitorLog findById(Long id) {
        return visitorLogMapper.selectByPrimaryKey(id);
    }

    @Override
    public PageResult<VisitorLog> page(int pageNum, int pageSize, VisitorLog query) {
        PageHelper.startPage(pageNum, pageSize);
        List<VisitorLog> list = visitorLogMapper.selectList(query);
        PageInfo<VisitorLog> info = new PageInfo<>(list);
        return new PageResult<>(info.getList(), info.getTotal(), info.getPageNum(), info.getPageSize());
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean save(VisitorLog record) {
        if (record.getStatus() == null || record.getStatus().isEmpty()) {
            record.setStatus("在访");
        }
        return visitorLogMapper.insert(record) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean update(VisitorLog record) {
        return visitorLogMapper.updateByPrimaryKey(record) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean changeStatus(Long id, String status) {
        VisitorLog v = new VisitorLog();
        v.setId(id);
        v.setStatus(status);
        return visitorLogMapper.updateByPrimaryKey(v) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean deleteById(Long id) {
        return visitorLogMapper.deleteByPrimaryKey(id) > 0;
    }
}
