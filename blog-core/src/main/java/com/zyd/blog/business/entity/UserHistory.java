package com.zyd.blog.business.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.zyd.blog.persistence.beans.BizUserHistory;

import java.util.Date;

/**
 * 用户浏览历史实体类
 *
 * @author yadong.zhang (yadong.zhang0415(a)gmail.com)
 * @version 1.0
 * @website https://docs.zhyd.me
 * @date 2025/12/18
 * @since 1.0
 */
public class UserHistory {
    private final BizUserHistory bizUserHistory;

    public UserHistory() {
        this.bizUserHistory = new BizUserHistory();
    }

    public UserHistory(BizUserHistory bizUserHistory) {
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

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "GMT+8")
    public Date getViewTime() {
        return this.bizUserHistory.getViewTime();
    }

    public void setViewTime(Date viewTime) {
        this.bizUserHistory.setViewTime(viewTime);
    }

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "GMT+8")
    public Date getCreateTime() {
        return this.bizUserHistory.getCreateTime();
    }

    public void setCreateTime(Date createTime) {
        this.bizUserHistory.setCreateTime(createTime);
    }

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "GMT+8")
    public Date getUpdateTime() {
        return this.bizUserHistory.getUpdateTime();
    }

    public void setUpdateTime(Date updateTime) {
        this.bizUserHistory.setUpdateTime(updateTime);
    }
}
