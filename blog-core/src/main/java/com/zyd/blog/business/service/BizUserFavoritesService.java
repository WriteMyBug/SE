package com.zyd.blog.business.service;

import com.zyd.blog.business.entity.BizUserFavoritesBo;
import com.zyd.blog.framework.object.AbstractService;
import com.zyd.blog.persistence.beans.BizUserFavorites;

import java.util.List;

/**
 * 用户收藏表Service接口
 *
 * @author yadong.zhang (yadong.zhang0415(a)gmail.com)
 * @version 1.0
 * @website https://docs.zhyd.me
 * @date 2025/12/18
 * @since 1.0
 */
public interface BizUserFavoritesService extends AbstractService<BizUserFavoritesBo, Long> {

    /**
     * 根据用户ID获取收藏的文章ID列表
     *
     * @param userId 用户ID
     * @return 文章ID列表
     */
    List<Long> listArticleIdsByUserId(Long userId);

    /**
     * 收藏文章
     *
     * @param userId   用户ID
     * @param articleId 文章ID
     * @return 是否收藏成功
     */
    boolean addFavorites(Long userId, Long articleId);

    /**
     * 取消收藏文章
     *
     * @param userId   用户ID
     * @param articleId 文章ID
     * @return 是否取消成功
     */
    boolean removeFavorites(Long userId, Long articleId);

    /**
     * 判断用户是否收藏了该文章
     *
     * @param userId   用户ID
     * @param articleId 文章ID
     * @return 是否收藏
     */
    boolean isFavorites(Long userId, Long articleId);

    /**
     * 切换文章收藏状态（收藏/取消收藏）
     *
     * @param articleId 文章ID
     * @return 操作后的收藏状态
     */
    boolean toggleFavorite(Long articleId);

    /**
     * 判断当前登录用户是否收藏了该文章
     *
     * @param articleId 文章ID
     * @return 是否收藏
     */
    boolean isFavorited(Long articleId);

    /**
     * 获取用户收藏的文章列表
     *
     * @param userId 用户ID
     * @return 文章列表
     */
    List<com.zyd.blog.business.entity.Article> getFavoriteArticles(Long userId);
}