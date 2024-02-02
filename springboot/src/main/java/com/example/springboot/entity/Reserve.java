package com.example.springboot.entity;

import lombok.Data;

import javax.persistence.*;

/**
 * 功能：
 * 作者：SixAn
 * 日期：2023-09-18 20:30
 */

@Table(name = "reserve")
@Data
public class Reserve {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "hotelId")
    private Integer hotelId;
    @Column(name = "userId")
    private Integer userId;
    @Column(name = "time")
    private String time;
    @Transient
    private String hotelName;
    @Transient
    private String userName;
}
