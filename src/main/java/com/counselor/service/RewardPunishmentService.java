package com.counselor.service;

import com.counselor.common.PageResult;
import com.counselor.entity.RewardPunishment;

public interface RewardPunishmentService {

    RewardPunishment findById(Long id);

    PageResult<RewardPunishment> page(int pageNum, int pageSize, RewardPunishment query);

    boolean save(RewardPunishment record);

    boolean update(RewardPunishment record);

    boolean deleteById(Long id);
}
