package com.example.springboot.controller;

import com.example.springboot.common.Result;
import com.example.springboot.entity.Log;
import com.example.springboot.entity.Params;
import com.example.springboot.service.LogService;
import com.github.pagehelper.PageInfo;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

@CrossOrigin
@RestController
@RequestMapping("/log")
public class LogController {

    @Resource
    private LogService logService;


    @PostMapping
    public Result save(@RequestBody Log log) {
        logService.add(log);
        return Result.success();
    }

    @GetMapping("/search")
    public Result findBySearch(Params params) {
        PageInfo<Log> info = logService.findBySearch(params);
        return Result.success(info);
    }

    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Integer id) {
        logService.delete(id);
        return Result.success();
    }

}