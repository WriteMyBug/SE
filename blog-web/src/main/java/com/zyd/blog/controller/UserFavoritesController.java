package com.zyd.blog.controller;

import com.zyd.blog.business.annotation.BussinessLog;
import com.zyd.blog.business.entity.User;
import com.zyd.blog.business.enums.PlatformEnum;
import com.zyd.blog.business.service.BizUserFavoritesService;
import com.zyd.blog.framework.object.ResponseVO;
import com.zyd.blog.util.ResultUtil;
import com.zyd.blog.util.SessionUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * 用户收藏控制器（前台）
 *
 * @author funnyhat
 * @date 2025/12/18
 */
@Slf4j
@RestController
@RequestMapping("/api")
public class UserFavoritesController {

    @Autowired
    private BizUserFavoritesService bizUserFavoritesService;

    /**
     * 切换收藏状态
     */
    @PostMapping("/favorites/toggle/{articleId}")
    @BussinessLog(value = "切换文章收藏状态", platform = PlatformEnum.WEB)
    public ResponseVO toggleFavorite(@PathVariable Long articleId) {
        User currentUser = SessionUtil.getUser();
        if (currentUser == null) {
            return ResultUtil.error("用户未登录");
        }

        try {
            Long userId = currentUser.getId();
            
            // 检查当前是否已收藏
            boolean isFavorited = bizUserFavoritesService.isFavorites(userId, articleId);
            
            if (isFavorited) {
                // 如果已收藏，则取消收藏
                boolean success = bizUserFavoritesService.removeFavorites(userId, articleId);
                if (success) {
                    return ResultUtil.success("取消收藏成功", false);
                } else {
                    return ResultUtil.error("取消收藏失败");
                }
            } else {
                // 如果未收藏，则添加收藏
                boolean success = bizUserFavoritesService.addFavorites(userId, articleId);
                if (success) {
                    return ResultUtil.success("收藏成功", true);
                } else {
                    return ResultUtil.error("收藏失败");
                }
            }
        } catch (Exception e) {
            log.error("切换收藏状态失败", e);
            return ResultUtil.error("操作失败，请稍后重试");
        }
    }

    /**
     * 检查文章是否已收藏
     */
    @GetMapping("/favorites/check/{articleId}")
    public ResponseVO isFavorited(@PathVariable Long articleId) {
        User currentUser = SessionUtil.getUser();
        if (currentUser == null) {
            return ResultUtil.error("用户未登录");
        }

        try {
            Long userId = currentUser.getId();
            boolean isFavorited = bizUserFavoritesService.isFavorites(userId, articleId);
            return ResultUtil.success("查询成功", isFavorited);
        } catch (Exception e) {
            log.error("检查收藏状态失败", e);
            return ResultUtil.error("查询失败");
        }
    }
}