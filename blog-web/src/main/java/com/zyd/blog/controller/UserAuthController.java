package com.zyd.blog.controller;

import com.zyd.blog.business.annotation.BussinessLog;
import com.zyd.blog.business.consts.SessionConst;
import com.zyd.blog.business.dto.UserLoginDTO;
import com.zyd.blog.business.dto.UserRegisterDTO;
import com.zyd.blog.business.entity.User;
import com.zyd.blog.business.enums.PlatformEnum;
import com.zyd.blog.business.service.SysUserService;
import com.zyd.blog.framework.exception.ZhydException;
import com.zyd.blog.framework.object.ResponseVO;
import com.zyd.blog.util.ResultUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

/**
 * 用户认证控制器（前台）
 *
 * @author funnyhat
 * @date 2024/12/17
 */
@Slf4j
@RestController
@RequestMapping("/api/auth")
public class UserAuthController {

    @Autowired
    private SysUserService userService;

    /**
     * 用户注册
     */
    @PostMapping("/register")
    @BussinessLog(value = "用户注册", platform = PlatformEnum.WEB)
    public ResponseVO register(@Validated @RequestBody UserRegisterDTO registerDTO, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return ResultUtil.error(bindingResult.getFieldError().getDefaultMessage());
        }

        try {
            User user = userService.register(registerDTO);
            return ResultUtil.success("注册成功", user);
        } catch (ZhydException e) {
            return ResultUtil.error(e.getMessage());
        } catch (Exception e) {
            log.error("用户注册失败", e);
            return ResultUtil.error("注册失败，请稍后重试");
        }
    }

    /**
     * 用户登录
     */
    @PostMapping("/login")
    @BussinessLog(value = "用户登录", platform = PlatformEnum.WEB)
    public ResponseVO login(@Validated @RequestBody UserLoginDTO loginDTO, BindingResult bindingResult, HttpSession session) {
        if (bindingResult.hasErrors()) {
            return ResultUtil.error(bindingResult.getFieldError().getDefaultMessage());
        }

        try {
            User user = userService.login(loginDTO);
            // 将用户信息存入session
            session.setAttribute(SessionConst.USER_SESSION_KEY, user);
            return ResultUtil.success("登录成功", user);
        } catch (ZhydException e) {
            return ResultUtil.error(e.getMessage());
        } catch (Exception e) {
            log.error("用户登录失败", e);
            return ResultUtil.error("登录失败，请稍后重试");
        }
    }

    /**
     * 获取当前登录用户信息
     */
    @GetMapping("/current")
    public ResponseVO getCurrentUser(HttpSession session) {
        User currentUser = (User) session.getAttribute(SessionConst.USER_SESSION_KEY);
        if (currentUser != null) {
            return ResultUtil.success("获取成功", currentUser);
        }
        return ResultUtil.error("用户未登录");
    }

    /**
     * 用户退出登录
     */
    @PostMapping("/logout")
    @BussinessLog(value = "用户退出登录", platform = PlatformEnum.WEB)
    public ResponseVO logout(HttpSession session) {
        try {
            session.removeAttribute(SessionConst.USER_SESSION_KEY);
            session.invalidate();
            return ResultUtil.success("退出成功");
        } catch (Exception e) {
            log.error("用户退出失败", e);
            return ResultUtil.error("退出失败");
        }
    }

    /**
     * 检查邮箱是否已存在
     */
    @GetMapping("/checkEmail")
    public ResponseVO checkEmail(@RequestParam String email) {
        User user = userService.getByEmail(email);
        if (user != null) {
            return ResultUtil.error("该邮箱已被注册");
        }
        return ResultUtil.success("该邮箱可用");
    }
}