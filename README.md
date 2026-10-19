# 辅导员管理系统

技术栈：Java 17、Spring Boot 3.5.7、Spring MVC、JSP/JSTL、MyBatis、PageHelper、MySQL。
保留 JSP 页面和原业务模块，数据库统一为六张表：用户、学生、学生记录、工作记录、访客和操作日志。

## 启动

1. 安装 JDK 17 或更新版本，将 `java` 加入 PATH。
2. 启动 MySQL，确认已有六表版本数据库。先备份，再依次执行 `sql/01_schema.sql`、`sql/02_demo_data.sql` 重建并导入演示数据（管理员 `admin`，密码 `123456`）。两个脚本会清除现有数据。
3. 在 `src/main/resources/jdbc.properties` 中配置数据库连接。
4. 在 Eclipse 中导入或刷新 Maven 项目，右键 `com.counselor.CounselorApplication`，选择 Run As → Java Application 启动。
5. 打开 <http://localhost:8080/>。

首次构建需要联网下载 Maven 和依赖，无需单独安装 Maven 或 Tomcat。
如果 8080 已被原来的 Tomcat 占用，请先在 IDE 中停止旧服务，或设置 `APP_PORT=8081`。
在 Eclipse 的 Console 视图中点击红色停止按钮即可停止应用。

也可以手动执行：

```powershell
.\mvnw.cmd clean package
java -jar target/counselor.war
```

## 配置

主要配置文件是 `src/main/resources/application.properties`。
默认读取原有 `jdbc.properties`，也支持以下环境变量覆盖：

| 变量 | 用途 | 默认值 |
| --- | --- | --- |
| `APP_PORT` | HTTP 端口 | `8080` |
| `DB_URL` | JDBC 连接地址 | `jdbc.properties` 中的地址 |
| `DB_USERNAME` | 数据库用户名 | `jdbc.properties` 中的用户名 |
| `DB_PASSWORD` | 数据库密码 | `jdbc.properties` 中的密码 |
| `UPLOAD_DIR` | 上传文件根目录 | 当前工作目录下的 `uploads` |

上传文件保存在外部目录 `uploads/archive/日期/`，通过登录后的 `/upload/**` 访问。
原来 Tomcat 部署目录中的 `upload/archive` 如有历史文件，请复制到新的 `uploads/archive` 下，数据库中的路径无需修改。

## 数据库脚本与演示数据

`sql/` 只保留三个文件：

| 文件 | 用途 |
| --- | --- |
| `01_schema.sql` | 重建六张业务表、索引和约束，清除原数据 |
| `02_demo_data.sql` | 清空并导入全新演示数据，操作日志为空 |
| `README.md` | 执行顺序、账号和数据说明 |

完整重置时先停止应用并备份数据库，再按 01、02 顺序执行。已有当前结构且只需重置内容时，可单独执行 02。SQL 内库名和默认连接均为 `counselor_db_v2`。不会修改其他项目数据库。

演示数据包含 4 个用户、24 名学生、40 条学生业务记录、16 条工作记录和 8 条访客记录。账号为 `admin`、`chenlaoshi`、`zhoulaoshi`、`sunlaoshi`，初始密码均为 `123456`。数据为虚构内容，档案附件路径为空，避免出现无效下载链接；可自行上传附件。脚本不插入操作日志，之后的业务操作仍正常记录。

五类学生业务统一存入 `student_record`，以 `REWARD / LEAVE / AID / ARCHIVE / EMPLOYMENT` 区分；工作提醒、纪要统一存入 `work_record`，以 `TASK / MINUTES` 区分。查询、更新、删除和统计均限定类型。

学生删除采用逻辑删除（`student.deleted=1`）：从学生列表、选择器和学生人数统计中移除，保留历史业务及学生姓名关联，学号仍保留。有关联记录的用户不能直接删除，可移交记录或停用账号。

程序和自动化测试使用的无重置结构文件为 `src/main/resources/db/schema.sql`，与 01 脚本结构保持一致。历史设计、回归报告位于 `docs/database/`。旧 SQL 与重置前数据库备份保存在 `.backups/fresh-data-时间/`。历史十二表迁移工具仍在 `tools/migrate-six-tables.py`，不属于当前初始化流程。

## 打包

使用可执行 WAR 是为了兼容 JSP。WAR 包包含内嵌 Tomcat，可直接通过 `java -jar` 运行，
也支持部署到兼容的外部 Tomcat 10.1；外部部署的访问前缀由容器的部署名称决定。

```powershell
.\mvnw.cmd clean package
```

数据库使用 Spring Boot 默认 HikariCP 连接池，日志使用 Boot 默认 Logback。
`target/` 是 Maven 构建产物，可通过 `mvnw.cmd clean` 清理，不应作为源码导入。

## 事务、操作日志与测试

- 已通过 `spring-boot-starter-aop` 启用业务写操作的日志切面，使用现有 `spring-aop`；通过 `spring-boot-starter-test` 引入 `spring-test`、JUnit 和 Mockito。
- 学生、用户、请假、资助、奖惩、就业、档案、来访、工作提醒、工作纪要的新增、修改、删除和状态变更使用 `spring-tx` 事务。抛出异常时回滚数据库写入，返回 `false` 本身不会触发回滚。档案上传文件不属于数据库事务，数据库回滚不会自动删除已保存的文件。
- 操作日志存入数据库 `operation_log` 表，不再生成 `operations.log` 文件。管理员登录后点击“系统管理 → 操作日志”，可按账号、操作内容和结果筛选，每页显示 20 条记录，按最新记录排序。辅导员无权查看。旧日志文件不会自动导入或删除。
- 日志包含时间、用户 ID、账号、中文操作名称、成功/未生效/异常结果与耗时。详情记录对象编号、标题/姓名/学号等标识及允许记录的业务字段变化；新增保留生成编号，删除保留删除前摘要，修改和状态变更显示“原值 → 新值”。不记录密码、证件号码、联系方式、正文、请假原因或原始请求参数。修改、状态变更和密码修改在前后数据一致时不新增日志；正文等未展示字段确有变化时，仅记录已更新提示，不保存内容。历史简略日志无法补回原先未保存的信息。
- 操作详情直接保存在 `operation_log.details`，账号、姓名、标题、记录编号及变化摘要均支持关键词搜索。失败操作的日志使用独立事务保存；日志保存失败不会改变已经提交的业务结果，控制台会显示保存失败提示。
- 启动时通过 `src/main/resources/db/operation-log.sql` 仅补建日志主表，不再创建日志明细表，也不会自动迁移旧业务库。不再对数据库日志自动执行原文件日志的 30 天清理策略。
- 执行 `.\mvnw.cmd test` 运行测试。事务测试使用独立 H2 内存数据库和模拟 Mapper；六表集成测试使用完整六表结构与真实 MyBatis Mapper，验证七类业务的字段映射、增删改查、类型隔离、统计及约束。测试不连接业务 MySQL。H2 仅在测试时使用，不随 WAR 部署。

本机服务启动后，可设置 `SMOKE_USERNAME`、`SMOKE_PASSWORD` 环境变量并运行 `python -S tools/smoke-six-tables.py` 检查真实页面。加 `--write-check` 可验证临时记录的增改删、审批及文件上传下载，自动清理临时业务记录和上传文件，保留其审计日志。`--counselor-id` 默认为 1，应指定实际存在的经办用户。

完整回归建议在独立测试库、独立端口和上传目录运行。写入检查还覆盖学生、用户的新增编辑，以及先删除有五类关联记录的学生、再核对历史保留和选择器隐藏；逻辑删除的测试学生仍保存在测试库中。若 IDE 自动构建会改动 `target/classes`，可用 `.\mvnw.cmd -B '-Dcounselor.build.directory=.build-check' package` 在隔离目录构建测试，避免与 IDE 输出互相覆盖。
