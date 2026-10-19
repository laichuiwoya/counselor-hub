package com.counselor.entity;

import lombok.Data;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 请假管理
 */
@Data
public class LeaveRequest implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long id;
    private Long studentId;
    /** 病假/事假/公假/其他 */
    private String leaveType;
    private Date startDate;
    private Date endDate;
    private BigDecimal days;
    private String reason;
    /** 待审批/已批准/已驳回/已销假 */
    private String status;
    private Long counselorId;
    private Date approveTime;
    private Date createTime;

    /** 关联字段 */
    private String studentName;
    private String studentNo;
    private String counselorName;
}
