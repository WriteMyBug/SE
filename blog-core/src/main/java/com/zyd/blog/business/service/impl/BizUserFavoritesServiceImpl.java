package com.zyd.blog.business.service.impl;

import com.zyd.blog.business.entity.BizUserFavoritesBo;
import com.zyd.blog.business.service.BizUserFavoritesService;
import com.zyd.blog.business.service.BizArticleService;
import com.zyd.blog.persistence.beans.BizUserFavorites;
import com.zyd.blog.persistence.mapper.BizUserFavoritesMapper;
import com.zyd.blog.util.SessionUtil;
import com.zyd.blog.business.entity.User;
import com.zyd.blog.business.entity.Article;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 用户收藏表Service实现类
 *
 * @author yadong.zhang (yadong.zhang0415(a)gmail.com)
 * @version 1.0
 * @website https://docs.zhyd.me
 * @date 2025/12/18
 * @since 1.0
 */
@Service
public class BizUserFavoritesServiceImpl implements BizUserFavoritesService {

    @Autowired
    private BizUserFavoritesMapper bizUserFavoritesMapper;

    @Autowired
    private BizArticleService bizArticleService;

    @Override
    public BizUserFavoritesBo insert(BizUserFavoritesBo entity) {
        if (entity != null) {
            Date now = new Date();
            entity.setCreateTime(now);
            entity.setUpdateTime(now);
            bizUserFavoritesMapper.insert(entity.getBizUserFavorites());
        }
        return entity;
    }

    @Override
    public boolean removeByPrimaryKey(Long primaryKey) {
        return bizUserFavoritesMapper.deleteByPrimaryKey(primaryKey) > 0;
    }

    @Override
    public boolean updateSelective(BizUserFavoritesBo entity) {
        if (entity != null) {
            entity.setUpdateTime(new Date());
            return bizUserFavoritesMapper.updateByPrimaryKeySelective(entity.getBizUserFavorites()) > 0;
        }
        return false;
    }

    @Override
    public BizUserFavoritesBo getByPrimaryKey(Long primaryKey) {
        BizUserFavorites bizUserFavorites = bizUserFavoritesMapper.selectByPrimaryKey(primaryKey);
        return bizUserFavorites != null ? new BizUserFavoritesBo(bizUserFavorites) : null;
    }

    @Override
    public List<BizUserFavoritesBo> listAll() {
        List<BizUserFavorites> list = bizUserFavoritesMapper.selectAll();
        if (list == null || list.isEmpty()) {
            return null;
        }
        List<BizUserFavoritesBo> boList = new ArrayList<>();
        for (BizUserFavorites bizUserFavorites : list) {
            boList.add(new BizUserFavoritesBo(bizUserFavorites));
        }
        return boList;
    }

    @Override
    public List<Long> listArticleIdsByUserId(Long userId) {
        return bizUserFavoritesMapper.listArticleIdsByUserId(userId);
    }

    @Override
    public boolean addFavorites(Long userId, Long articleId) {
        if (userId == null || articleId == null) {
            return false;
        }
        // 检查是否已经收藏
        if (bizUserFavoritesMapper.countByUserIdAndArticleId(userId, articleId) > 0) {
            return true; // 已经收藏
        }
        // 添加收藏
        BizUserFavorites bizUserFavorites = new BizUserFavorites();
        bizUserFavorites.setUserId(userId);
        bizUserFavorites.setArticleId(articleId);
        Date now = new Date();
        bizUserFavorites.setCreateTime(now);
        bizUserFavorites.setUpdateTime(now);
        return bizUserFavoritesMapper.insert(bizUserFavorites) > 0;
    }

    @Override
    public boolean removeFavorites(Long userId, Long articleId) {
        if (userId == null || articleId == null) {
            return false;
        }
        return bizUserFavoritesMapper.deleteByUserIdAndArticleId(userId, articleId) > 0;
    }

    @Override
    public boolean isFavorites(Long userId, Long articleId) {
        if (userId == null || articleId == null) {
            return false;
        }
        return bizUserFavoritesMapper.countByUserIdAndArticleId(userId, articleId) > 0;
    }

    @Override
    public boolean toggleFavorite(Long articleId) {
        User currentUser = SessionUtil.getUser();
        if (currentUser == null) {
            return false;
        }
        Long userId = currentUser.getId();
        if (isFavorites(userId, articleId)) {
            // 如果已经收藏，取消收藏
            return !removeFavorites(userId, articleId);
        } else {
            // 如果没有收藏，添加收藏
            return addFavorites(userId, articleId);
        }
    }

    @Override
    public boolean isFavorited(Long articleId) {
        User currentUser = SessionUtil.getUser();
        if (currentUser == null) {
            return false;
        }
        return isFavorites(currentUser.getId(), articleId);
    }

    @Override
    public List<com.zyd.blog.business.entity.Article> getFavoriteArticles(Long userId) {
        if (userId == null) {
            return new ArrayList<>();
        }
        // 获取用户收藏的文章ID列表
        List<Long> articleIds = listArticleIdsByUserId(userId);
        if (articleIds == null || articleIds.isEmpty()) {
            return new ArrayList<>();
        }
        // 根据文章ID列表获取文章详情
        return bizArticleService.listArticlesByIds(articleIds);
    }
}