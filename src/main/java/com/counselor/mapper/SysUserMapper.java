package com.counselor.mapper;

import com.counselor.entity.SysUser;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface SysUserMapper {

    SysUser selectByUsername(@Param("username") String username);

    SysUser selectByPrimaryKey(@Param("id") Long id);

    List<SysUser> selectAll(@Param("keyword") String keyword);

    int insert(SysUser record);

    int updateByPrimaryKey(SysUser record);

    int updatePassword(@Param("id") Long id, @Param("password") String password);

    int deleteByPrimaryKey(@Param("id") Long id);

    int countStudentByCounselor(@Param("counselorId") Long counselorId);
}
