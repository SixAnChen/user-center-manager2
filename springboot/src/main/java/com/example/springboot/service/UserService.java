package com.example.springboot.service;

import com.example.springboot.common.JwtTokenUtils;
import com.example.springboot.entity.Params;
import com.example.springboot.entity.User;
import com.example.springboot.exception.CustomException;
import com.example.springboot.mapper.UserMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

/**
 * 功能：
 * 作者：SixAn
 * 日期：2023-09-17 16:20
 */
@Service
public class UserService {

    @Resource
    private UserMapper userMapper;

    public List<User> list() {
        return userMapper.list();
    }


    public PageInfo<User> search(Params params) {

        // 开启分页查询
        PageHelper.startPage(params.getPageNum(), params.getPageSize());

        // 接下来的查询会自动按照当前开启的分页设置来查询
        List<User> list = userMapper.search(params);
        return PageInfo.of(list);
    }

    public void add(User user) {

        //用户名不能为空
        if (user.getName() == null || "".equals(user.getName())) {
            throw new CustomException("用户名不能为空");
        }
        // 进行重复性判断，用户名不允许重复
        // 1. 根据用户名查询
        User db_user = userMapper.selectByName(user.getName());
        if (db_user != null) {
            throw new CustomException("用户名已存在，请勿重复添加");
        }

        if (user.getPassword() == null) {
            user.setPassword("123456");
        }
        userMapper.insertSelective(user);
    }

    public void update(User user) {
        user.setUpdatetime(new Date());
        userMapper.updateByPrimaryKeySelective(user);
    }

    public void delete(Integer id) {
        userMapper.deleteByPrimaryKey(id);
    }

    public User login(User user) {
        // 进行非空判断
        if (user.getName() == null || "".equals(user.getName())) {
            throw new CustomException("用户名不能为空");
        }
        // 查询数据库
        User db_user = userMapper.selectByNameAndPassword(user.getName(), user.getPassword());
        if (db_user == null) {
            throw new CustomException("用户名或密码错误");
        }
        // 返回数据库查到的该行数据
        // 生成jwt token给前端
        String token = JwtTokenUtils.genToken(db_user.getId().toString(), db_user.getPassword());
        db_user.setToken(token);
        return db_user;
    }

    public User selectById(Integer id) {
        return userMapper.selectByPrimaryKey(id);
    }
}
