package com.counselor.entity;

import lombok.Data;
import java.io.Serializable;
import java.util.Date;

/**
 * 访客登记
 */
@Data
public class VisitorLog implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long id;
    private String visitorName;
    private String phone;
    private String idCard;
    private String visitPurpose;
    private String visitObject;
    private Date visitTime;
    private Date leaveTime;
    /** 在访/已离开 */
    private String status;
    private Long counselorId;
    private Date createTime;

    /** 关联字段 */
    private String counselorName;
}
