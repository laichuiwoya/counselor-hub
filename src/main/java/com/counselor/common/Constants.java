package com.counselor.common;

import java.security.MessageDigest;

/**
 * 系统常量与工具
 */
public class Constants {

    /** 会话中保存的当前登录用户 key */
    public static final String SESSION_USER = "loginUser";

    /** 默认密码（MD5 后） */
    public static final String DEFAULT_PWD_MD5 = "e10adc3949ba59abbe56e057f20f883e";

    /**
     * MD5 加密（32位小写）
     */
    public static String md5(String source) {
        if (source == null) {
            return null;
        }
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] bytes = md.digest(source.getBytes("UTF-8"));
            StringBuilder sb = new StringBuilder();
            for (byte b : bytes) {
                String hex = Integer.toHexString(b & 0xff);
                if (hex.length() == 1) {
                    sb.append("0");
                }
                sb.append(hex);
            }
            return sb.toString();
        } catch (Exception e) {
            throw new RuntimeException("MD5 加密失败", e);
        }
    }
}
