package com.counselor.service;

import com.counselor.common.PageResult;
import com.counselor.entity.VisitorLog;

public interface VisitorLogService {
    VisitorLog findById(Long id);
    PageResult<VisitorLog> page(int pageNum, int pageSize, VisitorLog query);

    boolean save(VisitorLog record);
    boolean update(VisitorLog record);
    boolean changeStatus(Long id, String status);
    boolean deleteById(Long id);
}
