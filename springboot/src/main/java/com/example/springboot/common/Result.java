package com.example.springboot.common;

import lombok.Data;

/**
 * 功能：封装统一返回结果
 * 作者：SixAn
 * 日期：2023-09-17 16:49
 */
@Data
public class Result {

    private static final String SUCCESS = "200";
    private static final String ERROR = "-1";

    private String code;
    private String msg;
    private Object data;

    public static Result success() {
        Result result = new Result();
        result.setCode(SUCCESS);
        return result;
    }

    public static Result success(Object data) {
        Result result = new Result();
        result.setCode(SUCCESS);
        result.setData(data);
        return result;
    }

    public static Result error(String msg) {
        Result result = new Result();
        result.setCode(ERROR);
        result.setMsg(msg);
        return result;
    }
}
