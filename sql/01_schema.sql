-- 01：重建六张表。会清除 counselor_db_v2 中的现有业务数据和操作日志。
-- 执行前停止应用并备份；然后执行 02_demo_data.sql。
CREATE DATABASE IF NOT EXISTS counselor_db_v2 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE counselor_db_v2;
DROP TABLE IF EXISTS operation_log;
DROP TABLE IF EXISTS visitor_log;
DROP TABLE IF EXISTS work_record;
DROP TABLE IF EXISTS student_record;
DROP TABLE IF EXISTS student;
DROP TABLE IF EXISTS sys_user;

SET NAMES utf8mb4;

CREATE TABLE sys_user (
    id          BIGINT       NOT NULL AUTO_INCREMENT COMMENT '主键',
    username    VARCHAR(50)  NOT NULL COMMENT '登录账号',
    password    VARCHAR(100) NOT NULL COMMENT '密码（MD5）',
    real_name   VARCHAR(50)  NOT NULL COMMENT '真实姓名',
    role        VARCHAR(20)  NOT NULL DEFAULT 'counselor' COMMENT '角色：admin管理员 counselor辅导员',
    phone       VARCHAR(20)           COMMENT '手机号',
    email       VARCHAR(50)           COMMENT '邮箱',
    avatar      VARCHAR(255)          COMMENT '头像路径',
    status      TINYINT      NOT NULL DEFAULT 1 COMMENT '状态 1启用 0禁用',
    create_time DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (id),
    UNIQUE KEY uk_username (username)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统用户表';

CREATE TABLE student (
    id               BIGINT       NOT NULL AUTO_INCREMENT COMMENT '主键',
    deleted          TINYINT NOT NULL DEFAULT 0 COMMENT '0正常 1已移除，保留历史关联',
    student_no       VARCHAR(20)  NOT NULL COMMENT '学号',
    name             VARCHAR(50)  NOT NULL COMMENT '姓名',
    gender           VARCHAR(4)   NOT NULL COMMENT '性别 男/女',
    college          VARCHAR(80)  NOT NULL COMMENT '学院',
    major            VARCHAR(80)  NOT NULL COMMENT '专业',
    class_name       VARCHAR(50)  NOT NULL COMMENT '班级',
    grade            VARCHAR(10)           COMMENT '年级',
    dorm_building    VARCHAR(20)           COMMENT '宿舍楼',
    dorm_room        VARCHAR(20)           COMMENT '宿舍号',
    phone            VARCHAR(20)           COMMENT '手机号',
    id_card          VARCHAR(18)           COMMENT '身份证号',
    native_place     VARCHAR(100)          COMMENT '籍贯',
    political_status VARCHAR(20)           COMMENT '政治面貌',
    counselor_id     BIGINT                COMMENT '辅导员ID',
    status           VARCHAR(20)  NOT NULL DEFAULT '在读' COMMENT '在读/休学/毕业/退学',
    create_time      DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (id),
    UNIQUE KEY uk_student_no (student_no),
    KEY idx_counselor (counselor_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='学生基本表';

CREATE TABLE IF NOT EXISTS `visitor_log` (
    `id`            BIGINT       NOT NULL AUTO_INCREMENT,
    `visitor_name`  VARCHAR(50)  NOT NULL COMMENT '访客姓名',
    `phone`         VARCHAR(20)  DEFAULT NULL COMMENT '联系电话',
    `id_card`       VARCHAR(18)  DEFAULT NULL COMMENT '证件号',
    `visit_purpose` VARCHAR(100) DEFAULT NULL COMMENT '来访事由',
    `visit_object`  VARCHAR(50)  DEFAULT NULL COMMENT '被访学生/老师',
    `visit_time`    DATETIME     NOT NULL COMMENT '来访时间',
    `leave_time`    DATETIME     DEFAULT NULL COMMENT '离开时间',
    `status`        VARCHAR(10)  NOT NULL DEFAULT '在访' COMMENT '在访/已离开',
    `counselor_id`  BIGINT       DEFAULT NULL COMMENT '登记辅导员ID',
    `create_time`   DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `idx_visitor_counselor` (`counselor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='访客登记';

CREATE TABLE student_record (
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    student_id BIGINT NOT NULL,
    record_type VARCHAR(16) NOT NULL COMMENT 'REWARD / LEAVE / AID / ARCHIVE / EMPLOYMENT',
    category VARCHAR(30) COMMENT '奖惩、请假、资助或档案分类',
    title VARCHAR(100) COMMENT '奖惩名称；请假、资助可为空',
    reason VARCHAR(500),
    status VARCHAR(20) COMMENT '沿用各业务状态；由类型与状态联合校验',
    counselor_id BIGINT COMMENT '审批或审核辅导员；奖惩旧记录可为空',
    operator VARCHAR(50) COMMENT '经办人姓名快照',
    occur_date DATE COMMENT '奖惩发生/档案归档/就业跟踪日期',
    reward_level VARCHAR(30),
    file_path VARCHAR(255) COMMENT '档案文件路径',
    description VARCHAR(500) COMMENT '档案说明',
    company VARCHAR(100),
    position VARCHAR(50),
    salary DECIMAL(10,2),
    city VARCHAR(50),
    school VARCHAR(100),
    major VARCHAR(80) COMMENT '升学专业，与学生基本专业区分',
    remark VARCHAR(500),
    start_date DATE,
    end_date DATE,
    days DECIMAL(5,1),
    approve_time DATETIME,
    amount DECIMAL(10,2),
    semester VARCHAR(20),
    family_income VARCHAR(100),
    difficulty_level VARCHAR(10),
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    KEY idx_student_type (student_id, record_type, create_time),
    KEY idx_counselor_type_status (counselor_id, record_type, status),
    FOREIGN KEY (student_id) REFERENCES student(id) ON DELETE RESTRICT,
    FOREIGN KEY (counselor_id) REFERENCES sys_user(id) ON DELETE RESTRICT,
    CONSTRAINT ck_record_type CHECK (record_type IN ('REWARD','LEAVE','AID','ARCHIVE','EMPLOYMENT')),
    CONSTRAINT ck_affair_required CHECK (
        (record_type = 'REWARD' AND occur_date IS NOT NULL)
        OR (record_type = 'LEAVE' AND start_date IS NOT NULL AND end_date IS NOT NULL AND days IS NOT NULL)
        OR (record_type = 'AID' AND difficulty_level IS NOT NULL)
        OR (record_type = 'ARCHIVE' AND occur_date IS NOT NULL)
        OR (record_type = 'EMPLOYMENT' AND occur_date IS NOT NULL)),
    CONSTRAINT ck_record_category CHECK (record_type = 'EMPLOYMENT' OR category IS NOT NULL),
    CONSTRAINT ck_leave_dates CHECK (end_date IS NULL OR start_date IS NULL OR end_date >= start_date),
    CONSTRAINT ck_leave_days CHECK (days IS NULL OR days > 0),
    CONSTRAINT ck_aid_amount CHECK (amount IS NULL OR amount >= 0),
    CONSTRAINT ck_affair_status CHECK (
        (record_type = 'ARCHIVE' AND status IS NULL)
        OR (record_type = 'EMPLOYMENT' AND status IS NOT NULL AND status IN ('已就业','升学','考公','创业','未就业'))
        OR (status IS NOT NULL AND (
        (record_type = 'REWARD' AND status IN ('生效','撤销'))
        OR (record_type = 'LEAVE' AND status IN ('待审批','已批准','已驳回','已销假'))
        OR (record_type = 'AID' AND status IN ('待审核','已通过','已驳回','已发放')))))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='学生记录：奖惩、请假、资助、档案、就业';

CREATE TABLE work_record (
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    record_type VARCHAR(16) NOT NULL COMMENT 'TASK提醒 / MINUTES纪要',
    title VARCHAR(100) NOT NULL,
    category VARCHAR(30),
    content TEXT,
    counselor_id BIGINT,
    priority VARCHAR(10),
    due_date DATE,
    status VARCHAR(10),
    meeting_date DATE,
    participants VARCHAR(500),
    location VARCHAR(100),
    summary VARCHAR(500),
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    KEY idx_work_task (counselor_id, record_type, status, due_date),
    KEY idx_work_meeting (record_type, meeting_date),
    FOREIGN KEY (counselor_id) REFERENCES sys_user(id) ON DELETE RESTRICT,
    CONSTRAINT ck_work_fields CHECK (
        (record_type = 'TASK' AND status IS NOT NULL AND priority IS NOT NULL
         AND status IN ('待办','进行中','已完成') AND priority IN ('高','中','低'))
        OR (record_type = 'MINUTES' AND meeting_date IS NOT NULL))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='辅导员工作：提醒和纪要';

CREATE TABLE operation_log (
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT,
    username VARCHAR(100),
    operation VARCHAR(200) NOT NULL,
    outcome VARCHAR(16) NOT NULL,
    error_type VARCHAR(100),
    duration_ms BIGINT NOT NULL,
    details TEXT COMMENT '原operation_log_detail.details',
    create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    KEY idx_log_time (create_time),
    KEY idx_log_user_time (user_id, create_time),
    KEY idx_log_outcome_time (outcome, create_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='操作日志，保留历史用户快照，不级联删除';

-- 关联约束：学生采用逻辑删除，历史记录保持关联。
ALTER TABLE student ADD CONSTRAINT fk_student_counselor
    FOREIGN KEY (counselor_id) REFERENCES sys_user(id) ON DELETE RESTRICT;
ALTER TABLE visitor_log ADD CONSTRAINT fk_visitor_counselor
    FOREIGN KEY (counselor_id) REFERENCES sys_user(id) ON DELETE RESTRICT;
