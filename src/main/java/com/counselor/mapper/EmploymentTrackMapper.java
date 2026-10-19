package com.counselor.mapper;

import com.counselor.entity.EmploymentTrack;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface EmploymentTrackMapper {

    EmploymentTrack selectByPrimaryKey(@Param("id") Long id);

    List<EmploymentTrack> selectList(EmploymentTrack query);

    int insert(EmploymentTrack record);

    int updateByPrimaryKey(EmploymentTrack record);

    int deleteByPrimaryKey(@Param("id") Long id);

    Long countByStatus(@Param("status") String status);
}
