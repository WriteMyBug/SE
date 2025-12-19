package com.zyd.blog.business.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.zyd.blog.persistence.beans.BizUserFavorites;

import java.util.Date;

/**
 * 用户收藏实体类
 *
 * @author yadong.zhang (yadong.zhang0415(a)gmail.com)
 * @version 1.0
 * @website https://docs.zhyd.me
 * @date 2025/12/18
 * @since 1.0
 */
public class UserFavorites {
    private final BizUserFavorites bizUserFavorites;

    public UserFavorites() {
        this.bizUserFavorites = new BizUserFavorites();
    }

    public UserFavorites(BizUserFavorites bizUserFavorites) {
        this.bizUserFavorites = bizUserFavorites;
    }

    @JsonIgnore
    public BizUserFavorites getBizUserFavorites() {
        return this.bizUserFavorites;
    }

    public Long getId() {
        return this.bizUserFavorites.getId();
    }

    public void setId(Long id) {
        this.bizUserFavorites.setId(id);
    }

    public Long getUserId() {
        return this.bizUserFavorites.getUserId();
    }

    public void setUserId(Long userId) {
        this.bizUserFavorites.setUserId(userId);
    }

    public Long getArticleId() {
        return this.bizUserFavorites.getArticleId();
    }

    public void setArticleId(Long articleId) {
        this.bizUserFavorites.setArticleId(articleId);
    }

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "GMT+8")
    public Date getCreateTime() {
        return this.bizUserFavorites.getCreateTime();
    }

    public void setCreateTime(Date createTime) {
        this.bizUserFavorites.setCreateTime(createTime);
    }

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "GMT+8")
    public Date getUpdateTime() {
        return this.bizUserFavorites.getUpdateTime();
    }

    public void setUpdateTime(Date updateTime) {
        this.bizUserFavorites.setUpdateTime(updateTime);
    }
}
