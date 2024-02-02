package com.example.springboot.exception;

/**
 * 功能：
 * 作者：SixAn
 * 日期：2023-09-18 06:45
 */
public class CustomException extends RuntimeException {
    private String msg;

    public CustomException(String msg) {
        this.msg = msg;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }
}
