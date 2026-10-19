package com.counselor.mapper;

import com.counselor.entity.WorkReminder;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface WorkReminderMapper {

    WorkReminder selectByPrimaryKey(@Param("id") Long id);

    List<WorkReminder> selectList(WorkReminder query);

    int insert(WorkReminder record);

    int updateByPrimaryKey(WorkReminder record);

    int deleteByPrimaryKey(@Param("id") Long id);

    Long countByStatus(@Param("status") String status);
}
