package com.example.springboot.service;

import cn.hutool.core.collection.CollectionUtil;
import com.example.springboot.entity.Hotel;
import com.example.springboot.entity.Params;
import com.example.springboot.mapper.HotelMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;


@Service
public class HotelService {

    @Resource
    private HotelMapper hotelMapper;


    public PageInfo<Hotel> findBySearch(Params params) {
        // 开启分页查询
        PageHelper.startPage(params.getPageNum(), params.getPageSize());
        // 接下来的查询会自动按照当前开启的分页设置来查询
        List<Hotel> list = hotelMapper.findBySearch(params);
        if (CollectionUtil.isEmpty(list)) {
            return PageInfo.of(new ArrayList<>());
        }
        return PageInfo.of(list);
    }

    public void add(Hotel hotel) {
        hotelMapper.insertSelective(hotel);
    }

    public void update(Hotel hotel) {
        hotelMapper.updateByPrimaryKeySelective(hotel);
    }

    public void delete(Integer id) {
        hotelMapper.deleteByPrimaryKey(id);
    }
}
