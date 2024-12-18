package com.example.springboot.mapper;

import com.example.springboot.entity.Book;
import com.example.springboot.entity.Params;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;


@Repository
public interface BookMapper extends Mapper<Book> {

    List<Book> findBySearch(@Param("params") Params params);

    List<Book> findAll();
}

