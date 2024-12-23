package com.example.springboot.mapper;

import com.example.springboot.entity.Hotel;
import com.example.springboot.entity.Params;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

@Repository
public interface HotelMapper extends Mapper<Hotel> {

    List<Hotel> findBySearch(@Param("params") Params params);
}
