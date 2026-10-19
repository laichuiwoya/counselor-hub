# 辅导员管理系统

技术栈：Java 17、Spring Boot 3.5.7、Spring MVC、JSP/JSTL、MyBatis、PageHelper、MySQL。
保留原有 JSP 页面、CSS、JavaScript 和数据库结构，没有使用 Vue。

## 启动

1. 安装 JDK 17 或更新版本，将 `java` 加入 PATH。
2. 启动 MySQL，确认已有 `counselor_db` 数据库及项目所需表。
3. 在 `src/main/resources/jdbc.properties` 中配置数据库连接。
4. 双击 `start.bat`，构建完成后会在当前窗口启动。
5. 打开 <http://localhost:8080/>。

首次构建需要联网下载 Maven 和依赖，无需单独安装 Maven 或 Tomcat。
如果 8080 已被原来的 Tomcat 占用，请先在 IDE 中停止旧服务，或设置 `APP_PORT=8081`。
启动窗口按 Ctrl+C 可以正常停止应用；`stop.bat` 仅停止通过本项目 `start.bat` 启动的 Java 进程。

也可以手动执行：

```powershell
.\mvnw.cmd clean package
java -jar target/counselor.war
```

在 Eclipse/IDEA 中重新导入或刷新 Maven 项目，然后运行
`com.counselor.CounselorApplication` 的 `main` 方法即可启动。

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

数据库 SQL 文件保留在 `sql/`。已有数据库无需重新导入；`counselor.sql` 包含删库语句，不能在已有数据的数据库上直接执行。

## 打包

使用可执行 WAR 是为了兼容 JSP。WAR 包包含内嵌 Tomcat，可直接通过 `java -jar` 运行，
也支持部署到兼容的外部 Tomcat 10.1；外部部署的访问前缀由容器的部署名称决定。

```powershell
.\mvnw.cmd clean package
```

数据库使用 Spring Boot 默认 HikariCP 连接池，日志使用 Boot 默认 Logback。
`target/` 是 Maven 构建产物，可通过 `mvnw.cmd clean` 清理，不应作为源码导入。
