package com.counselor.mapper;

import com.counselor.entity.StudentArchive;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface StudentArchiveMapper {

    StudentArchive selectByPrimaryKey(@Param("id") Long id);

    List<StudentArchive> selectList(StudentArchive query);

    int insert(StudentArchive record);

    int updateByPrimaryKey(StudentArchive record);

    int deleteByPrimaryKey(@Param("id") Long id);

    Long countAll();
}
