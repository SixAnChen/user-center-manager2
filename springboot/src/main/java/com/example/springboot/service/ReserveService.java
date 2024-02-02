package com.example.springboot.service;

import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.util.ObjectUtil;
import com.example.springboot.entity.Hotel;
import com.example.springboot.entity.Params;
import com.example.springboot.entity.Reserve;
import com.example.springboot.entity.User;
import com.example.springboot.mapper.HotelMapper;
import com.example.springboot.mapper.ReserveMapper;
import com.example.springboot.mapper.UserMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;


@Service
public class ReserveService {

    @Resource
    private ReserveMapper reserveMapper;
    @Resource
    private HotelMapper hotelMapper;
    @Resource
    private UserMapper userMapper;


    public PageInfo<Reserve> findBySearch(Params params) {
        // 开启分页查询
        PageHelper.startPage(params.getPageNum(), params.getPageSize());
        // 接下来的查询会自动按照当前开启的分页设置来查询
        List<Reserve> list = reserveMapper.findBySearch(params);
        if (CollectionUtil.isEmpty(list)) {
            return PageInfo.of(new ArrayList<>());
        }
        for (Reserve reserve : list) {
            if (ObjectUtil.isNotEmpty(reserve.getHotelId())) {
                Hotel hotel = hotelMapper.selectByPrimaryKey(reserve.getHotelId());
                if (ObjectUtil.isNotEmpty(hotel)) {
                    reserve.setHotelName(hotel.getName());
                }
            }
            if (ObjectUtil.isNotEmpty(reserve.getUserId())) {
                User user = userMapper.selectByPrimaryKey(reserve.getUserId());
                if (ObjectUtil.isNotEmpty(user)) {
                    reserve.setUserName(user.getName());
                }
            }
        }
        return PageInfo.of(list);
    }

    public void add(Reserve reserve) {
        reserveMapper.insertSelective(reserve);
    }

    public void update(Reserve reserve) {
        reserveMapper.updateByPrimaryKeySelective(reserve);
    }

    public void delete(Integer id) {
        reserveMapper.deleteByPrimaryKey(id);
    }
}
