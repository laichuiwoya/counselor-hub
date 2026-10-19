-- 02：清空六表数据并导入全新、虚构的演示数据；不改变表结构。
-- 重复执行将覆盖现有业务数据；请先停止应用并备份。
-- 所有演示账号密码均为 123456；不写入任何操作日志。
USE counselor_db_v2;
SET NAMES utf8mb4;
START TRANSACTION;
DELETE FROM operation_log;
DELETE FROM visitor_log;
DELETE FROM work_record;
DELETE FROM student_record;
DELETE FROM student;
DELETE FROM sys_user;


INSERT INTO sys_user (`id`, `username`, `password`, `real_name`, `role`, `phone`, `email`, `status`) VALUES
(1, 'admin', 'e10adc3949ba59abbe56e057f20f883e', '演示管理员', 'admin', '13800000001', 'admin@example.invalid', 1),
(2, 'chenlaoshi', 'e10adc3949ba59abbe56e057f20f883e', '陈予宁', 'counselor', '13800000002', 'chenlaoshi@example.invalid', 1),
(3, 'zhoulaoshi', 'e10adc3949ba59abbe56e057f20f883e', '周清禾', 'counselor', '13800000003', 'zhoulaoshi@example.invalid', 1),
(4, 'sunlaoshi', 'e10adc3949ba59abbe56e057f20f883e', '孙景行', 'counselor', '13800000004', 'sunlaoshi@example.invalid', 1);


INSERT INTO student (`id`, `deleted`, `student_no`, `name`, `gender`, `college`, `major`, `class_name`, `grade`, `dorm_building`, `dorm_room`, `phone`, `id_card`, `native_place`, `political_status`, `counselor_id`, `status`) VALUES
(1, 0, '2026100101', '周以安', '男', '信息工程学院', '计算机科学与技术', '计科2602班', '2026级', '1号楼', '202', '13910000001', NULL, '江苏省南京市', '群众', 2, '在读'),
(2, 0, '2026100102', '许星澜', '女', '信息工程学院', '计算机科学与技术', '计科2601班', '2026级', '1号楼', '203', '13910000002', NULL, '江苏省南京市', '中共党员', 2, '在读'),
(3, 0, '2024100103', '沈知夏', '男', '信息工程学院', '计算机科学与技术', '计科2402班', '2024级', '1号楼', '204', '13910000003', NULL, '江苏省南京市', '共青团员', 2, '在读'),
(4, 0, '2022100104', '林予墨', '女', '信息工程学院', '计算机科学与技术', '计科2201班', '2022级', '1号楼', '205', '13910000004', NULL, '江苏省南京市', '群众', 2, '毕业'),
(5, 0, '2026100105', '苏明远', '男', '信息工程学院', '计算机科学与技术', '计科2602班', '2026级', '1号楼', '206', '13910000005', NULL, '江苏省南京市', '中共党员', 2, '在读'),
(6, 0, '2024100106', '顾书宁', '女', '信息工程学院', '计算机科学与技术', '计科2401班', '2024级', '1号楼', '201', '13910000006', NULL, '江苏省南京市', '共青团员', 2, '在读'),
(7, 0, '2026100107', '陆时雨', '男', '信息工程学院', '计算机科学与技术', '计科2602班', '2026级', '1号楼', '202', '13910000007', NULL, '江苏省南京市', '群众', 2, '在读'),
(8, 0, '2022100108', '宋亦舟', '女', '信息工程学院', '计算机科学与技术', '计科2201班', '2022级', '1号楼', '303', '13910000008', NULL, '江苏省南京市', '中共党员', 2, '毕业'),
(9, 0, '2024100209', '程语桐', '男', '经济管理学院', '工商管理', '工商2402班', '2024级', '2号楼', '304', '13910000009', NULL, '浙江省杭州市', '共青团员', 3, '在读'),
(10, 0, '2026100210', '方景初', '女', '经济管理学院', '工商管理', '工商2601班', '2026级', '2号楼', '305', '13910000010', NULL, '浙江省杭州市', '群众', 3, '在读'),
(11, 0, '2026100211', '季思源', '男', '经济管理学院', '工商管理', '工商2602班', '2026级', '2号楼', '306', '13910000011', NULL, '浙江省杭州市', '中共党员', 3, '在读'),
(12, 0, '2022100212', '唐清越', '女', '经济管理学院', '工商管理', '工商2201班', '2022级', '2号楼', '301', '13910000012', NULL, '浙江省杭州市', '共青团员', 3, '毕业'),
(13, 0, '2026100213', '温若溪', '男', '经济管理学院', '工商管理', '工商2602班', '2026级', '2号楼', '302', '13910000013', NULL, '浙江省杭州市', '群众', 3, '在读'),
(14, 0, '2026100214', '邵承泽', '女', '经济管理学院', '工商管理', '工商2601班', '2026级', '2号楼', '303', '13910000014', NULL, '浙江省杭州市', '中共党员', 3, '在读'),
(15, 0, '2024100215', '江晚晴', '男', '经济管理学院', '工商管理', '工商2402班', '2024级', '2号楼', '304', '13910000015', NULL, '浙江省杭州市', '共青团员', 3, '在读'),
(16, 0, '2022100216', '梁沐辰', '女', '经济管理学院', '工商管理', '工商2201班', '2022级', '2号楼', '405', '13910000016', NULL, '浙江省杭州市', '群众', 3, '毕业'),
(17, 0, '2026100317', '贺南乔', '男', '外国语学院', '英语', '英语2602班', '2026级', '3号楼', '406', '13910000017', NULL, '安徽省合肥市', '中共党员', 4, '在读'),
(18, 0, '2024100318', '叶星遥', '女', '外国语学院', '英语', '英语2401班', '2024级', '3号楼', '401', '13910000018', NULL, '安徽省合肥市', '共青团员', 4, '在读'),
(19, 0, '2026100319', '白砚秋', '男', '外国语学院', '英语', '英语2602班', '2026级', '3号楼', '402', '13910000019', NULL, '安徽省合肥市', '群众', 4, '在读'),
(20, 0, '2022100320', '孟云舒', '女', '外国语学院', '英语', '英语2201班', '2022级', '3号楼', '403', '13910000020', NULL, '安徽省合肥市', '中共党员', 4, '毕业'),
(21, 0, '2024100321', '夏知言', '男', '外国语学院', '英语', '英语2402班', '2024级', '3号楼', '404', '13910000021', NULL, '安徽省合肥市', '共青团员', 4, '在读'),
(22, 0, '2026100322', '余怀瑾', '女', '外国语学院', '英语', '英语2601班', '2026级', '3号楼', '405', '13910000022', NULL, '安徽省合肥市', '群众', 4, '在读'),
(23, 0, '2026100323', '钟映雪', '男', '外国语学院', '英语', '英语2602班', '2026级', '3号楼', '406', '13910000023', NULL, '安徽省合肥市', '中共党员', 4, '在读'),
(24, 0, '2022100324', '秦望舒', '女', '外国语学院', '英语', '英语2201班', '2022级', '3号楼', '501', '13910000024', NULL, '安徽省合肥市', '共青团员', 4, '毕业');


INSERT INTO student_record (`id`, `student_id`, `record_type`, `category`, `title`, `reward_level`, `reason`, `occur_date`, `operator`, `status`, `start_date`, `end_date`, `days`, `counselor_id`, `approve_time`, `amount`, `semester`, `family_income`, `difficulty_level`, `description`, `file_path`, `company`, `position`, `salary`, `city`, `school`, `major`, `remark`) VALUES
(1, 1, 'REWARD', '奖励', '学业进步奖', '校级', '演示评定记录，仅用于系统功能展示', DATE_ADD(CURDATE(), INTERVAL -30 DAY), '陈予宁', '生效', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2, 4, 'REWARD', '奖励', '优秀毕业生', '院级', '演示评定记录，仅用于系统功能展示', DATE_ADD(CURDATE(), INTERVAL -29 DAY), '陈予宁', '生效', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(3, 7, 'REWARD', '奖励', '社会实践先进个人', '校级', '演示评定记录，仅用于系统功能展示', DATE_ADD(CURDATE(), INTERVAL -28 DAY), '陈予宁', '生效', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(4, 10, 'REWARD', '处分', '宿舍违纪警告', '院级', '演示评定记录，仅用于系统功能展示', DATE_ADD(CURDATE(), INTERVAL -27 DAY), '周清禾', '生效', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5, 13, 'REWARD', '奖励', '志愿服务优秀个人', '校级', '演示评定记录，仅用于系统功能展示', DATE_ADD(CURDATE(), INTERVAL -26 DAY), '周清禾', '生效', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(6, 16, 'REWARD', '奖励', '创新项目优秀奖', '院级', '演示评定记录，仅用于系统功能展示', DATE_ADD(CURDATE(), INTERVAL -25 DAY), '周清禾', '生效', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(7, 19, 'REWARD', '处分', '课堂纪律警告', '校级', '演示评定记录，仅用于系统功能展示', DATE_ADD(CURDATE(), INTERVAL -24 DAY), '孙景行', '撤销', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(8, 22, 'REWARD', '奖励', '文体活动积极分子', '院级', '演示评定记录，仅用于系统功能展示', DATE_ADD(CURDATE(), INTERVAL -23 DAY), '孙景行', '生效', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(9, 1, 'LEAVE', '事假', NULL, NULL, '办理个人事务', NULL, NULL, '待审批', DATE_ADD(CURDATE(), INTERVAL -10 DAY), DATE_ADD(CURDATE(), INTERVAL -9 DAY), 2.0, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10, 4, 'LEAVE', '病假', NULL, NULL, '校医院建议休息', NULL, NULL, '已批准', DATE_ADD(CURDATE(), INTERVAL -9 DAY), DATE_ADD(CURDATE(), INTERVAL -8 DAY), 2.0, 2, TIMESTAMP(DATE_ADD(CURDATE(), INTERVAL -10 DAY), '09:00:00'), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11, 7, 'LEAVE', '公假', NULL, NULL, '参加校外比赛', NULL, NULL, '已销假', DATE_ADD(CURDATE(), INTERVAL -8 DAY), DATE_ADD(CURDATE(), INTERVAL -7 DAY), 2.0, 2, TIMESTAMP(DATE_ADD(CURDATE(), INTERVAL -9 DAY), '09:00:00'), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(12, 10, 'LEAVE', '其他', NULL, NULL, '参加家庭活动', NULL, NULL, '已驳回', DATE_ADD(CURDATE(), INTERVAL -7 DAY), DATE_ADD(CURDATE(), INTERVAL -6 DAY), 2.0, 3, TIMESTAMP(DATE_ADD(CURDATE(), INTERVAL -8 DAY), '09:00:00'), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(13, 13, 'LEAVE', '事假', NULL, NULL, '办理个人事务', NULL, NULL, '待审批', DATE_ADD(CURDATE(), INTERVAL -6 DAY), DATE_ADD(CURDATE(), INTERVAL -5 DAY), 2.0, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(14, 16, 'LEAVE', '病假', NULL, NULL, '校医院建议休息', NULL, NULL, '已批准', DATE_ADD(CURDATE(), INTERVAL -5 DAY), DATE_ADD(CURDATE(), INTERVAL -4 DAY), 2.0, 3, TIMESTAMP(DATE_ADD(CURDATE(), INTERVAL -6 DAY), '09:00:00'), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(15, 19, 'LEAVE', '公假', NULL, NULL, '参加校外比赛', NULL, NULL, '已销假', DATE_ADD(CURDATE(), INTERVAL -4 DAY), DATE_ADD(CURDATE(), INTERVAL -3 DAY), 2.0, 4, TIMESTAMP(DATE_ADD(CURDATE(), INTERVAL -5 DAY), '09:00:00'), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(16, 22, 'LEAVE', '其他', NULL, NULL, '参加家庭活动', NULL, NULL, '已驳回', DATE_ADD(CURDATE(), INTERVAL -3 DAY), DATE_ADD(CURDATE(), INTERVAL -2 DAY), 2.0, 4, TIMESTAMP(DATE_ADD(CURDATE(), INTERVAL -4 DAY), '09:00:00'), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(17, 1, 'AID', '助学金', NULL, NULL, '演示申请：支持学生完成学业', NULL, NULL, '待审核', NULL, NULL, NULL, 2, NULL, 3000, '2026-2027-1', '虚构演示家庭情况', '一般', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(18, 4, 'AID', '助学贷款', NULL, NULL, '演示申请：支持学生完成学业', NULL, NULL, '已通过', NULL, NULL, NULL, 2, NULL, 8000, '2026-2027-1', '虚构演示家庭情况', '困难', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(19, 7, 'AID', '困难补助', NULL, NULL, '演示申请：支持学生完成学业', NULL, NULL, '已发放', NULL, NULL, NULL, 2, NULL, 1500, '2026-2027-1', '虚构演示家庭情况', '特别困难', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(20, 10, 'AID', '勤工助学', NULL, NULL, '演示申请：支持学生完成学业', NULL, NULL, '已驳回', NULL, NULL, NULL, 3, NULL, NULL, '2026-2027-1', '虚构演示家庭情况', '一般', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(21, 13, 'AID', '助学金', NULL, NULL, '演示申请：支持学生完成学业', NULL, NULL, '待审核', NULL, NULL, NULL, 3, NULL, 8000, '2026-2027-1', '虚构演示家庭情况', '困难', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(22, 16, 'AID', '助学贷款', NULL, NULL, '演示申请：支持学生完成学业', NULL, NULL, '已通过', NULL, NULL, NULL, 3, NULL, 1500, '2026-2027-1', '虚构演示家庭情况', '特别困难', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(23, 19, 'AID', '困难补助', NULL, NULL, '演示申请：支持学生完成学业', NULL, NULL, '已发放', NULL, NULL, NULL, 4, NULL, 3000, '2026-2027-1', '虚构演示家庭情况', '一般', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(24, 22, 'AID', '勤工助学', NULL, NULL, '演示申请：支持学生完成学业', NULL, NULL, '已驳回', NULL, NULL, NULL, 4, NULL, NULL, '2026-2027-1', '虚构演示家庭情况', '困难', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(25, 1, 'ARCHIVE', '入学登记表', '周以安—演示归档资料', NULL, NULL, DATE_ADD(CURDATE(), INTERVAL -20 DAY), '陈予宁', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '演示档案条目，尚未上传附件；可在编辑页上传真实文件。', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(26, 4, 'ARCHIVE', '成绩单', '林予墨—演示归档资料', NULL, NULL, DATE_ADD(CURDATE(), INTERVAL -19 DAY), '陈予宁', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '演示档案条目，尚未上传附件；可在编辑页上传真实文件。', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(27, 7, 'ARCHIVE', '实习材料', '陆时雨—演示归档资料', NULL, NULL, DATE_ADD(CURDATE(), INTERVAL -18 DAY), '陈予宁', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '演示档案条目，尚未上传附件；可在编辑页上传真实文件。', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(28, 10, 'ARCHIVE', '毕业材料', '方景初—演示归档资料', NULL, NULL, DATE_ADD(CURDATE(), INTERVAL -17 DAY), '周清禾', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '演示档案条目，尚未上传附件；可在编辑页上传真实文件。', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(29, 13, 'ARCHIVE', '入学登记表', '温若溪—演示归档资料', NULL, NULL, DATE_ADD(CURDATE(), INTERVAL -16 DAY), '周清禾', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '演示档案条目，尚未上传附件；可在编辑页上传真实文件。', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(30, 16, 'ARCHIVE', '成绩单', '梁沐辰—演示归档资料', NULL, NULL, DATE_ADD(CURDATE(), INTERVAL -15 DAY), '周清禾', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '演示档案条目，尚未上传附件；可在编辑页上传真实文件。', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(31, 19, 'ARCHIVE', '实习材料', '白砚秋—演示归档资料', NULL, NULL, DATE_ADD(CURDATE(), INTERVAL -14 DAY), '孙景行', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '演示档案条目，尚未上传附件；可在编辑页上传真实文件。', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(32, 22, 'ARCHIVE', '毕业材料', '余怀瑾—演示归档资料', NULL, NULL, DATE_ADD(CURDATE(), INTERVAL -13 DAY), '孙景行', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '演示档案条目，尚未上传附件；可在编辑页上传真实文件。', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(33, 4, 'EMPLOYMENT', NULL, NULL, NULL, NULL, DATE_ADD(CURDATE(), INTERVAL -7 DAY), NULL, '已就业', NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '示例科技有限公司', '开发助理', 8500, '南京', NULL, NULL, '虚构演示跟踪记录'),
(34, 8, 'EMPLOYMENT', NULL, NULL, NULL, NULL, DATE_ADD(CURDATE(), INTERVAL -6 DAY), NULL, '升学', NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '示例研究生院', '专业硕士', '虚构演示跟踪记录'),
(35, 12, 'EMPLOYMENT', NULL, NULL, NULL, NULL, DATE_ADD(CURDATE(), INTERVAL -5 DAY), NULL, '考公', NULL, NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '示例事业单位', NULL, NULL, '合肥', NULL, NULL, '虚构演示跟踪记录'),
(36, 16, 'EMPLOYMENT', NULL, NULL, NULL, NULL, DATE_ADD(CURDATE(), INTERVAL -4 DAY), NULL, '创业', NULL, NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '示例创新工作室', NULL, NULL, '南京', NULL, NULL, '虚构演示跟踪记录'),
(37, 20, 'EMPLOYMENT', NULL, NULL, NULL, NULL, DATE_ADD(CURDATE(), INTERVAL -3 DAY), NULL, '未就业', NULL, NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '虚构演示跟踪记录'),
(38, 24, 'EMPLOYMENT', NULL, NULL, NULL, NULL, DATE_ADD(CURDATE(), INTERVAL -2 DAY), NULL, '已就业', NULL, NULL, NULL, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '示例科技有限公司', '开发助理', 11000, '合肥', NULL, NULL, '虚构演示跟踪记录'),
(39, 3, 'EMPLOYMENT', NULL, NULL, NULL, NULL, DATE_ADD(CURDATE(), INTERVAL -1 DAY), NULL, '升学', NULL, NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '示例研究生院', '专业硕士', '虚构演示跟踪记录'),
(40, 15, 'EMPLOYMENT', NULL, NULL, NULL, NULL, DATE_ADD(CURDATE(), INTERVAL 0 DAY), NULL, '未就业', NULL, NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '虚构演示跟踪记录');


INSERT INTO work_record (`id`, `record_type`, `title`, `category`, `content`, `counselor_id`, `priority`, `due_date`, `status`, `meeting_date`, `participants`, `location`, `summary`) VALUES
(1, 'TASK', '新生安全教育准备', '会议', '演示工作安排：按计划完成并记录结果。', 2, '高', DATE_ADD(CURDATE(), INTERVAL -2 DAY), '待办', NULL, NULL, NULL, NULL),
(2, 'TASK', '收集班级奖学金材料', '材料', '演示工作安排：按计划完成并记录结果。', 3, '中', DATE_ADD(CURDATE(), INTERVAL -1 DAY), '进行中', NULL, NULL, NULL, NULL),
(3, 'TASK', '宿舍卫生走访', '检查', '演示工作安排：按计划完成并记录结果。', 4, '低', DATE_ADD(CURDATE(), INTERVAL 0 DAY), '已完成', NULL, NULL, NULL, NULL),
(4, 'TASK', '毕业生去向核对', '谈话', '演示工作安排：按计划完成并记录结果。', 2, '高', DATE_ADD(CURDATE(), INTERVAL 1 DAY), '待办', NULL, NULL, NULL, NULL),
(5, 'TASK', '困难学生回访', '其他', '演示工作安排：按计划完成并记录结果。', 3, '中', DATE_ADD(CURDATE(), INTERVAL 2 DAY), '进行中', NULL, NULL, NULL, NULL),
(6, 'TASK', '整理本周谈话计划', '会议', '演示工作安排：按计划完成并记录结果。', 4, '低', DATE_ADD(CURDATE(), INTERVAL 3 DAY), '已完成', NULL, NULL, NULL, NULL),
(7, 'TASK', '班委工作例会准备', '材料', '演示工作安排：按计划完成并记录结果。', 2, '高', DATE_ADD(CURDATE(), INTERVAL 4 DAY), '待办', NULL, NULL, NULL, NULL),
(8, 'TASK', '请假台账核查', '检查', '演示工作安排：按计划完成并记录结果。', 3, '中', DATE_ADD(CURDATE(), INTERVAL 5 DAY), '进行中', NULL, NULL, NULL, NULL),
(9, 'TASK', '心理健康主题活动', '谈话', '演示工作安排：按计划完成并记录结果。', 4, '低', DATE_ADD(CURDATE(), INTERVAL 6 DAY), '已完成', NULL, NULL, NULL, NULL),
(10, 'TASK', '期中学情摸排', '其他', '演示工作安排：按计划完成并记录结果。', 2, '高', DATE_ADD(CURDATE(), INTERVAL 7 DAY), '待办', NULL, NULL, NULL, NULL),
(11, 'MINUTES', '新学期班委工作会议', '专题会议', '演示纪要：交流学生近况，明确下一步工作安排。', 2, NULL, NULL, NULL, DATE_ADD(CURDATE(), INTERVAL -5 DAY), '相关班级学生及辅导员', '教学楼201教室', '已完成沟通，后续按计划跟进。'),
(12, 'MINUTES', '学生学业辅导谈话', '学生谈话', '演示纪要：交流学生近况，明确下一步工作安排。', 3, NULL, NULL, NULL, DATE_ADD(CURDATE(), INTERVAL -4 DAY), '相关班级学生及辅导员', '教学楼202教室', '已完成沟通，后续按计划跟进。'),
(13, 'MINUTES', '宿舍安全检查小结', '走访宿舍', '演示纪要：交流学生近况，明确下一步工作安排。', 4, NULL, NULL, NULL, DATE_ADD(CURDATE(), INTERVAL -3 DAY), '相关班级学生及辅导员', '教学楼203教室', '已完成沟通，后续按计划跟进。'),
(14, 'MINUTES', '就业指导专题会议', '专题会议', '演示纪要：交流学生近况，明确下一步工作安排。', 2, NULL, NULL, NULL, DATE_ADD(CURDATE(), INTERVAL -2 DAY), '相关班级学生及辅导员', '教学楼204教室', '已完成沟通，后续按计划跟进。'),
(15, 'MINUTES', '资助政策宣讲记录', '主题班会', '演示纪要：交流学生近况，明确下一步工作安排。', 3, NULL, NULL, NULL, DATE_ADD(CURDATE(), INTERVAL -1 DAY), '相关班级学生及辅导员', '教学楼205教室', '已完成沟通，后续按计划跟进。'),
(16, 'MINUTES', '心理健康主题班会', '主题班会', '演示纪要：交流学生近况，明确下一步工作安排。', 4, NULL, NULL, NULL, DATE_ADD(CURDATE(), INTERVAL 0 DAY), '相关班级学生及辅导员', '教学楼206教室', '已完成沟通，后续按计划跟进。');


INSERT INTO visitor_log (`id`, `visitor_name`, `phone`, `id_card`, `visit_purpose`, `visit_object`, `visit_time`, `leave_time`, `status`, `counselor_id`) VALUES
(1, '演示访客01', NULL, NULL, '家校沟通', '陈予宁', TIMESTAMP(DATE_ADD(CURDATE(), INTERVAL -1 DAY), '09:00:00'), TIMESTAMP(DATE_ADD(CURDATE(), INTERVAL -1 DAY), '11:00:00'), '已离开', 2),
(2, '演示访客02', NULL, NULL, '校友交流', '周清禾', TIMESTAMP(DATE_ADD(CURDATE(), INTERVAL 0 DAY), '09:00:00'), NULL, '在访', 3),
(3, '演示访客03', NULL, NULL, '招聘对接', '孙景行', TIMESTAMP(DATE_ADD(CURDATE(), INTERVAL -3 DAY), '09:00:00'), TIMESTAMP(DATE_ADD(CURDATE(), INTERVAL -3 DAY), '11:00:00'), '已离开', 4),
(4, '演示访客04', NULL, NULL, '学生事务咨询', '陈予宁', TIMESTAMP(DATE_ADD(CURDATE(), INTERVAL -4 DAY), '09:00:00'), TIMESTAMP(DATE_ADD(CURDATE(), INTERVAL -4 DAY), '11:00:00'), '已离开', 2),
(5, '演示访客05', NULL, NULL, '家校沟通', '周清禾', TIMESTAMP(DATE_ADD(CURDATE(), INTERVAL -5 DAY), '09:00:00'), TIMESTAMP(DATE_ADD(CURDATE(), INTERVAL -5 DAY), '11:00:00'), '已离开', 3),
(6, '演示访客06', NULL, NULL, '校友交流', '孙景行', TIMESTAMP(DATE_ADD(CURDATE(), INTERVAL 0 DAY), '09:00:00'), NULL, '在访', 4),
(7, '演示访客07', NULL, NULL, '招聘对接', '陈予宁', TIMESTAMP(DATE_ADD(CURDATE(), INTERVAL -7 DAY), '09:00:00'), TIMESTAMP(DATE_ADD(CURDATE(), INTERVAL -7 DAY), '11:00:00'), '已离开', 2),
(8, '演示访客08', NULL, NULL, '学生事务咨询', '周清禾', TIMESTAMP(DATE_ADD(CURDATE(), INTERVAL -8 DAY), '09:00:00'), TIMESTAMP(DATE_ADD(CURDATE(), INTERVAL -8 DAY), '11:00:00'), '已离开', 3);


COMMIT;

-- 重置编号起点；MySQL 自动取不小于现有最大编号 + 1 的值。
ALTER TABLE sys_user AUTO_INCREMENT = 1;
ALTER TABLE student AUTO_INCREMENT = 1;
ALTER TABLE student_record AUTO_INCREMENT = 1;
ALTER TABLE work_record AUTO_INCREMENT = 1;
ALTER TABLE visitor_log AUTO_INCREMENT = 1;
ALTER TABLE operation_log AUTO_INCREMENT = 1;
