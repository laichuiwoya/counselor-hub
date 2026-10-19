package com.counselor.audit;

import com.counselor.common.PageResult;
import com.counselor.entity.OperationLog;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import java.util.ArrayList;
import java.util.List;
import java.sql.PreparedStatement;

@Repository
public class OperationLogStore {
    private final JdbcTemplate jdbc;
    public OperationLogStore(JdbcTemplate jdbc) { this.jdbc = jdbc; }

    @Transactional(propagation = Propagation.REQUIRES_NEW)
    public void append(OperationLog log) {
        jdbc.update(connection -> {
            PreparedStatement statement = connection.prepareStatement(
                    "INSERT INTO operation_log (user_id, username, operation, outcome, error_type, duration_ms, details) VALUES (?, ?, ?, ?, ?, ?, ?)");
            statement.setObject(1, log.getUserId());
            statement.setString(2, log.getUsername());
            statement.setString(3, log.getOperation());
            statement.setString(4, log.getOutcome());
            statement.setString(5, log.getErrorType());
            statement.setObject(6, log.getDurationMs());
            statement.setString(7, log.getDetails());
            return statement;
        });
    }

    public PageResult<OperationLog> page(int pageNum, String keyword, String outcome) {
        StringBuilder where = new StringBuilder(" WHERE 1=1");
        List<Object> args = new ArrayList<>();
        if (keyword != null && !keyword.isBlank()) {
            where.append(" AND (username LIKE ? OR operation LIKE ? OR details LIKE ?)");
            String search = "%" + keyword.trim() + "%";
            args.add(search);
            args.add(search);
            args.add(search);
        }
        if (List.of("SUCCESS", "REJECTED", "ERROR").contains(outcome == null ? "" : outcome)) {
            where.append(" AND outcome = ?");
            args.add(outcome);
        }
        String from = " FROM operation_log l";
        long total = jdbc.queryForObject("SELECT COUNT(*)" + from + where, Long.class, args.toArray());
        int size = 20;
        int pages = (int) Math.min(Integer.MAX_VALUE, (total + size - 1) / size);
        int current = Math.max(1, Math.min(pageNum, Math.max(1, pages)));
        args.add(size);
        args.add((long) (current - 1) * size);
        List<OperationLog> list = jdbc.query("SELECT l.*" + from + where
                + " ORDER BY l.id DESC LIMIT ? OFFSET ?", ROW_MAPPER, args.toArray());
        return new PageResult<>(list, total, current, size);
    }

    private static final RowMapper<OperationLog> ROW_MAPPER = (rs, row) -> {
        OperationLog log = new OperationLog();
        log.setId(rs.getLong("id"));
        log.setUserId(rs.getObject("user_id", Long.class));
        log.setUsername(rs.getString("username"));
        log.setOperation(rs.getString("operation"));
        log.setDetails(rs.getString("details"));
        log.setOutcome(rs.getString("outcome"));
        log.setErrorType(rs.getString("error_type"));
        log.setDurationMs(rs.getLong("duration_ms"));
        log.setCreateTime(rs.getTimestamp("create_time"));
        return log;
    };
}
