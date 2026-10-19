package com.counselor.audit;

import com.counselor.common.Constants;
import com.counselor.entity.SysUser;
import com.counselor.entity.OperationLog;
import jakarta.servlet.http.HttpSession;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

/** Records write outcomes without student data, passwords, or method arguments. */
@Aspect
@Component
@Order(Ordered.LOWEST_PRECEDENCE - 1)
public class OperationLogAspect {
    private static final Logger LOG = LoggerFactory.getLogger(OperationLogAspect.class);
    private final OperationLogStore store;

    public OperationLogAspect(OperationLogStore store) { this.store = store; }

    // Runs outside the transaction interceptor so commit failures are logged as failures.
    @Around("execution(public boolean com.counselor.service.impl.*.save(..)) || "
            + "execution(public boolean com.counselor.service.impl.*.update(..)) || "
            + "execution(public boolean com.counselor.service.impl.*.updatePassword(..)) || "
            + "execution(public boolean com.counselor.service.impl.*.changeStatus(..)) || "
            + "execution(public boolean com.counselor.service.impl.*.deleteById(..))")
    public Object record(ProceedingJoinPoint invocation) throws Throwable {
        SysUser user = currentUser();
        long start = System.nanoTime();
        OperationLog log = new OperationLog();
        log.setUserId(user == null ? null : user.getId());
        log.setUsername(user == null ? null : user.getUsername());
        log.setOperation(operationName(invocation));
        OperationDetails.Snapshot before = OperationDetails.before(invocation);
        Object result;
        try {
            result = invocation.proceed();
        } catch (Throwable failure) {
            log.setOutcome("ERROR");
            log.setErrorType(failure.getClass().getSimpleName());
            log.setDetails(OperationDetails.describe(invocation, before, false));
            persist(log, start);
            throw failure;
        }
        log.setOutcome(Boolean.TRUE.equals(result) ? "SUCCESS" : "REJECTED");
        log.setDetails(OperationDetails.describe(invocation, before, Boolean.TRUE.equals(result)));
        if (log.getDetails() != null) persist(log, start);
        return result;
    }

    private void persist(OperationLog log, long start) {
        log.setDurationMs((System.nanoTime() - start) / 1_000_000);
        try {
            store.append(log);
        } catch (RuntimeException failure) {
            // A failed audit insert must not turn a committed business operation into a failure.
            LOG.warn("操作日志保存失败，异常类型：{}", failure.getClass().getSimpleName());
        }
    }

    private String operationName(ProceedingJoinPoint invocation) {
        String module = switch (invocation.getTarget().getClass().getSimpleName()) {
            case "StudentServiceImpl" -> "学生基本信息";
            case "StudentArchiveServiceImpl" -> "学生档案";
            case "SysUserServiceImpl" -> "系统用户";
            case "LeaveRequestServiceImpl" -> "请假管理";
            case "FinancialAidServiceImpl" -> "困难资助";
            case "RewardPunishmentServiceImpl" -> "学生奖惩";
            case "EmploymentTrackServiceImpl" -> "就业跟踪";
            case "VisitorLogServiceImpl" -> "访客登记";
            case "WorkReminderServiceImpl" -> "工作提示";
            case "WorkflowMinutesServiceImpl" -> "工作流程纪要";
            default -> "业务操作";
        };
        String action = switch (invocation.getSignature().getName()) {
            case "save" -> "新增";
            case "update" -> "修改";
            case "deleteById" -> "删除";
            case "changeStatus" -> "变更状态";
            case "updatePassword" -> "修改密码";
            default -> invocation.getSignature().getName();
        };
        return module + " / " + action;
    }

    private SysUser currentUser() {
        if (RequestContextHolder.getRequestAttributes() instanceof ServletRequestAttributes attrs) {
            HttpSession session = attrs.getRequest().getSession(false);
            if (session != null && session.getAttribute(Constants.SESSION_USER) instanceof SysUser user) {
                return user;
            }
        }
        return null;
    }
}
