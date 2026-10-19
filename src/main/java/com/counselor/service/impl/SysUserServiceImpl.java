package com.counselor.service.impl;

import com.counselor.common.Constants;
import com.counselor.entity.SysUser;
import com.counselor.mapper.SysUserMapper;
import com.counselor.service.SysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class SysUserServiceImpl implements SysUserService {

    @Autowired
    private SysUserMapper sysUserMapper;

    @Override
    public SysUser login(String username, String password) {
        SysUser user = sysUserMapper.selectByUsername(username);
        if (user == null) {
            return null;
        }
        String md5 = Constants.md5(password);
        if (user.getPassword() == null || !user.getPassword().equalsIgnoreCase(md5)) {
            return null;
        }
        if (user.getStatus() != null && user.getStatus() == 0) {
            return null;
        }
        return user;
    }

    @Override
    public SysUser findById(Long id) {
        return sysUserMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<SysUser> list(String keyword) {
        return sysUserMapper.selectAll(keyword);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean save(SysUser user) {
        if (user.getPassword() == null || user.getPassword().isEmpty()) {
            user.setPassword(Constants.DEFAULT_PWD_MD5);
        } else {
            user.setPassword(Constants.md5(user.getPassword()));
        }
        if (user.getStatus() == null) {
            user.setStatus(1);
        }
        return sysUserMapper.insert(user) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean update(SysUser user) {
        // 这里 password 字段为明文，由调用方控制是否修改密码
        if (user.getPassword() != null && !user.getPassword().isEmpty() && user.getPassword().length() != 32) {
            user.setPassword(Constants.md5(user.getPassword()));
        }
        return sysUserMapper.updateByPrimaryKey(user) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updatePassword(Long id, String oldPwd, String newPwd) {
        SysUser user = sysUserMapper.selectByPrimaryKey(id);
        if (user == null) {
            return false;
        }
        String oldMd5 = Constants.md5(oldPwd);
        if (!oldMd5.equalsIgnoreCase(user.getPassword())) {
            return false;
        }
        return sysUserMapper.updatePassword(id, Constants.md5(newPwd)) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean deleteById(Long id) {
        return sysUserMapper.deleteByPrimaryKey(id) > 0;
    }
}
