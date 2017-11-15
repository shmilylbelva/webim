/*
Navicat MySQL Data Transfer

Source Server         : 本地
Source Server Version : 50553
Source Host           : localhost:3306
Source Database       : chat

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2017-11-14 17:02:18
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `tb_msg`
-- ----------------------------
DROP TABLE IF EXISTS `tb_msg`;
CREATE TABLE `tb_msg` (
  `msgIdx` int(20) NOT NULL AUTO_INCREMENT,
  `msgType` tinyint(1) DEFAULT '1' COMMENT '1为请求添加用户2为系统消息（添加好友）3为请求加群 4为系统消息（添加群） 5 全体会员消息',
  `from` int(20) DEFAULT NULL COMMENT '消息发送者 0表示为系统消息',
  `to` int(20) DEFAULT NULL COMMENT '消息接收者 0表示全体会员',
  `status` tinyint(4) DEFAULT '1' COMMENT '1未读 2同意 3拒绝 4同意且返回消息已读 5拒绝且返回消息已读 6全体消息已读',
  `remark` varchar(128) DEFAULT NULL COMMENT '附加消息',
  `sendTime` char(10) DEFAULT NULL COMMENT '发送消息时间',
  `readTime` char(10) DEFAULT NULL COMMENT '读消息时间',
  PRIMARY KEY (`msgIdx`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_msg
-- ----------------------------
INSERT INTO `tb_msg` VALUES ('1', '1', '911117', '1570855', '1', '你好！能做个朋友吗', '1510647891', null);
INSERT INTO `tb_msg` VALUES ('2', '1', '911117', '911088', '1', '很高兴认识你', '1510677891', null);
INSERT INTO `tb_msg` VALUES ('3', '2', '911117', '1570845', '2', '很高兴认识你', '1510677891', '1510679891');
INSERT INTO `tb_msg` VALUES ('4', '2', '911117', '911100', '3', '很高兴认识你', '1510677791', '1510689891');

-- ----------------------------
-- Table structure for `tb_person`
-- ----------------------------
DROP TABLE IF EXISTS `tb_person`;
CREATE TABLE `tb_person` (
  `memberIdx` bigint(20) NOT NULL AUTO_INCREMENT,
  `memberName` varchar(200) NOT NULL,
  `memberAge` int(11) NOT NULL,
  `memberSex` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0保密 1男 2女',
  `memberStatus` tinyint(1) NOT NULL,
  `signature` varchar(500) NOT NULL DEFAULT '',
  `emailAddress` varchar(200) NOT NULL DEFAULT '',
  `phoneNumber` varchar(200) NOT NULL,
  `memberPWD` varchar(200) NOT NULL,
  `userToken` varchar(200) NOT NULL DEFAULT '',
  `oauth_token` varchar(200) NOT NULL,
  PRIMARY KEY (`memberIdx`)
) ENGINE=InnoDB AUTO_INCREMENT=1570856 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of tb_person
-- ----------------------------
INSERT INTO `tb_person` VALUES ('910992', '清风', '23', '1', '0', '星光灿烂', '', '', 'c286dc5c0b2f4707d9ba5c7ea8a021d7', 'egsudUhV$oJP', '');
INSERT INTO `tb_person` VALUES ('911058', '实力派', '30', '1', '0', '善 是一个美好', '', '', 'c286dc5c0b2f4707d9ba5c7ea8a021d7', 'egsudUhV$oJP', '');
INSERT INTO `tb_person` VALUES ('911067', '爱咋咋地', '18', '0', '0', '一个优秀的人', '', '', 'c286dc5c0b2f4707d9ba5c7ea8a021d7', 'egsudUhV$oJP', '');
INSERT INTO `tb_person` VALUES ('911085', '清晨', '48', '2', '0', '你不进步就在后退，不做温水里的癞疙宝', '', '', 'c286dc5c0b2f4707d9ba5c7ea8a021d7', 'egsudUhV$oJP', '');
INSERT INTO `tb_person` VALUES ('911088', '豆浆', '25', '0', '0', '本人是一个开朗的人', '', '', 'c286dc5c0b2f4707d9ba5c7ea8a021d7', 'egsudUhV$oJP', 'f844d7a6d5bf136c21d7bb5319fe4dd4');
INSERT INTO `tb_person` VALUES ('911100', '等待', '19', '2', '0', '陪伴是最长情的告白', '', '', 'c286dc5c0b2f4707d9ba5c7ea8a021d7', 'egsudUhV$oJP', '');
INSERT INTO `tb_person` VALUES ('911117', '美的不要不要的', '21', '2', '0', 'The world makes way for the man who knows where he is going.', '102@qq.com', '', 'c286dc5c0b2f4707d9ba5c7ea8a021d7', 'egsudUhV$oJP', '69ebdafcd94ee5b72b8a4044950b8bd5');
INSERT INTO `tb_person` VALUES ('1570845', '花海', '20', '1', '0', '我就不写签名< (ˉ^ˉ)>', '', '15708440000', 'c286dc5c0b2f4707d9ba5c7ea8a021d7', 'egsudUhV$oJP', '513a290382a0f562e9b98f49a64f704a');
INSERT INTO `tb_person` VALUES ('1570855', '回眸淡然笑', '20', '2', '0', '有钱的自由，没钱的幻想！', '', '18381334800', 'c286dc5c0b2f4707d9ba5c7ea8a021d7', 'egsudUhV$oJP', 'b6eee48de455892f8eef3cbc5117dc2d');

-- ----------------------------
-- Table structure for `tb_skin`
-- ----------------------------
DROP TABLE IF EXISTS `tb_skin`;
CREATE TABLE `tb_skin` (
  `skinIdx` int(20) NOT NULL AUTO_INCREMENT,
  `memberIdx` int(20) DEFAULT NULL,
  `url` varchar(32) DEFAULT NULL,
  `isUserUpload` tinyint(1) DEFAULT '0' COMMENT '1 用户自定义皮肤 0默认',
  PRIMARY KEY (`skinIdx`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of tb_skin
-- ----------------------------
INSERT INTO `tb_skin` VALUES ('4', '911117', '911117_1510293501.jpg', '1');
INSERT INTO `tb_skin` VALUES ('5', '1570855', '2.jpg', '0');
