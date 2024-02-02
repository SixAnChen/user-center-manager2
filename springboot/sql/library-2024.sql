/*
 Navicat Premium Data Transfer

 Source Server         : MySQL - @localhost
 Source Server Type    : MySQL
 Source Server Version : 50731
 Source Host           : localhost:3306
 Source Schema         : library-2024

 Target Server Type    : MySQL
 Target Server Version : 50731
 File Encoding         : 65001

 Date: 02/02/2024 09:17:43
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for audit
-- ----------------------------
DROP TABLE IF EXISTS `audit`;
CREATE TABLE `audit`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '请假缘由',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '请假日期',
  `day` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '请假天数',
  `userId` int(11) NULL DEFAULT NULL COMMENT '请假用户ID',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '审核状态',
  `reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '审核意见',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '请假审核表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of audit
-- ----------------------------
INSERT INTO `audit` VALUES (1, '结婚', '2023-09-28', '20', 193, '审核通过', '同意');
INSERT INTO `audit` VALUES (2, '剪头发', '2023-09-19', '1', 195, '审核不通过', '不允许');
INSERT INTO `audit` VALUES (3, 'hahah', '2023-09-20', '12', 193, '审核不通过', '不行');

-- ----------------------------
-- Table structure for book
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '图书名称',
  `price` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '图书价格',
  `author` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '图书作者',
  `press` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '图书出版社',
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '图书封面',
  `createtime` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updatetime` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `typeId` int(10) NULL DEFAULT NULL COMMENT '图书分类ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of book
-- ----------------------------
INSERT INTO `book` VALUES (2, 'Java', '23', 'xixi', '清华出版社', '1695005662304', '2023-09-18 00:00:00', '2023-09-18 15:21:28', 12);
INSERT INTO `book` VALUES (3, 'Java', '23', 'xiaowang', '清华出版社', '1695015596035', '2023-09-18 00:00:00', '2023-09-18 15:21:43', 12);
INSERT INTO `book` VALUES (4, 'Java', '23', 'xiaowang', '清华出版社', '1695005672107', '2023-09-18 00:00:00', '2023-09-18 15:30:28', 11);
INSERT INTO `book` VALUES (5, 'Java', '23', 'xiaowang', '清华出版社', '1695015249203', '2023-09-18 00:00:00', '2023-09-18 15:21:37', 10);
INSERT INTO `book` VALUES (6, 'Java', '23', 'xiaowang', '清华出版社', '1695024335860', '2023-09-18 00:00:00', '2023-09-18 16:05:37', 10);
INSERT INTO `book` VALUES (7, 'Java', '23', 'xiaowang', '清华出版社', '1695015608392', '2023-09-18 00:00:00', '2023-09-18 15:21:49', 10);
INSERT INTO `book` VALUES (8, 'Java', '23', 'xiaowang', '清华出版社', '1695015651719', '2023-09-18 00:00:00', '2023-09-18 15:21:45', 13);
INSERT INTO `book` VALUES (9, 'Java', '23', 'xiaowang', '清华出版社', '1695015658414', '2023-09-18 00:00:00', '2023-09-18 15:20:57', 11);
INSERT INTO `book` VALUES (10, 'Java', '23', 'xiaowang', '清华出版社', '1695015794727', '2023-09-18 00:00:00', '2023-09-18 15:20:23', 13);
INSERT INTO `book` VALUES (11, 'Java面向对象编程', '23', 'xiaowang', '清华出版社', '1695005654141', '2023-09-18 00:00:00', '2023-09-18 15:21:31', 12);
INSERT INTO `book` VALUES (12, 'Java', '23', 'xiaowang', '清华出版社', '1695015783709', '2023-09-18 00:00:00', '2023-09-18 15:20:26', 10);
INSERT INTO `book` VALUES (13, 'Java', '23', 'xiaowang', '清华出版社', '1695024329183', '2023-09-18 00:00:00', '2023-09-18 20:27:42', 11);
INSERT INTO `book` VALUES (14, 'Java', '23', 'xiaowang', '清华出版社', '1695024320997', '2023-09-18 00:00:00', '2023-09-18 16:05:22', 12);
INSERT INTO `book` VALUES (15, 'Java', '23', 'xiaowang', '清华出版社', '1695015816629', '2023-09-18 00:00:00', '2023-09-18 15:19:27', 12);
INSERT INTO `book` VALUES (16, 'Java', '23', 'xiaowang', '清华出版社', '1695015673066', '2023-09-18 00:00:00', '2023-09-18 15:20:48', 12);
INSERT INTO `book` VALUES (17, 'Java', '23', 'xiaowang', '清华出版社', '1695015808440', '2023-09-18 00:00:00', '2023-09-18 15:20:20', 12);
INSERT INTO `book` VALUES (18, 'Java', '23', 'xiaowang', '清华出版社', '1695015688115', '2023-09-18 00:00:00', '2023-09-18 15:20:36', 13);
INSERT INTO `book` VALUES (19, 'Java', '23', 'xiaowang', '清华出版社', '1695015678200', '2023-09-18 00:00:00', '2023-09-18 15:20:43', 10);
INSERT INTO `book` VALUES (20, 'Java', '23', 'xiaowang', '清华出版社', '1695015683206', '2023-09-18 00:00:00', '2023-09-18 15:20:40', 12);
INSERT INTO `book` VALUES (22, '12', '23', '哈哈哈', 'A出版社', '1695015769203', '2023-09-18 00:00:00', '2023-09-18 15:20:30', 12);
INSERT INTO `book` VALUES (23, '哈哈哈', '42', 'six', 'B出版社', '1695001141434', '2023-09-18 00:00:00', '2023-09-18 15:21:34', 12);
INSERT INTO `book` VALUES (24, '哈喽', '23', '222222', '出版社2', '1695015696387', '2023-09-18 00:00:00', '2023-09-18 15:20:33', 11);
INSERT INTO `book` VALUES (25, '哈利波特', '21', '哈利', '出版社A', '1695088611276', '2023-09-19 09:57:07', NULL, 10);
INSERT INTO `book` VALUES (26, '名侦探柯南', '222', '哈哈哈哈', '1111', '1695114822323', '2023-09-19 17:14:02', NULL, 27);

-- ----------------------------
-- Table structure for hotel
-- ----------------------------
DROP TABLE IF EXISTS `hotel`;
CREATE TABLE `hotel`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '酒店名称',
  `price` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '入住价格',
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '酒店图片',
  `num` int(10) NULL DEFAULT NULL COMMENT '剩余间数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '酒店信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hotel
-- ----------------------------
INSERT INTO `hotel` VALUES (9, '小白酒店', '200', '1695044097120', 18);
INSERT INTO `hotel` VALUES (10, '哈利酒店', '212', '1695044330397', 8);
INSERT INTO `hotel` VALUES (11, '小白酒店', '122', '1695044354690', 0);
INSERT INTO `hotel` VALUES (12, '花花酒店', '111', '1695044419728', 4);

-- ----------------------------
-- Table structure for log
-- ----------------------------
DROP TABLE IF EXISTS `log`;
CREATE TABLE `log`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '操作内容',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '操作时间',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '操作人',
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '操作人IP',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 71 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '操作日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of log
-- ----------------------------
INSERT INTO `log` VALUES (54, '分页查询图书信息', '2023-09-19 10:12:40', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (55, '分页查询图书信息', '2023-09-19 10:12:45', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (56, '更新日志操作', '2023-09-19 14:31:28', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (57, '更新日志操作', '2023-09-19 14:34:41', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (58, '更新日志操作', '2023-09-19 14:35:32', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (59, '更新日志操作', '2023-09-19 14:35:43', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (60, '更新日志操作', '2023-09-19 15:01:26', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (61, '分页查询图书信息', '2023-09-19 16:23:51', 'student', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (62, '分页查询图书信息', '2023-09-19 17:10:02', 'student', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (63, '分页查询图书信息', '2023-09-19 17:13:32', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (64, '修改图书信息', '2023-09-19 17:14:02', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (65, '分页查询图书信息', '2023-09-19 17:14:02', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (66, '分页查询图书信息', '2023-09-19 22:15:35', 'student', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (67, '分页查询图书信息', '2023-09-20 08:41:16', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (68, '分页查询图书信息', '2023-09-20 08:41:23', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (69, '分页查询图书信息', '2023-09-20 08:41:34', 'admin', '0:0:0:0:0:0:0:1');
INSERT INTO `log` VALUES (70, '分页查询图书信息', '2023-09-20 08:41:59', 'admin', '0:0:0:0:0:0:0:1');

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '公告标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '公告内容',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '公告时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 51 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '系统公告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of notice
-- ----------------------------
INSERT INTO `notice` VALUES (47, '第一条公告', '测试', '2023-09-19 14:34:41');
INSERT INTO `notice` VALUES (48, '公告测试2222', '哈哈哈哈哈哈哈哈哈哈哈哈哈或或或或', '2023-09-19 14:35:32');
INSERT INTO `notice` VALUES (49, '你好吗', 'Hello World', '2023-09-19 14:35:43');
INSERT INTO `notice` VALUES (50, '特殊公告', '1234', '2023-09-19 15:01:26');

-- ----------------------------
-- Table structure for reserve
-- ----------------------------
DROP TABLE IF EXISTS `reserve`;
CREATE TABLE `reserve`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `hotelId` int(10) NULL DEFAULT NULL COMMENT '酒店ID',
  `userId` int(10) NULL DEFAULT NULL COMMENT '用户ID',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '预订时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '预订信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reserve
-- ----------------------------
INSERT INTO `reserve` VALUES (19, 9, 193, '2023-09-18 21:49:12');
INSERT INTO `reserve` VALUES (20, 10, 193, '2023-09-18 21:49:25');
INSERT INTO `reserve` VALUES (21, 11, 193, '2023-09-19 09:22:01');
INSERT INTO `reserve` VALUES (22, 12, 193, '2023-09-19 09:22:02');
INSERT INTO `reserve` VALUES (23, 10, 193, '2023-09-19 09:22:03');
INSERT INTO `reserve` VALUES (24, 9, 193, '2023-09-19 09:22:03');

-- ----------------------------
-- Table structure for type
-- ----------------------------
DROP TABLE IF EXISTS `type`;
CREATE TABLE `type`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '分类名称',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '分类介绍',
  `createtime` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updatetime` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '图书分类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of type
-- ----------------------------
INSERT INTO `type` VALUES (10, '航海日志', '关于航海员的生活日志', '2023-09-18 10:45:11', NULL);
INSERT INTO `type` VALUES (11, '人文历史', '123', '2023-09-18 10:51:11', NULL);
INSERT INTO `type` VALUES (12, '侦探类', '名侦探柯南', '2023-09-18 10:51:43', NULL);
INSERT INTO `type` VALUES (13, '草莓派', '草莓派的制作过程', '2023-09-18 10:58:27', NULL);
INSERT INTO `type` VALUES (27, '漫画书', '漫画、航海王、。。。。', '2023-09-19 17:13:29', NULL);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '姓名',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户名',
  `age` int(11) NULL DEFAULT NULL COMMENT '年龄',
  `sex` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '性别',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '电话',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '地址',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '123456' COMMENT '密码',
  `createtime` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updatetime` datetime NULL DEFAULT NULL COMMENT '修改时间',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户头像',
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '普通用户' COMMENT '角色',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 196 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (32, 'admin21', '', 21, '男', '123', '123', '安徽合肥', '9e0cf4a488c41ec2fb02b3c09ef07739', '2023-09-05 14:46:48', '2023-09-17 11:20:44', '1694131659071', '管理员');
INSERT INTO `user` VALUES (177, '用户1', '', 21, '男', NULL, NULL, '安徽合肥', '9e0cf4a488c41ec2fb02b3c09ef07739', '2023-09-08 00:00:00', '2023-09-18 16:05:59', '1694131598056', '教师');
INSERT INTO `user` VALUES (178, '用户2', '', 21, '男', '999999', '999999', '湖南长沙', '9e0cf4a488c41ec2fb02b3c09ef07739', '2023-09-08 00:00:00', '2023-09-18 15:52:55', '1694114963169', '普通用户');
INSERT INTO `user` VALUES (179, '用户3', '', 21, '男', '123456', '123456', '安徽合肥', '9e0cf4a488c41ec2fb02b3c09ef07739', '2023-09-08 03:35:56', '2023-09-08 08:06:12', '1694131571218', '普通用户');
INSERT INTO `user` VALUES (180, 'admin2', '', 21, '男', NULL, NULL, '湖南长沙', '9e0cf4a488c41ec2fb02b3c09ef07739', '2023-09-08 00:00:00', '2023-09-18 16:01:46', '1694130966980', '教师');
INSERT INTO `user` VALUES (181, '用户5', '', 21, '女', NULL, NULL, '安徽合肥', '87bfd1dab7ea4e4465270fc09dd37102', '2023-09-08 00:00:00', '2023-09-18 16:10:29', '1694130961272', '学生');
INSERT INTO `user` VALUES (182, '用户6', '', 21, '男', '1', '1', '湖南长沙', '9e0cf4a488c41ec2fb02b3c09ef07739', '2023-09-17 00:00:00', '2023-09-18 16:10:32', '1694920875643', '学生');
INSERT INTO `user` VALUES (183, '用户7', NULL, 21, '男', NULL, NULL, '湖南长沙', '123456', '2023-09-17 17:45:10', NULL, NULL, '普通用户');
INSERT INTO `user` VALUES (184, '用户8', NULL, 21, '女', NULL, NULL, '安徽合肥', '123456', '2023-09-17 00:00:00', '2023-09-18 15:58:56', NULL, '管理员');
INSERT INTO `user` VALUES (185, '用户9', NULL, 21, '男', NULL, NULL, '湖南长沙', '123456', '2023-09-17 00:00:00', '2023-09-18 16:05:53', NULL, '教师');
INSERT INTO `user` VALUES (186, '用户10', NULL, 21, '男', NULL, NULL, '湖南长沙', '123456', '2023-09-17 17:45:16', NULL, NULL, '普通用户');
INSERT INTO `user` VALUES (187, '用户11', NULL, 21, '男', NULL, NULL, '安徽合肥', '123456', '2023-09-17 00:00:00', '2023-09-18 15:58:51', NULL, '管理员');
INSERT INTO `user` VALUES (188, 'teacher', NULL, 21, '女', NULL, NULL, '湖南长沙', '123456', '2023-09-17 00:00:00', '2023-09-18 16:05:56', NULL, '教师');
INSERT INTO `user` VALUES (189, 'admin', NULL, 21, '男', NULL, NULL, '湖南长沙', '123456', '2023-09-17 00:00:00', '2023-09-18 07:20:10', NULL, '管理员');
INSERT INTO `user` VALUES (192, 'test', NULL, NULL, '女', NULL, NULL, '四川成都', '123456', '2023-09-17 00:00:00', '2023-09-20 08:52:28', '1695171147445', '学生');
INSERT INTO `user` VALUES (193, 'student', NULL, NULL, '女', NULL, NULL, '云南', '123456', '2023-09-18 00:00:00', '2023-09-20 08:52:22', '1695171141084', '学生');
INSERT INTO `user` VALUES (195, '李四', NULL, NULL, '男', NULL, NULL, '12345', '123456', '2023-09-18 00:00:00', '2023-09-20 08:52:15', '1695171134026', '学生');

SET FOREIGN_KEY_CHECKS = 1;
