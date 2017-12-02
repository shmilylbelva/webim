/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50710
Source Host           : localhost:3306
Source Database       : chat

Target Server Type    : MYSQL
Target Server Version : 50710
File Encoding         : 65001

Date: 2017-12-03 00:03:53
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `tb_admin`
-- ----------------------------
DROP TABLE IF EXISTS `tb_admin`;
CREATE TABLE `tb_admin` (
  `adminIdx` int(10) NOT NULL AUTO_INCREMENT,
  `memberIdx` int(10) NOT NULL,
  `groupIdx` bigint(30) NOT NULL,
  `type` tinyint(1) DEFAULT '1' COMMENT '1管理员 2所有者',
  PRIMARY KEY (`adminIdx`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_admin
-- ----------------------------
INSERT INTO `tb_admin` VALUES ('1', '1570845', '34331010596865', '2');

-- ----------------------------
-- Table structure for `tb_chatlog`
-- ----------------------------
DROP TABLE IF EXISTS `tb_chatlog`;
CREATE TABLE `tb_chatlog` (
  `chatlogIdx` bigint(30) NOT NULL AUTO_INCREMENT,
  `from` bigint(20) NOT NULL DEFAULT '0',
  `to` bigint(20) NOT NULL DEFAULT '0',
  `content` varchar(1024) DEFAULT NULL,
  `sendTime` char(13) DEFAULT NULL,
  `type` enum('chatroom','friend','group') DEFAULT 'friend',
  `status` tinyint(1) DEFAULT '1' COMMENT '1 可以正常访问 2禁止访问',
  PRIMARY KEY (`chatlogIdx`,`from`,`to`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of tb_chatlog
-- ----------------------------
INSERT INTO `tb_chatlog` VALUES ('53', '911117', '1570855', '12', '1511575687522', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('54', '911117', '1570855', 'hh', '1511575811519', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('55', '911117', '911088', '你这一天都在啊', '1511873478943', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('56', '911117', '911100', '12', '1511875571631', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('57', '911117', '911100', '12', '1511875581333', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('58', '911117', '32403609419777', '12', '1511875705064', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('59', '911117', '32403609419777', '333', '1511875713509', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('60', '911117', '32403609419777', '2', '1511875751646', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('61', '1570855', '32403609419777', '12', '1511875761654', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('62', '911117', '32403609419777', '11', '1511876906604', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('63', '911117', '1570855', '1', '1511876945668', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('64', '911117', '32032104185857', '12', '1511877127051', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('65', '1570855', '32032104185857', '12', '1511877154403', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('66', '911117', '1570855', '1', '1511877172199', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('67', '1570855', '911117', '111', '1511877193023', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('68', '1570855', '911117', '1', '1511877418314', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('69', '911117', '1570855', '12', '1511877431192', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('70', '911117', '32032104185857', '1', '1511877449059', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('71', '1570845', '32403609419777', '1', '1511878584308', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('72', '911117', '32403609419777', '1', '1511878609692', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('73', '911117', '1570855', '22', '1511878617164', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('74', '911117', '32403609419777', '12', '1511878722004', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('75', '911117', '1570855', '1', '1511881452853', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('76', '911117', '1570855', 'zz', '1512135777476', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('77', '911117', '1570855', 'dd', '1512135940494', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('78', '911117', '1570855', 'cc', '1512136016032', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('79', '911117', '1570855', 'xx', '1512136404362', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('80', '911117', '1570855', 'dd', '1512136564459', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('81', '911117', '32403609419777', 'dd', '1512136573671', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('82', '911117', '32403609419777', 'ee', '1512138880024', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('83', '911117', '1570845', '滴滴', '1512197280536', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('84', '911117', '1570855', '？', '1512197776494', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('85', '911117', '1570845', 'c', '1512211708277', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('86', '911117', '34331010596865', '33', '1512230149894', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('87', '911117', '34331010596865', 'fff', '1512230524019', 'group', '1');

-- ----------------------------
-- Table structure for `tb_group`
-- ----------------------------
DROP TABLE IF EXISTS `tb_group`;
CREATE TABLE `tb_group` (
  `groupIdx` bigint(30) NOT NULL COMMENT '群号',
  `groupName` varchar(63) DEFAULT NULL COMMENT '群名称',
  `des` varchar(256) DEFAULT NULL COMMENT '描述',
  `number` int(10) DEFAULT NULL COMMENT '人数',
  PRIMARY KEY (`groupIdx`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_group
-- ----------------------------
INSERT INTO `tb_group` VALUES ('34331010596865', '不扯淡', '点点滴滴', '1000');
INSERT INTO `tb_group` VALUES ('32403609419777', 'layim一群', '2', '1000');
INSERT INTO `tb_group` VALUES ('32403628294145', 'layim二群', '1', '1000');

-- ----------------------------
-- Table structure for `tb_msg`
-- ----------------------------
DROP TABLE IF EXISTS `tb_msg`;
CREATE TABLE `tb_msg` (
  `msgIdx` int(20) NOT NULL AUTO_INCREMENT,
  `msgType` tinyint(1) DEFAULT '1' COMMENT '1为请求添加用户2为系统消息（添加好友）3为请求加群 4为系统消息（添加群） 5 全体会员消息',
  `from` int(20) DEFAULT NULL COMMENT '消息发送者 0表示为系统消息',
  `to` bigint(20) DEFAULT NULL COMMENT '消息接收者 0表示全体会员',
  `status` tinyint(4) DEFAULT '1' COMMENT '1未读 2同意 3拒绝 4同意且返回消息已读 5拒绝且返回消息已读 6全体消息已读',
  `remark` varchar(128) DEFAULT NULL COMMENT '附加消息',
  `sendTime` char(10) DEFAULT NULL COMMENT '发送消息时间',
  `readTime` char(10) DEFAULT NULL COMMENT '读消息时间',
  `time` char(10) DEFAULT NULL,
  `adminGroup` bigint(20) NOT NULL DEFAULT '0' COMMENT '接收消息的管理员',
  `handle` bigint(20) DEFAULT NULL COMMENT '处理该请求的管理员id',
  PRIMARY KEY (`msgIdx`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_msg
-- ----------------------------
INSERT INTO `tb_msg` VALUES ('7', '2', '1570855', '911117', '4', '你好', '1510760568', '1510760575', '1510760575', '0', null);
INSERT INTO `tb_msg` VALUES ('2', '1', '911117', '911088', '1', '很高兴认识你1', '1510677891', null, null, '0', null);
INSERT INTO `tb_msg` VALUES ('3', '2', '911117', '1570845', '4', '？', '1512224909', '1512228739', '1512228739', '0', null);
INSERT INTO `tb_msg` VALUES ('4', '2', '911117', '911100', '5', '很高兴认识你3', '1510677791', '1510689891', null, '0', null);
INSERT INTO `tb_msg` VALUES ('8', '2', '911117', '1570855', '4', '', '1510758910', '1510758915', '1510758915', '0', null);
INSERT INTO `tb_msg` VALUES ('17', '4', '911117', '34331010596865', '4', '232323', '1512230120', '1512230125', '1512230125', '1570845', '1570845');

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
) ENGINE=InnoDB AUTO_INCREMENT=1570869 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of tb_person
-- ----------------------------
INSERT INTO `tb_person` VALUES ('1', '11', '1', '0', '1', '', '', '1', '1', '', '1');
INSERT INTO `tb_person` VALUES ('3', '3', '3', '0', '3', '', '', '3', '3', '', '3');
INSERT INTO `tb_person` VALUES ('12', '1', '1', '0', '1', '', '', '1', '1', '', '1');
INSERT INTO `tb_person` VALUES ('22', '2', '2', '0', '2', '', '', '2', '2', '', '2');
INSERT INTO `tb_person` VALUES ('122', '1', '1', '0', '1', '', '', '1', '1', '', '1');
INSERT INTO `tb_person` VALUES ('910992', '清风', '23', '1', '0', '星光灿烂', '', '', 'c286dc5c0b2f4707d9ba5c7ea8a021d7', 'egsudUhV$oJP', '');
INSERT INTO `tb_person` VALUES ('911058', '实力派', '30', '1', '0', '善 是一个美好', '', '', 'c286dc5c0b2f4707d9ba5c7ea8a021d7', 'egsudUhV$oJP', '');
INSERT INTO `tb_person` VALUES ('911067', '爱咋咋地', '18', '0', '0', '一个优秀的人', '', '', 'c286dc5c0b2f4707d9ba5c7ea8a021d7', 'egsudUhV$oJP', '');
INSERT INTO `tb_person` VALUES ('911085', '清晨', '48', '2', '0', '你不进步就在后退，不做温水里的癞疙宝', '', '', 'c286dc5c0b2f4707d9ba5c7ea8a021d7', 'egsudUhV$oJP', '');
INSERT INTO `tb_person` VALUES ('911088', '豆浆', '25', '0', '0', '本人是一个开朗的人', '', '', 'c286dc5c0b2f4707d9ba5c7ea8a021d7', 'egsudUhV$oJP', 'f844d7a6d5bf136c21d7bb5319fe4dd4');
INSERT INTO `tb_person` VALUES ('911100', '等待', '19', '2', '0', '陪伴是最长情的告白', '', '', 'c286dc5c0b2f4707d9ba5c7ea8a021d7', 'egsudUhV$oJP', '');
INSERT INTO `tb_person` VALUES ('911117', '美的不要不要的', '21', '2', '0', 'The world makes way for the man who knows where he is going.', '102@qq.com', '', 'c286dc5c0b2f4707d9ba5c7ea8a021d7', 'egsudUhV$oJP', '69ebdafcd94ee5b72b8a4044950b8bd5');
INSERT INTO `tb_person` VALUES ('1570845', '花海', '20', '1', '0', '我就不写签名< (ˉ^ˉ)>', '', '15708440000', 'c286dc5c0b2f4707d9ba5c7ea8a021d7', 'egsudUhV$oJP', '513a290382a0f562e9b98f49a64f704a');
INSERT INTO `tb_person` VALUES ('1570855', '回眸淡然笑', '20', '2', '0', '有钱的自由，没钱的幻想！', '', '18381334800', 'c286dc5c0b2f4707d9ba5c7ea8a021d7', 'egsudUhV$oJP', 'b6eee48de455892f8eef3cbc5117dc2d');
INSERT INTO `tb_person` VALUES ('1570868', '圆圆', '40', '0', '0', '各有各的活法', '', '1', 'c286dc5c0b2f4707d9ba5c7ea8a021d7', 'egsudUhV$oJP', '2');

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of tb_skin
-- ----------------------------
INSERT INTO `tb_skin` VALUES ('4', '911117', '3.jpg', '0');
INSERT INTO `tb_skin` VALUES ('5', '1570855', '2.jpg', '0');
INSERT INTO `tb_skin` VALUES ('6', '1570845', '4.jpg', '0');
