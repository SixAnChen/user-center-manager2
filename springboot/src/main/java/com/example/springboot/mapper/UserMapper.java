package com.example.springboot.mapper;

import com.example.springboot.entity.Params;
import com.example.springboot.entity.User;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

@Repository
public interface UserMapper extends Mapper<User> {
    List<User> list();

    List<User> search(@Param("params") Params params);

    @Select("select * from user where name = #{name} limit 1")
    User selectByName(@Param("name") String name);

    @Select("select * from user where name = #{name} and password = #{password} limit 1")
    User selectByNameAndPassword(@Param("name") String name, @Param("password") String password);
}
