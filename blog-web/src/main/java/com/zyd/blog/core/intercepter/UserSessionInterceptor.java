package com.zyd.blog.core.intercepter;

import com.zyd.blog.business.entity.User;
import com.zyd.blog.util.SessionUtil;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 用户会话拦截器，将当前登录用户信息添加到所有页面模型中
 *
 * @author funnyhat
 * @date 2024/12/17
 */
@Component
public class UserSessionInterceptor implements HandlerInterceptor {

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        if (modelAndView != null) {
            // 获取当前登录用户
            User currentUser = SessionUtil.getUser();
            if (currentUser != null) {
                // 将用户信息添加到模型中，这样所有页面都可以访问
                modelAndView.addObject("user", currentUser);
            }
        }
    }
}