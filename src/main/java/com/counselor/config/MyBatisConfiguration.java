package com.counselor.config;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Configuration;

@Configuration
@MapperScan("com.counselor.mapper")
public class MyBatisConfiguration {
}
