<#include "include/macros.ftl">
<@compress single_line=false>
<@header title="用户注册 - ${config.siteName!}"
    keywords="用户注册,${config.siteName!}"
    description="用户注册页面"
    canonical="/register">
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
        .success-message {
            color: #5cb85c;
            font-size: 12px;
            margin-top: 5px;
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
                <h2 class="auth-title">用户注册</h2>
                
                <!-- 页面内提示区域 -->
                <div id="alertMessage" class="alert-message"></div>
                
                <form id="registerForm" autocomplete="off">
                    <div class="form-group">
                        <input type="email" class="form-control" id="email" name="email" placeholder="请输入邮箱地址" required autocomplete="off" readonly>
                        <div class="error-message" id="emailError"></div>
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control" id="nickname" name="nickname" placeholder="请输入昵称" required autocomplete="off" readonly>
                        <div class="error-message" id="nicknameError"></div>
                    </div>
                    <div class="form-group">
                        <input type="password" class="form-control" id="password" name="password" placeholder="请输入密码（6-20位）" required autocomplete="off" readonly>
                        <div class="error-message" id="passwordError"></div>
                    </div>
                    <div class="form-group">
                        <input type="password" class="form-control" id="confirmPassword" placeholder="请再次输入密码" required autocomplete="off" readonly>
                        <div class="error-message" id="confirmPasswordError"></div>
                    </div>
                    <button type="submit" class="btn btn-auth" id="registerBtn">注册</button>
                </form>
                <div class="auth-link">
                    <a href="/login">已有账号？立即登录</a>
                </div>
            </div>
        </div>
    </div>
</div>

<@footer>
    <script>
        $(document).ready(function() {
            // 强制禁用自动补全
            $('#email, #nickname, #password, #confirmPassword').attr('autocomplete', 'off');
            
            // 移除readonly属性，使输入框可编辑
            setTimeout(function() {
                $('#email, #nickname, #password, #confirmPassword').removeAttr('readonly');
            }, 200);
            
            // 清除可能的自动填充值
            setTimeout(function() {
                $('#email, #nickname, #password, #confirmPassword').val('');
            }, 100);
            // 邮箱实时验证
            $('#email').on('blur', function() {
                var email = $(this).val();
                if (!email) return;
                
                if (!validateEmail(email)) {
                    $('#emailError').text('邮箱格式不正确');
                    return;
                }
                
                $('#emailError').text('');
                
                // 检查邮箱是否已存在
                $.get('/api/auth/checkEmail?email=' + email, function(response) {
                    if (response.status === 200) {
                        $('#emailError').text('').addClass('success-message').text('该邮箱可用');
                    } else {
                        $('#emailError').text('该邮箱已被注册');
                    }
                });
            });
            
            // 密码确认验证
            $('#confirmPassword').on('blur', function() {
                var password = $('#password').val();
                var confirmPassword = $(this).val();
                
                if (password !== confirmPassword) {
                    $('#confirmPasswordError').text('两次输入的密码不一致');
                } else {
                    $('#confirmPasswordError').text('');
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
            $('#registerForm').on('submit', function(e) {
                e.preventDefault();
                
                // 清除错误信息和提示
                $('.error-message').text('');
                hideAlert();
                
                var formData = {
                    email: $('#email').val(),
                    nickname: $('#nickname').val(),
                    password: $('#password').val()
                };
                
                // 前端验证
                if (!validateForm(formData)) {
                    return;
                }
                
                $('#registerBtn').prop('disabled', true).text('注册中...');
                
                $.ajax({
                    url: '/api/auth/register',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(formData),
                    success: function(response) {
                        if (response.status === 200) {
                            showAlert('注册成功！即将跳转到登录页面...', 'success');
                            // 延迟1秒后跳转到登录页面，让用户看到成功提示
                            setTimeout(function() {
                                window.location.href = '/login';
                            }, 1000);
                        } else {
                            showAlert('注册失败：' + response.message, 'error');
                            $('#registerBtn').prop('disabled', false).text('注册');
                        }
                    },
                    error: function() {
                        showAlert('注册失败，请稍后重试', 'error');
                        $('#registerBtn').prop('disabled', false).text('注册');
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
                
                if (!data.nickname) {
                    $('#nicknameError').text('昵称不能为空');
                    isValid = false;
                } else if (data.nickname.length < 2 || data.nickname.length > 20) {
                    $('#nicknameError').text('昵称长度必须在2-20位之间');
                    isValid = false;
                }
                
                if (!data.password) {
                    $('#passwordError').text('密码不能为空');
                    isValid = false;
                } else if (data.password.length < 6 || data.password.length > 20) {
                    $('#passwordError').text('密码长度必须在6-20位之间');
                    isValid = false;
                }
                
                var confirmPassword = $('#confirmPassword').val();
                if (data.password !== confirmPassword) {
                    $('#confirmPasswordError').text('两次输入的密码不一致');
                    isValid = false;
                }
                
                return isValid;
            }
        });
    </script>
</@footer>
</@compress>