package com.example.springboot.mapper;


import com.example.springboot.entity.Log;
import com.example.springboot.entity.Params;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

@Repository
public interface LogMapper extends Mapper<Log> {

    List<Log> findBySearch(@Param("params") Params params);
}