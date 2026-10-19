-- ============================================================
-- 辅导员管理系统 - 扩展功能模块（4张新表）
-- 请假管理 / 访客登记 / 困难资助 / 就业跟踪
-- ============================================================

-- 1. 请假管理表
CREATE TABLE IF NOT EXISTS `leave_request` (
    `id`            BIGINT       NOT NULL AUTO_INCREMENT,
    `student_id`    BIGINT       NOT NULL COMMENT '学生ID',
    `leave_type`    VARCHAR(20)  NOT NULL COMMENT '病假/事假/公假/其他',
    `start_date`    DATE         NOT NULL COMMENT '开始日期',
    `end_date`      DATE         NOT NULL COMMENT '结束日期',
    `days`          DECIMAL(5,1) NOT NULL COMMENT '请假天数',
    `reason`        VARCHAR(500) DEFAULT NULL COMMENT '请假事由',
    `status`        VARCHAR(10)  NOT NULL DEFAULT '待审批' COMMENT '待审批/已批准/已驳回/已销假',
    `counselor_id`  BIGINT       DEFAULT NULL COMMENT '审批辅导员ID',
    `approve_time`  DATETIME     DEFAULT NULL COMMENT '审批时间',
    `create_time`   DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `idx_student` (`student_id`),
    KEY `idx_counselor` (`counselor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='请假管理';

-- 2. 访客登记表
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
    KEY `idx_counselor` (`counselor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='访客登记';

-- 3. 困难资助表
CREATE TABLE IF NOT EXISTS `financial_aid` (
    `id`            BIGINT       NOT NULL AUTO_INCREMENT,
    `student_id`    BIGINT       NOT NULL COMMENT '学生ID',
    `aid_type`      VARCHAR(30)  NOT NULL COMMENT '助学金/助学贷款/困难补助/勤工助学/学费减免',
    `amount`        DECIMAL(10,2) DEFAULT NULL COMMENT '金额',
    `semester`      VARCHAR(20)  DEFAULT NULL COMMENT '学期，如2025-2026-1',
    `family_income` VARCHAR(100) DEFAULT NULL COMMENT '家庭收入情况',
    `difficulty_level` VARCHAR(10) NOT NULL DEFAULT '一般' COMMENT '一般/困难/特别困难',
    `reason`        VARCHAR(500) DEFAULT NULL COMMENT '申请理由',
    `status`        VARCHAR(10)  NOT NULL DEFAULT '待审核' COMMENT '待审核/已通过/已驳回/已发放',
    `counselor_id`  BIGINT       DEFAULT NULL COMMENT '审核辅导员ID',
    `create_time`   DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `idx_student` (`student_id`),
    KEY `idx_counselor` (`counselor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='困难资助';

-- 4. 就业跟踪表
CREATE TABLE IF NOT EXISTS `employment_track` (
    `id`            BIGINT       NOT NULL AUTO_INCREMENT,
    `student_id`    BIGINT       NOT NULL COMMENT '学生ID',
    `employment_status` VARCHAR(10) NOT NULL DEFAULT '未就业' COMMENT '已就业/升学/考公/创业/未就业',
    `company`       VARCHAR(100) DEFAULT NULL COMMENT '就业单位',
    `position`      VARCHAR(50)  DEFAULT NULL COMMENT '岗位',
    `salary`        DECIMAL(10,2) DEFAULT NULL COMMENT '薪资',
    `city`          VARCHAR(50)  DEFAULT NULL COMMENT '就业城市',
    `school`        VARCHAR(100) DEFAULT NULL COMMENT '升学学校',
    `major`         VARCHAR(80)  DEFAULT NULL COMMENT '升学专业',
    `track_date`    DATE         NOT NULL COMMENT '跟踪日期',
    `remark`        VARCHAR(500) DEFAULT NULL COMMENT '备注',
    `counselor_id`  BIGINT       DEFAULT NULL COMMENT '跟踪辅导员ID',
    `create_time`   DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `idx_student` (`student_id`),
    KEY `idx_counselor` (`counselor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='就业跟踪';

-- ============================================================
-- 示例数据
-- ============================================================

-- 请假管理示例数据
INSERT INTO `leave_request` (student_id, leave_type, start_date, end_date, days, reason, status, counselor_id) VALUES
(1,  '病假', '2026-03-10', '2026-03-12', 3.0, '感冒发烧，需在家休养', '已批准', 1),
(3,  '事假', '2026-03-15', '2026-03-15', 1.0, '家中临时有事需回家处理', '已批准', 2),
(5,  '病假', '2026-04-01', '2026-04-03', 3.0, '肠胃炎，校医院建议休息', '待审批', 1),
(8,  '公假', '2026-04-05', '2026-04-07', 3.0, '参加省级编程竞赛', '已批准', 3),
(12, '事假', '2026-04-10', '2026-04-11', 2.0, '办理身份证补办手续', '已驳回', 2),
(15, '病假', '2026-04-18', '2026-04-20', 3.0, '运动扭伤，需复查', '待审批', 1),
(20, '公假', '2026-05-01', '2026-05-03', 3.0, '学校合唱团演出', '已销假', 4),
(25, '病假', '2026-05-08', '2026-05-09', 2.0, '发烧38.5度，校医院建议休息', '已批准', 5);

-- 访客登记示例数据
INSERT INTO `visitor_log` (visitor_name, phone, id_card, visit_purpose, visit_object, visit_time, leave_time, status, counselor_id) VALUES
('张伟', '13800001111', '340102199001011234', '家长探望', '张三(学生)', '2026-03-12 09:30:00', '2026-03-12 17:00:00', '已离开', 1),
('李娜', '13800002222', '340102198505056789', '送生活用品', '李四(学生)', '2026-03-20 14:00:00', '2026-03-20 16:30:00', '已离开', 2),
('王强', '13800003333', NULL, '企业校招宣讲', '计算机学院', '2026-04-02 13:30:00', NULL, '在访', 1),
('赵敏', '13800004444', '340102199203034567', '家长沟通学业', '王五(学生)', '2026-04-08 10:00:00', '2026-04-08 11:30:00', '已离开', 3),
('刘洋', '13800005555', NULL, '校友返校交流', '辅导员办公室', '2026-04-15 15:00:00', NULL, '在访', 4),
('陈芳', '13800006666', '340102198812128901', '送药', '赵六(学生)', '2026-04-22 18:00:00', '2026-04-22 19:00:00', '已离开', 5);

-- 困难资助示例数据
INSERT INTO `financial_aid` (student_id, aid_type, amount, semester, family_income, difficulty_level, reason, status, counselor_id) VALUES
(2,  '助学金',     3000.00, '2025-2026-2', '低收入家庭',   '困难',     '父亲因病丧失劳动能力，母亲打零工维持家用', '已通过', 1),
(6,  '助学贷款',   8000.00, '2025-2026-2', '低保户',       '特别困难', '单亲家庭，母亲务农，弟弟在读高中', '已发放', 2),
(10, '困难补助',   2000.00, '2025-2026-2', '务农为主',     '一般',     '今年受灾农作物减产，家庭收入下降', '待审核', 1),
(14, '助学金',     3000.00, '2025-2026-2', '打工收入',     '困难',     '父母均在外打工，弟弟年幼需照顾', '已通过', 3),
(18, '勤工助学',   NULL,    '2025-2026-2', '低收入家庭',   '困难',     '申请图书馆勤工助学岗位', '已发放', 4),
(22, '学费减免',   5000.00, '2025-2026-2', '建档立卡贫困户', '特别困难', '建档立卡贫困户，家庭无稳定收入', '待审核', 5),
(28, '困难补助',   1500.00, '2025-2026-2', '务农收入',     '一般',     '家中老人患病，医疗费用较高', '已驳回', 2),
(30, '助学金',     3000.00, '2025-2026-2', '低收入家庭',   '困难',     '母亲身体不好，父亲一人养家', '已通过', 1);

-- 就业跟踪示例数据
INSERT INTO `employment_track` (student_id, employment_status, company, position, salary, city, school, major, track_date, remark, counselor_id) VALUES
(1,  '已就业', '字节跳动科技有限公司', 'Java开发工程师', 18000.00, '北京', NULL, NULL, '2026-03-01', '校招入职，表现优秀', 1),
(3,  '升学',   NULL, NULL, NULL, NULL, '清华大学', '计算机科学与技术', '2026-03-05', '考研初试401分复试通过', 2),
(5,  '已就业', '腾讯科技（深圳）有限公司', '前端开发工程师', 16000.00, '深圳', NULL, NULL, '2026-03-10', '拿到offer，7月入职', 1),
(8,  '考公',   '某市工业和信息化局', '科员', 6500.00, '合肥', NULL, NULL, '2026-03-15', '省考上岸', 3),
(10, '已就业', '华为技术有限公司', '测试工程师', 14000.00, '上海', NULL, NULL, '2026-03-20', '校招签约', 4),
(12, '升学',   NULL, NULL, NULL, NULL, '浙江大学', '软件工程', '2026-04-01', '保研录取', 2),
(15, '已就业', '阿里巴巴集团', '产品经理', 17000.00, '杭州', NULL, NULL, '2026-04-05', '拿到offer', 5),
(20, '未就业', NULL, NULL, NULL, NULL, NULL, NULL, '2026-04-10', '正在准备春招', 1),
(25, '创业',   '校园科技工作室', '创始人', NULL, '合肥', NULL, NULL, '2026-04-15', '入驻学校创业孵化基地', 3),
(28, '已就业', '百度在线网络技术公司', '算法工程师', 20000.00, '北京', NULL, NULL, '2026-05-01', '校招sp offer', 4);
