package com.counselor.mapper;

import com.counselor.entity.VisitorLog;
import org.apache.ibatis.annotations.Param;
import java.util.List;

public interface VisitorLogMapper {
    VisitorLog selectByPrimaryKey(@Param("id") Long id);
    List<VisitorLog> selectList(VisitorLog query);
    int insert(VisitorLog record);
    int updateByPrimaryKey(VisitorLog record);
    int deleteByPrimaryKey(@Param("id") Long id);
    Long countByStatus(@Param("status") String status);
}
