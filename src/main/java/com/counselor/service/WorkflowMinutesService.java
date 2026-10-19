package com.counselor.service;

import com.counselor.common.PageResult;
import com.counselor.entity.WorkflowMinutes;

import java.util.List;

public interface WorkflowMinutesService {

    WorkflowMinutes findById(Long id);

    PageResult<WorkflowMinutes> page(int pageNum, int pageSize, WorkflowMinutes query);

    List<WorkflowMinutes> listRecent(int limit);

    boolean save(WorkflowMinutes record);

    boolean update(WorkflowMinutes record);

    boolean deleteById(Long id);
}
