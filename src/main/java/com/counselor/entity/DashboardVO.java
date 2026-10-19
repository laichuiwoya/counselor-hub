package com.counselor.entity;

import lombok.Data;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

/**
 * 仪表盘统计数据
 */
@Data
public class DashboardVO implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long studentCount;
    private Long rewardCount;
    private Long punishCount;
    private Long reminderTodoCount;
    private Long reminderDoneCount;
    private Long workflowCount;
    private Long archiveCount;
    private Long leavePendingCount;
    private Long visitorCount;
    private Long aidPendingCount;
    private Long employedCount;

    /** 学院分布 */
    private List<Map<String, Object>> collegeStat;
    /** 性别分布 */
    private List<Map<String, Object>> genderStat;
    /** 政治面貌分布 */
    private List<Map<String, Object>> politicalStat;
    /** 最近7天新增纪要数 */
    private List<Map<String, Object>> recentWorkflow;
}
