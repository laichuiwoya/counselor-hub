package com.counselor.service;

import com.counselor.entity.SysUser;

import java.util.List;

public interface SysUserService {

    SysUser login(String username, String password);

    SysUser findById(Long id);

    List<SysUser> list(String keyword);

    boolean save(SysUser user);

    boolean update(SysUser user);

    boolean updatePassword(Long id, String oldPwd, String newPwd);

    boolean deleteById(Long id);
}
