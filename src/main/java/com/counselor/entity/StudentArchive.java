package com.counselor.entity;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 学生档案
 */
@Data
public class StudentArchive implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long id;
    private Long studentId;
    /** 入学登记表/成绩单/奖惩材料/实习材料/毕业材料/其他 */
    private String archiveType;
    private String archiveName;
    private String filePath;
    private String description;
    private Date uploadDate;
    private String operator;
    private Date createTime;

    /** 关联字段 */
    private String studentNo;
    private String studentName;
    private String className;
}
