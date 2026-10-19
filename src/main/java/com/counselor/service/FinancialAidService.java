package com.counselor.service;

import com.counselor.common.PageResult;
import com.counselor.entity.FinancialAid;

public interface FinancialAidService {

    FinancialAid findById(Long id);

    PageResult<FinancialAid> page(int pageNum, int pageSize, FinancialAid query);

    boolean save(FinancialAid record);

    boolean update(FinancialAid record);

    boolean changeStatus(Long id, String status);

    boolean deleteById(Long id);
}
