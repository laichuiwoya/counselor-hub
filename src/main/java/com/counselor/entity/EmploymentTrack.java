package com.counselor.entity;

import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 就业跟踪
 */
@Data
public class EmploymentTrack implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long id;
    private Long studentId;
    /** 已就业/升学/考公/创业/未就业 */
    private String employmentStatus;
    private String company;
    private String position;
    private BigDecimal salary;
    private String city;
    private String school;
    private String major;
    private Date trackDate;
    private String remark;
    private Long counselorId;
    private Date createTime;

    /** 关联字段 */
    private String studentName;
    private String studentNo;
    private String counselorName;
}
