package com.counselor.entity;

import lombok.Data;
import java.util.Date;

@Data
public class OperationLog {
    private Long id;
    private Long userId;
    private String username;
    private String operation;
    private String details;
    private String outcome;
    private String errorType;
    private Long durationMs;
    private Date createTime;
}
