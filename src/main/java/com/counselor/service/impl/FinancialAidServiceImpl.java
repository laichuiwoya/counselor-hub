package com.counselor.service.impl;

import com.counselor.common.PageResult;
import com.counselor.entity.FinancialAid;
import com.counselor.mapper.FinancialAidMapper;
import com.counselor.service.FinancialAidService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FinancialAidServiceImpl implements FinancialAidService {

    @Autowired
    private FinancialAidMapper financialAidMapper;

    @Override
    public FinancialAid findById(Long id) {
        return financialAidMapper.selectByPrimaryKey(id);
    }

    @Override
    public PageResult<FinancialAid> page(int pageNum, int pageSize, FinancialAid query) {
        PageHelper.startPage(pageNum, pageSize);
        List<FinancialAid> list = financialAidMapper.selectList(query);
        PageInfo<FinancialAid> info = new PageInfo<>(list);
        return new PageResult<>(info.getList(), info.getTotal(), info.getPageNum(), info.getPageSize());
    }

    @Override
    public boolean save(FinancialAid record) {
        if (record.getStatus() == null || record.getStatus().isEmpty()) {
            record.setStatus("待审核");
        }
        if (record.getDifficultyLevel() == null || record.getDifficultyLevel().isEmpty()) {
            record.setDifficultyLevel("一般");
        }
        return financialAidMapper.insert(record) > 0;
    }

    @Override
    public boolean update(FinancialAid record) {
        return financialAidMapper.updateByPrimaryKey(record) > 0;
    }

    @Override
    public boolean changeStatus(Long id, String status) {
        FinancialAid f = new FinancialAid();
        f.setId(id);
        f.setStatus(status);
        return financialAidMapper.updateByPrimaryKey(f) > 0;
    }

    @Override
    public boolean deleteById(Long id) {
        return financialAidMapper.deleteByPrimaryKey(id) > 0;
    }
}
