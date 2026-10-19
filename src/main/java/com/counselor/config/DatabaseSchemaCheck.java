package com.counselor.config;

import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

/** Fail at startup instead of serving partially broken pages against a v1 database. */
@Component
public class DatabaseSchemaCheck implements ApplicationRunner {
    private final JdbcTemplate jdbc;

    public DatabaseSchemaCheck(JdbcTemplate jdbc) {
        this.jdbc = jdbc;
    }

    @Override
    public void run(ApplicationArguments args) {
        try {
            jdbc.queryForList("SELECT deleted FROM student WHERE 1=0");
            jdbc.queryForList("SELECT record_type FROM student_record WHERE 1=0");
            jdbc.queryForList("SELECT record_type FROM work_record WHERE 1=0");
            jdbc.queryForList("SELECT details FROM operation_log WHERE 1=0");
        } catch (DataAccessException error) {
            throw new IllegalStateException("请核对六表数据库及 student.deleted 字段，并参照 sql/README.md 检查结构。重建或重置前请先备份现有数据。", error);
        }
    }
}
