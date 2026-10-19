CREATE TABLE IF NOT EXISTS operation_log (
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT,
    username VARCHAR(100),
    operation VARCHAR(200) NOT NULL,
    outcome VARCHAR(16) NOT NULL,
    error_type VARCHAR(100),
    duration_ms BIGINT NOT NULL,
    details TEXT,
    create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
