package com.zyd.blog.core;

import com.zyd.blog.core.intercepter.BraumIntercepter;
import com.zyd.blog.core.intercepter.UserSessionInterceptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * @author yadong.zhang (yadong.zhang0415(a)gmail.com)
 * @version 1.0
 * @website https://docs.zhyd.me
 * @date 2018/11/19 9:39
 * @since 1.8
 */
@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    @Autowired
    BraumIntercepter braumIntercepter;
    
    @Autowired
    UserSessionInterceptor userSessionInterceptor;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        // 用户会话拦截器，优先级高于Braum拦截器
        registry.addInterceptor(userSessionInterceptor)
                .excludePathPatterns("/assets/**", "/error/**", "favicon.ico", "/css/**", "/js/**", "/img/**", "/api/**")
                .addPathPatterns("/**");
        
        // Braum安全拦截器
        registry.addInterceptor(braumIntercepter)
                .excludePathPatterns("/assets/**", "/error/**", "favicon.ico", "/css/**", "/js/**", "/img/**")
                .addPathPatterns("/**");
    }
}
