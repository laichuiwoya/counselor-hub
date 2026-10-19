package com.counselor.entity;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 学生奖惩
 */
@Data
public class RewardPunishment implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long id;
    private Long studentId;
    /** 奖励 / 处分 */
    private String type;
    private String level;
    private String name;
    private String reason;
    private Date occurDate;
    private String operator;
    /** 生效 / 撤销 */
    private String status;
    private Date createTime;

    /** 关联字段 */
    private String studentNo;
    private String studentName;
    private String className;
}
