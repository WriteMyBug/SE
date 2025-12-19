package com.zyd.blog.persistence.mapper;

import com.zyd.blog.persistence.beans.BizUserFavorites;
import com.zyd.blog.plugin.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 用户收藏表Mapper接口
 *
 * @author yadong.zhang (yadong.zhang0415(a)gmail.com)
 * @version 1.0
 * @website https://docs.zhyd.me
 * @date 2025/12/18
 * @since 1.0
 */
@Repository
public interface BizUserFavoritesMapper extends BaseMapper<BizUserFavorites> {

    /**
     * 根据用户ID获取收藏的文章ID列表
     *
     * @param userId 用户ID
     * @return 文章ID列表
     */
    List<Long> listArticleIdsByUserId(@Param("userId") Long userId);

    /**
     * 根据用户ID和文章ID删除收藏
     *
     * @param userId   用户ID
     * @param articleId 文章ID
     * @return 删除成功的行数
     */
    int deleteByUserIdAndArticleId(@Param("userId") Long userId, @Param("articleId") Long articleId);

    /**
     * 判断用户是否收藏了该文章
     *
     * @param userId   用户ID
     * @param articleId 文章ID
     * @return 收藏记录数
     */
    int countByUserIdAndArticleId(@Param("userId") Long userId, @Param("articleId") Long articleId);
}