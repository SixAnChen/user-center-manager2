package com.example.springboot.service;

import com.example.springboot.entity.Book;
import com.example.springboot.entity.Params;
import com.example.springboot.mapper.BookMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

/**
 * 功能：
 * 作者：SixAn
 * 日期：2023-09-18 08:36
 */

@Service
public class BookService {
    @Resource
    private BookMapper bookMapper;


    public PageInfo<Book> findBySearch(Params params) {
        // 开启分页查询
        PageHelper.startPage(params.getPageNum(), params.getPageSize());
        // 接下来的查询会自动按照当前开启的分页设置来查询
        List<Book> list = bookMapper.findBySearch(params);

        return PageInfo.of(list);
    }

    public void add(Book book) {
        bookMapper.insertSelective(book);
    }

    public void update(Book book) {
        book.setUpdatetime(new Date());
        bookMapper.updateByPrimaryKeySelective(book);
    }

    public void delete(Integer id) {
        bookMapper.deleteByPrimaryKey(id);
    }

    public List<Book> findAll() {
       return bookMapper.findAll();
    }
}
