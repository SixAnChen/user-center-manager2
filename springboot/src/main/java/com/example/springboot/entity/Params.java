package com.example.springboot.entity;

import lombok.Data;

/**
 * 功能：
 * 作者：SixAn
 * 日期：2023-09-17 17:08
 */
@Data
public class Params {
    private String name;
    private String address;
    private String author;
    private String description;
    private String role;
    private Integer userId;
    private String username;
    private Integer pageNum;
    private Integer pageSize;
}
