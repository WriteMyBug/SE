<#include "include/macros.ftl">
<@compress single_line=false>
<@header title="个人中心 - ${config.siteName!}"
    keywords="个人中心,${config.siteName!}"
    description="个人中心页面"
    canonical="/profile">
    <style>
        .profile-container {
            max-width: 600px;
            margin: 50px auto;
            padding: 30px;
            background: #fff;
            border-radius: 5px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .profile-title {
            text-align: center;
            margin-bottom: 30px;
            color: #333;
            font-size: 24px;
            border-bottom: 1px solid #eee;
            padding-bottom: 15px;
        }
        .profile-info {
            margin-bottom: 20px;
        }
        .info-label {
            font-weight: bold;
            color: #666;
            margin-bottom: 5px;
        }
        .info-value {
            color: #333;
            font-size: 16px;
            padding: 8px 0;
            border-bottom: 1px solid #f5f5f5;
        }
        .back-home {
            text-align: center;
            margin-top: 30px;
        }
        .btn-back {
            background: #337ab7;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 3px;
            text-decoration: none;
        }
        .btn-back:hover {
            background: #286090;
            color: white;
            text-decoration: none;
        }
    </style>
</@header>

<div class="container custome-container">
    <div class="row">
        <div class="col-sm-12">
            <div class="profile-container">
                <h2 class="profile-title">个人中心</h2>
                
                <div class="profile-info">
                    <div class="info-label">邮箱地址</div>
                    <div class="info-value">${user.email!}</div>
                </div>
                
                <div class="profile-info">
                    <div class="info-label">昵称</div>
                    <div class="info-value">${user.nickname!}</div>
                </div>
                
                <div class="profile-info">
                    <div class="info-label">用户类型</div>
                    <div class="info-value">
                        <#if user.userType??>
                            <#if user.userType == "USER">普通用户<#else>${user.userType!}</#if>
                        <#else>
                            普通用户
                        </#if>
                    </div>
                </div>
                
                <div class="profile-info">
                    <div class="info-label">注册时间</div>
                    <div class="info-value">
                        <#if user.createTime??>
                            ${user.createTime?string("yyyy-MM-dd HH:mm:ss")}
                        <#else>
                            未知
                        </#if>
                    </div>
                </div>
                
                <div class="profile-info">
                    <div class="info-label">最后登录时间</div>
                    <div class="info-value">
                        <#if user.lastLoginTime??>
                            ${user.lastLoginTime?string("yyyy-MM-dd HH:mm:ss")}
                        <#else>
                            从未登录
                        </#if>
                    </div>
                </div>
                
                <div class="back-home">
                    <a href="/" class="btn btn-back">返回首页</a>
                </div>
            </div>
        </div>
    </div>
</div>

<@footer>
    <script>
        $(document).ready(function() {
            // 页面加载完成后的初始化操作
            console.log('个人中心页面加载完成');
        });
    </script>
</@footer>
</@compress>