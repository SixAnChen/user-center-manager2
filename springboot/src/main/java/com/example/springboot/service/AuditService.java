package com.example.springboot.service;

import cn.hutool.core.util.ObjectUtil;
import com.example.springboot.common.JwtTokenUtils;
import com.example.springboot.entity.Audit;
import com.example.springboot.entity.Params;
import com.example.springboot.entity.User;
import com.example.springboot.exception.CustomException;
import com.example.springboot.mapper.AuditMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * 功能：
 * 作者：SixAn
 * 日期：2023-09-18 08:36
 */

@Service
public class AuditService {
    @Resource
    private AuditMapper auditMapper;


    public PageInfo<Audit> findBySearch(Params params) {
        User user = JwtTokenUtils.getCurrentUser();
        if (ObjectUtil.isNull(user)) {
            throw new CustomException("从token中未解析到用户信息，请重新登录");
        }
        if ("学生".equals(user.getRole())) {
            params.setUserId(user.getId());
        }
        // 开启分页查询
        PageHelper.startPage(params.getPageNum(), params.getPageSize());
        // 接下来的查询会自动按照当前开启的分页设置来查询
        List<Audit> list = auditMapper.findBySearch(params);

        return PageInfo.of(list);
    }

    public void add(Audit audit) {
        auditMapper.insertSelective(audit);
    }

    public void update(Audit audit) {
        auditMapper.updateByPrimaryKeySelective(audit);
    }

    public void delete(Integer id) {
        auditMapper.deleteByPrimaryKey(id);
    }
}
