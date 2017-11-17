/*
Navicat MySQL Data Transfer

Source Server         : sglm
Source Server Version : 50634
Source Host           : rm-bp195qct86bpp011c.mysql.rds.aliyuncs.com:3306
Source Database       : db_sglm

Target Server Type    : MYSQL
Target Server Version : 50634
File Encoding         : 65001

Date: 2017-11-17 13:40:49
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `tb_chatlog`
-- ----------------------------
DROP TABLE IF EXISTS `tb_chatlog`;
CREATE TABLE `tb_chatlog` (
  `chatlogIdx` bigint(30) NOT NULL AUTO_INCREMENT,
  `from` int(20) NOT NULL DEFAULT '0',
  `to` int(20) NOT NULL DEFAULT '0',
  `content` varchar(1024) DEFAULT NULL,
  `sendTime` char(13) DEFAULT NULL,
  `type` enum('chatroom','friend','group') DEFAULT 'friend',
  `status` tinyint(1) DEFAULT '1' COMMENT '1 可以正常访问 2禁止访问',
  PRIMARY KEY (`chatlogIdx`,`from`,`to`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of tb_chatlog
-- ----------------------------
