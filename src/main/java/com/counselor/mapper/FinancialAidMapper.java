package com.counselor.mapper;

import com.counselor.entity.FinancialAid;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface FinancialAidMapper {

    FinancialAid selectByPrimaryKey(@Param("id") Long id);

    List<FinancialAid> selectList(FinancialAid query);

    int insert(FinancialAid record);

    int updateByPrimaryKey(FinancialAid record);

    int deleteByPrimaryKey(@Param("id") Long id);

    Long countByStatus(@Param("status") String status);
}
