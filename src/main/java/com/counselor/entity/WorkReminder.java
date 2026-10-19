package com.counselor.entity;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 工作提示
 */
@Data
public class WorkReminder implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long id;
    private String title;
    private String content;
    /** 会议/材料/谈话/检查/其他 */
    private String type;
    /** 高/中/低 */
    private String priority;
    private Date dueDate;
    /** 待办/进行中/已完成 */
    private String status;
    private Long counselorId;
    private Date createTime;

    /** 关联字段 */
    private String counselorName;
}
