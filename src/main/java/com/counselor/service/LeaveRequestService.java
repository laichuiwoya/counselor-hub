package com.counselor.service;

import com.counselor.common.PageResult;
import com.counselor.entity.LeaveRequest;

public interface LeaveRequestService {

    LeaveRequest findById(Long id);

    PageResult<LeaveRequest> page(int pageNum, int pageSize, LeaveRequest query);

    boolean save(LeaveRequest record);

    boolean update(LeaveRequest record);

    boolean changeStatus(Long id, String status);

    boolean deleteById(Long id);
}
