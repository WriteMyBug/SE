package com.zyd.blog.business.service.impl;

import com.zyd.blog.business.entity.BizUserHistoryBo;
import com.zyd.blog.business.service.BizUserHistoryService;
import com.zyd.blog.business.service.BizArticleService;
import com.zyd.blog.persistence.beans.BizUserHistory;
import com.zyd.blog.persistence.mapper.BizUserHistoryMapper;
import com.zyd.blog.business.entity.Article;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * 用户浏览历史表Service实现类
 *
 * @author yadong.zhang (yadong.zhang0415(a)gmail.com)
 * @version 1.0
 * @website https://docs.zhyd.me
 * @date 2025/12/18
 * @since 1.0
 */
@Service
public class BizUserHistoryServiceImpl implements BizUserHistoryService {

    @Autowired
    private BizUserHistoryMapper bizUserHistoryMapper;

    @Autowired
    private BizArticleService bizArticleService;

    @Override
    public BizUserHistoryBo insert(BizUserHistoryBo entity) {
        if (entity != null) {
            bizUserHistoryMapper.insert(entity.getBizUserHistory());
        }
        return entity;
    }

    @Override
    public boolean removeByPrimaryKey(Long primaryKey) {
        return bizUserHistoryMapper.deleteByPrimaryKey(primaryKey) > 0;
    }

    @Override
    public boolean updateSelective(BizUserHistoryBo entity) {
        if (entity != null) {
            return bizUserHistoryMapper.updateByPrimaryKeySelective(entity.getBizUserHistory()) > 0;
        }
        return false;
    }

    @Override
    public BizUserHistoryBo getByPrimaryKey(Long primaryKey) {
        BizUserHistory bizUserHistory = bizUserHistoryMapper.selectByPrimaryKey(primaryKey);
        return bizUserHistory != null ? new BizUserHistoryBo(bizUserHistory) : null;
    }

    @Override
    public List<BizUserHistoryBo> listAll() {
        List<BizUserHistory> list = bizUserHistoryMapper.selectAll();
        if (list == null || list.isEmpty()) {
            return null;
        }
        List<BizUserHistoryBo> boList = new ArrayList<>();
        for (BizUserHistory bizUserHistory : list) {
            boList.add(new BizUserHistoryBo(bizUserHistory));
        }
        return boList;
    }

    @Override
    public List<Long> listArticleIdsByUserId(Long userId) {
        return bizUserHistoryMapper.listArticleIdsByUserId(userId);
    }

    @Override
    public boolean addHistory(Long userId, Long articleId) {
        if (userId == null || articleId == null) {
            return false;
        }
        // 检查是否已经有浏览记录
        if (bizUserHistoryMapper.countByUserIdAndArticleId(userId, articleId) > 0) {
            // 如果有记录，更新浏览时间
            return bizUserHistoryMapper.updateViewTimeByUserIdAndArticleId(userId, articleId) > 0;
        } else {
            // 如果没有记录，添加新记录
            BizUserHistory bizUserHistory = new BizUserHistory();
            bizUserHistory.setUserId(userId);
            bizUserHistory.setArticleId(articleId);
            // 显式设置时间字段
            java.util.Date now = new java.util.Date();
            bizUserHistory.setViewTime(new java.sql.Timestamp(now.getTime()));
            bizUserHistory.setCreateTime(new java.sql.Timestamp(now.getTime()));
            bizUserHistory.setUpdateTime(new java.sql.Timestamp(now.getTime()));
            return bizUserHistoryMapper.insert(bizUserHistory) > 0;
        }
    }

    @Override
    public boolean removeHistory(Long userId, Long articleId) {
        if (userId == null || articleId == null) {
            return false;
        }
        return bizUserHistoryMapper.deleteByUserIdAndArticleId(userId, articleId) > 0;
    }

    @Override
    public boolean isHistory(Long userId, Long articleId) {
        if (userId == null || articleId == null) {
            return false;
        }
        return bizUserHistoryMapper.countByUserIdAndArticleId(userId, articleId) > 0;
    }

    @Override
    public List<Map<String, Object>> getHistoryArticles(Long userId) {
        if (userId == null) {
            return new ArrayList<>();
        }
        // 获取用户浏览历史的文章信息，包括浏览时间
        List<Map<String, Object>> historyList = bizUserHistoryMapper.listArticlesWithViewTimeByUserId(userId);
        if (historyList == null || historyList.isEmpty()) {
            return new ArrayList<>();
        }
        return historyList;
    }
}