<#include "include/macros.ftl">
<@compress single_line=false>
<@header title="用户登录 - ${config.siteName!}"
    keywords="用户登录,${config.siteName!}"
    description="用户登录页面"
    canonical="/login">
    <style>
        .auth-container {
            max-width: 400px;
            margin: 50px auto;
            padding: 30px;
            background: #fff;
            border-radius: 5px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .auth-title {
            text-align: center;
            margin-bottom: 30px;
            color: #333;
            font-size: 24px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-control {
            height: 40px;
            border-radius: 3px;
        }
        .btn-auth {
            width: 100%;
            height: 40px;
            background: #337ab7;
            border: none;
            color: white;
            border-radius: 3px;
            font-size: 16px;
        }
        .btn-auth:hover {
            background: #286090;
        }
        .auth-link {
            text-align: center;
            margin-top: 20px;
        }
        .error-message {
            color: #d9534f;
            font-size: 12px;
            margin-top: 5px;
        }
        .remember-me {
            margin-bottom: 15px;
        }
        .alert-message {
            padding: 10px 15px;
            border-radius: 3px;
            margin-bottom: 20px;
            display: none;
        }
        .alert-success {
            background-color: #dff0d8;
            border: 1px solid #d6e9c6;
            color: #3c763d;
        }
        .alert-error {
            background-color: #f2dede;
            border: 1px solid #ebccd1;
            color: #a94442;
        }
    </style>
</@header>

<div class="container custome-container">
    <div class="row">
        <div class="col-sm-12">
            <div class="auth-container">
                <h2 class="auth-title">用户登录</h2>
                
                <!-- 页面内提示区域 -->
                <div id="alertMessage" class="alert-message"></div>
                
                <form id="loginForm" autocomplete="off">
                    <!-- 隐藏的干扰输入框，防止浏览器自动补全 -->
                    <input type="text" style="display:none" autocomplete="off">
                    <input type="password" style="display:none" autocomplete="off">
                    <div class="form-group">
                        <input type="email" class="form-control" id="email" name="email" placeholder="请输入邮箱地址" required autocomplete="off" readonly>
                        <div class="error-message" id="emailError"></div>
                    </div>
                    <div class="form-group">
                        <input type="password" class="form-control" id="password" name="password" placeholder="请输入密码" required autocomplete="off" readonly>
                        <div class="error-message" id="passwordError"></div>
                    </div>
                    <div class="form-group remember-me">
                        <label>
                            <input type="checkbox" id="rememberMe" name="rememberMe"> 记住我
                        </label>
                    </div>
                    <button type="submit" class="btn btn-auth" id="loginBtn">登录</button>
                </form>
                <div class="auth-link">
                    <a href="/register">还没有账号？立即注册</a>
                </div>
            </div>
        </div>
    </div>
</div>

<@footer>
    <script>
        $(document).ready(function() {
            // 强制禁用自动补全
            $('#email, #password').attr('autocomplete', 'off');
            
            // 移除readonly属性，使输入框可编辑
            setTimeout(function() {
                $('#email, #password').removeAttr('readonly');
            }, 200);
            
            // 清除可能的自动填充值
            setTimeout(function() {
                $('#email, #password').val('');
            }, 100);
            
            // 邮箱验证
            $('#email').on('blur', function() {
                var email = $(this).val();
                if (!email) return;
                
                if (!validateEmail(email)) {
                    $('#emailError').text('邮箱格式不正确');
                } else {
                    $('#emailError').text('');
                }
            });
            
            // 显示提示信息
            function showAlert(message, type) {
                var alertDiv = $('#alertMessage');
                alertDiv.removeClass('alert-success alert-error').addClass('alert-' + type);
                alertDiv.text(message).show();
                
                // 3秒后自动隐藏成功提示
                if (type === 'success') {
                    setTimeout(function() {
                        alertDiv.fadeOut();
                    }, 3000);
                }
            }
            
            // 隐藏提示信息
            function hideAlert() {
                $('#alertMessage').hide();
            }
            
            // 表单提交
            $('#loginForm').on('submit', function(e) {
                e.preventDefault();
                
                // 清除错误信息和提示
                $('.error-message').text('');
                hideAlert();
                
                var formData = {
                    email: $('#email').val(),
                    password: $('#password').val()
                };
                
                // 前端验证
                if (!validateForm(formData)) {
                    return;
                }
                
                $('#loginBtn').prop('disabled', true).text('登录中...');
                
                $.ajax({
                    url: '/api/auth/login',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(formData),
                    success: function(response) {
                        if (response.status === 200) {
                            showAlert('登录成功！正在跳转...', 'success');
                            // 延迟1秒后跳转到博客主页，让用户看到成功提示
                            setTimeout(function() {
                                window.location.href = '/';
                            }, 1000);
                        } else {
                            showAlert('登录失败：' + response.message, 'error');
                            $('#loginBtn').prop('disabled', false).text('登录');
                        }
                    },
                    error: function() {
                        showAlert('登录失败，请稍后重试', 'error');
                        $('#loginBtn').prop('disabled', false).text('登录');
                    }
                });
            });
            
            function validateEmail(email) {
                var re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                return re.test(email);
            }
            
            function validateForm(data) {
                var isValid = true;
                
                if (!data.email) {
                    $('#emailError').text('邮箱不能为空');
                    isValid = false;
                } else if (!validateEmail(data.email)) {
                    $('#emailError').text('邮箱格式不正确');
                    isValid = false;
                }
                
                if (!data.password) {
                    $('#passwordError').text('密码不能为空');
                    isValid = false;
                }
                
                return isValid;
            }
        });
    </script>
</@footer>
</@compress>