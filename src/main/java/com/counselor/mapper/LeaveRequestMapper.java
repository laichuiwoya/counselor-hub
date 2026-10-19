package com.counselor.mapper;

import com.counselor.entity.LeaveRequest;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface LeaveRequestMapper {

    LeaveRequest selectByPrimaryKey(@Param("id") Long id);

    List<LeaveRequest> selectList(LeaveRequest query);

    int insert(LeaveRequest record);

    int updateByPrimaryKey(LeaveRequest record);

    int deleteByPrimaryKey(@Param("id") Long id);

    Long countByStatus(@Param("status") String status);
}
