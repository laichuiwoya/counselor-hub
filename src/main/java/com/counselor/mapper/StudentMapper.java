package com.counselor.mapper;

import com.counselor.entity.Student;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface StudentMapper {

    Student selectByPrimaryKey(@Param("id") Long id);

    Student selectByStudentNo(@Param("studentNo") String studentNo);

    List<Student> selectList(Student query);

    int insert(Student record);

    int updateByPrimaryKey(Student record);

    int deleteByPrimaryKey(@Param("id") Long id);

    Long countAll(Student query);

    List<Map<String, Object>> countByCollege();

    List<Map<String, Object>> countByGender();

    List<Map<String, Object>> countByPolitical();
}
