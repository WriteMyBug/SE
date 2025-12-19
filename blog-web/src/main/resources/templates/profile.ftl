<#include "include/macros.ftl">
<@compress single_line=false>
<@header title="个人中心 - ${config.siteName!}"
    keywords="个人中心,${config.siteName!}"
    description="个人中心页面"
    canonical="/profile">
    <style>
        .profile-container {
            max-width: 1000px;
            margin: 50px auto;
            background: #fff;
            border-radius: 5px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            display: flex;
        }
        .profile-title {
            text-align: center;
            margin-bottom: 30px;
            color: #333;
            font-size: 24px;
            border-bottom: 1px solid #eee;
            padding-bottom: 15px;
        }
        .left-panel {
            width: 300px;
            padding: 30px;
            border-right: 1px solid #eee;
            background: #fafafa;
        }
        .right-panel {
            flex: 1;
            padding: 30px;
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
        .action-buttons {
            margin-top: 30px;
        }
        .action-btn {
            display: block;
            width: 100%;
            padding: 12px;
            margin-bottom: 10px;
            background: #337ab7;
            color: white;
            border: none;
            border-radius: 3px;
            text-align: center;
            text-decoration: none;
            font-size: 16px;
            cursor: pointer;
        }
        .action-btn:hover {
            background: #286090;
            color: white;
            text-decoration: none;
        }
        .action-btn.active {
            background: #23527c;
        }
        .content-panel {
            display: none;
        }
        .content-panel.active {
            display: block;
        }
        .article-item {
            padding: 15px 0;
            border-bottom: 1px solid #f5f5f5;
        }
        .article-item:last-child {
            border-bottom: none;
        }
        .article-title {
            color: #333;
            font-size: 18px;
            margin-bottom: 5px;
            text-decoration: none;
        }
        .article-title:hover {
            color: #337ab7;
            text-decoration: none;
        }
        .article-meta {
            color: #999;
            font-size: 14px;
        }
        .no-data {
            text-align: center;
            padding: 50px 0;
            color: #999;
        }
    </style>
</@header>

<div class="container custome-container">
    <div class="row">
        <div class="col-sm-12">
            <div class="profile-container">
                <!-- 左侧面板 -->
                <div class="left-panel">
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
                    
                    <div class="action-buttons">
                        <button class="action-btn active" data-panel="favorites">收藏夹</button>
                        <button class="action-btn" data-panel="history">浏览历史</button>
                        <a href="/" class="action-btn">返回首页</a>
                    </div>
                </div>
                
                <!-- 右侧面板 -->
                <div class="right-panel">
                    <!-- 收藏夹内容 -->
                    <div id="favorites-panel" class="content-panel active">
                        <h3>我的收藏</h3>
                        <div id="favorites-content">
                            <div class="no-data">加载中...</div>
                        </div>
                    </div>
                    
                    <!-- 浏览历史内容 -->
                    <div id="history-panel" class="content-panel">
                        <h3>浏览历史</h3>
                        <div id="history-content">
                            <div class="no-data">加载中...</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<@footer>
    <script>
        $(document).ready(function() {
            // 页面加载完成后默认加载收藏夹
            loadFavorites();
            
            // 按钮点击事件
            $('.action-btn').click(function() {
                if ($(this).attr('href')) return; // 如果是返回首页按钮，则不处理
                
                // 切换按钮状态
                $('.action-btn').removeClass('active');
                $(this).addClass('active');
                
                // 切换内容面板
                var panel = $(this).data('panel');
                $('.content-panel').removeClass('active');
                $('#' + panel + '-panel').addClass('active');
                
                // 根据面板类型加载内容
                if (panel === 'favorites') {
                    loadFavorites();
                } else if (panel === 'history') {
                    loadHistory();
                }
            });
        });
        
        // 加载收藏夹内容
        function loadFavorites() {
            $.ajax({
                url: '/profile/favorites',
                type: 'GET',
                dataType: 'json',
                success: function(response) {
                    if (response.success) {
                        renderArticles('favorites-content', response.data);
                    } else {
                        $('#favorites-content').html('<div class="no-data">' + response.message + '</div>');
                    }
                },
                error: function() {
                    $('#favorites-content').html('<div class="no-data">加载失败，请稍后重试</div>');
                }
            });
        }
        
        // 加载浏览历史内容
        function loadHistory() {
            $.ajax({
                url: '/profile/history',
                type: 'GET',
                dataType: 'json',
                success: function(response) {
                    if (response.success) {
                        renderArticles('history-content', response.data);
                    } else {
                        $('#history-content').html('<div class="no-data">' + response.message + '</div>');
                    }
                },
                error: function() {
                    $('#history-content').html('<div class="no-data">加载失败，请稍后重试</div>');
                }
            });
        }
        
        // 渲染文章列表
        function renderArticles(containerId, articles) {
            var container = $('#' + containerId);
            
            // 添加调试信息
            console.log('渲染文章列表 - containerId:', containerId);
            console.log('渲染文章列表 - articles:', articles);
            
            if (articles && articles.length > 0) {
                var html = '';
                $.each(articles, function(index, article) {
                    // 查看每个article对象的结构
                    console.log('文章对象:', article);
                    
                    html += '<div class="article-item">';
                    html += '    <a href="/article/' + article.id + '" class="article-title">' + article.title + '</a>';
                    html += '    <div class="article-meta">';
                    
                    // 再次确认containerId的值
                    console.log('当前containerId:', containerId);
                    console.log('是否为history-content:', containerId === 'history-content');
                    
                    if (containerId === 'history-content') {
                        // 浏览历史显示浏览时间
                        html += '        <span>浏览时间：' + (article.viewTime ? new Date(article.viewTime).toLocaleString() : '未知时间') + '</span>';
                    } else {
                        // 收藏夹显示发布时间
                        html += '        <span>发布时间：' + new Date(article.createTime).toLocaleString() + '</span>';
                    }
                    if (article.category) {
                        html += '        <span>分类：' + article.category + '</span>';
                    }
                    if (article.viewCount) {
                        html += '        <span>浏览：' + article.viewCount + '</span>';
                    }
                    html += '    </div>';
                    html += '</div>';
                });
                container.html(html);
            } else {
                container.html('<div class="no-data">暂无数据</div>');
            }
        }
    </script>
</@footer>
</@compress>