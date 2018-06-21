<?php
require_once 'class/config.php';
require_once 'class/url.php'; 
?>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>layim - WebIM</title><link rel="stylesheet" href="static/css/contextMenu.css" />
        <link rel="stylesheet" href="static/layui/css/layui.css">
        <link rel="stylesheet" href="static/css/menu.css">
        <link href="favicon.ico" type="image/vnd.microsoft.icon" rel="shortcut icon"/>        
    </head>
    <body data-token="<?php echo $uinfo['id']; ?>" data-rykey="<?php echo $uinfo['easemob_token']; ?>">
    <pre style="padding-top: 50px;padding-left: 50px">
    已实现功能:
        1.好友/群内的文字、表情、图片、文件 在线/离线消息发送和接收。 
        2.查看群员列表。 
        3.面板内快速查找。 
        4.面板右键自定义事件 
        5.修改签名
        6.自定义上传背景皮肤
        7.搜索好友/群
        8.添加好友/群
        9.新建群
        10.消息盒子展示
        11.查看/修改个人信息
        12.实时获取好友在线状态
        13.挤下线提醒
        14.文件储存在七牛云
        15.增删改 好友/好友分组
        16.群管理（增删管理员/修改群名片/单个群员禁言解除禁言/踢人）
        体验完整功能请移步<a href="https://github.com/shmilylbelva/webim" style="color: red">这里</a>
        如果登陆一段时间后接收不到消息，可能是有别的小伙伴登陆了这个账号^_^,点击这里<a href="http://test.guoshanchina.com/login.php" style="color: red">重新登陆</a>即可(还没做退出登陆00……)
    </pre>        
    </body>
        <script type='text/javascript' src='static/js/webim.config.js'></script>
        <script type='text/javascript' src='static/js/strophe-1.2.8.min.js'></script>
        <script type='text/javascript' src='static/js/websdk-1.4.13.js'></script> 
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
                        , type: 'post' //默认post
                    }
                    //上传文件接口
                    , uploadFile: {
                        url: 'class/doAction.php?action=uploadFile' //
                        , type: 'post' //默认post
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
                        url: 'class/doAction.php?action=getRecommend'
                        , type: 'get' //默认
                    }
                    //查找好友总数
                    ,findFriendTotal:{
                        url: 'class/doAction.php?action=findFriendTotal'
                        , type: 'get' //默认
                    }                      
                    //查找好友
                    ,findFriend:{
                        url: 'class/doAction.php?action=findFriend'
                        , type: 'get' //默认
                    }  
                    //获取好友资料
                    ,getInformation:{
                        url: 'class/doAction.php?action=getInformation'
                        , type: 'get' //默认
                    }  
                    //保存我的资料
                    ,saveMyInformation:{
                        url: 'class/doAction.php?action=saveMyInformation'
                        , type: 'post' //默认
                    }                     
                    //提交建群信息
                    ,commitGroupInfo:{
                        url: 'class/doAction.php?action=commitGroupInfo'
                        , type: 'get' //默认
                    }                                       
                    //获取系统消息
                    ,getMsgBox:{
                        url: 'class/doAction.php?action=getMsgBox'
                        , type: 'get' //默认post
                    }                      
                    //获取总的记录数
                    ,getChatLogTotal:{
                        url: 'class/doAction.php?action=getChatLogTotal'
                        , type: 'get' //默认post
                    }                       
                    //获取历史记录
                    ,getChatLog:{
                        url: 'class/doAction.php?action=getChatLog'
                        , type: 'get' //默认post
                    }                                     
                    , isAudio: false //开启聊天工具栏音频
                    , isVideo: false //开启聊天工具栏视频
                    , groupMembers: true
                    //扩展工具栏
                    // , tool: [{
                    //         alias: 'code'
                    //         , title: '代码'
                    //         , icon: '&#xe64e;'
                    //     }]
                    ,title: 'layim' 
                    ,copyright:true
                    , initSkin: '1.jpg' //1-5 设置初始背景
                    , notice: true //是否开启桌面消息提醒，默认false
                    , systemNotice: false //是否开启系统消息提醒，默认false
                    , msgbox: layui.cache.dir + 'css/modules/layim/html/msgbox.html' //消息盒子页面地址，若不开启，剔除该项即可
                    , find: layui.cache.dir + 'css/modules/layim/html/find.html' //发现页面地址，若不开启，剔除该项即可
                    , chatLog: layui.cache.dir + 'css/modules/layim/html/chatlog.html' //聊天记录页面地址，若不开启，剔除该项即可
                    , createGroup: layui.cache.dir + 'css/modules/layim/html/createGroup.html' //创建群页面地址，若不开启，剔除该项即可
                    , Information: layui.cache.dir + 'css/modules/layim/html/getInformation.html' //好友群资料页面
                });  
            });
        </script>  
</html>
