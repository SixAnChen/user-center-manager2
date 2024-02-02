package com.example.springboot.entity;

import lombok.Data;

import javax.persistence.*;

/**
 * 功能：
 * 作者：SixAn
 * 日期：2023-09-18 20:29
 */

@Table(name = "hotel")
@Data
public class Hotel {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "name")
    private String name;
    @Column(name = "price")
    private String price;
    @Column(name = "img")
    private String img;
    @Column(name = "num")
    private Integer num;
}
