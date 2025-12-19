package com.zyd.blog.business.service;

import com.zyd.blog.business.entity.BizUserHistoryBo;
import com.zyd.blog.business.entity.Article;
import com.zyd.blog.framework.object.AbstractService;

import java.util.List;
import java.util.Map;

/**
 * 用户浏览历史表Service接口
 *
 * @author yadong.zhang (yadong.zhang0415(a)gmail.com)
 * @version 1.0
 * @website https://docs.zhyd.me
 * @date 2025/12/18
 * @since 1.0
 */
public interface BizUserHistoryService extends AbstractService<BizUserHistoryBo, Long> {

    /**
     * 根据用户ID获取浏览历史的文章ID列表，按浏览时间倒序
     *
     * @param userId 用户ID
     * @return 文章ID列表
     */
    List<Long> listArticleIdsByUserId(Long userId);

    /**
     * 添加浏览历史记录
     *
     * @param userId   用户ID
     * @param articleId 文章ID
     * @return 是否添加成功
     */
    boolean addHistory(Long userId, Long articleId);

    /**
     * 删除浏览历史记录
     *
     * @param userId   用户ID
     * @param articleId 文章ID
     * @return 是否删除成功
     */
    boolean removeHistory(Long userId, Long articleId);

    /**
     * 判断用户是否浏览过该文章
     *
     * @param userId   用户ID
     * @param articleId 文章ID
     * @return 是否浏览过
     */
    boolean isHistory(Long userId, Long articleId);

    /**
     * 获取用户浏览历史的文章列表，包含浏览时间
     *
     * @param userId 用户ID
     * @return 文章列表（包含浏览时间）
     */
    List<Map<String, Object>> getHistoryArticles(Long userId);
}