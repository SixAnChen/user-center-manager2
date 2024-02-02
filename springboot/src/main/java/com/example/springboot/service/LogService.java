package com.example.springboot.service;

import com.example.springboot.entity.Log;
import com.example.springboot.entity.Params;
import com.example.springboot.mapper.LogMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;


@Service
public class LogService {

    @Resource
    private LogMapper logMapper;


    public void add(Log log) {
        logMapper.insertSelective(log);
    }


    public PageInfo<Log> findBySearch(Params params) {
        // 开启分页查询
        PageHelper.startPage(params.getPageNum(), params.getPageSize());
        // 接下来的查询会自动按照当前开启的分页设置来查询
        List<Log> list = logMapper.findBySearch(params);
        return PageInfo.of(list);
    }

    public void delete(Integer id) {
        logMapper.deleteByPrimaryKey(id);
    }

}