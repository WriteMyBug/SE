<#include "include/macros.ftl">
<@header title="${article.title} | ${config.siteName}" keywords="${article.keywords!},${config.siteName}" description="${article.description!}"
    canonical="/article/${article.id}" hasEditor=true>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/social-share.js@1.0.16/dist/css/share.min.css" />
    <style>
        /* 提示消息样式 - 仅适用于自定义提示 */
        #alertMessage {
            padding: 15px;
            border-radius: 4px;
            margin: 20px 0;
            display: none;
        }
        #alertMessage.alert-success {
            background-color: #dff0d8 !important;
            border: 1px solid #d6e9c6 !important;
            color: #3c763d !important;
        }
        #alertMessage.alert-error {
            background-color: #f2dede !important;
            border: 1px solid #ebccd1 !important;
            color: #a94442 !important;
        }
        
        /* Bootstrap alert 样式增强 */
        .alert-warning {
            background-color: #fcf8e3;
            border: 1px solid #faebcc;
            color: #8a6d3b;
            padding: 15px;
            border-radius: 4px;
            margin: 20px 0;
        }
        
        .alert-dismissible {
            padding-right: 35px;
            position: relative;
        }
        
        .alert-dismissible .close {
            position: absolute;
            top: 0;
            right: 0;
            padding: 15px;
            color: inherit;
            background: none;
            border: none;
            font-size: 18px;
            cursor: pointer;
            opacity: 0.5;
        }
        
        .alert-dismissible .close:hover {
            opacity: 0.8;
        }
        
        /* 响应式alert样式 */
        @media (max-width: 768px) {
            .alert-warning {
                padding: 12px;
                font-size: 14px;
            }
            
            .alert-dismissible {
                padding-right: 30px;
            }
            
            .alert-dismissible .close {
                padding: 12px;
                font-size: 16px;
            }
        }
        
        @media (max-width: 480px) {
            .alert-warning {
                padding: 10px;
                font-size: 13px;
                margin: 15px 0;
            }
            
            .alert-dismissible {
                padding-right: 25px;
            }
            
            .alert-dismissible .close {
                padding: 10px;
                font-size: 14px;
            }
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
        
        /* 横向按钮布局 */
        
        .button-group {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 15px;
            flex-wrap: wrap;
        }
        
        .button-group .like,
        .button-group .share-s {
            float: none;
            margin: 0;
        }
        
        .button-group .like a,
        .button-group .share-s a {
            margin: 0;
            width: 120px;
            text-align: center;
            padding: 8px 15px;
            border-radius: 4px;
            transition: all 0.2s ease-in;
            background: #fff;
            border: 1px solid rgba(0, 0, 0, 0.1);
            text-decoration: none;
            display: inline-block;
            color: #333;
        }
        
        .button-group .like a:hover,
        .button-group .share-s a:hover {
            background: rgba(0, 0, 0, 0.05);
            border-color: rgba(0, 0, 0, 0.2);
        }
        
        /* 收藏按钮样式 */
        .button-group .favorite a {
            background: #fff;
            border: 1px solid rgba(0, 0, 0, 0.1);
            width: 120px;
            text-align: center;
            padding: 8px 15px;
            border-radius: 4px;
            transition: all 0.2s ease-in;
            text-decoration: none;
            display: inline-block;
            color: #333;
        }
        
        .button-group .favorite a:hover {
            background: rgba(255, 193, 7, 0.08) !important;
            color: #ffc107 !important;
            border-color: rgba(255, 193, 7, 0.3) !important;
        }
        
        .button-group .favorite a:hover .fa-star {
            color: #ffc107 !important;
        }
        
        /* 响应式设计 */
        @media (max-width: 768px) {
            .button-group {
                gap: 10px;
            }
            
            .button-group .like a,
            .button-group .share-s a,
            .button-group .favorite a {
                width: 100px;
                padding: 6px 12px;
                font-size: 14px;
            }
            
            #share {
                margin-left: 60px;
            }
        }
        
        @media (max-width: 480px) {
            .button-group {
                gap: 8px;
            }
            
            .button-group .like a,
            .button-group .share-s a,
            .button-group .favorite a {
                width: 90px;
                padding: 5px 10px;
                font-size: 13px;
            }
            
            #share {
                margin-left: 50px;
            }
        }
        
        @media (max-width: 320px) {
            .button-group {
                gap: 6px;
            }
            
            .button-group .like a,
            .button-group .share-s a,
            .button-group .favorite a {
                width: 80px;
                padding: 4px 8px;
                font-size: 12px;
            }
            
            #share {
                margin-left: 40px;
            }
        }
        
        /* 分享下拉框位置调整 */
        .social-main {
            position: relative;
            width: auto;
            margin: 20px 0;
        }
        
        #share {
            position: absolute;
            top: auto;
            bottom: 50px;
            right: auto;
            left: 50%;
            transform: translateX(-50%);
            margin-left: 80px;
            z-index: 1000;
        }
        
        @media (max-width: 768px) {
            #share {
                margin-left: 60px;
            }
        }
        
        @media (max-width: 480px) {
            #share {
                margin-left: 50px;
            }
        }
    </style>
</@header>
<#if article.coverImage??>
    <img src="${article.coverImage!}" onerror="this.src='${config.staticWebSite}/img/default.png'" style="display: none;" id="cover-img">
</#if>
<div class="container custome-container">
    <nav class="breadcrumb">
        <a class="crumbs" title="返回首页" href="${config.siteUrl}" data-toggle="tooltip" data-placement="bottom"><i class="fa fa-home"></i>首页</a>
        <i class="fa fa-angle-right"></i>
        <a href="${config.siteUrl}/type/${article.typeId}" title="点击查看该分类文章" data-toggle="tooltip" data-placement="bottom">${article.type.name}</a>
        <i class="fa fa-angle-right"></i>正文
    </nav>
    <div class="row article-body">
        <div class="col-sm-8 blog-main">
            <#-- 广告位 -->
            <div class="ad-mark" id="ARTICLE_TOP" style="display: none"></div>
            <div class="blog-body overflow-initial fade-in">
                <div class="article-flag">
                    <#if article.original?string('true','false') == 'true'>
                        <span class="article-blockquote article-blockquote-green"></span>
                        <span class="article-original article-original-green">
                            <a href="${config.siteUrl}/article/${article.id}"><i class="fa fa-check"></i> 原创</a>
                        </span>
                    <#else>
                        <span class="article-blockquote article-blockquote-gray"></span>
                        <span class="article-original article-original-gray">
                            <a href="${config.siteUrl}/article/${article.id}"><i class="fa fa-reply"></i> 转载</a>
                        </span>
                    </#if>
                    <div class="blog-info-meta pull-right">
                        <ul class="list-unstyled list-inline">
                            <li><i class="fa fa-clock-o fa-fw"></i>${article.createTime?string('yyyy-MM-dd')}</li>
                            <li><i class="fa fa-eye fa-fw"></i><a class="pointer" data-original-title="${article.lookCount!(0)}人浏览了该文章" data-toggle="tooltip" data-placement="bottom">浏览 (<num>${article.lookCount!(0)}</num>)</a></li>
                            <li><a href="#comment-box" data-original-title="${article.commentCount!(0)}人评论了该文章" data-toggle="tooltip" data-placement="bottom"><i class="fa fa-comments-o fa-fw"></i>评论 (${article.commentCount!(0)})</a></li>
                        </ul>
                    </div>
                </div>
                <div class="blog-info overflow-initial">
                    <h1 class="blog-info-title">
                        <strong>${article.title}</strong>
                    </h1>
                    <div class="blog-info-body ${article.isMarkdown?string('markdown-body editor-preview-active-side', '')}">
                        <#-- 文章最后修改日期的判断 -->
                        <#assign intervalDayNum=((.now?long - article.updateTime?long)?abs / (1000 * 60 * 60 * 24))?int>
                        <#if intervalDayNum gt 1>
                            <div class="ob-alert">
                                <div class="title">
                                    <i class="fa fa-bullhorn fa-fw"></i>
                                    <span class="text">温馨提示：</span>
                                </div>
                                <div class="content">
                                    本文最后更新于 ${article.updateTime?string('yyyy年MM月dd日')}，已超过 ${intervalDayNum} 天没有更新。若文章内的图片失效（无法正常加载），请留言反馈或直接<a href="mailto:${config.authorEmail}" target="_blank" title="点击给我发邮件" rel="external nofollow"><i class="fa fa fa-envelope fa-fw"></i>联系我</a>。
                                </div>
                            </div>
                        </#if>
                        <#-- 加密文章处理：需要认证的文章 -->
                        <#if article.requiredAuth>
                            <#-- 如果用户未登录，显示登录提醒 -->
                            <#if !user??>
                                <div class="alert alert-warning alert-dismissible fade in" role="alert">
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                    <i class="fa fa-lock fa-fw"></i> 该文章已被加密，需要 <a href="/login" style="color: #8a6d3b; text-decoration: underline;">登录</a> 后才能查看文章详情
                                </div>
                            <#-- 如果用户已登录但仍无权限，显示权限不足提醒 -->
                            <#else>
                                <div class="alert alert-warning alert-dismissible fade in" role="alert">
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                    <i class="fa fa-lock fa-fw"></i> 您当前账号权限不足，无法查看该加密文章
                                </div>
                            </#if>
                        <#else >
                            <#if article.private>
                                ${article.description!}

                                <br>
                                <div class="alert alert-warning alert-dismissible fade in" role="alert">
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                    <i class="fa fa-lock fa-fw"></i> 文章已被加密，需要 <a href="javascript:void(0)" data-toggle="modal" data-target="#lockModal">输入密码</a> 才能查看文章详情
                                </div>
                            <#else >
                                ${article.content}
                            </#if>
                        </#if>
                    </div>
                    <div class="separateline"><span>正文到此结束</span></div>
                    <#-- 提示消息区域 -->
                    <div id="alertMessage" style="display: none; margin: 20px 0; padding: 15px; border-radius: 4px;"></div>
                    <div id="social" style="margin-bottom: 45px;">
                        <div class="social-main">
                            <div class="button-group">
                                <span class="like">
                                    <a href="javascript:;" data-id="${article.id?c}" title="点赞" ><i class="fa fa-thumbs-up"></i>赞 <i class="count"> ${article.loveCount!(0)}</i> </a>
                                </span>
                                <#-- 收藏按钮 - 仅对登录用户可见 -->
                                <#if user??>
                                <span class="favorite">
                                    <a href="javascript:;" data-id="${article.id?c}" title="收藏" onclick="toggleFavorite(${article.id?c}, event);"><i class="fa fa-star"></i>收藏</a>
                                </span>
                                </#if>
                                <span class="share-s">
                                    <a href="javascript:void(0)" id="share-s" title="分享"><i class="fa fa-share-alt"></i>分享</a>
                                </span>
                            </div>
                            <div id="share" style="display: none">
                                <div class="social-share" data-initialized="true">
                                    <a href="#" class="social-share-icon icon-twitter"></a>
                                    <a href="#" class="social-share-icon icon-google"></a>
                                    <a href="#" class="social-share-icon icon-facebook"></a>
                                    <a href="#" class="social-share-icon icon-douban"></a>
                                    <a href="#" class="social-share-icon icon-qzone"></a>
                                    <a href="#" class="social-share-icon icon-wechat"></a>
                                    <a href="#" class="social-share-icon icon-qq"></a>
                                    <a href="#" class="social-share-icon icon-weibo"></a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="article-footer overflow-initial">所属分类：<a href="${config.siteUrl}/type/${article.typeId}" data-original-title="点击查看${article.type.name}分类的文章" data-toggle="tooltip" data-placement="bottom">${article.type.name}</a></div>
                </div>
            </div>
            <div class="blog-body article-tag">
                <div class="cat">
                    <ul class="list-unstyled">
                        <li>
                            <strong>本文标签：</strong>
                                <#if article.tags?? && article.tags?size gt 0>
                                    <#list article.tags as item>
                                        <a href="${config.siteUrl}/tag/${item.id?c}" class="c-label" data-original-title="${item.name}" data-toggle="tooltip" data-placement="bottom" target="_blank">${item.name}</a>
                                    </#list>
                                <#else>
                                    <a href="javascript:;;" class="c-label" data-original-title="暂无相关标签" data-toggle="tooltip" data-placement="bottom" target="_blank">暂无相关标签</a>
                                </#if>
                        </li>
                        <li>
                            <strong>本文链接：</strong>
                            ${config.siteUrl}/article/${article.id?c}
                        </li>
                        <li>
                            <strong>版权声明：</strong>
                            <#if article.original?string('true','false') == 'true'>
                            本文由<a href="${config.siteUrl}" target="_blank" data-original-title="${config.siteName}" data-toggle="tooltip" data-placement="bottom"><strong>${config.authorName}</strong></a>原创发布，转载请遵循《<a href="https://creativecommons.org/licenses/by-nc-sa/4.0/deed.zh" target="_blank" rel="nofollow">署名-非商业性使用-相同方式共享 4.0 国际 (CC BY-NC-SA 4.0)</a>》许可协议授权
                            <#else>
                            本文为互联网转载文章，出处已在文章中说明(部分除外)。如果侵权，请<a target="_blank" href="mailto:${config.authorEmail}" title="点击给我发邮件" data-toggle="tooltip" data-placement="bottom"><strong>联系本站长</strong></a>删除，谢谢。
                            </#if>
                        </li>
                    </ul>
                </div>
            </div>
            <#-- 广告位 -->
            <div class="ad-mark" id="ARTICLE_BOTTOM" style="display: none"></div>
            <div class="blog-body prev-next">
                <nav class="nav-single wow" data-wow-delay="0.3s">
                    <#if other.prev>
                        <a href="${config.siteUrl}/article/${other.prev.id?c}" rel="prev">
                            <span class="meta-nav" data-original-title="${other.prev.title}" data-toggle="tooltip" data-placement="bottom"><span class="post-nav"><i class="fa fa-angle-left"></i> 上一篇</span>
                                <br>${other.prev.title}
                            </span>
                        </a>
                    <#else >
                        <a href="javascript:void(0)" rel="nofollow prev">
                            <span class="meta-nav" data-original-title="已经到第一篇了" data-toggle="tooltip" data-placement="bottom"><span class="post-nav"><i class="fa fa-angle-left"></i> 上一篇</span>
                                <br>已经到第一篇了
                            </span>
                        </a>
                    </#if>
                    <#if other.next>
                        <a href="${config.siteUrl}/article/${other.next.id?c}" rel="next">
                            <span class="meta-nav" data-original-title="${other.next.title}" data-toggle="tooltip" data-placement="bottom"><span class="post-nav">下一篇 <i class="fa fa-angle-right"></i></span>
                                <br>${other.next.title}
                            </span>
                        </a>
                    <#else >
                        <a href="${config.siteUrl}/article/1" rel="nofollow next">
                            <span class="meta-nav" data-original-title="已经到最后一篇了" data-toggle="tooltip" data-placement="bottom"><span class="post-nav">下一篇 <i class="fa fa-angle-right"></i></span>
                                <br>已经到最后一篇了
                            </span>
                        </a>
                    </#if>
                    <div class="clear"></div>
                </nav>
            </div>
            <#-- 热门推荐 -->
            <div class="blog-body clear overflow-initial">
                <h5 class="custom-title"><i class="fa fa-fire fa-fw icon"></i><strong>热门推荐</strong><small></small></h5>
                <ul class="list-unstyled">
                    <@articleTag method="hotList" pageSize="10">
                        <#if hotList?? && (hotList?size > 0)>
                            <#list hotList as item>
                            <li class="line-li">
                                <div class="line-container">
                                    <div class="line-left">
                                        <#if item.coverImage??>
                                            <img class="lazy-img" <#if config.lazyloadPath!>data-original<#else>src</#if>="${item.coverImage}" onerror="this.src='${config.staticWebSite}/img/default.png'"width="50" height="50" rel="external nofollow"/>
                                        <#else>
                                            <img class="lazy-img" <#if config.lazyloadPath!>data-original<#else>src</#if>="${config.staticWebSite}/img/favicon.ico" onerror="this.src='${config.staticWebSite}/img/default.png'"width="50" height="50" rel="external nofollow"/>
                                        </#if>
                                    </div>
                                    <div class="line-right">
                                        <div class="text">
                                            <a href="${config.siteUrl}/article/${item.id?c}" data-original-title="${item.lookCount?c}人浏览了该文章" data-toggle="tooltip" data-placement="bottom">
                                                ${item.title}
                                            </a>
                                        </div>
                                        <div class="text">
                                            <#--<div style="display: inline-block">热门指数：</div>-->
                                            <#--<div class="rating ignore" data-star="5"></div>-->
                                            <span class="views" title="" data-toggle="tooltip" data-placement="bottom" data-original-title="文章阅读次数"><i class="fa fa-eye fa-fw"></i>浏览(${item.lookCount!(0)})</span>
                                            <span class="comment" title="" data-toggle="tooltip" data-placement="bottom" data-original-title="文章评论次数">
                                                <a href="${config.siteUrl}/article/${item.id?c}#comment-box" rel="external nofollow">
                                                    <i class="fa fa-comments-o fa-fw"></i>评论(${item.commentCount!(0)})
                                                </a>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </li>
                            </#list>
                        </#if>
                    </@articleTag>
                </ul>
                <div class="clear"></div>
            </div>
            <#-- 相关文章 -->
            <div class="blog-body clear overflow-initial">
                <h5 class="custom-title"><i class="fa fa-google-wallet fa-fw icon"></i><strong>相关文章</strong><small></small></h5>
                <ul class="list-unstyled">
                    <#list relatedList as item>
                        <li class="line-li">
                            <div class="line-container">
                                <div class="line-right">
                                    <div class="text">
                                        <a href="${config.siteUrl}/article/${item.id?c}" data-original-title="${item.lookCount?c}人浏览了该文章" data-toggle="tooltip" data-placement="bottom">
                                            <i class="fa fa-book fa-fw"></i>${item.title}
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </li>
                    </#list>
                </ul>
                <div class="clear"></div>
            </div>
            <#-- 广告位 -->
            <div class="ad-mark" id="COMMENT_BOX_TOP" style="display: none"></div>
            <#if !article.requiredAuth>
                <#--评论-->
                <#if article.comment>
                    <div class="blog-body clear overflow-initial expansion">
                        <div id="comment-box" data-id="${article.id?c}"></div>
                    </div>
                </#if>
            </#if>
        </div>
        <#include "layout/sidebar.ftl"/>
    </div>
</div>
<div id="lockModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true" data-keyboard="false">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">输入密码查看文章详情</h4>
            </div>
            <div class="modal-body">
                <input type="text" name="password" id="password" class="form-control" placeholder="请输入文章密码">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="verifyPassword">确定</button>
            </div>
        </div>
    </div>
</div>
<@footer>
    <#if (config.enableHitokoto == 1 || config.enableHitokoto == "1")>
        <script src="https://v1.hitokoto.cn/?encode=js&c=i&select=.hitokoto" defer></script>
    </#if>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/highlight.js@9.12.0/lib/highlight.min.js"></script>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/simplemde@1.11.2/dist/simplemde.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/social-share.js@1.0.16/dist/js/social-share.min.js"></script>
<#--    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/social-share.js@1.0.16/dist/js/jquery.share.min.js"></script>-->
    <script src="https://res.wx.qq.com/open/js/jweixin-1.6.0.js" type="text/javascript"></script>

    <script>
        // 显示提示信息 - 简化版本，直接设置样式
        function showAlert(message, type) {
            var alertDiv = $('#alertMessage');
            
            // 确保元素存在
            if (!alertDiv.length) {
                console.error('Alert message div not found!');
                return;
            }
            
            // 直接设置基础样式
            var baseStyle = 'padding: 15px; border-radius: 4px; margin: 20px 0; display: block;';
            var successStyle = 'background-color: #dff0d8; border: 1px solid #d6e9c6; color: #3c763d;';
            var errorStyle = 'background-color: #f2dede; border: 1px solid #ebccd1; color: #a94442;';
            
            if (type === 'success') {
                alertDiv.attr('style', baseStyle + successStyle);
            } else {
                alertDiv.attr('style', baseStyle + errorStyle);
            }
            
            alertDiv.text(message);
            
            // 3秒后自动隐藏成功提示
            if (type === 'success') {
                setTimeout(function() {
                    alertDiv.fadeOut();
                }, 3000);
            }
        }
        
        // 收藏功能处理 - 简化版本，确保可靠性
        function toggleFavorite(articleId, event) {
            // 调试信息
            console.log('toggleFavorite called with articleId:', articleId);
            
            // 获取当前点击的按钮 - 使用事件源对象
            var currentBtn = event.target.closest('.favorite a');
            console.log('Current button:', currentBtn);
            
            // 如果找不到按钮，尝试通过data-id查找
            if (!currentBtn) {
                currentBtn = $('.favorite a[data-id="' + articleId + '"]');
                console.log('Button found by data-id:', currentBtn);
            }
            
            // 显示临时提示，确保函数执行
            showAlert('正在处理收藏...', 'success');
            
            $.ajax({
                type: "post",
                url: "/api/favorites/toggle/" + articleId,
                success: function (json) {
                    console.log('AJAX success, response:', json);
                    
                    // 兼容不同的响应格式
                    var success = json.code === 200 || json.status === 200;
                    var isFavorited = success ? json.data : false;
                    
                    console.log('Success:', success, 'isFavorited:', isFavorited);
                    
                    if (success) {
                        if (isFavorited) {
                            $(currentBtn).html('<i class="fa fa-star" style="color: #ffc107;"></i>已收藏');
                            showAlert('收藏成功', 'success');
                        } else {
                            $(currentBtn).html('<i class="fa fa-star"></i>收藏');
                            showAlert('取消收藏成功', 'success');
                        }
                    } else {
                        showAlert(json.message || json.msg || '操作失败', 'error');
                    }
                },
                error: function (xhr, status, error) {
                    console.error('AJAX error:', status, error);
                    console.error('Response:', xhr.responseText);
                    showAlert('网络错误，请重试', 'error');
                }
            });
        }
        
        // 初始化Bootstrap alert关闭功能
        $(document).ready(function() {
            // Bootstrap alert关闭功能
            $('.alert-dismissible .close').click(function() {
                $(this).parent().fadeOut();
            });
        });
        
        // 分享按钮点击事件
        $(document).ready(function() {
            // Bootstrap alert关闭功能
            $('.alert-dismissible .close').click(function() {
                $(this).parent().fadeOut();
            });
            
            // 测试alert组件功能
            console.log('Alert组件初始化完成');
            console.log('找到', $('.alert-warning').length, '个警告alert');
            console.log('找到', $('.alert-dismissible').length, '个可关闭alert');
            
            $('#share-s').click(function(e) {
                e.preventDefault();
                $('#share').toggle();
            });
            
            // 点击其他地方关闭分享菜单
            $(document).click(function(e) {
                if (!$(e.target).closest('#share-s').length && !$(e.target).closest('#share').length) {
                    $('#share').hide();
                }
            });
        });
        
        var isPrivate = '${article.private}';
        if(isPrivate || isPrivate == 'true') {
            $("#lockModal").modal('show')
        }

        $("#verifyPassword").click(function (){
            var password = $("#password").val();
            var articleId = "${article.id}";
            $.post("/api/verifyArticlePassword", {articleId : articleId, password: password}, function (json) {
                $.alert.ajaxSuccess(json);
                if(json.status === 200) {
                    $(".blog-info-body").html(json.data);
                    $("#lockModal").modal('hide')
                }
            })
        })


        $(function () {
            var url = location.href.split("#")[0];
            //当前页面的url
            var encodeUrl = encodeURIComponent(url);

            var title = "${article.title}";
            var desc = "${article.description}";
            var imgUrl = "${article.coverImage}";

            $.post("/api/jssdkGetSignature", {url: encodeUrl}, function (json) {
                // $.alert.ajaxSuccess(json);

                if (json.status === 200) {
                    var signature = json.data.signature;
                    var timestamp = json.data.timestamp;
                    var noncestr = json.data.noncestr;
                    var appid = json.data.appid;
                    var jsapi_ticket = json.data.ticket;

                    // alert(signature + "---" + timestamp + "---" + noncestr + "---" + appid + "---" + jsapi_ticket);
                    // console.log(signature + "---" + timestamp + "---" + noncestr + "---" + appid + "---" + jsapi_ticket)
                    wx.config({
                        debug: false, // true:开启调试模式,调用的所有 api 的返回值会在客户端 alert 出来，若要查看传入的参数，可以在 pc 端打开，参数信息会通过 log 打出，仅在 pc 端时才会打印。
                        appId: appid, // 必填，公众号的唯一标识
                        timestamp: timestamp, // 必填，生成签名的时间戳
                        nonceStr: noncestr, // 必填，生成签名的随机串
                        signature: signature,// 必填，签名
                        jsApiList: ["updateAppMessageShareData", "updateTimelineShareData"] // 必填，需要使用的 JS 接口列表
                    });

                    wx.error(function (res) {
                        // alert(JSON.stringify(res));
                        // config信息验证失败会执行 error 函数，如签名过期导致验证失败，具体错误信息可以打开 config 的debug模式查看，也可以在返回的 res 参数中查看，对于 SPA 可以在这里更新签名。
                        console.log(JSON.stringify(res))
                    });

                    var mTitle = title;
                    wx.ready(function () {
                        //需在用户可能点击分享按钮前就先调用 自定义“分享到朋友圈”及“分享到 QQ 空间”按钮的分享内容
                        wx.updateTimelineShareData({
                            title: mTitle, // 分享标题
                            link: url, // 分享链接，该链接域名或路径必须与当前页面对应的公众号 JS 安全域名一致
                            imgUrl: imgUrl, // 分享图标
                            success: function () {
                                // 设置成功
                            }
                        });

                    });

                    var nTitle = '您有新消息| ' + title;
                    wx.ready(function () {
                        //需在用户可能点击分享按钮前就先调用 自定义“分享给朋友”及“分享到QQ”按钮的分享内容
                        wx.updateAppMessageShareData({
                            title: nTitle, // 分享标题
                            desc: desc, // 分享描述
                            link: url, // 分享链接，该链接域名或路径必须与当前页面对应的公众号 JS 安全域名一致
                            imgUrl: imgUrl, // 分享图标
                            success: function () {
                                // 设置成功
                            }
                        });
                    });

                }
            })
        })
    </script>
</@footer>