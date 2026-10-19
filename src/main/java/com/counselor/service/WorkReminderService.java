package com.counselor.service;

import com.counselor.common.PageResult;
import com.counselor.entity.WorkReminder;

import java.util.List;

public interface WorkReminderService {

    WorkReminder findById(Long id);

    PageResult<WorkReminder> page(int pageNum, int pageSize, WorkReminder query);

    List<WorkReminder> listRecent(int limit);

    boolean save(WorkReminder record);

    boolean update(WorkReminder record);

    boolean changeStatus(Long id, String status);

    boolean deleteById(Long id);
}
