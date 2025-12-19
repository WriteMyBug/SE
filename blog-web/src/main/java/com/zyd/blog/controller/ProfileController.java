package com.zyd.blog.controller;

import com.zyd.blog.business.entity.Article;
import com.zyd.blog.business.entity.User;
import com.zyd.blog.business.service.BizArticleService;
import com.zyd.blog.business.service.BizUserFavoritesService;
import com.zyd.blog.business.service.BizUserHistoryService;
import com.zyd.blog.util.ResultUtil;
import com.zyd.blog.util.SessionUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 个人中心控制器
 *
 * @author yadong.zhang
 * @date 2025-12-18
 */
@RestController
@RequestMapping("/profile")
public class ProfileController {

    @Autowired
    private BizUserFavoritesService bizUserFavoritesService;

    @Autowired
    private BizUserHistoryService bizUserHistoryService;

    @Autowired
    private BizArticleService bizArticleService;

    /**
     * 获取用户收藏的文章
     */
    @GetMapping("/favorites")
    public Map<String, Object> getFavorites() {
        User currentUser = SessionUtil.getUser();
        if (currentUser == null) {
            return createErrorResponse("用户未登录");
        }

        try {
            List<Article> favoriteArticles = bizUserFavoritesService.getFavoriteArticles(currentUser.getId());
            return createSuccessResponse(favoriteArticles);
        } catch (Exception e) {
            e.printStackTrace();
            return createErrorResponse("加载收藏夹失败");
        }
    }

    /**
     * 获取用户的浏览历史
     */
    @GetMapping("/history")
    public Map<String, Object> getHistory() {
        User currentUser = SessionUtil.getUser();
        if (currentUser == null) {
            return createErrorResponse("用户未登录");
        }

        try {
            List<Map<String, Object>> historyArticles = bizUserHistoryService.getHistoryArticles(currentUser.getId());
            // 为了调试，打印返回的数据结构
            System.out.println("浏览历史数据: " + historyArticles);
            return createSuccessResponse(historyArticles);
        } catch (Exception e) {
            e.printStackTrace();
            return createErrorResponse("加载浏览历史失败");
        }
    }

    /**
     * 创建成功响应
     */
    private Map<String, Object> createSuccessResponse(Object data) {
        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        response.put("message", "成功");
        response.put("data", data);
        return response;
    }

    /**
     * 创建错误响应
     */
    private Map<String, Object> createErrorResponse(String message) {
        Map<String, Object> response = new HashMap<>();
        response.put("success", false);
        response.put("message", message);
        return response;
    }
}
