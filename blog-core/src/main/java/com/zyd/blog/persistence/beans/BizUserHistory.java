package com.zyd.blog.persistence.beans;

import com.zyd.blog.framework.object.AbstractDO;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.Date;

/**
 * 用户浏览历史表实体类
 *
 * @author yadong.zhang (yadong.zhang0415(a)gmail.com)
 * @version 1.0
 * @website https://docs.zhyd.me
 * @date 2025/12/18
 * @since 1.0
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class BizUserHistory extends AbstractDO {
    private Long userId;
    private Long articleId;
    private Date viewTime;
}
