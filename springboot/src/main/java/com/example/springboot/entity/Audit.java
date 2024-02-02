package com.example.springboot.entity;

import lombok.Data;

import javax.persistence.*;

/**
 * 功能：
 * 作者：SixAn
 * 日期：2023-09-18 16:35
 */
@Data
@Table(name = "audit")
public class Audit {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "name")
    private String name;
    @Column(name = "time")
    private String time;
    @Column(name = "day")
    private String day;
    @Column(name = "userId")
    private Integer userId;
    @Column(name = "status")
    private String status;
    @Column(name = "reason")
    private String reason;

    @Transient
    private String userName;
}
