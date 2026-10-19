package com.counselor.service;

import com.counselor.common.PageResult;
import com.counselor.entity.StudentArchive;
import org.springframework.web.multipart.MultipartFile;

public interface StudentArchiveService {

    StudentArchive findById(Long id);

    PageResult<StudentArchive> page(int pageNum, int pageSize, StudentArchive query);

    boolean save(StudentArchive record, MultipartFile file);

    boolean update(StudentArchive record, MultipartFile file);

    boolean deleteById(Long id);
}
