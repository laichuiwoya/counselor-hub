package com.counselor.service;

import com.counselor.common.PageResult;
import com.counselor.entity.EmploymentTrack;

public interface EmploymentTrackService {

    EmploymentTrack findById(Long id);

    PageResult<EmploymentTrack> page(int pageNum, int pageSize, EmploymentTrack query);

    boolean save(EmploymentTrack record);

    boolean update(EmploymentTrack record);

    boolean deleteById(Long id);
}
