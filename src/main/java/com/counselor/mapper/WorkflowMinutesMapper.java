package com.counselor.mapper;

import com.counselor.entity.WorkflowMinutes;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface WorkflowMinutesMapper {

    WorkflowMinutes selectByPrimaryKey(@Param("id") Long id);

    List<WorkflowMinutes> selectList(WorkflowMinutes query);

    int insert(WorkflowMinutes record);

    int updateByPrimaryKey(WorkflowMinutes record);

    int deleteByPrimaryKey(@Param("id") Long id);

    Long countAll();

    List<Map<String, Object>> countRecent7Days();
}
