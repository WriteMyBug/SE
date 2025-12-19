package com.zyd.blog.persistence.beans;

import com.zyd.blog.framework.object.AbstractDO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 用户收藏表实体类
 *
 * @author yadong.zhang (yadong.zhang0415(a)gmail.com)
 * @version 1.0
 * @website https://docs.zhyd.me
 * @date 2025/12/18
 * @since 1.0
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class BizUserFavorites extends AbstractDO {
    private Long userId;
    private Long articleId;
}