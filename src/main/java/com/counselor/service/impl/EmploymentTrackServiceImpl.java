package com.counselor.service.impl;

import com.counselor.common.PageResult;
import com.counselor.entity.EmploymentTrack;
import com.counselor.mapper.EmploymentTrackMapper;
import com.counselor.service.EmploymentTrackService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmploymentTrackServiceImpl implements EmploymentTrackService {

    @Autowired
    private EmploymentTrackMapper employmentTrackMapper;

    @Override
    public EmploymentTrack findById(Long id) {
        return employmentTrackMapper.selectByPrimaryKey(id);
    }

    @Override
    public PageResult<EmploymentTrack> page(int pageNum, int pageSize, EmploymentTrack query) {
        PageHelper.startPage(pageNum, pageSize);
        List<EmploymentTrack> list = employmentTrackMapper.selectList(query);
        PageInfo<EmploymentTrack> info = new PageInfo<>(list);
        return new PageResult<>(info.getList(), info.getTotal(), info.getPageNum(), info.getPageSize());
    }

    @Override
    public boolean save(EmploymentTrack record) {
        if (record.getEmploymentStatus() == null || record.getEmploymentStatus().isEmpty()) {
            record.setEmploymentStatus("未就业");
        }
        return employmentTrackMapper.insert(record) > 0;
    }

    @Override
    public boolean update(EmploymentTrack record) {
        return employmentTrackMapper.updateByPrimaryKey(record) > 0;
    }

    @Override
    public boolean deleteById(Long id) {
        return employmentTrackMapper.deleteByPrimaryKey(id) > 0;
    }
}
