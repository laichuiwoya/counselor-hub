package com.counselor.controller;

import com.counselor.common.Result;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerMapping;
import org.springframework.web.servlet.ModelAndView;

/** Turns record constraints into useful messages without exposing SQL or student data. */
@ControllerAdvice
public class DataConstraintAdvice {
    @ExceptionHandler(DataIntegrityViolationException.class)
    public Object handle(DataIntegrityViolationException error, HttpServletRequest request) {
        String message = error instanceof DuplicateKeyException
                ? "账号或学号已存在，请检查后重试。"
                : "数据未保存：请检查必填项、日期、金额和状态；删除学生或用户前，请先处理其关联记录。";
        if (request.getRequestURI().endsWith("/user/delete")) {
            message = "该账号仍有关联学生或业务记录，请先移交相关记录，或将账号设为停用。";
        }
        Object handler = request.getAttribute(HandlerMapping.BEST_MATCHING_HANDLER_ATTRIBUTE);
        if (handler instanceof HandlerMethod method && method.hasMethodAnnotation(ResponseBody.class)) {
            return new org.springframework.http.ResponseEntity<>(Result.fail(message), org.springframework.http.HttpStatus.OK);
        }
        ModelAndView view = new ModelAndView("error/validation");
        view.addObject("message", message);
        view.setStatus(org.springframework.http.HttpStatus.BAD_REQUEST);
        return view;
    }
}
