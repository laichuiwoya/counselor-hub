package com.counselor.mapper;

import com.counselor.entity.RewardPunishment;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface RewardPunishmentMapper {

    RewardPunishment selectByPrimaryKey(@Param("id") Long id);

    List<RewardPunishment> selectList(RewardPunishment query);

    int insert(RewardPunishment record);

    int updateByPrimaryKey(RewardPunishment record);

    int deleteByPrimaryKey(@Param("id") Long id);

    Long countByType(@Param("type") String type);
}
