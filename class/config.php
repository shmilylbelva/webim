<?php 
session_start();

#配置信息，一个都不能少
define("DB_HOST",'localhost');
define("DB_USER",'root');
define('DB_PWD','root');
define('DB_NAME','chat');
define('DB_PORT','3306');
define('DB_TYPE','mysql');
error_reporting(5);
define('DB_CHARSET','utf8');
define('QN_FILE','http://XXXXXXXXX.bkt.clouddn.com/');//这里是七牛云的仓库地址 用于上传文件，如果不需要可以改为本地储存
define('AK','XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX');//这里是七牛云的access_key
define('SK','XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX');//这里是七牛云的secret_key
$BASEURL = 'http://a1.easemob.com/XXXXXXXXXXXXXX/XXX/';//这里是环信地址，具体配置请到环信注册后获取
$APIURL = '../uploads/';
$tables = 'tb_person';
$tb_skin = 'tb_skin';
$tb_msg = 'tb_msg';
$tb_chatlog = 'tb_chatlog';
$tb_group = 'tb_group';
$tb_my_friend = 'tb_my_friend';
$tb_my_group = 'tb_my_group';
$tb_group_member = 'tb_group_member';
const ADD_USER_MSG = 1;//为请求添加用户
const ADD_USER_SYS = 2;//为系统消息（添加好友
const ADD_GROUP_MSG = 3;//为请求加群
const ADD_GROUP_SYS = 4;//为系统消息（添加群）
const ADD_ADMIN = 6;//为添加管理
const REMOVE_ADMIN = 7;//为取消管理
const ALLUSER_SYS = 5;// 全体会员消息
const UNREAD = 1;//未读
const AGREE_BY_TO= 2;//同意
const DISAGREE_BY_TO = 3;//拒绝
const AGREE_BY_FROM = 4;//同意且返回消息已读
const DISAGREE_BY_FROM = 5;//拒绝且返回消息已读
const READ = 6;//全体消息已读

#格式化打印函数
function dump($data) {
    echo '<hr/><br/><pre>';
    print_r($data);
    echo '</pre><br/><hr/>';
}