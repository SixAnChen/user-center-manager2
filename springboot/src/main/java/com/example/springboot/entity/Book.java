package com.example.springboot.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import javax.persistence.*;
import java.util.Date;

/**
 * 功能：
 * 作者：SixAn
 * 日期：2023-09-18 08:33
 */
@Table(name = "book")
@Data
public class Book {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "name")
    private String name;
    @Column(name = "price")
    private String price;
    @Column(name = "author")
    private String author;
    @Column(name = "press")
    private String press;
    @Column(name = "img")
    private String img;
    @Column(name = "typeId")
    private Integer typeId;
    @Transient
    private String typeName;
    @Column(name = "createtime")
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date createtime;
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    @Column(name = "updatetime")
    private Date updatetime;
}
