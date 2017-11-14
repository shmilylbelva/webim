<?php
require_once 'class/config.php';
require_once 'class/url.php';
?>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>layim - WebIM</title><link rel="stylesheet" href="static/css/contextMenu.css" />
        <link rel="stylesheet" href="static/layui/css/layui.2.1.7.css">
        <link rel="stylesheet" href="static/css/menu.css">
        <link href="favicon.ico" type="image/vnd.microsoft.icon" rel="shortcut icon"/>        
    </head>

    <body data-token="<?php echo $uinfo['id']; ?>" data-rykey="<?php echo $uinfo['easemob_token']; ?>">

    </body>
        <script type='text/javascript' src='static/js/webim.config.js'></script>
        <script type='text/javascript' src='static/js/strophe-1.2.8.min.js'></script>
        <script type='text/javascript' src='static/js/websdk-1.4.13.js'></script> 
<!-- <script src="http://www.jq22.com/jquery/jquery-1.10.2.js"></script> -->
        <script src="static/layui/layui.js"></script>
        <script>
            //layui绑定扩展
            layui.config({
                base: 'static/js/'
            }).extend({
                socket: 'socket',
            });
            layui.use(['layim', 'jquery', 'socket'], function (layim, socket) {
                var $ = layui.jquery;
                var socket = layui.socket;
                var token = $('body').data('token');
                var rykey = $('body').data('rykey');           
                socket.config({
                    user: token,
                    pwd: rykey ,
                    layim: layim,
                });

                layim.config({
                    init: {
                        url: 'class/doAction.php?action=get_user_data', data: {}
                    },
                    //获取群成员
                    members: {
                        url: 'class/doAction.php?action=groupMembers', data: {}
                    }
                    //上传图片接口
                    , uploadImage: {
                        url: 'class/doAction.php?action=uploadImage' //（返回的数据格式见下文）
                        , type: '' //默认post
                    }
                    //上传文件接口
                    , uploadFile: {
                        url: 'class/doAction.php?action=uploadFile' //
                        , type: '' //默认post
                    }
                    //自定义皮肤
                    ,uploadSkin: {
                        url: 'class/doAction.php?action=uploadSkin'
                        , type: 'post' //默认post
                    }           
                    //选择系统皮肤         
                    ,systemSkin: {
                        url: 'class/doAction.php?action=systemSkin'
                        , type: 'post' //默认post
                    }
                    //获取推荐好友
                    ,getRecommend:{
                        url: 'class/doAction.php?action=find'
                        , type: 'post' //默认post
                    }
                    , isAudio: false //开启聊天工具栏音频
                    , isVideo: false //开启聊天工具栏视频

                    //扩展工具栏
                    // , tool: [{
                    //         alias: 'code'
                    //         , title: '代码'
                    //         , icon: '&#xe64e;'
                    //     }]
                    ,title: '国善' 
                    ,copyright:true
                    , initSkin: '1.jpg' //1-5 设置初始背景
                    // , initSkin: '3.jpg' //1-5 设置初始背景
                    , notice: true //是否开启桌面消息提醒，默认false
                    , msgbox: layui.cache.dir + 'css/modules/layim/html/msgbox.html' //消息盒子页面地址，若不开启，剔除该项即可
                    , find: layui.cache.dir + 'css/modules/layim/html/find.html' //发现页面地址，若不开启，剔除该项即可
                    , chatLog: layui.cache.dir + 'css/modules/layim/html/chatLog.html' //聊天记录页面地址，若不开启，剔除该项即可
                });  
            });
        </script>  
</html>
