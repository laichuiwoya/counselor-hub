package com.counselor.entity;

import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 困难资助
 */
@Data
public class FinancialAid implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long id;
    private Long studentId;
    /** 助学金/助学贷款/困难补助/勤工助学/学费减免 */
    private String aidType;
    private BigDecimal amount;
    private String semester;
    private String familyIncome;
    /** 一般/困难/特别困难 */
    private String difficultyLevel;
    private String reason;
    /** 待审核/已通过/已驳回/已发放 */
    private String status;
    private Long counselorId;
    private Date createTime;

    /** 关联字段 */
    private String studentName;
    private String studentNo;
    private String counselorName;
}
