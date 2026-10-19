package com.counselor.service.impl;

import com.counselor.entity.DashboardVO;
import com.counselor.mapper.*;
import com.counselor.service.DashboardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class DashboardServiceImpl implements DashboardService {

    @Autowired
    private StudentMapper studentMapper;
    @Autowired
    private RewardPunishmentMapper rewardPunishmentMapper;
    @Autowired
    private WorkReminderMapper workReminderMapper;
    @Autowired
    private WorkflowMinutesMapper workflowMinutesMapper;
    @Autowired
    private StudentArchiveMapper studentArchiveMapper;
    @Autowired
    private LeaveRequestMapper leaveRequestMapper;
    @Autowired
    private VisitorLogMapper visitorLogMapper;
    @Autowired
    private FinancialAidMapper financialAidMapper;
    @Autowired
    private EmploymentTrackMapper employmentTrackMapper;

    @Override
    public DashboardVO load() {
        DashboardVO vo = new DashboardVO();
        com.counselor.entity.Student s = new com.counselor.entity.Student();
        s.setStatus("在读");
        vo.setStudentCount(studentMapper.countAll(s));
        vo.setRewardCount(nvl(rewardPunishmentMapper.countByType("奖励")));
        vo.setPunishCount(nvl(rewardPunishmentMapper.countByType("处分")));
        vo.setReminderTodoCount(nvl(workReminderMapper.countByStatus("待办"))
                + nvl(workReminderMapper.countByStatus("进行中")));
        vo.setReminderDoneCount(nvl(workReminderMapper.countByStatus("已完成")));
        vo.setWorkflowCount(nvl(workflowMinutesMapper.countAll()));
        vo.setArchiveCount(nvl(studentArchiveMapper.countAll()));
        vo.setLeavePendingCount(nvl(leaveRequestMapper.countByStatus("待审批")));
        vo.setVisitorCount(nvl(visitorLogMapper.countByStatus("在访")));
        vo.setAidPendingCount(nvl(financialAidMapper.countByStatus("待审核")));
        vo.setEmployedCount(nvl(employmentTrackMapper.countByStatus("已就业")));

        List<Map<String, Object>> collegeStat = studentMapper.countByCollege();
        List<Map<String, Object>> genderStat = studentMapper.countByGender();
        List<Map<String, Object>> politicalStat = studentMapper.countByPolitical();
        List<Map<String, Object>> recent = workflowMinutesMapper.countRecent7Days();
        vo.setCollegeStat(collegeStat);
        vo.setGenderStat(genderStat);
        vo.setPoliticalStat(politicalStat);
        vo.setRecentWorkflow(recent);
        return vo;
    }

    private long nvl(Long v) {
        return v == null ? 0 : v;
    }
}
