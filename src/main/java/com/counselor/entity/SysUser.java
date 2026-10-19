package com.counselor.entity;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 系统用户（辅导员/管理员）
 */
@Data
public class SysUser implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long id;
    private String username;
    private String password;
    private String realName;
    /** admin 管理员 / counselor 辅导员 */
    private String role;
    private String phone;
    private String email;
    private String avatar;
    /** 1 启用 0 禁用 */
    private Integer status;
    private Date createTime;
}
