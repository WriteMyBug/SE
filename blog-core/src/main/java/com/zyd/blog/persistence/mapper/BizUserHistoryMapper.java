package com.zyd.blog.persistence.mapper;

import com.zyd.blog.persistence.beans.BizUserHistory;
import com.zyd.blog.plugin.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * 用户浏览历史表Mapper接口
 *
 * @author yadong.zhang (yadong.zhang0415(a)gmail.com)
 * @version 1.0
 * @website https://docs.zhyd.me
 * @date 2025/12/18
 * @since 1.0
 */
@Repository
public interface BizUserHistoryMapper extends BaseMapper<BizUserHistory> {

    /**
     * 根据用户ID获取浏览历史的文章ID列表，按浏览时间倒序
     *
     * @param userId 用户ID
     * @return 文章ID列表
     */
    List<Long> listArticleIdsByUserId(@Param("userId") Long userId);

    /**
     * 根据用户ID和文章ID删除历史记录
     *
     * @param userId   用户ID
     * @param articleId 文章ID
     * @return 删除成功的行数
     */
    int deleteByUserIdAndArticleId(@Param("userId") Long userId, @Param("articleId") Long articleId);

    /**
     * 判断用户是否浏览过该文章
     *
     * @param userId   用户ID
     * @param articleId 文章ID
     * @return 历史记录数
     */
    int countByUserIdAndArticleId(@Param("userId") Long userId, @Param("articleId") Long articleId);

    /**
     * 更新用户浏览文章的时间
     *
     * @param userId   用户ID
     * @param articleId 文章ID
     * @return 更新成功的行数
     */
    int updateViewTimeByUserIdAndArticleId(@Param("userId") Long userId, @Param("articleId") Long articleId);

    /**
     * 根据用户ID获取浏览历史的文章信息，包括浏览时间
     *
     * @param userId 用户ID
     * @return 文章信息列表，包含浏览时间
     */
    List<Map<String, Object>> listArticlesWithViewTimeByUserId(@Param("userId") Long userId);
}