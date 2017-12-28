/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50710
Source Host           : localhost:3306
Source Database       : chat

Target Server Type    : MYSQL
Target Server Version : 50710
File Encoding         : 65001

Date: 2017-12-27 22:47:31
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
) ENGINE=InnoDB AUTO_INCREMENT=328 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

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
INSERT INTO `tb_chatlog` VALUES ('326', '911117', '32403609419777', 'nih ', '1514382040316', 'group', '1');
INSERT INTO `tb_chatlog` VALUES ('327', '911117', '1570845', '在', '1514383163959', 'friend', '1');

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
  PRIMARY KEY (`groupIdx`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_group
-- ----------------------------
INSERT INTO `tb_group` VALUES ('34331010596865', '不扯淡', '点点滴滴', '1000', '1', '1');
INSERT INTO `tb_group` VALUES ('32403609419777', 'layim一群', '2', '1000', '1', '1');
INSERT INTO `tb_group` VALUES ('32403628294145', 'layim二群', '1', '1000', '1', '1');
INSERT INTO `tb_group` VALUES ('34501063409665', '不验证', '不验证', '20', '-1', '1');
INSERT INTO `tb_group` VALUES ('34601052471298', '111', '111', '500', '1', '1');
INSERT INTO `tb_group` VALUES ('34601112240129', '滴滴', '滴滴', '500', '1', '1');
INSERT INTO `tb_group` VALUES ('35234327363585', '你好', '123445', '500', '1', '1');
INSERT INTO `tb_group` VALUES ('34515427852290', '12', '12', '500', '-1', '1');
INSERT INTO `tb_group` VALUES ('34600914059267', '啊啊', '啊啊', '500', '1', '1');
INSERT INTO `tb_group` VALUES ('35234343092225', '', '', '500', '1', '1');

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
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='群员表';

-- ----------------------------
-- Records of tb_group_member
-- ----------------------------
INSERT INTO `tb_group_member` VALUES ('1', '32403609419777', '911117', '1', null, '1', '0', '有事找管理');
INSERT INTO `tb_group_member` VALUES ('2', '32403609419777', '911088', '1', null, '2', '0', null);
INSERT INTO `tb_group_member` VALUES ('3', '32403609419777', '1570845', '1', null, '3', '0', null);
INSERT INTO `tb_group_member` VALUES ('4', '32403609419777', '1570855', '1', null, '3', '0', null);

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
) ENGINE=MyISAM AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_msg
-- ----------------------------
INSERT INTO `tb_msg` VALUES ('7', '2', '1570855', '911117', '4', '你好', '1510760568', '1510760575', '1510760575', '0', null, null);
INSERT INTO `tb_msg` VALUES ('2', '1', '911117', '911088', '1', '很高兴认识你1', '1510677891', null, null, '0', null, null);
INSERT INTO `tb_msg` VALUES ('3', '2', '911117', '1570845', '4', '？', '1512224909', '1512228739', '1512228739', '0', null, null);
INSERT INTO `tb_msg` VALUES ('4', '2', '911117', '911100', '5', '很高兴认识你3', '1510677791', '1510689891', null, '0', null, null);
INSERT INTO `tb_msg` VALUES ('8', '2', '911117', '1570855', '4', '12', '1513344364', '1513689036', '1513689036', '0', null, null);
INSERT INTO `tb_msg` VALUES ('17', '4', '911117', '34331010596865', '4', '23', '1512290980', '1512290985', '1512290985', '1570845', '1570845', null);
INSERT INTO `tb_msg` VALUES ('20', '4', '1570845', '34515089162242', '4', '流量', '1512314670', '1512314678', '1512314678', '911117', '911117', null);
INSERT INTO `tb_msg` VALUES ('21', '2', '911117', '911085', '4', '订单', '1514359755', '1514359772', '1514359772', '0', null, '2');
INSERT INTO `tb_msg` VALUES ('22', '1', '911117', '911058', '1', '', '1514353080', null, '1514353080', '0', null, null);

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
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='我的分组下的好友列表';

-- ----------------------------
-- Records of tb_my_friend
-- ----------------------------
INSERT INTO `tb_my_friend` VALUES ('1', '1', '1570845', '开发师');
INSERT INTO `tb_my_friend` VALUES ('2', '1', '911088', null);
INSERT INTO `tb_my_friend` VALUES ('3', '1', '910992', null);
INSERT INTO `tb_my_friend` VALUES ('4', '4', '911117', null);
INSERT INTO `tb_my_friend` VALUES ('5', '1', '911085', null);

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
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COMMENT='我的好友分组';

-- ----------------------------
-- Records of tb_my_group
-- ----------------------------
INSERT INTO `tb_my_group` VALUES ('1', '911117', '我的战友', '1');
INSERT INTO `tb_my_group` VALUES ('3', '911085', '我的好友', '1');
INSERT INTO `tb_my_group` VALUES ('4', '911085', '我的同学', '2');
INSERT INTO `tb_my_group` VALUES ('15', '911117', '我的好友', '3');
INSERT INTO `tb_my_group` VALUES ('19', '911117', '未命名', '7');

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
) ENGINE=InnoDB AUTO_INCREMENT=1570869 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of tb_person
-- ----------------------------
INSERT INTO `tb_person` VALUES ('910992', '清风', '2017年12月14日', '1', '0', '星光灿烂', '', '', 'c286dc5c0b2f4707d9ba5c7ea8a021d7', 'egsudUhV$oJP', '', '其他血型', null, '', '', null, 'YWMtOT7IiulEEee1aBdoGYH1uDa-6sDFuhHniHT7UGSJR-fLo19AxboR55F3x25tMU72AwMAAAFgjIw66wBPGgBVzWdRwpBQ3X2C0Y0Jov2LL6IbOAIghXNfJLIUO5I7iQ', '1514186488', '5183999');
INSERT INTO `tb_person` VALUES ('911058', '实力派', '2017年12月14日', '1', '0', '善 是一个美好', '', '', 'c286dc5c0b2f4707d9ba5c7ea8a021d7', 'egsudUhV$oJP', '', '其他血型', null, '', '', null, 'YWMtN5RwPulEEeegzoG4TvSiKTa-6sDFuhHniHT7UGSJR-fE3wqwxboR54ZHaZLhHAmEAwMAAAFgjIwwAQBPGgARQbbKSE8ZaOymvF1w6TfJxK322PXPF9Azy6dgvazvbg', '1514186485', '5183999');
INSERT INTO `tb_person` VALUES ('911067', '爱咋咋地', '2017年12月14日', '3', '0', '一个优秀的人', '', '', 'c286dc5c0b2f4707d9ba5c7ea8a021d7', 'egsudUhV$oJP', '', '其他血型', null, '', '', null, 'YWMtNixcjulEEeeZvrVtqRFjAja-6sDFuhHniHT7UGSJR-e8nYwAxboR54_KNScHmePpAwMAAAFgjIwmyQBPGgDH57C-hA6AOw5x-tq1utqKF3PJVO1l5RgByDeHUML_Ig', '1514186483', '5183999');
INSERT INTO `tb_person` VALUES ('911085', '清晨', '2017年12月14日', '2', '0', '你不进步就在后退，不做温水里的癞疙宝', '', '', 'c286dc5c0b2f4707d9ba5c7ea8a021d7', 'egsudUhV$oJP', '', '其他血型', null, '', '', null, 'YWMtNKwhKOlEEee4q7FW2JZqsza-6sDFuhHniHT7UGSJR-e2YhaAxboR54SYPxjcCwhUAwMAAAFgjIwc8wBPGgBDtzBViJ17xxbf3aO2VMtDmIiFneHuI_FuaYHWC0mpBA', '1514186481', '5183999');
INSERT INTO `tb_person` VALUES ('911088', '豆浆', '2017年12月14日', '3', '0', '本人是一个开朗的人', '', '', 'c286dc5c0b2f4707d9ba5c7ea8a021d7', 'egsudUhV$oJP', 'f844d7a6d5bf136c21d7bb5319fe4dd4', '其他血型', null, '', '', null, 'YWMt1YB1xua2Eeelpvmd0wxs1za-6sDFuhHniHT7UGSJR-fROA1wxboR57CVc_RDWrl2AwMAAAFge9ItCQBPGgAkDOQXLJK1614BnHDAk8JbMTstLO_YdNK9dpmp1KQhxQ', '1513924313', '5165542');
INSERT INTO `tb_person` VALUES ('911100', '等待', '2017年12月14日', '2', '0', '陪伴是最长情的告白', '', '', 'c286dc5c0b2f4707d9ba5c7ea8a021d7', 'egsudUhV$oJP', '', '其他血型', null, '', '', null, null, null, null);
INSERT INTO `tb_person` VALUES ('911117', '回眸', '2017年12月14日', '3', '0', '本人我是一个开朗的人2', '1028604181@qq.com', '', '4d5dc7577e3130d3792321487b816fe8', 'egsudUhV$oJP', '69ebdafcd94ee5b72b8a4044950b8bd5', 'B型', '1', '1028604181', 'shmily_lb_elva', '2017-12-26 16:28:50', 'YWMttXNjCObIEee4Si3I_sFGQza-6sDFuhHniHT7UGSJR-fWOhiQxboR57LQKc-JMVEQAwMAAAFgfEdR-QBPGgD1orblvOUZkHYyLshzbEirOZlybX_T1o_ZhHrDxBOIMQ', '1513920520', '5177012');
INSERT INTO `tb_person` VALUES ('1570845', '花海', '2017年12月14日', '1', '0', '我就不写签名< (ˉ^ˉ)>', '', '15708440000', 'c286dc5c0b2f4707d9ba5c7ea8a021d7', 'egsudUhV$oJP', '513a290382a0f562e9b98f49a64f704a', '其他血型', null, '', '', null, 'YWMtGDtAIubZEeeFkh19XbqstDa-6sDFuhHniHT7UGSJR-fcQTegxboR56_SK7apZRZOAwMAAAFgfLK04wBPGgDYlZjY-BxBQUXDpCz0N8ObIu3QxqsBJAryi1MIIJ8Cmw', '1513920570', '5183999');
INSERT INTO `tb_person` VALUES ('1570855', '回眸淡然笑', '2017年12月14日', '2', '0', '有钱的自由，没钱的幻想！', '', '18381334800', 'c286dc5c0b2f4707d9ba5c7ea8a021d7', 'egsudUhV$oJP', 'b6eee48de455892f8eef3cbc5117dc2d', '其他血型', null, '', '', null, 'YWMtfKaa3Oa4EeenUjeTt8UUdza-6sDFuhHniHT7UGSJR-fsUq6AxboR55ZjZViGj9nzAwMAAAFge90CLwBPGgDKeAGhe9q-FvP2c9p48yGhK53IFcVQnw4bSAqI8nS7', '1513910375', '5180190');
INSERT INTO `tb_person` VALUES ('1570868', '圆圆', '2017年12月14日', '3', '0', '各有各的活法', '', '1', 'c286dc5c0b2f4707d9ba5c7ea8a021d7', 'egsudUhV$oJP', '2', '其他血型', null, '', '', null, null, null, null);

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of tb_skin
-- ----------------------------
INSERT INTO `tb_skin` VALUES ('4', '911117', '3.jpg', '0');
INSERT INTO `tb_skin` VALUES ('5', '1570855', '2.jpg', '0');
INSERT INTO `tb_skin` VALUES ('6', '1570845', '4.jpg', '0');
INSERT INTO `tb_skin` VALUES ('7', '911085', '4.jpg', '0');
