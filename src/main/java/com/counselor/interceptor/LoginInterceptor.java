package com.counselor.interceptor;

import com.counselor.common.Constants;
import com.counselor.entity.SysUser;
import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * 登录拦截器：未登录跳转到登录页
 */
public class LoginInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        HttpSession session = request.getSession(false);
        SysUser user = session == null ? null : (SysUser) session.getAttribute(Constants.SESSION_USER);
        if (user == null) {
            String header = request.getHeader("X-Requested-With");
            if ("XMLHttpRequest".equals(header)) {
                response.setStatus(401);
                response.setContentType("application/json;charset=UTF-8");
                response.getWriter().write("{\"code\":401,\"msg\":\"登录已过期，请重新登录\"}");
                return false;
            }
            String ctx = request.getContextPath();
            response.sendRedirect(ctx + "/login");
            return false;
        }
        return true;
    }
}
