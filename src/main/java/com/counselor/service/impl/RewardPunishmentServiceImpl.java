package com.counselor.service.impl;

import com.counselor.common.PageResult;
import com.counselor.entity.RewardPunishment;
import com.counselor.mapper.RewardPunishmentMapper;
import com.counselor.service.RewardPunishmentService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RewardPunishmentServiceImpl implements RewardPunishmentService {

    @Autowired
    private RewardPunishmentMapper rewardPunishmentMapper;

    @Override
    public RewardPunishment findById(Long id) {
        return rewardPunishmentMapper.selectByPrimaryKey(id);
    }

    @Override
    public PageResult<RewardPunishment> page(int pageNum, int pageSize, RewardPunishment query) {
        PageHelper.startPage(pageNum, pageSize);
        List<RewardPunishment> list = rewardPunishmentMapper.selectList(query);
        PageInfo<RewardPunishment> info = new PageInfo<>(list);
        return new PageResult<>(info.getList(), info.getTotal(), info.getPageNum(), info.getPageSize());
    }

    @Override
    public boolean save(RewardPunishment record) {
        if (record.getStatus() == null || record.getStatus().isEmpty()) {
            record.setStatus("生效");
        }
        return rewardPunishmentMapper.insert(record) > 0;
    }

    @Override
    public boolean update(RewardPunishment record) {
        return rewardPunishmentMapper.updateByPrimaryKey(record) > 0;
    }

    @Override
    public boolean deleteById(Long id) {
        return rewardPunishmentMapper.deleteByPrimaryKey(id) > 0;
    }
}
