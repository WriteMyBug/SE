package com.zyd.blog.business.dto;

import lombok.Data;
import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;

/**
 * 用户注册DTO
 *
 * @author funnyhat
 * @date 2024/12/17
 */
@Data
public class UserRegisterDTO {
    
    @NotBlank(message = "邮箱不能为空")
    @Email(message = "邮箱格式不正确")
    private String email;
    
    @NotBlank(message = "密码不能为空")
    @Length(min = 6, max = 20, message = "密码长度必须在6-20位之间")
    private String password;
    
    @NotBlank(message = "昵称不能为空")
    @Length(min = 2, max = 20, message = "昵称长度必须在2-20位之间")
    private String nickname;
}