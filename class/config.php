<?php 
session_start();

#配置信息，一个都不能少
define("DB_HOST",'rm-bp195qct86bpp011c.mysql.rds.aliyuncs.com');
define("DB_USER",'sglm');
define('DB_PWD','sglm@2017');
define('DB_NAME','db_sglm');
// define("DB_HOST",'localhost');
// define("DB_USER",'root');
// define('DB_PWD','root');
// define('DB_NAME','guoshan');
define('DB_PORT','3306');
define('DB_TYPE','mysql');

error_reporting(4);
define('DB_CHARSET','utf8');

#格式化打印函数
function dump($data) {
    echo '<hr/><br/><pre>';
    print_r($data);
    echo '</pre><br/><hr/>';
}