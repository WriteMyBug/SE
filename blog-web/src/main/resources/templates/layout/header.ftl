<nav id="topmenu" class="navbar navbar-default navbar-fixed-top">
    <div class="menu-box">
        <div class="pull-left">
            <ul class="list-unstyled list-inline">
                <li><span id="currentTime"></span></li>
            </ul>
            <div class="clear"></div>
        </div>
        <div class="menu-topmenu-container pull-right">
            <ul class="list-unstyled list-inline pull-left">
                <li><a href="${config.siteUrl}/about" class="menu_a" title="关于博客" data-toggle="tooltip" data-placement="bottom">关于本站</a></li>
                <li><a href="${config.siteUrl}/links" class="menu_a" title="友情链接" data-toggle="tooltip" data-placement="bottom">友情链接</a></li>
                <li><a href="${config.siteUrl}/guestbook" class="menu_a" title="友情链接" data-toggle="tooltip" data-placement="bottom">留言板</a></li>
            </ul>
        </div>
    </div>
</nav>

<style>
    /* 用户头像下拉菜单样式 */
    .user-avatar-dropdown {
        position: relative;
    }
    
    .user-avatar-img {
        width: 32px;
        height: 32px;
        border-radius: 50%;
        border: 2px solid #fff;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        transition: all 0.3s ease;
    }
    
    .user-avatar-img:hover {
        transform: scale(1.1);
        box-shadow: 0 4px 8px rgba(0,0,0,0.2);
    }
    
    .avatar-toggle {
        padding: 8px 12px !important;
        display: flex;
        align-items: center;
        gap: 8px;
    }
    
    .avatar-dropdown-menu {
        position: absolute;
        top: 100%;
        right: 0;
        min-width: 150px;
        background: #fff;
        border: 1px solid #ddd;
        border-radius: 4px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        margin-top: 5px;
        padding: 5px 0;
        z-index: 1000;
    }
    
    .avatar-dropdown-menu li {
        list-style: none;
    }
    
    .avatar-dropdown-menu li a {
        display: block;
        padding: 8px 15px;
        color: #333;
        text-decoration: none;
        transition: background-color 0.2s;
    }
    
    .avatar-dropdown-menu li a:hover {
        background-color: #f5f5f5;
        color: #337ab7;
    }
    
    .avatar-dropdown-menu li a i {
        margin-right: 8px;
        width: 16px;
        text-align: center;
    }
    
    .avatar-dropdown-menu::before {
        content: '';
        position: absolute;
        top: -6px;
        right: 15px;
        width: 0;
        height: 0;
        border-left: 6px solid transparent;
        border-right: 6px solid transparent;
        border-bottom: 6px solid #fff;
    }
    
    .avatar-dropdown-menu::after {
        content: '';
        position: absolute;
        top: -7px;
        right: 14px;
        width: 0;
        height: 0;
        border-left: 7px solid transparent;
        border-right: 7px solid transparent;
        border-bottom: 7px solid #ddd;
        z-index: -1;
    }
</style>
<script>
    // 退出登录
    function logout() {
        $.post('/api/auth/logout', function(response) {
            if (response.status == 200) {
                window.location.reload();
            } else {
                alert('退出失败：' + response.message);
            }
        });
    }
    
    // 头像下拉菜单功能
    $(document).ready(function() {
        // 头像下拉菜单交互
        $('.avatar-toggle').on('click', function(e) {
            e.preventDefault();
            var dropdown = $(this).closest('.user-avatar-dropdown');
            var menu = dropdown.find('.avatar-dropdown-menu');
            
            // 切换显示状态
            menu.toggle();
            
            // 阻止事件冒泡
            e.stopPropagation();
        });
        
        // 点击页面其他地方关闭下拉菜单
        $(document).on('click', function(e) {
            if (!$(e.target).closest('.user-avatar-dropdown').length) {
                $('.avatar-dropdown-menu').hide();
            }
        });
        
        // 鼠标悬停效果增强
        $('.user-avatar-dropdown').on('mouseenter', function() {
            $(this).find('.user-avatar-img').css('transform', 'scale(1.1)');
        }).on('mouseleave', function() {
            $(this).find('.user-avatar-img').css('transform', 'scale(1)');
        });
    });
</script>
<div class="modal" id="oauth" tabindex="-1" role="dialog" aria-labelledby="oauthTitle">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <ul class="list-inline">
                    <li><h4 class="modal-title" id="oauthTitle">登录</h4></li>
                    <li><a href="javascript:$.alert.info('没用，别点了！我就没打算开发这个功能。Just to show you~~~');"><h4 class="modal-title" id="myModalLabel">注册</h4></a></li>
                </ul>
            </div>
            <div class="modal-body">
                <div class="oauth">
                    <ul class="list-unstyled list-inline oauth-list" style="text-align: center;">
                        <@zhydTag method="listAvailableOAuthPlatforms">
                            <#if listAvailableOAuthPlatforms?? && listAvailableOAuthPlatforms?size gt 0>
                                <#list listAvailableOAuthPlatforms as item>
                                    <li>
                                        <a href="${config.siteUrl}/oauth/social/${item.platform}" target="">
                                            <img src="${item.logo}" alt="" class="img-circle">
                                        </a>
                                    </li>
                                </#list>
                            <#else>
                                <li>
                                    稍等一下， 博主正在快马加鞭的配置~~
                                </li>
                            </#if>
                        </@zhydTag>
                    </ul>
                    <div class="oauth-line">
                        <span style="font-size: 12px">
                            Powered by <a href="https://gitee.com/fujieid/jap" target="_blank">JustAuthPlus(JAP)</a>
                        </span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<nav id="mainmenu" class="navbar navbar-default navbar-fixed-top" role="navigation">
    <div class="menu-box">
        <div class="navbar-header">
            <span class="pull-right nav-search toggle-search" data-toggle="modal" data-target=".nav-search-box"><i class="fa fa-search"></i></span>
            <button class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">
                <img alt="Brand" src="${config.siteFavicon}">${config.siteName}
            </a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <div class="pull-left site-desc">
                <h1 class="auto-shake"><a href="${config.siteUrl}" data-original-title="${config.siteDesc}" data-toggle="tooltip" data-placement="bottom">${config.siteName}</a></h1>
                <p class="site-description">${config.siteDesc}</p>
            </div>
            <ul class="nav navbar-nav ">
                <li>
                    <a href="/" class="menu_a"><i class="fa fa-home"></i>首页</a>
                </li>
                <@zhydTag method="types">
                    <#if types?? && types?size gt 0>
                        <#list types as item>
                            <#if item.nodes?? && item.nodes?size gt 0>
                                <li class="dropdown">
                                    <a href="/type/${item.id?c}" class="menu_a">
                                        <i class="${item.icon!}"></i>${item.name!} <span class="caret dropdown-toggle" data-toggle="dropdown" aria-expanded="false"></span>
                                    </a>
                                    <ul class="dropdown-menu" role="menu">
                                        <#list item.nodes as node>
                                        <li><a href="/type/${node.id?c}" title="点击查看《${node.name!}》的文章">${node.name!}</a></li>
                                        </#list>
                                    </ul>
                                </li>
                            <#else>
                                <li><a href="/type/${item.id?c}" class="menu_a"><i class="${item.icon!}"></i>${item.name!}</a></li>
                            </#if>
                        </#list>
                    </#if>
                </@zhydTag>
                
                <!-- 用户认证相关菜单 -->
                <#if user??>
                    <li class="dropdown user-avatar-dropdown">
                        <a href="#" class="dropdown-toggle avatar-toggle" data-toggle="dropdown" aria-expanded="false">
                            <img src="/img/user.png" alt="用户头像" class="user-avatar-img">
                            <span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu avatar-dropdown-menu" role="menu">
                            <li><a href="/profile"><i class="fa fa-user-circle"></i>个人信息</a></li>
                            <li><a href="javascript:void(0)" onclick="logout()"><i class="fa fa-sign-out"></i>退出登录</a></li>
                        </ul>
                    </li>
                <#else>
                    <li><a href="/login" class="menu_a"><i class="fa fa-sign-in"></i>登录</a></li>
                    <li><a href="/register" class="menu_a"><i class="fa fa-user-plus"></i>注册</a></li>
                </#if>
                
                <li><span class="pull-right nav-search main-search" data-toggle="modal" data-target=".nav-search-box"><i class="fa fa-search"></i></span></li>
            </ul>
        </div>
    </div>
</nav>
