package com.counselor.service.impl;

import com.counselor.common.PageResult;
import com.counselor.entity.StudentArchive;
import com.counselor.mapper.StudentArchiveMapper;
import com.counselor.service.StudentArchiveService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import org.springframework.beans.factory.annotation.Value;
import java.nio.file.Files;
import java.nio.file.Path;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Service
public class StudentArchiveServiceImpl implements StudentArchiveService {

    @Autowired
    private StudentArchiveMapper studentArchiveMapper;

    @Value("${app.upload-dir}")
    private String uploadDir;

    @Override
    public StudentArchive findById(Long id) {
        return studentArchiveMapper.selectByPrimaryKey(id);
    }

    @Override
    public PageResult<StudentArchive> page(int pageNum, int pageSize, StudentArchive query) {
        PageHelper.startPage(pageNum, pageSize);
        List<StudentArchive> list = studentArchiveMapper.selectList(query);
        PageInfo<StudentArchive> info = new PageInfo<>(list);
        return new PageResult<>(info.getList(), info.getTotal(), info.getPageNum(), info.getPageSize());
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean save(StudentArchive record, MultipartFile file) {
        if (file != null && !file.isEmpty()) {
            String path = storeFile(file);
            record.setFilePath(path);
            if (record.getArchiveName() == null || record.getArchiveName().isEmpty()) {
                record.setArchiveName(file.getOriginalFilename());
            }
        }
        if (record.getUploadDate() == null) {
            record.setUploadDate(new Date());
        }
        return studentArchiveMapper.insert(record) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean update(StudentArchive record, MultipartFile file) {
        if (file != null && !file.isEmpty()) {
            String path = storeFile(file);
            record.setFilePath(path);
            if (record.getArchiveName() == null || record.getArchiveName().isEmpty()) {
                record.setArchiveName(file.getOriginalFilename());
            }
        }
        return studentArchiveMapper.updateByPrimaryKey(record) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean deleteById(Long id) {
        return studentArchiveMapper.deleteByPrimaryKey(id) > 0;
    }

    /**
     * 保存上传文件，返回可访问的相对路径
     */
    private String storeFile(MultipartFile file) {
        try {
            String dateDir = new SimpleDateFormat("yyyyMMdd").format(new Date());
            Path directory = Path.of(uploadDir).toAbsolutePath().normalize().resolve("archive").resolve(dateDir);
            Files.createDirectories(directory);
            File dir = directory.toFile();
            String original = file.getOriginalFilename();
            String ext = "";
            if (original != null && original.contains(".")) {
                ext = original.substring(original.lastIndexOf("."));
            }
            String fileName = UUID.randomUUID().toString().replace("-", "") + ext;
            File dest = new File(dir, fileName);
            file.transferTo(dest);
            return "/upload/archive/" + dateDir + "/" + fileName;
        } catch (IOException e) {
            throw new RuntimeException("文件保存失败：" + e.getMessage(), e);
        }
    }
}
