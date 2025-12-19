/**
 *
 * 评论插件(md版)
 *
 * @date 2018-01-05 10:57
 * @author zhyd(yadong.zhang0415#gmail.com)
 * @link https://docs.zhyd.me
 */
var _form = {
    valid: function(form){
        var valid = true;
        $(form).find("small").each(function(){
            if($(this).attr("data-bv-result") == "INVALID"){
                valid = false;
            }
        });
        return valid;
    }
};

$.extend({
    comment: {
        detailKey: 'comment-detail',
        sid: 0,
        _commentDetailModal: '',
        _detailForm: '',
        _detailFormBtn: '',
        _closeBtn: '',
        _commentPid: '',
        _commentPlace: '',
        _commentPost: '',
        _cancelReply: '',
        _commentReply: '',
        _simplemde: null,
        initDom: function () {
            $.comment._commentDetailModal = $('#comment-detail-modal');
            $.comment._detailForm = $('#detail-form');
            $.comment._detailFormBtn = $('#detail-form-btn');
            $.comment._closeBtn = $('#comment-detail-modal .close');
            $.comment._commentPid = $('#comment-pid');
            $.comment._commentPlace = $('#comment-place');
            $.comment._commentPost = $('#comment-post');
            $.comment._cancelReply = $('#cancel-reply');
            $.comment._commentReply = $('.comment-reply');
        },
        init: function (options) {
            var $box = $('#comment-box');
            if (!$box || !$box[0]) {
                return;
            }
            var op = $.extend({
            }, options);
            var commentBox = '<div id="comment-place">'
                    + '<div class="comment-post" id="comment-post" style="position: relative">'
                    + '<h5 class="custom-title"><i class="fa fa-commenting-o fa-fw icon"></i><strong>评论</strong><small></small></h5>'
                    + '<form class="form-horizontal" role="form" id="comment-form">'
                    + '<div class="cancel-reply" id="cancel-reply" style="display: none;"><a href="javascript:void(0);" onclick="$.comment.cancelReply(this)" rel="external nofollow"><i class="fa fa-share"></i>取消回复</a></div>'
                    + '<input type="hidden" name="pid" id="comment-pid" value="0" size="22" tabindex="1">'
                    + '<textarea id="comment_content" class="form-control col-md-7 col-xs-12 valid" style="display: none"></textarea>'
                    + '<textarea name="content" style="display: none"></textarea>'
                    + '<div style="position: absolute;right: 10px;bottom: 70px;font-size: 14px;color: #dbdada;z-index: 1;">' + op.wmName + '<br>' + op.wmUrl + '<br>' + op.wmDesc + '</div>'
                    + '<a id="comment-form-btn" type="button" data-loading-text="正在提交评论..." class="btn btn-default btn-block">提交评论</a>'
                    + '</form></div></div>';
            $box.html(commentBox);
            // 初始化并缓存常用的dom元素
            $.comment.initDom();
            // 延迟创建编辑框，确保DOM元素完全加载
            var self = this;
            setTimeout(function() {
                self._simplemde = $.comment.createEdit(op);
                $.comment.loadCommentList($box);
                $.comment.initValidatorPlugin();
                
                // 绑定提交评论按钮点击事件
                $('#comment-form-btn').on('click', function() {
                    console.log('提交按钮被点击');
                    $.comment.submit(this);
                });
                
                // 添加调试日志，确认按钮绑定成功
                console.log('评论提交按钮绑定完成:', $('#comment-form-btn')[0]);
            }, 100);
        },
        createEdit: function (options) {
            // 定义表情包列表
            var emojis = [
                "😀", "😃", "😄", "😁", "😆", "😅", "😂", "🤣",
                "😊", "😇", "🙂", "🙃", "😉", "😌", "😍", "🥰",
                "😘", "😗", "😙", "😚", "😋", "😛", "😝", "😜",
                "🤪", "🤨", "🧐", "🤓", "😎", "🤩", "🥳", "😏",
                "😒", "😞", "😔", "😟", "😕", "🙁", "☹️", "😣",
                "😖", "😫", "😩", "🥺", "😢", "😭", "😤", "😠",
                "😡", "🤬", "🤯", "😳", "🥵", "🥶", "😱", "😨",
                "😰", "😥", "😓", "🤗", "🤔", "🤭", "🤫", "🤥",
                "😶", "😐", "😑", "😬", "🙄", "😯", "😦", "😧",
                "😮", "😲", "🥱", "😴", "🤤", "😪", "😵", "🤐",
                "🥴", "🤢", "🤮", "🤧", "😷", "🤒", "🤕", "🤑"
            ];
            
            // 创建表情包选择器HTML
            var emojiPickerHTML = '<div id="emoji-picker" style="position: absolute; bottom: 100%; left: 0; background: white; border: 1px solid #ccc; border-radius: 4px; padding: 10px; z-index: 1000; display: none; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">' +
                '<div style="max-height: 150px; overflow-y: auto; min-width: 300px;">' +
                '<table style="border-collapse: collapse; width: 100%;">';
            
            for (var i = 0; i < emojis.length; i += 8) {
                emojiPickerHTML += '<tr>';
                for (var j = 0; j < 8 && (i + j) < emojis.length; j++) {
                    emojiPickerHTML += '<td style="padding: 8px; cursor: pointer; font-size: 24px; text-align: center; border: 1px solid #f0f0f0;" data-emoji="' + emojis[i + j] + '">' + emojis[i + j] + '</td>';
                }
                emojiPickerHTML += '</tr>';
            }
            
            emojiPickerHTML += '</table></div></div>';
            
            // 创建SimpleMDE编辑器
            // 先定义自定义表情按钮
            var emojiButton = {
                name: "emoji",
                action: function(editor) {
                    // 显示/隐藏表情选择器
                    var picker = document.getElementById("emoji-picker");
                    if (picker) {
                        picker.style.display = picker.style.display === "none" ? "block" : "none";
                    }
                },
                className: "fa fa-smile-o",
                title: "表情"
            };
            
            var simplemde = new SimpleMDE({
                element: document.getElementById("comment_content"),
                toolbar: ["bold", "italic", "|", "code", "quote", "|", emojiButton, "preview", "|", "guide"],
                autoDownloadFontAwesome: false,
                placeholder: options.placeholder || "说点什么吧",
                renderingConfig: {
                    codeSyntaxHighlighting: true
                },
                tabSize: 4,
                toolbarGuideIcon: "❓",
                toolbarButtonClassPrefix: "fa"
            });
            
            // 为表情按钮添加点击事件
            try {
                // 等待DOM加载完成
                setTimeout(function() {
                    // 获取表情按钮
                    var emojiButtonElement = document.querySelector('.editor-toolbar .fa-smile-o');
                    console.log('找到表情按钮:', emojiButtonElement);
                    
                    if (emojiButtonElement) {
                        // 添加点击事件
                        emojiButtonElement.addEventListener('click', function() {
                            var picker = document.getElementById("emoji-picker");
                            if (picker) {
                                picker.style.display = picker.style.display === "none" ? "block" : "none";
                            }
                        });
                        
                        // 添加样式确保按钮可见
                        emojiButtonElement.style.cursor = "pointer";
                        emojiButtonElement.style.margin = "0 3px";
                        emojiButtonElement.style.display = "inline-block";
                        emojiButtonElement.style.padding = "4px 6px";
                        emojiButtonElement.style.fontSize = "16px";
                        
                        console.log('表情按钮事件绑定完成');
                    } else {
                        console.error('未找到表情按钮');
                    }
                }, 50);
            } catch (e) {
                console.error('添加表情按钮事件失败:', e);
            }
            
            // 添加表情包选择器到页面
            var editorElement = document.getElementById("comment_content");
            if (editorElement) {
                // 将表情包选择器直接添加到编辑器容器，不嵌套额外div
                var editorParent = editorElement.parentElement;
                editorParent.insertAdjacentHTML('beforeend', emojiPickerHTML);
                console.log('表情选择器已添加到DOM:', document.getElementById('emoji-picker'));
            }
            
            // 表情按钮已在SimpleMDE配置中直接定义，无需手动添加
            
            // 点击表情包插入到编辑器
            document.addEventListener("click", function(e) {
                var picker = document.getElementById("emoji-picker");
                if (e.target.dataset.emoji) {
                    simplemde.codemirror.replaceSelection(e.target.dataset.emoji);
                    if (picker) {
                        picker.style.display = "none";
                    }
                    // 更新隐藏的textarea
                    $("textarea[name=content]").val(simplemde.markdown(simplemde.value()));
                } else if (e.target.closest(".fa-smile-o")) {
                    // 点击表情按钮显示/隐藏表情选择器
                    if (picker) {
                        if (picker.style.display === "none" || picker.style.display === "") {
                            picker.style.display = "block";
                            console.log('表情选择器已显示');
                        } else {
                            picker.style.display = "none";
                            console.log('表情选择器已隐藏');
                        }
                    } else {
                        console.error('未找到表情选择器元素');
                    }
                } else if (!e.target.closest("#emoji-picker")) {
                    // 点击其他地方关闭表情包选择器
                    if (picker) {
                        picker.style.display = "none";
                    }
                }
            });
            
            // 监听编辑器内容变化，更新隐藏的textarea
            simplemde.codemirror.on("change", function(){
                $("textarea[name=content]").val(simplemde.markdown(simplemde.value()));
            });

            return simplemde;
        },
        loadCommentList: function (box, pageNumber) {
            var sid = box.attr("data-id");
            if(!sid){
                throw "未指定sid！";
            }
            this.sid = sid;
            $.ajax({
                type: "post",
                url: "/api/comments",
                data: {sid: sid, pageNumber: pageNumber || 1},
                success: function (json) {
                    $.alert.ajaxSuccess(json);
                    // 加载 评论列表 start
                    var commentList = json.data.commentList;
                    var commentListBox  = '';
                    if(!commentList){
                        commentListBox = '<div class="commentList">'
                                + '<h5 class="custom-title"><i class="fa fa-comments-o fa-fw icon"></i><strong>0 评论</strong><small></small></h5>'
                                + '<ul class="comment">';
                        commentListBox += '<li><div class="list-comment-empty-w fade-in">'
                                +'<div class="empty-prompt-w">'
                                +'<span class="prompt-null-w">还没有评论，快来抢沙发吧！</span>'
                                +'</div>'
                                +'</div></li>';
                        // 加载 评论列表 end
                        commentListBox += '</ul></div>';
                        $(commentListBox).appendTo(box);
                    }else{
                        // 首次加载-刷新页面后第一次加载，此时没有点击加载更多进行分页
                        if(!pageNumber) {
                            commentListBox = '<div class="commentList">'
                                    + '<h5 class="custom-title"><i class="fa fa-comments-o fa-fw icon"></i><strong>' + json.data.total + ' 评论</strong><small></small></h5>'
                                    + '<ul class="comment">';
                        }
                        for(var i = 0, len = commentList.length; i < len ; i ++){
                            var comment = commentList[i];
                            var userUrl = comment.url || "javascript:void(0)";
                            var parent = comment.parent;
                            var adminIcon = '';
                            var adminClass = '';
                            if(comment.root){
                                adminIcon = '<img src="/img/author.png" alt="" class="author-icon" title="管理员">';
                                adminClass = 'admin-nickname';
                            }
                            var parentQuote = parent ? '<a href="#comment-' + parent.id + '" class="comment-quote">@' + parent.nickname + '</a><div style="background-color: #f5f5f5;padding: 5px;margin: 5px;border-radius: 4px;"><i class="fa fa-quote-left"></i><p></p><div style="padding-left: 10px;">' + filterXSS(parent.content) + '</div></div>' : '';
                            commentListBox += '<li>' +
                                    '    <div class="comment-body fade-in" id="comment-'+comment.id+'">' +
                                    '        <div class="cheader">' +
                                    '           <div class="user-img">' + adminIcon + '<img class="userImage" src="' + filterXSS(comment.avatar) + '" onerror="this.src=\'' + appConfig.staticPath + '/img/user.png\'"></div>' +
                                    '           <div class="user-info">' +
                                    '              <div class="nickname">' +
                                    '                 <a target="_blank" href="' + userUrl + '" rel="external nofollow" class="' + adminClass + '"><strong>' + comment.nickname + '</strong></a>' +
                                    '                <i class="icons os-' + comment.osShortName + '" title="' + comment.os + '"></i>' +
                                    '                <i class="icons browser-' + comment.browserShortName + '" title="' + comment.browser + '"></i>' +
                                    '              </div>            ' +
                                    '             <div class="timer">' +
                                    '                  <i class="fa fa-clock-o fa-fw"></i>' + comment.createTimeString +
                                    '                  <i class="fa fa-map-marker fa-fw"></i>' + comment.address +
                                    '              </div>' +
                                    '          </div>' +
                                    '        </div>' +
                                    '        <div class="content">' + parentQuote + '<div style="word-break: break-all;">' + filterXSS(comment.content) + '</div></div>' +
                                    '        <div class="sign">' +
                                    '            <a href="javascript:void(0);" class="comment-up" onclick="$.comment.praise(' + comment.id + ', this)"><i class="fa fa-thumbs-o-up"></i>赞(<span class="count">' + comment.support + '</span>)<i class="sepa"></i></a>' +
                                    '            <a href="javascript:void(0);" class="comment-down" onclick="$.comment.step(' + comment.id + ', this)"><i class="fa fa-thumbs-o-down"></i>踩(<span class="count">' + comment.oppose + '</span>)<i class="sepa"></i></a>' +
                                    '            <a href="javascript:void(0);" class="comment-reply" onclick="$.comment.reply(' + comment.id + ', this)"><i class="fa fa-reply"></i>回复</a>' +
                                    '            <a href="javascript:void(0);" class="comment-flag hide" onclick="$.comment.report(' + comment.id + ', this)"><i class="fa fa-flag"></i>举报</a>' +
                                    '        </div>' +
                                    '    </div>' +
                                    '</li>';
                        }
                        // 如果存在下一页，则显示加载按钮
                        if(json.data.hasNextPage){
                            commentListBox += '<li><div class="list-comment-empty-w fade-in">'
                                    +'<div class="empty-prompt-w">'
                                    +'<span class="prompt-null-w pointer load-more">加载更多 <i class="fa fa-angle-double-down"></i></span>'
                                    +'</div>'
                                    +'</div></li>';
                        }
                        // 加载 评论列表 end

                        if(!pageNumber) {
                            // 首次加载-刷新页面后第一次加载，此时没有点击加载更多进行分页
                            commentListBox += '</ul></div>';
                            $(commentListBox).appendTo(box);
                        }else{
                            // 点击加载更多时，列表追加到ul中
                            $(commentListBox).appendTo($(".comment"));
                        }

                        // 加载更多按钮
                        $(".load-more").click(function () {
                            $(this).parents('li').hide();
                            $.comment.loadCommentList(box, json.data.nextPage)
                        });
                    }
                },
                error: $.alert.ajaxError
            });
        },
        initValidatorPlugin: function () {
            $.comment._detailForm.bootstrapValidator({
                message: "输入值无效",
                feedbackIcons: {
                    valid: "fa fa-check",
                    invalid: "fa fa-remove",
                    validating: "fa fa-refresh"
                },
                fields: {
                    nickname: {
                        validators: {
                            notEmpty: {
                                message: "昵称必填"
                            }
                        }
                    },
                    url: {
                        validators: {
                            uri: {
                                message: "URL地址不正确"
                            }
                        }
                    },
                    email: {
                        validators: {
                            emailAddress: {
                                message: "邮箱地址不正确"
                            }
                        }
                    }
                }
            });
        },
        submit: function (target) {
            var $this = $(target);
            $this.button('loading');
            var data = $("#comment-form").serialize();
            if(typeof oauthConfig === 'undefined' || !oauthConfig.loginUserId) {
                var detail = localStorage.getItem(this.detailKey);
                if(detail){
                    var detailInfoJson = $.tool.parseFormSerialize(detail);
                    $.comment._detailForm.find("input").each(function () {
                        var $this = $(this);
                        var inputName = $this.attr("name");
                        if(detailInfoJson[inputName]){
                            $this.val(detailInfoJson[inputName]);
                        }
                    });
                    var $img = $.comment._detailForm.find('img');
                    $img.attr('src', detailInfoJson.avatar);
                    $img.removeClass('hide');
                }
                this._commentDetailModal.modal('show');
                this._closeBtn.unbind('click');
                this._closeBtn.click(function () {
                    setTimeout(function () {
                        $this.html("<i class='fa fa-close'></i>取消操作...");
                        setTimeout(function () {
                            $this.button('reset');
                        }, 1000);
                    }, 500);
                });
                // 模态框抖动
                this._commentDetailModal.find('.modal-content').addClass("shake");
                $.comment._detailForm.find("input[name=qq]").unbind('change');
                $.comment._detailForm.find("input[name=qq]").change(function () {
                    var $this = $(this);
                    var qq = $this.val();
                    var $nextImg = $this.next('img');
                    if(qq){
                        $.ajax({
                            type: "post",
                            url: "/api/qq/" + qq,
                            success: function (json) {
                                $.alert.ajaxSuccess(json);
                                var data = json.data;
                                $.comment._detailForm.find("input").each(function () {
                                    var $this = $(this);
                                    var inputName = $this.attr("name");
                                    if(data[inputName]){
                                        $this.val(data[inputName]);
                                    }
                                });
                                $nextImg.attr('src', data.avatar);
                                $nextImg.removeClass('hide');
                            },
                            error: $.alert.ajaxError
                        });
                    }else{
                        $nextImg.addClass('hide');
                    }

                });
                // 提交评论
                this._detailFormBtn.unbind('click');
                this._detailFormBtn.click(function () {
                    $.comment._detailForm.bootstrapValidator("validate");
                    if (_form.valid($.comment._detailForm)) {
                        data = data + "&" + $.comment._detailForm.serialize();
                        localStorage.setItem($.comment.detailKey, $.comment._detailForm.serialize());
                        submitForm(data);
                    }
                });
            } else {
                submitForm(data);
            }




            function submitForm(data) {
                console.log('提交的数据:', data);
                console.log('文章ID:', $.comment.sid);
                $.ajax({
                    type: "post",
                    url: "/api/comment",
                    data: data + '&sid=' + $.comment.sid,
                    success: function (json) {
                        console.log('提交成功:', json);
                        $.alert.ajaxSuccess(json);

                        $.comment._commentDetailModal.modal('hide');

                        setTimeout(function () {
                            $this.html("<i class='fa fa-check'></i>" + json.message);
                            setTimeout(function () {
                                $this.button('reset');
                                if (json.status == 200) {
                                    window.location.reload();
                                }
                            }, 3000);
                        }, 1000);
                    },
                    error: function (xhr, status, error) {
                        console.log('提交失败:', xhr.responseText);
                        console.log('错误状态:', status);
                        console.log('错误信息:', error);
                        $.alert.ajaxError();
                        $this.button('reset');
                    }
                });
            }
        },
        reply: function (pid, target) {
            // console.log(pid);
            this._commentPid.val(pid);
            this._cancelReply.show();
            // this._commentReply.show();
            $(target).hide();
            $(target).parents('.comment-body').append($("#comment-form"));
        },
        cancelReply: function (target) {
            this._commentPid.val("");
            this._cancelReply.hide();
            $(target).parents(".comment-body").find('.comment-reply').show();
            this._commentPost.append($("#comment-form"));
        },
        /* 赞 */
        praise: function (pid, target) {
            $.bubble.unbind();
            $.ajax({
                type: "post",
                url: "/api/doSupport/" + pid,
                success: function (json) {
                    $.alert.ajaxSuccess(json);
                    if(json.status == 200){
                        $(target).effectBubble({y:-80, className:'thumb-bubble', fontSize: 1, content: '<i class="fa fa-smile-o"></i>+1'});
                        var oldCount = $(target).find('span.count').text();
                        $(target).find('span.count').text(parseInt(oldCount) + 1);
                    }
                    $.bubble.init();
                },
                error: function () {
                    $.alert.ajaxError();
                    $.bubble.init();
                }
            });
        },
        /* 踩 */
        step: function (pid, target) {
            $.bubble.unbind();
            $.ajax({
                type: "post",
                url: "/api/doOppose/" + pid,
                success: function (json) {
                    $.alert.ajaxSuccess(json);
                    if(json.status == 200){
                        $(target).effectBubble({y:-80, className:'thumb-bubble', fontSize: 1, content: '<i class="fa fa-meh-o"></i>+1'});
                        var oldCount = $(target).find('span.count').text();
                        $(target).find('span.count').text(parseInt(oldCount) + 1);
                    }
                    $.bubble.init();
                },
                error: function () {
                    $.alert.ajaxError();
                    $.bubble.init();
                }
            });
        },
        /* 举报 */
        report: function (pid, target) {
        }
    }
});

