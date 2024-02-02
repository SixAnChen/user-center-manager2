package com.example.springboot.controller;

import com.example.springboot.common.CaptureConfig;
import com.example.springboot.common.Result;
import com.example.springboot.entity.Params;
import com.example.springboot.entity.User;
import com.example.springboot.service.UserService;
import com.github.pagehelper.PageInfo;
import com.wf.captcha.utils.CaptchaUtil;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * 功能：
 * 作者：SixAn
 * 日期：2023-09-17 16:19
 */

@RestController
@RequestMapping("/user")
@CrossOrigin
public class UserController {
    @Resource
    private UserService userService;


    @GetMapping("/list")
    public Result list() {
        return Result.success(userService.list());
    }


    @GetMapping("/search")
    public Result search(Params params) {
        PageInfo<User> info = userService.search(params);
        return Result.success(info);
    }


    @PostMapping
    public Result save(@RequestBody User user) {
        if (user.getId() == null) {
            userService.add(user);
        } else {
            userService.update(user);
        }
        return Result.success();
    }

    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Integer id) {
        userService.delete(id);
        return Result.success();
    }

    @PostMapping("/login")
    public Result login(@RequestBody User user, @RequestParam String key, HttpServletRequest request) {
        // 判读验证码是否正确
        if (!user.getVerCode().toLowerCase().equals(CaptureConfig.CAPTURE_MAP.get(key))) {
            // 如果不相等，说明验证不通过
            CaptchaUtil.clear(request);
            return Result.error("验证码不正确");
        }
        CaptureConfig.CAPTURE_MAP.remove(key);
        return Result.success(userService.login(user));
    }
}
