package com.zyd.blog.business.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.zyd.blog.persistence.beans.BizUserHistory;

import java.util.Date;

/**
 * 用户浏览历史表业务对象
 *
 * @author yadong.zhang (yadong.zhang0415(a)gmail.com)
 * @version 1.0
 * @website https://docs.zhyd.me
 * @date 2025/12/18
 * @since 1.0
 */
public class BizUserHistoryBo {
    private BizUserHistory bizUserHistory;

    public BizUserHistoryBo() {
        this.bizUserHistory = new BizUserHistory();
    }

    public BizUserHistoryBo(BizUserHistory bizUserHistory) {
        this.bizUserHistory = bizUserHistory;
    }

    @JsonIgnore
    public BizUserHistory getBizUserHistory() {
        return this.bizUserHistory;
    }

    public Long getId() {
        return this.bizUserHistory.getId();
    }

    public void setId(Long id) {
        this.bizUserHistory.setId(id);
    }

    public Long getUserId() {
        return this.bizUserHistory.getUserId();
    }

    public void setUserId(Long userId) {
        this.bizUserHistory.setUserId(userId);
    }

    public Long getArticleId() {
        return this.bizUserHistory.getArticleId();
    }

    public void setArticleId(Long articleId) {
        this.bizUserHistory.setArticleId(articleId);
    }

    public Date getViewTime() {
        return this.bizUserHistory.getViewTime();
    }

    public void setViewTime(Date viewTime) {
        this.bizUserHistory.setViewTime(viewTime);
    }

    public Date getCreateTime() {
        return this.bizUserHistory.getCreateTime();
    }

    public void setCreateTime(Date createTime) {
        this.bizUserHistory.setCreateTime(createTime);
    }

    public Date getUpdateTime() {
        return this.bizUserHistory.getUpdateTime();
    }

    public void setUpdateTime(Date updateTime) {
        this.bizUserHistory.setUpdateTime(updateTime);
    }
}