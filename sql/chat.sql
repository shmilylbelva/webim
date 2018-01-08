/*
Navicat MySQL Data Transfer

Source Server         : 本地
Source Server Version : 50553
Source Host           : localhost:3306
Source Database       : chat

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2018-01-08 14:13:06
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
) ENGINE=InnoDB AUTO_INCREMENT=512 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

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
INSERT INTO `tb_chatlog` VALUES ('88', '911117', '1570845', '柔软', '1512285805471', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('89', '911117', '911117', '柔软', '1512285814205', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('90', '911117', '911117', '2', '1512286001202', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('91', '911117', '34331010596865', '12', '1512287599037', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('92', '911117', '34331010596865', '；', '1512287626476', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('93', '911117', '34331010596865', 'k', '1512287677239', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('94', '1570845', '34331010596865', '测试', '', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('95', '911117', '34331010596865', '12', '1512289102663', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('96', '911117', '34331010596865', 'l', '1512289156466', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('97', '911117', '34331010596865', '学习', '1512289299543', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('98', '911117', '34331010596865', '是是是', '1512289460817', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('99', '911117', '34331010596865', '方法', '1512289580873', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('100', '911117', '34331010596865', '成都', '1512289726888', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('101', '911117', '34331010596865', '滴滴滴', '1512289754688', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('102', '911117', '34331010596865', '吃饭VC', '1512289882684', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('103', '911117', '34331010596865', '方法', '1512289895093', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('104', '911117', '34331010596865', '飞', '1512290077637', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('105', '911117', '34331010596865', '那你', '1512290105902', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('106', '1570845', '34331010596865', '美的不要不要的', '', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('107', '911117', '34331010596865', '可能', '1512290855772', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('108', '911117', '34331010596865', '‘’', '1512290877775', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('109', '1570845', '34331010596865', '美的不要不要的', '', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('110', '911117', '34331010596865', 'll', '1512291097560', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('111', '911117', '34331010596865', '方法', '1512291240770', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('112', '1570845', '34331010596865', '的点点滴滴', '1512291254187', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('113', '911117', '34331010596865', '王企鹅', '1512291259820', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('114', '911117', '34331010596865', '树先生', '1512291316828', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('115', '911117', '34331010596865', '方法', '1512291436620', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('116', '911117', '34331010596865', '方法', '1512291442416', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('117', '911117', '1570845', '恩恩', '1512291467697', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('118', '911117', '34501063409665', '方法', '1512304640443', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('119', '911117', '34515089162242', '花海', '', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('120', '911117', '911088', '你每天都要登陆？', '1512389544373', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('121', '911117', '911100', '旺旺', '1512391166749', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('122', '911117', '32403609419777', '？', '1512392101570', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('123', '911117', '32403609419777', '用你自己的环信秘钥呗', '1512392144299', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('124', '911117', '911088', '你好', '1512392194668', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('125', '911117', '911088', '恩', '1512392207111', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('126', '911117', '911088', '后台？ 服务端用的php', '1512392238707', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('127', '911117', '911088', '环信是起socket作用', '1512392284731', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('128', '911117', '911088', '起到的作用是通信', '1512392299941', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('129', '911117', '911088', 'layim是前端页面展示', '1512392309439', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('130', '911117', '911088', '是的，历史和换肤就需要自己的服务器配合', '1512392333857', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('131', '911117', '911088', '创建群组，搜索好友，这些都需要服务器配合的', '1512392372954', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('132', '911117', '911088', '成都', '1512392374802', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('133', '911117', '911088', '兄台有何指教', '1512392416238', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('134', '911117', '911088', 'shmily_lb_elva', '1512392424341', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('135', '911117', '911088', '微信时不时的登陆一下', '1512392439607', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('136', '911117', '911088', '不保证能及时回复', '1512392450821', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('137', '911117', '911088', '你是做什么方面的呢', '1512392477797', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('138', '911117', '911088', '厉害', '1512392508940', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('139', '911117', '911088', '就是做外包呗', '1512392661814', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('140', '911117', '911088', '。。。', '1512392688739', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('141', '911117', '911088', '你不是还自称为包工头么', '1512392703425', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('142', '911117', '911088', '[:|] ', '1512392709179', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('143', '911117', '911088', '恩', '1512392738785', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('144', '911117', '32403609419777', '朋友？', '1513005582927', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('145', '911117', '32403609419777', '废话', '1513006464238', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('146', '911117', '32403609419777', '大半夜不睡觉', '1513006480614', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('147', '911117', '32403609419777', '本来就有这个功能', '1513006503914', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('148', '911117', '32403609419777', '只是我把屏蔽了', '1513006511389', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('149', '911117', '32403609419777', '觉得不实用', '1513006523879', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('150', '911117', '32403609419777', '[):] ', '1513006534649', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('151', '911117', '32403609419777', '有的', '1513006539804', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('152', '911117', '32403609419777', '是的', '1513006561568', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('153', '911117', '32403609419777', '可以看看我的github', '1513006571107', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('154', '911117', '32403609419777', 'https://github.com/shmilylbelva/webim', '1513006594927', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('155', '911117', '32403609419777', '一直会更新完善的', '1513006603878', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('156', '911117', '32403609419777', '1028604181', '1513006610061', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('157', '911117', '32403609419777', '现在workerman版本的聊天也在上手中', '1513006630828', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('158', '911117', '32403609419777', '给个star呗', '1513006693712', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('159', '911117', '32403609419777', '可以的', '1513006732027', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('160', '911117', '32403609419777', '定制功能也可以的', '1513006739842', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('161', '911117', '32403609419777', 'video[http://www.w3school.com.cn//i/movie.ogg]', '1513087169680', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('162', '911117', '32403609419777', '收到', '1513087367335', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('163', '911117', '32403609419777', 'video[http://www.w3school.com.cn//i/movie.ogg]', '1513087513748', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('164', '911117', '32403609419777', 'video[http://ossguoshan.oss-cn-shanghai.aliyuncs.com/VID_20171212_215649.mp4]', '1513087517021', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('165', '1570855', '911085', '？？', '1513087873134', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('166', '1570855', '911085', 'video[http://www.w3school.com.cn//i/movie.ogg]', '1513087927959', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('167', '1570855', '911085', '收到了吗', '1513087943372', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('168', '1570855', '911085', '到时候如果要上线用，可以先上传到阿里云上的oss', '1513087984777', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('169', '1570855', '911085', '这样播放不会出问题', '1513087999146', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('170', '1570855', '911085', '可以', '1513088038006', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('171', '1570855', '911085', '我看看', '1513088102687', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('172', '1570855', '911085', '稍等', '1513088104790', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('173', '1570855', '911085', '你那边我没有开启发送视频', '1513088135463', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('174', '1570855', '911085', '只有我调试才有', '1513088146109', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('175', '1570855', '911085', '首先是用户上传视频到云服务器，云服务器解析后返回视频地址，后台再处理返回给客户端', '1513088235742', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('176', '1570855', '911085', '客户端接收特定的信息格式，展示视频消息', '1513088258184', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('177', '1570855', '911085', '不经过环信', '1513088312351', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('178', '1570855', '911085', '绕过环信', '1513088323906', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('179', '1570855', '911085', '是的', '1513088327318', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('180', '1570855', '911085', '可以', '1513088337272', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('181', '1570855', '911085', '如果你那边是比较私密的类型，可以不用第三方通信', '1513088385775', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('182', '1570855', '911085', '可以直接给你搭建一个通信服务器', '1513088397035', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('183', '1570855', '911085', '如果选择的是发送文件，那么久只能下载下来', '1513088432785', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('184', '1570855', '911085', '环信那边只是能够看到你这条消息', '1513088478062', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('185', '1570855', '911085', '他是看不到内容的', '1513088490557', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('186', '1570855', '911085', '文件/视频/图片，都可以不经过环信  直接通过oss', '1513088523440', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('187', '1570855', '911085', '环信只是作为一个通信介质', '1513088536117', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('188', '1570855', '911085', '相当于是快递员', '1513088542513', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('189', '1570855', '911085', '他只是知道你用一个包裹，包裹里面是什么，他并不知道', '1513088561559', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('190', '1570855', '911085', '可以的', '1513088612180', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('191', '1570855', '911085', '可以在线，', '1513088628497', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('192', '1570855', '911085', '环信传递的只是一个视频路径', '1513088644412', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('193', '1570855', '911085', '刚刚说了，文件是上传到的自己的oss', '1513088665332', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('194', '1570855', '911085', '如果觉得oss还不安全，可以直接传到自己的服务器', '1513088683113', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('195', '1570855', '911085', '直接将文件传到环信，也是可以的', '1513088773759', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('196', '1570855', '911085', '如果文档说了不能', '1513088809679', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('197', '1570855', '911085', '文档上的上传附件', '1513088838473', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('198', '1570855', '911085', '就相当于是将文件零时保存在环信的', '1513088863906', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('199', '1570855', '911085', '他返回的路径不是可以直接播放的', '1513088894134', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('200', '1570855', '911085', '需要一个秘钥', '1513088899192', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('201', '1570855', '911085', '通过秘钥才能正常访问视频', '1513088919719', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('202', '1570855', '911085', '文件类型的都是这样的', '1513088929173', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('203', '1570855', '911085', '链接肯定不行，需要上传源文件', '1513089029523', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('204', '1570855', '911085', 'layim 原生是只支持发送视频链接的', '1513089089011', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('205', '1570855', '911085', '返回给你的信息里面还有别的参数', '1513089111088', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('206', '1570855', '911085', '文档写有', '1513089119479', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('207', '1570845', '32403609419777', '1', '1513089208162', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('208', '911117', '911088', '[):] ', '1513261592914', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('209', '911117', '911088', '[<o)][;)] ', '1513261610614', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('210', '911117', '1570855', 'o', '1513344231806', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('211', '911117', '911088', '[(F)] ', '1513614151501', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('212', '911117', '911088', '[({)] ', '1513686681215', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('213', '911117', '911088', 'img[]', '1513688733436', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('214', '911117', '911088', 'img[]', '1513688749337', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('215', '911117', '911088', 'img[https://a1.easemob.com/1199170801115017/layim/chatfiles/e4265a00-e4bd-11e7-a3e2-37a7b1528b57]', '1513688987022', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('216', '1570855', '911117', 'img[https://a1.easemob.com/1199170801115017/layim/chatfiles/06d3ea40-e4be-11e7-b4c5-936626a4c596]', '1513689045225', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('217', '911117', '1570855', 'file(http://a1.easemob.com/1199170801115017/layim/chatfiles/3b5a6af0-e4be-11e7-ab49-ebff39df5654)[QQ截图20161103102615.png]', '1513689133317', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('218', '911117', '1570855', 'file(http://a1.easemob.com/1199170801115017/layim/chatfiles/03062140-e5ee-11e7-a214-7964d0dae884)[20161021142954414.png]', '1513819604024', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('219', '911117', '1570855', 'file(https://a1.easemob.com/1199170801115017/layim/chatfiles/4048a7d0-e5ee-11e7-95e8-bd0c1669d35c)[readme.txt]', '1513819706662', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('220', '911117', '32403609419777', '1', '1513821452106', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('221', '911117', '32403609419777', 'file(https://a1.easemob.com/1199170801115017/layim/chatfiles/0afd1ab0-e5f4-11e7-b17d-41188d88112e)[QQ截图20170922172812.jpg]', '1513822194431', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('222', '911117', '32403609419777', 'img[https://a1.easemob.com/1199170801115017/layim/chatfiles/0f85fe30-e5f4-11e7-bb43-114300bace9b]', '1513822202124', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('223', '911117', '1570845', 'file(https://a1.easemob.com/1199170801115017/layim/chatfiles/9d5b4360-e5fd-11e7-8b4c-ff7487d2c0fd)[QQ截图20171221095153.jpg]', '1513826305351', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('224', '911117', '1570845', 'file()[QQ截图20170922172812.jpg]', '1513826786089', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('225', '911117', '1570845', 'file(20161021142954414.png)[20161021142954414.png]', '1513826838232', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('226', '911117', '911088', '牛逼', '1513828154495', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('227', '911117', '1570845', 'file(20161021142954414.png)[20161021142954414.png]', '1513833432360', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('228', '1570845', '911117', '11', '1513920582582', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('229', '911117', '32403609419777', '1w ', '1513920589921', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('230', '1570845', '911117', '12', '1513921120408', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('231', '911117', '1570845', '1', '1513921826792', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('232', '911117', '1570845', '1', '1513922608680', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('233', '911117', '1570845', '12', '1513924930011', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('234', '1570845', '911117', '12', '1513925033843', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('235', '911117', '1570845', 'qq', '1513925053003', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('236', '1570845', '911117', '存储', '1513925079205', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('237', '911117', '1570845', 'sw ', '1513925083525', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('238', '1570845', '911117', 'd的', '1513925091021', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('239', '911117', '32403609419777', 'file(http://p17mgqcab.bkt.clouddn.com/双匣记.txt)[双匣记.txt]', '1513926223864', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('240', '911117', '32403609419777', 'file(http://p17mgqcab.bkt.clouddn.com/双匣记.txt)[双]', '1513926336300', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('241', '1570845', '32403609419777', '我', '1513926401859', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('242', '911117', '32403609419777', 'file(http://p17mgqcab.bkt.clouddn.com/双匣记.txt)[双匣记.txt]', '1513926410328', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('243', '911117', '1570845', 'file(http://p17mgqcab.bkt.clouddn.com/双匣记.txt)[双匣记.txt]', '1513926803850', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('244', '911117', '1570845', '1', '1513926873058', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('245', '911117', '1570845', 'file(http://p17mgqcab.bkt.clouddn.com/双匣记.txt)[双匣记.txt]', '1513926879467', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('246', '1570845', '911117', '2file(http://p17mgqcab.bkt.clouddn.com/荣誉 军事小说.txt)[荣誉 军事小说.txt]', '1513926915220', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('247', '911117', '1570845', 'file(http://p17mgqcab.bkt.clouddn.com/双匣记.txt)[双匣记.txt]', '1513927054529', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('248', '911117', '1570845', '[):] ', '1513927520985', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('249', '911117', '1570845', 'img[https://a1.easemob.com/1199170801115017/layim/chatfiles/da654d90-e6e9-11e7-9b7d-a9d481fcbd7e]', '1513927768768', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('250', '911117', '1570845', 'img[https://a1.easemob.com/1199170801115017/layim/chatfiles/e575cac0-e6e9-11e7-9fa5-e35619ba6856]', '1513927787398', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('251', '911117', '1570845', 'img[https://a1.easemob.com/1199170801115017/layim/chatfiles/ec068c30-e6e9-11e7-8272-43b07667148c]', '1513927798541', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('252', '1570845', '32403609419777', 'img[https://a1.easemob.com/1199170801115017/layim/chatfiles/24e9a6e0-e703-11e7-a37f-3386b73b37f2]', '1513938631454', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('253', '911117', '911088', '111', '1514255051027', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('254', '911117', '911088', '码', '1514266246298', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('255', '911117', '911088', '隐藏登录页面？', '1514266381833', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('256', '911117', '911088', '啥意思', '1514266390825', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('257', '911117', '911088', '只有没有登录才会展示这个登录页面', '1514266407185', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('258', '911117', '911088', '哦，可以的', '1514266477602', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('259', '911117', '911088', '你用你自己的登录页面登录后，在后台请求环信token，将token传递到前台页面，前台调用环信去做请求就可以了', '1514266550323', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('260', '911117', '911088', 'img[https://a1.easemob.com/1199170801115017/layim/chatfiles/c05461d0-e9fe-11e7-ae87-75365d51fda2]', '1514266602506', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('261', '911117', '911088', '还是需要连接请求环信的，你后台只是获取了token，需要前台请求环信的js', '1514266645554', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('262', '911117', '911088', '双击图片', '1514266759827', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('263', '911117', '911088', '可以不用全部走js 环信有后台api文档', '1514267070386', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('264', '911117', '911088', '只是登录需要', '1514267076883', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('265', '911117', '911088', '别的都可以不用走js', '1514267082370', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('266', '911117', '911088', '是的', '1514267199747', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('267', '911117', '911088', '你要觉得后台处理方便就用后台请求，要是觉得前台通过js方便，你就用sj', '1514267229178', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('268', '911117', '911088', 'js', '1514267230746', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('269', '911117', '911088', '我做php的', '1514267240762', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('270', '911117', '911088', '做要做后台和接口开发', '1514267255555', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('271', '911117', '911088', '我也没怎么学过js', '1514267331306', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('272', '911117', '911088', '就是公司可能有合格需求，我就先自己先做着', '1514267353922', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('273', '911117', '911088', '哪知道能做到现在，现在就想把项目晚上', '1514267382122', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('274', '911117', '911088', '完善', '1514267384738', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('275', '911117', '911088', '是的', '1514267387531', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('276', '911117', '911088', '还有群管理部分，没有做，现在正在做', '1514267403706', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('277', '911117', '911088', 'img[https://a1.easemob.com/1199170801115017/layim/chatfiles/b30f8d90-ea00-11e7-86ca-d1501df422e7]', '1514267439420', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('278', '911117', '911088', '都可以，禁言，踢人，邀请，修改群信息，修改群昵称，添加管理员，等等，', '1514267569357', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('279', '911117', '911088', '我在成都', '1514267595011', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('280', '911117', '911088', '就是最近雾霾大', '1514267616570', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('281', '911117', '911088', '现在坐公交车都免费', '1514267626443', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('282', '911117', '911088', '你哪儿的？', '1514267660163', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('283', '911117', '911088', '没有听歌', '1514267763555', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('284', '911117', '911088', '在上海不错嘛', '1514267774859', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('285', '911117', '911088', '有发展前途', '1514267781147', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('286', '911117', '911088', '是啊，最近我这边照php，一共收到100多个简历', '1514267841219', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('287', '911117', '911088', '看都看不过来', '1514267849699', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('288', '911117', '911088', '很多一看简历就知道是培训出来的，一般问几个问题就知道了', '1514267938899', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('289', '911117', '911088', '不可以', '1514268073419', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('290', '911117', '911088', 'img[https://a1.easemob.com/1199170801115017/layim/chatfiles/7b9361a0-ea02-11e7-84a4-0beb4d784832]', '1514268205216', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('291', '911117', '911088', '比如修改签名，获取群员这些都是需要的', '1514268222260', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('292', '911117', '911088', '那你就把相应的代码去掉就行，但是必须要注册的', '1514268277819', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('293', '911117', '911088', '注册事件里面你觉得没有的可以不用去实现', '1514268320859', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('294', '911117', '911088', '就是layim的cache，', '1514268515093', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('295', '911117', '911088', '自带的', '1514268518315', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('296', '911117', '911088', 'img[https://a1.easemob.com/1199170801115017/layim/chatfiles/45f5fd54-ea03-11e7-a754-67e9f2e455ef]', '1514268544730', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('297', '911117', '911088', 'conn就是注册环信的', '1514268705635', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('298', '911117', '911088', '需要', '1514268707739', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('299', '911117', '911088', '监听这个只是建立连接，获取数据需要调用conn', '1514268828228', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('300', '911117', '911088', '相当于是句柄', '1514268839260', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('301', '911117', '911088', '不用', '1514269050492', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('302', '911117', '911088', '自动调用的', '1514269058044', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('303', '911117', '911088', '你自己的逻辑处理需要啊，这个只是告诉你对方添加了你，你前台显示或者提示用户需要自己处理', '1514269468956', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('304', '911117', '911088', '嗯，是的，我自己后台也需要控制啊，比如历史消息啊，获取用户头像，修改自己的信息等等', '1514269632916', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('305', '911117', '911088', '那样你怎么处理加群加好友操作呢，', '1514269724980', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('306', '911117', '911088', '要是消息当时没有处理，以后不是就看不见了', '1514269756652', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('307', '911117', '911088', '环信只是一个通讯介质，逻辑关系这些需要自己来处理', '1514269782700', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('308', '911117', '911088', '有好友关系，有群关系', '1514269960540', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('309', '911117', '911088', 'img[https://a1.easemob.com/1199170801115017/layim/chatfiles/ab851b20-ea06-11e7-8403-513f1990dc24]', '1514270003757', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('310', '911117', '911088', '但是添加谁为好友，怎么处理好友申请，是否同意好哟申请，你得自己来判断，虽然都是有方法的', '1514270062980', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('311', '911117', '911088', '就像一部汽车，它是可以运动的，但是往哪儿开，开多快，你的自己控制', '1514270125684', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('312', '911117', '911088', '朋友有空在我的github项目给个小星星吧，会一直更新的https://github.com/shmilylbelva/webim', '1514271337023', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('313', '911117', '36103937654785', '？', '1514273859504', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('314', '911117', '36103937654785', '新来的', '1514273890080', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('315', '911117', '911058', '[):] ', '1514273968823', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('316', '911117', '1570855', '11', '1514275585805', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('317', '1570845', '911117', '刚刚', '1514275766321', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('318', '911117', '911088', 'en ', '1514280086573', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('319', '911117', '911088', 'dd', '1514342321797', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('320', '911117', '911088', '咋子', '1514354636173', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('321', '911117', '911088', '是啊', '1514354650810', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('322', '911117', '1570855', '因为我现在是在本地登录的', '1514355597513', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('323', '911117', '1570855', '你是在服务器', '1514355603185', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('324', '911117', '1570855', '两边数据不一样', '1514355610201', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('325', '911117', '1570855', '嗯', '1514355635234', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('326', '911117', '1570845', '00', '1514423810325', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('327', '911117', '911088', '你是在做webm吗', '1514446992069', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('328', '911117', '911088', '？', '1514447375621', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('329', '911117', '911088', '。。。', '1514447472781', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('330', '911117', '911088', '嗯', '1514531322481', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('331', '911117', '911088', '自己的号？', '1514531425801', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('332', '911117', '911088', '头像昵称初始化的时候从后台返回给页面储存', '1514531465321', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('333', '911117', '911088', '从自己的服务器获取', '1514531476249', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('334', '911117', '911088', '你只管初始化的头像昵称获取就行，剩下的layim会帮你实现', '1514531953201', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('335', '911117', '911088', '你只管初始化的头像昵称获取就行，剩下的layim会帮你实现', '1514531953201', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('336', '911117', '911088', '嗯', '1514532115321', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('337', '911117', '911088', '有不清除的可以再找我，我的微信shmily_lb_elva', '1514532152481', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('338', '911117', '911088', '你好', '1514533014058', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('339', '911117', '911088', '码农', '1514533052562', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('340', '911117', '911088', 'layim.getMessage({\n  username: \"纸飞机\" //消息来源用户名\n  ,avatar: \"http://tp1.sinaimg.cn/1571889140/180/40030060651/1\" //消息来源用户头像\n  ,id: \"100000\" //消息的来源ID（如果是私聊，则是用户id，如果是群聊，则是群组id）\n  ,type: \"friend\" //聊天窗口来源类型，从发送消息传递的to里面获取\n  ,content: \"嗨，你好！本消息系离线消息。\" //消息内容\n  ,cid: 0 //消息id，可不传。除非你要对消息进行一些操作（如撤回）\n  ,mine: false //是否我发送的消息，如果为true，则会显示在右方\n  ,fromid: \"100000\" //消息的发送者id（比如群组中的某个消息发送者），可用于自动解决浏览器多窗口时的一些问题\n  ,timestamp: 1467475443306 //服务端时间戳毫秒数。注意：如果你返回的是标准的 unix 时间戳，记得要 *1000\n});', '1514533873243', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('341', '911117', '911088', '那就需要你自己从后台请求该用户的昵称和同乡', '1514533898499', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('342', '911117', '911088', '头像', '1514533901018', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('343', '911117', '911088', 'layim.getMessage(data);', '1514534048555', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('344', '911117', '911088', '当用户收到匿名陌生用户发来的消息时，你从后台获取到昵称和头像，传入这个data', '1514534099811', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('345', '911117', '911088', '切换窗口调用api接口', '1514536851229', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('346', '911117', '911088', '修改了源码部分，环信默认是解析[]这种的，但是layim是解析face[]这种的，我把源码的face[]改为[]就行了，再把表情文件替换或者增加一个文件。', '1514537468942', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('347', '911117', '1570845', 'dd', '1514856546671', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('348', '1570845', '37181564452865', '回眸', '', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('349', '1570845', '37181564452865', '回眸淡然笑', '', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('350', '911117', '32403609419777', '回眸淡然笑', '', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('351', '911117', '32403609419777', '回眸淡然笑', '', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('352', '911117', '32403609419777', '回眸淡然笑', '', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('353', '911117', '32403609419777', '回眸淡然笑', '', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('354', '911117', '32403628294145', '？', '1514874437324', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('355', '911117', '32403628294145', '123', '1514874685822', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('356', '911117', '32403628294145', '这么多人/', '1514874695333', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('357', '911117', '32403628294145', 'img[https://a1.easemob.com/1199170801115017/layim/chatfiles/ca640c60-ef86-11e7-961e-05393c909c42]', '1514874784800', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('358', '911117', '1570845', '1', '1515030202646', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('359', '911117', '1570845', '[):] ', '1515030234649', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('360', '911117', '1570845', 'img[https://a1.easemob.com/1199170801115017/layim/chatfiles/ca6a7080-f0f0-11e7-9b1e-87979d05c064]', '1515030261916', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('361', '911117', '1570845', '1', '1515032210899', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('362', '911117', '1570845', 'img[https://a1.easemob.com/1199170801115017/layim/chatfiles/60228be0-f0f5-11e7-8908-01a2e1fd14bf]', '1515032231251', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('363', '911117', '32403609419777', '？', '1515034176389', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('364', '911117', '1570845', '1515034780', '1515034180', '', '1');
INSERT INTO `tb_chatlog` VALUES ('365', '911117', '32403609419777', '没懂', '1515034274029', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('366', '911117', '32403609419777', '是自己看到是错误的，还是接收方', '1515034363076', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('367', '911117', '32403609419777', '接收方需要 var timestamp = (new Date()).valueOf(); ', '1515034420197', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('368', '911117', '32403609419777', '从后台返回的时间格式需要 var timestamp = Date.parse(new Date(message.time));', '1515034475125', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('369', '911117', '32403609419777', 'message.time是你返回的时间', '1515034482902', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('370', '911117', '36682917281793', '有啊', '1515034493165', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('371', '911117', '35297058422786', '/', '1515034539677', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('372', '911117', '32403609419777', '入了的', '1515034656781', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('373', '911117', '32403609419777', '要不怎么看历史记录啊', '1515034702581', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('374', '911117', '1570845', '1515035501', '1515034901', '', '1');
INSERT INTO `tb_chatlog` VALUES ('375', '911117', '1570845', '1515035540', '1515034940', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('376', '911117', '32403609419777', '这个只是demo，具体方案你自己实现，用第三方的可以通过api去获取聊天数据保存，自己实现的可以像微信存本地，等等', '1515035079221', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('377', '911117', '911085', '？', '1515035093606', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('378', '911117', '34331010596865', '1', '1515035524366', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('379', '911117', '32403609419777', '嗯', '1515035592342', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('380', '911117', '32403609419777', '好', '1515037189824', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('381', '911117', '37370973978625', '123456', '', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('382', '911117', '37370973978625', '1515039151', '1515038551', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('383', '911117', '37370973978625', '1515039182', '1515038582', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('384', '911117', '37370973978625', '1', '1515040370042', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('385', '911117', '37370973978625', '1', '1515040378361', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('386', '911117', '37370973978625', '1515040999', '1515040399', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('387', '911117', '37370973978625', '1515041396', '1515040796', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('388', '911117', '37370973978625', '1', '1515040815197', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('389', '911117', '37370973978625', '1515041858', '1515041000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('390', '911117', '37370973978625', '1', '1515041270450', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('391', '911117', '37370973978625', '1515041996', '1515041396000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('392', '911117', '37370973978625', '1515042331', '1515041731000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('393', '911117', '37370973978625', '1', '1515041764763', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('394', '911117', '37370973978625', '1', '1515041933914', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('395', '911117', '37370973978625', '1515042538', '1515041938000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('396', '911117', '37370973978625', 'q', '1515042078387', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('397', '911117', '37370973978625', '1515042685', '1515042085000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('398', '911117', '37370973978625', '1515042785', '1515042185000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('399', '911117', '37370973978625', '1515042848', '1515042248000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('400', '911117', '37370973978625', '1515042910', '1515042310000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('401', '911117', '37370973978625', '1515042938', '1515042338000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('402', '911117', '37370973978625', '1515042947', '1515042347000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('403', '911117', '37370973978625', '1515043007', '1515042407000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('404', '911117', '32403609419777', '123456', '', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('405', '911117', '37370973978625', '1515043171', '1515042571000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('406', '911117', '37370973978625', '1515043182', '1515042582000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('407', '911117', '37370973978625', '1515043324', '1515042724000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('408', '911117', '37370973978625', '1515043630', '1515043030000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('409', '911117', '37370973978625', '1515043645', '1515043045000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('410', '911117', '37370973978625', '1515043733', '1515043133000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('411', '911117', '37370973978625', '1515043893', '1515043293000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('412', '911117', '37370973978625', '1515043922', '1515043322000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('413', '911117', '37370973978625', '1515044020', '1515043420000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('414', '911117', '37370973978625', '1515044071', '1515043471000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('415', '911117', '37370973978625', '1515044187', '1515043587000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('416', '911117', '37370973978625', '1515044224', '1515043624000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('417', '911117', '37370973978625', '1515044322', '1515043722000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('418', '911117', '37370973978625', '1515044937', '1515044337000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('419', '911117', '911088', '说', '1515044552685', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('420', '911117', '37370973978625', '1515045173', '1515044573000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('421', '911117', '911088', '比如？', '1515044652957', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('422', '911117', '911088', '都可以的', '1515044823604', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('423', '911117', '911088', '三个js？', '1515044924885', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('424', '911117', '37370973978625', '1515045544', '1515044944000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('425', '911117', '37370973978625', '1515045599', '1515044999000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('426', '911117', '911088', '你是说环信的demo吗', '1515045034462', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('427', '911117', '911088', 'demo的那个，很难自己动手去做修改', '1515045090478', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('428', '911117', '911088', 'webpack打包了的，', '1515045102621', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('429', '911117', '911088', '你还是自己动手做一个吧，界面就用layim', '1515045133598', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('430', '911117', '911088', '如果不改动界面，可以直接用环信的demo', '1515045219381', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('431', '911117', '911088', '配置一下参数就能用了，还有就是昵称头像，自己改改', '1515045264254', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('432', '911117', '37370973978625', '1515045915', '1515045315000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('433', '911117', '37370973978625', '1515046057', '1515045457000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('434', '911117', '911088', '嗯，可以的', '1515045482918', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('435', '911117', '911088', '不客气', '1515045498550', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('436', '911117', '37370973978625', '1515046202', '1515045602000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('437', '911117', '37370973978625', '1515046228', '1515045628000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('438', '911117', '37370973978625', '1515046278', '1515045678000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('439', '911117', '37370973978625', '1515046456', '1515045856000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('440', '911117', '32403609419777', '是的，除了修改皮肤这些修改了layim源代码的地方', '1515046149494', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('441', '911117', '32403609419777', '我在完善群组管理部分', '1515046372808', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('442', '911117', '37370973978625', '1515047060', '1515046460000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('443', '911117', '37370973978625', '1515047082', '1515046482000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('444', '911117', '37370973978625', '1515047170', '1515046570000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('445', '123456', '37370973978625', '1', '1515046667263', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('446', '911117', '37370973978625', '1515070418', '1515048818000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('447', '911117', '37370973978625', '1515050432', '1515049832000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('448', '911117', '37370973978625', '1515050459', '1515049859000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('449', '911117', '37370973978625', '1515050468', '1515049868000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('450', '911117', '37370973978625', '1515050629', '1515050029000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('451', '123456', '37370973978625', '1', '1515050199049', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('452', '123456', '37370973978625', '1', '1515050283267', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('453', '123456', '37370973978625', '1', '1515050385346', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('454', '123456', '37370973978625', '1', '1515050440690', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('455', '123456', '37370973978625', 'w', '1515050661402', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('456', '123456', '37370973978625', 'w', '1515050661402', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('457', '911117', '37370973978625', '1515051384', '1515050784000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('458', '911117', '37370973978625', '1515051416', '1515050816000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('459', '911117', '37370973978625', '1515051511', '1515050911000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('460', '911117', '37370973978625', '1515051580', '1515050980000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('461', '911117', '37370973978625', '1515051692', '1515051092000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('462', '123456', '37370973978625', '1', '1515051106451', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('463', '123456', '37370973978625', '[(u)] ', '1515051116147', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('464', '911117', '37370973978625', '1515051855', '1515051255000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('465', '123456', '37370973978625', '1', '1515051273618', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('466', '911117', '37370973978625', '1515052263', '1515051663000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('467', '911117', '37370973978625', 'file(http://p17mgqcab.bkt.clouddn.com/QQ截图20170922172812.jpg)[QQ截图20170922172812.jpg]', '1515052418046', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('468', '911117', '37370973978625', '1', '1515052504740', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('469', '911117', '37370973978625', '1', '1515052587460', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('470', '911117', '37370973978625', '？？', '1515052600420', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('471', '911117', '37370973978625', '1', '1515052708220', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('472', '911117', '32403609419777', '123456', '', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('473', '911117', '37370973978625', '1', '1515115572454', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('474', '123456', '37370973978625', '啊啊', '1515116218092', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('475', '911117', '32403609419777', 'w', '1515119020305', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('476', '911117', '37370973978625', 'w', '1515119061204', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('477', '911117', '1570845', 'qq', '1515119094017', 'friend', '1');
INSERT INTO `tb_chatlog` VALUES ('478', '911088', '32403609419777', '1', '1515127972680', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('479', '911088', '32403609419777', '1', '1515128026479', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('481', '0', '32403609419777', '123456(123456) 已退出该群', '1515132114545', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('482', '0', '32403609419777', '123456(123456) 已退出该群', '1515134744198', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('483', '911117', '37370973978625', 'q', '1515134828351', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('484', '911117', '37370973978625', 'w', '1515134966093', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('485', '0', '32403609419777', '123456(123456) 已退出该群', '1515134989604', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('486', '0', '32403609419777', '123456(123456) 已退出该群', '1515135573477', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('487', '0', '32403609419777', '1515136400', '1515135800000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('488', '0', '32403609419777', '1515136415', '1515135815000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('489', '0', '32403609419777', '0', '', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('490', '0', '32403609419777', '1515140501', '1515139901000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('491', '0', '32403609419777', '0', '', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('492', '0', '32403609419777', '1515140554', '1515139954000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('493', '0', '32403609419777', '0', '', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('494', '0', '32403609419777', '1515143591', '1515139991000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('495', '0', '32403609419777', '0', '', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('496', '0', '32403609419777', '1515141230', '1515140630000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('497', '0', '32403609419777', '0', '', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('498', '0', '32403609419777', '1515141326', '1515140726000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('499', '0', '32403609419777', '0', '', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('500', '0', '32403609419777', '1515141411', '1515140811000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('501', '0', '32403609419777', '0', '', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('502', '0', '32403609419777', '1515141464', '1515140864000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('503', '0', '32403609419777', '1515141572', '1515140972000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('504', '0', '32403609419777', '0', '', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('505', '0', '32403609419777', '1515144587', '1515140987000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('506', '0', '32403609419777', '0', '', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('507', '0', '32403609419777', '1515141752', '1515141152000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('508', '0', '32403609419777', '1515142000000', '1515141400000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('509', '0', '32403609419777', '0', '', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('510', '0', '32403609419777', '1515142013000', '1515141413000', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('511', '0', '32403609419777', '0', '', 'group', '1');

-- ----------------------------
-- Table structure for `tb_group`
-- ----------------------------
DROP TABLE IF EXISTS `tb_group`;
CREATE TABLE `tb_group` (
  `groupIdx` bigint(30) NOT NULL COMMENT '群号',
  `groupName` varchar(63) DEFAULT NULL COMMENT '群名称',
  `des` varchar(256) DEFAULT NULL COMMENT '描述',
  `number` int(10) DEFAULT NULL COMMENT '人数',
  `approval` tinyint(1) NOT NULL DEFAULT '1' COMMENT '-1无需验证 1需要验证',
  `status` tinyint(1) DEFAULT '1' COMMENT '1正常 2全体禁言',
  `belong` bigint(20) DEFAULT NULL COMMENT '群主',
  PRIMARY KEY (`groupIdx`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_group
-- ----------------------------
INSERT INTO `tb_group` VALUES ('34331010596865', '不扯淡', '点点滴滴', '1000', '1', '1', '1570845');
INSERT INTO `tb_group` VALUES ('32403609419777', 'layim一群', '2', '1000', '1', '1', '911117');
INSERT INTO `tb_group` VALUES ('32403628294145', 'layim二群', '1', '1000', '1', '1', '1570845');
INSERT INTO `tb_group` VALUES ('34501063409665', '不验证', '不验证', '20', '-1', '1', '1578045');
INSERT INTO `tb_group` VALUES ('34923038703617', '豆浆油条', '豆浆油条', '1000', '1', '1', '911088');
INSERT INTO `tb_group` VALUES ('36682917281793', '期望很高', '期望很高', '1000', '1', '1', '911058');
INSERT INTO `tb_group` VALUES ('35297058422786', '国美', '国美', '1000', '1', '1', '911085');
INSERT INTO `tb_group` VALUES ('37370973978625', '测试', '1', '200', '1', '1', '911117');

-- ----------------------------
-- Table structure for `tb_group_member`
-- ----------------------------
DROP TABLE IF EXISTS `tb_group_member`;
CREATE TABLE `tb_group_member` (
  `groupMemberIdx` bigint(30) NOT NULL AUTO_INCREMENT,
  `groupIdx` bigint(30) NOT NULL DEFAULT '0' COMMENT '群id',
  `memberIdx` bigint(20) NOT NULL DEFAULT '0' COMMENT '用户id',
  `status` tinyint(1) DEFAULT '1' COMMENT '1正常 2为该群黑名单',
  `addTime` char(10) DEFAULT NULL COMMENT '加群时间',
  `type` tinyint(1) DEFAULT '3' COMMENT '1群主 2 管理员 3会员',
  `gagTime` char(10) DEFAULT '0' COMMENT '禁言到某个时间',
  `nickName` varchar(128) DEFAULT NULL COMMENT '群员的群昵称',
  PRIMARY KEY (`groupMemberIdx`,`groupIdx`,`memberIdx`)
) ENGINE=MyISAM AUTO_INCREMENT=52 DEFAULT CHARSET=utf8 COMMENT='群员表';

-- ----------------------------
-- Records of tb_group_member
-- ----------------------------
INSERT INTO `tb_group_member` VALUES ('1', '32403609419777', '911117', '1', null, '1', '0', '有事找管理');
INSERT INTO `tb_group_member` VALUES ('2', '32403609419777', '911088', '1', null, '3', '0', null);
INSERT INTO `tb_group_member` VALUES ('3', '32403609419777', '1570845', '1', null, '2', '1515035540', null);
INSERT INTO `tb_group_member` VALUES ('10', '32403609419777', '910992', '1', null, '3', '1515029465', null);
INSERT INTO `tb_group_member` VALUES ('11', '32403609419777', '911100', '1', null, '3', '1515029807', null);
INSERT INTO `tb_group_member` VALUES ('9', '32403609419777', '1570855', '1', '1514863868', '3', '0', null);
INSERT INTO `tb_group_member` VALUES ('12', '32403609419777', '911085', '1', null, '3', '0', null);
INSERT INTO `tb_group_member` VALUES ('13', '32403609419777', '911067', '1', null, '2', '0', null);
INSERT INTO `tb_group_member` VALUES ('14', '32403609419777', '911058', '1', null, '3', '1515136415', '实力派');
INSERT INTO `tb_group_member` VALUES ('15', '34331010596865', '1570855', '1', null, '3', '0', null);
INSERT INTO `tb_group_member` VALUES ('16', '34331010596865', '911117', '1', null, '3', '0', null);
INSERT INTO `tb_group_member` VALUES ('17', '34331010596865', '1570845', '1', null, '1', '0', null);
INSERT INTO `tb_group_member` VALUES ('18', '34501063409665', '1570855', '1', null, '3', '0', null);
INSERT INTO `tb_group_member` VALUES ('19', '34501063409665', '910992', '1', null, '3', '0', null);
INSERT INTO `tb_group_member` VALUES ('20', '34501063409665', '911117', '1', null, '3', '0', null);
INSERT INTO `tb_group_member` VALUES ('21', '34501063409665', '1570845', '1', null, '1', '0', null);
INSERT INTO `tb_group_member` VALUES ('22', '34923038703617', '911088', '1', null, '1', '0', null);
INSERT INTO `tb_group_member` VALUES ('23', '34923038703617', '911117', '1', null, '3', '0', null);
INSERT INTO `tb_group_member` VALUES ('24', '34923038703617', '1570845', '1', null, '3', '0', null);
INSERT INTO `tb_group_member` VALUES ('25', '32403628294145', '1570855', '1', null, '3', '0', null);
INSERT INTO `tb_group_member` VALUES ('26', '32403628294145', '911117', '1', null, '3', '0', null);
INSERT INTO `tb_group_member` VALUES ('27', '32403628294145', '1570845', '1', null, '1', '0', null);
INSERT INTO `tb_group_member` VALUES ('28', '32403628294145', '911088', '1', null, '2', '0', null);
INSERT INTO `tb_group_member` VALUES ('29', '32403628294145', '911085', '1', null, '3', '0', null);
INSERT INTO `tb_group_member` VALUES ('30', '36682917281793', '911058', '1', null, '1', '0', null);
INSERT INTO `tb_group_member` VALUES ('31', '36682917281793', '911088', '1', null, '3', '0', null);
INSERT INTO `tb_group_member` VALUES ('32', '36682917281793', '911117', '1', null, '3', '0', null);
INSERT INTO `tb_group_member` VALUES ('33', '36682917281793', '1570845', '1', null, '3', '0', null);
INSERT INTO `tb_group_member` VALUES ('34', '35297058422786', '911117', '1', null, '3', '0', null);
INSERT INTO `tb_group_member` VALUES ('35', '35297058422786', '911088', '1', null, '3', '0', null);
INSERT INTO `tb_group_member` VALUES ('36', '35297058422786', '911085', '1', null, '1', '0', null);
INSERT INTO `tb_group_member` VALUES ('37', '37370973978625', '911117', '1', '1515038138', '1', '0', null);
INSERT INTO `tb_group_member` VALUES ('42', '37370973978625', '123456', '1', '1515119654', '2', '1515122482', '11');

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
  `mygroupIdx` bigint(20) DEFAULT NULL COMMENT '好友分组',
  PRIMARY KEY (`msgIdx`)
) ENGINE=MyISAM AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_msg
-- ----------------------------
INSERT INTO `tb_msg` VALUES ('35', '4', '123456', '37370973978625', '4', '', '1515119650', '1515119654', '1515119654', '911117', '911117', null);
INSERT INTO `tb_msg` VALUES ('30', '2', '1570845', '911117', '4', '订单', '1514948300', '1514948315', '1514948315', '0', null, '39');

-- ----------------------------
-- Table structure for `tb_my_friend`
-- ----------------------------
DROP TABLE IF EXISTS `tb_my_friend`;
CREATE TABLE `tb_my_friend` (
  `myfriendIdx` bigint(20) NOT NULL AUTO_INCREMENT,
  `mygroupIdx` bigint(20) DEFAULT NULL,
  `memberIdx` bigint(20) DEFAULT NULL COMMENT '好友id',
  `nickName` varchar(128) DEFAULT NULL COMMENT '好友昵称 ',
  PRIMARY KEY (`myfriendIdx`)
) ENGINE=MyISAM AUTO_INCREMENT=40 DEFAULT CHARSET=utf8 COMMENT='我的分组下的好友列表';

-- ----------------------------
-- Records of tb_my_friend
-- ----------------------------
INSERT INTO `tb_my_friend` VALUES ('10', '2', '911117', null);
INSERT INTO `tb_my_friend` VALUES ('2', '1', '911088', '豆浆1');
INSERT INTO `tb_my_friend` VALUES ('3', '1', '1570845', '');
INSERT INTO `tb_my_friend` VALUES ('4', '4', '911117', null);
INSERT INTO `tb_my_friend` VALUES ('11', '6', '911088', null);
INSERT INTO `tb_my_friend` VALUES ('31', '39', '911100', null);
INSERT INTO `tb_my_friend` VALUES ('12', '6', '911085', null);
INSERT INTO `tb_my_friend` VALUES ('13', '6', '910992', null);
INSERT INTO `tb_my_friend` VALUES ('14', '6', '1570855', null);
INSERT INTO `tb_my_friend` VALUES ('15', '6', '1570845', null);
INSERT INTO `tb_my_friend` VALUES ('16', '4', '911100', null);
INSERT INTO `tb_my_friend` VALUES ('17', '7', '911088', null);
INSERT INTO `tb_my_friend` VALUES ('18', '4', '911058', null);
INSERT INTO `tb_my_friend` VALUES ('19', '4', '910992', null);
INSERT INTO `tb_my_friend` VALUES ('20', '7', '1570845', null);
INSERT INTO `tb_my_friend` VALUES ('21', '8', '911058', null);
INSERT INTO `tb_my_friend` VALUES ('22', '8', '910992', null);
INSERT INTO `tb_my_friend` VALUES ('23', '8', '1570845', null);
INSERT INTO `tb_my_friend` VALUES ('24', '9', '911067', null);
INSERT INTO `tb_my_friend` VALUES ('25', '9', '1578055', null);
INSERT INTO `tb_my_friend` VALUES ('26', '41', '911100', '等待123');
INSERT INTO `tb_my_friend` VALUES ('27', '10', '911088', null);
INSERT INTO `tb_my_friend` VALUES ('28', '10', '1570855', null);
INSERT INTO `tb_my_friend` VALUES ('29', '10', '1578045', null);
INSERT INTO `tb_my_friend` VALUES ('30', '11', '911117', null);
INSERT INTO `tb_my_friend` VALUES ('32', '39', '911088', null);
INSERT INTO `tb_my_friend` VALUES ('33', '2', '911085', null);
INSERT INTO `tb_my_friend` VALUES ('34', '39', '911067', null);
INSERT INTO `tb_my_friend` VALUES ('35', '39', '910992', null);
INSERT INTO `tb_my_friend` VALUES ('36', '39', '1570855', null);
INSERT INTO `tb_my_friend` VALUES ('37', '5', '911100', null);
INSERT INTO `tb_my_friend` VALUES ('38', '5', '911058', null);
INSERT INTO `tb_my_friend` VALUES ('39', '5', '910992', null);

-- ----------------------------
-- Table structure for `tb_my_group`
-- ----------------------------
DROP TABLE IF EXISTS `tb_my_group`;
CREATE TABLE `tb_my_group` (
  `mygroupIdx` bigint(20) NOT NULL AUTO_INCREMENT,
  `memberIdx` bigint(20) DEFAULT NULL,
  `mygroupName` varchar(128) DEFAULT '' COMMENT '分组名称',
  `weight` tinyint(2) DEFAULT '1' COMMENT '好友分组的排列顺序 越小越靠前',
  PRIMARY KEY (`mygroupIdx`)
) ENGINE=MyISAM AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COMMENT='我的好友分组';

-- ----------------------------
-- Records of tb_my_group
-- ----------------------------
INSERT INTO `tb_my_group` VALUES ('1', '911117', '我的战友', '1');
INSERT INTO `tb_my_group` VALUES ('39', '1570845', '我的同学', '2');
INSERT INTO `tb_my_group` VALUES ('3', '911085', '我的好友', '1');
INSERT INTO `tb_my_group` VALUES ('4', '911085', '我的同学', '2');
INSERT INTO `tb_my_group` VALUES ('38', '911117', '未命名', '2');
INSERT INTO `tb_my_group` VALUES ('2', '1570845', '我的好友', '1');
INSERT INTO `tb_my_group` VALUES ('5', '1570855', '我的朋友', '1');
INSERT INTO `tb_my_group` VALUES ('6', '911100', '我的朋友', '1');
INSERT INTO `tb_my_group` VALUES ('7', '911085', '我的朋友', '1');
INSERT INTO `tb_my_group` VALUES ('8', '911067', '我的朋友', '1');
INSERT INTO `tb_my_group` VALUES ('9', '911058', '我的朋友', '1');
INSERT INTO `tb_my_group` VALUES ('10', '910992', '我的朋友', '1');
INSERT INTO `tb_my_group` VALUES ('11', '911088', '我的朋友', '1');
INSERT INTO `tb_my_group` VALUES ('41', '910992', '未命名', '2');

-- ----------------------------
-- Table structure for `tb_person`
-- ----------------------------
DROP TABLE IF EXISTS `tb_person`;
CREATE TABLE `tb_person` (
  `memberIdx` bigint(20) NOT NULL AUTO_INCREMENT,
  `memberName` varchar(200) NOT NULL COMMENT '昵称',
  `birthday` varchar(64) NOT NULL COMMENT '生日',
  `memberSex` tinyint(1) unsigned zerofill NOT NULL DEFAULT '3' COMMENT '1男 2女 3保密 ',
  `memberStatus` tinyint(1) NOT NULL,
  `signature` varchar(500) NOT NULL DEFAULT '',
  `emailAddress` varchar(200) NOT NULL DEFAULT '',
  `phoneNumber` varchar(200) NOT NULL,
  `memberPWD` varchar(200) NOT NULL,
  `userToken` varchar(200) NOT NULL DEFAULT '',
  `oauth_token` varchar(200) NOT NULL,
  `blood_type` varchar(32) NOT NULL DEFAULT '其他血型' COMMENT 'A型 B型 AB型 O型 其他血型 ',
  `job` tinyint(2) DEFAULT '0' COMMENT '1 计算机/互联网/通信 2生产/工艺/制造 3医疗/护理/制药 4 金融/银行/投资/保险 5商业/服务业/个体经营 6文化/广告/传媒 7娱乐/艺术/表演 8 律师/法务 9教育/培训 10公务员/行政/事业单位 11模特 12空姐 13学生 14其他\r\n\r\n这里可以单独建一个职业表，作为演示，我就不设计那么多表了',
  `qq` varchar(20) NOT NULL DEFAULT '',
  `wechat` varchar(64) NOT NULL DEFAULT '',
  `updateTime` varchar(64) DEFAULT NULL,
  `easemob_token` varchar(256) DEFAULT '0',
  `loginTime` varchar(13) DEFAULT '0',
  `expires_in` bigint(20) DEFAULT '0',
  PRIMARY KEY (`memberIdx`)
) ENGINE=InnoDB AUTO_INCREMENT=1570856 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of tb_person
-- ----------------------------
INSERT INTO `tb_person` VALUES ('123456', '123456', '', '3', '0', '', '', '', 'c286dc5c0b2f4707d9ba5c7ea8a021d7', 'egsudUhV$oJP', '', '其他血型', '0', '', '', null, 'YWMt1ZCmQvEDEeet7PGv9PvPpDa-6sDFuhHniHT7UGSJR-fEB8lQ8QMR54end3IJDOS8AwMAAAFgv1QFTwBPGgBE0zpBycCD3OkerCNW3VSqgCQIPyt0Q6KBz7TzJOrBag', '1515038440', '5183999');
INSERT INTO `tb_person` VALUES ('910992', '清风', '2017年12月14日', '1', '0', '星光灿烂', '', '', 'c286dc5c0b2f4707d9ba5c7ea8a021d7', 'egsudUhV$oJP', '', '其他血型', null, '', '', null, 'YWMtOT7IiulEEee1aBdoGYH1uDa-6sDFuhHniHT7UGSJR-fLo19AxboR55F3x25tMU72AwMAAAFgjIw66wBPGgBVzWdRwpBQ3X2C0Y0Jov2LL6IbOAIghXNfJLIUO5I7iQ', '1514186488', '5183999');
INSERT INTO `tb_person` VALUES ('911058', '实力派', '2017年12月14日', '1', '0', '善 是一个美好', '', '', 'c286dc5c0b2f4707d9ba5c7ea8a021d7', 'egsudUhV$oJP', '', '其他血型', null, '', '', null, 'YWMtN5RwPulEEeegzoG4TvSiKTa-6sDFuhHniHT7UGSJR-fE3wqwxboR54ZHaZLhHAmEAwMAAAFgjIwwAQBPGgARQbbKSE8ZaOymvF1w6TfJxK322PXPF9Azy6dgvazvbg', '1514186485', '5183999');
INSERT INTO `tb_person` VALUES ('911067', '爱咋咋地', '2017年12月14日', '3', '0', '一个优秀的人', '', '', 'c286dc5c0b2f4707d9ba5c7ea8a021d7', 'egsudUhV$oJP', '', '其他血型', null, '', '', null, 'YWMtNixcjulEEeeZvrVtqRFjAja-6sDFuhHniHT7UGSJR-e8nYwAxboR54_KNScHmePpAwMAAAFgjIwmyQBPGgDH57C-hA6AOw5x-tq1utqKF3PJVO1l5RgByDeHUML_Ig', '1514186483', '5183999');
INSERT INTO `tb_person` VALUES ('911085', '清晨', '2017年12月14日', '2', '0', '你不进步就在后退，不做温水里的癞疙宝', '', '', 'c286dc5c0b2f4707d9ba5c7ea8a021d7', 'egsudUhV$oJP', '', '其他血型', null, '', '', null, 'YWMtNKwhKOlEEee4q7FW2JZqsza-6sDFuhHniHT7UGSJR-e2YhaAxboR54SYPxjcCwhUAwMAAAFgjIwc8wBPGgBDtzBViJ17xxbf3aO2VMtDmIiFneHuI_FuaYHWC0mpBA', '1514186481', '5183999');
INSERT INTO `tb_person` VALUES ('911088', '豆浆', '2017年12月14日', '3', '0', '本人是一个开朗的人', '', '', 'c286dc5c0b2f4707d9ba5c7ea8a021d7', 'egsudUhV$oJP', 'f844d7a6d5bf136c21d7bb5319fe4dd4', '其他血型', null, '', '', null, 'YWMt1YB1xua2Eeelpvmd0wxs1za-6sDFuhHniHT7UGSJR-fROA1wxboR57CVc_RDWrl2AwMAAAFge9ItCQBPGgAkDOQXLJK1614BnHDAk8JbMTstLO_YdNK9dpmp1KQhxQ', '1513924313', '5165542');
INSERT INTO `tb_person` VALUES ('911100', '等待', '2017年12月14日', '2', '0', '陪伴是最长情的告白', '', '', 'c286dc5c0b2f4707d9ba5c7ea8a021d7', 'egsudUhV$oJP', '', '其他血型', null, '', '', null, 'YWMt-4kmpu9cEeeTYLldMpdoKDa-6sDFuhHniHT7UGSJR-dZOEugxboR57L4RfMZA1iTAwMAAAFgtIDR6gBPGgBLseo4FKs7dt0DDtk1y1ggkJKoO-MTwmss8VTdv1sefA', '1514954517', '5086310');
INSERT INTO `tb_person` VALUES ('911117', '回眸', '2017年12月14日', '3', '0', '本人我是一个开朗的人2', '1028604181@qq.com', '', '4d5dc7577e3130d3792321487b816fe8', 'egsudUhV$oJP', '69ebdafcd94ee5b72b8a4044950b8bd5', 'B型', '1', '1028604181', 'shmily_lb_elva', '2017-12-26 16:28:50', 'YWMttXNjCObIEee4Si3I_sFGQza-6sDFuhHniHT7UGSJR-fWOhiQxboR57LQKc-JMVEQAwMAAAFgfEdR-QBPGgD1orblvOUZkHYyLshzbEirOZlybX_T1o_ZhHrDxBOIMQ', '1513920520', '5177012');
INSERT INTO `tb_person` VALUES ('1570845', '花海', '2017年12月14日', '1', '0', '我就不写签名< (ˉ^ˉ)>', '', '15708440000', 'c286dc5c0b2f4707d9ba5c7ea8a021d7', 'egsudUhV$oJP', '513a290382a0f562e9b98f49a64f704a', '其他血型', null, '', '', null, 'YWMtGDtAIubZEeeFkh19XbqstDa-6sDFuhHniHT7UGSJR-fcQTegxboR56_SK7apZRZOAwMAAAFgfLK04wBPGgDYlZjY-BxBQUXDpCz0N8ObIu3QxqsBJAryi1MIIJ8Cmw', '1513920570', '5183999');
INSERT INTO `tb_person` VALUES ('1570855', '回眸淡然笑', '2017年12月14日', '2', '0', '有钱的自由，没钱的幻想！', '', '18381334800', 'c286dc5c0b2f4707d9ba5c7ea8a021d7', 'egsudUhV$oJP', 'b6eee48de455892f8eef3cbc5117dc2d', '其他血型', null, '', '', null, 'YWMtfKaa3Oa4EeenUjeTt8UUdza-6sDFuhHniHT7UGSJR-fsUq6AxboR55ZjZViGj9nzAwMAAAFge90CLwBPGgDKeAGhe9q-FvP2c9p48yGhK53IFcVQnw4bSAqI8nS7', '1513910375', '5180190');

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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of tb_skin
-- ----------------------------
INSERT INTO `tb_skin` VALUES ('4', '911117', '3.jpg', '0');
INSERT INTO `tb_skin` VALUES ('5', '1570855', '2.jpg', '0');
INSERT INTO `tb_skin` VALUES ('6', '1570845', '4.jpg', '0');
INSERT INTO `tb_skin` VALUES ('7', '911085', '4.jpg', '0');
INSERT INTO `tb_skin` VALUES ('8', '910992', '910992_1514954456.png', '1');
INSERT INTO `tb_skin` VALUES ('9', '123456', '5.jpg', '0');
