/*
Navicat MySQL Data Transfer

Source Server         : sglm
Source Server Version : 50634
Source Host           : rm-bp195qct86bpp011c.mysql.rds.aliyuncs.com:3306
Source Database       : db_sglm

Target Server Type    : MYSQL
Target Server Version : 50634
File Encoding         : 65001

Date: 2017-11-10 11:05:01
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `tb_person`
-- ----------------------------
DROP TABLE IF EXISTS `tb_person`;
CREATE TABLE `tb_person` (
  `memberIdx` bigint(20) NOT NULL AUTO_INCREMENT,
  `memberName` varchar(200) NOT NULL,
  `memberAge` int(11) NOT NULL,
  `memberSex` tinyint(4) NOT NULL,
  `memberStatus` tinyint(4) NOT NULL,
  `signature` varchar(500) NOT NULL DEFAULT '',
  `emailAddress` varchar(200) NOT NULL DEFAULT '',
  `phoneNumber` varchar(200) NOT NULL,
  `memberPWD` varchar(200) NOT NULL,
  `userToken` varchar(200) NOT NULL DEFAULT '',
  `oauth_token` varchar(200) NOT NULL,
  PRIMARY KEY (`memberIdx`)
) ENGINE=InnoDB AUTO_INCREMENT=1570862 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of tb_person
-- ----------------------------
INSERT INTO `tb_person` VALUES ('910992', '清风', '0', '0', '0', '星光灿烂', '', '', 'c286dc5c0b2f4707d9ba5c7ea8a021d7', 'egsudUhV$oJP', '');
INSERT INTO `tb_person` VALUES ('911058', '实力派', '0', '0', '0', '善 是一个美好', '', '', 'c286dc5c0b2f4707d9ba5c7ea8a021d7', 'egsudUhV$oJP', '');
INSERT INTO `tb_person` VALUES ('911067', '爱咋咋地', '0', '0', '0', '一个优秀的人', '', '', 'c286dc5c0b2f4707d9ba5c7ea8a021d7', 'egsudUhV$oJP', '');
INSERT INTO `tb_person` VALUES ('911085', '清晨', '0', '0', '0', '你不进步就在后退，不做温水里的癞疙宝', '', '', 'c286dc5c0b2f4707d9ba5c7ea8a021d7', 'egsudUhV$oJP', '');
INSERT INTO `tb_person` VALUES ('911088', '豆浆', '0', '0', '0', '本人是一个开朗的人', '', '', 'c286dc5c0b2f4707d9ba5c7ea8a021d7', 'egsudUhV$oJP', 'f844d7a6d5bf136c21d7bb5319fe4dd4');
INSERT INTO `tb_person` VALUES ('911100', '等待', '0', '0', '0', '陪伴是最长情的告白', '', '', 'c286dc5c0b2f4707d9ba5c7ea8a021d7', 'egsudUhV$oJP', '');
INSERT INTO `tb_person` VALUES ('911117', '美的不要不要的', '0', '0', '0', 'The world makes way for the man who knows where he is going.', '102@qq.com', '', 'c286dc5c0b2f4707d9ba5c7ea8a021d7', 'egsudUhV$oJP', '69ebdafcd94ee5b72b8a4044950b8bd5');
INSERT INTO `tb_person` VALUES ('1570845', '花海', '0', '0', '0', '我就不写签名< (ˉ^ˉ)>', '', '15708440000', 'c286dc5c0b2f4707d9ba5c7ea8a021d7', 'egsudUhV$oJP', '513a290382a0f562e9b98f49a64f704a');
INSERT INTO `tb_person` VALUES ('1570855', '回眸淡然笑', '0', '0', '0', '有钱的自由，没钱的幻想！', '', '18381334800', 'c286dc5c0b2f4707d9ba5c7ea8a021d7', 'egsudUhV$oJP', 'b6eee48de455892f8eef3cbc5117dc2d');

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
INSERT INTO `tb_skin` VALUES ('4', '911117', '911117_1510202564.png', '1');
INSERT INTO `tb_skin` VALUES ('5', '1570855', '2.jpg', '0');
