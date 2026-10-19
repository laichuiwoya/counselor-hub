package com.counselor.entity;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 工作流程纪要
 */
@Data
public class WorkflowMinutes implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long id;
    private String title;
    /** 主题班会/学生谈话/走访宿舍/专题会议/其他 */
    private String category;
    private String content;
    private String participants;
    private Date meetingDate;
    private String location;
    private String summary;
    private Long counselorId;
    private Date createTime;

    /** 关联字段 */
    private String counselorName;
}
