package com.counselor.entity;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 学生基本
 */
@Data
public class Student implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long id;
    private String studentNo;
    private String name;
    private String gender;
    private String college;
    private String major;
    private String className;
    private String grade;
    private String dormBuilding;
    private String dormRoom;
    private String phone;
    private String idCard;
    private String nativePlace;
    private String politicalStatus;
    private Long counselorId;
    /** 在读/休学/毕业/退学 */
    private String status;
    private Date createTime;

    /** 关联字段（非数据库列） */
    private String counselorName;
}
