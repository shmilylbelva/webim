搭建客服系统看这里 [laykefu]( https://github.com/shmilylbelva/laykefu)

体验移动端功能看这里 [layim]( http://ee.laykefu.com/)

# WebIM
交流群【601391162】

## 简述

        本webim是基于 [layim]( http://layim.layui.com/) 和[环信webim3.X](https://www.easemob.com/)开发而成的，本项目仅供学习使用，使用前请先到layim[官网]( http://layim.layui.com/)获取layim的授权许可 。目前已完成的功能有：
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


## 需要配置修改的地方包括

    1 static/js/webim.config.js 环信配置文件appkey，需要先到环信注册添加应用获取。
    2 class/config.php 配置文件

    1） 因为考虑到需要和app之间进行通信（表情，图片等），环信的表情定义为[/:u]类似的字符而layim则为face[/:u]的字符，为了同时满足两种情况，修改了layim.js的表情相关代码，请知晓
    2） 自定义右键的删除功能借鉴的是layim的删除历史会话
    3） 自定义上传皮肤功能，在layim.js添加了一个setSkinByUser的方法，并修改了皮肤寻则模版，对应的上传路径是class/doAction.php?action=uploadSkin
    4） 面板内的搜索好友功能，修改了layim.js的search方法


>部分截图如下
![好友间聊天](http://upload-images.jianshu.io/upload_images/2825702-7b39cfff734f1e8f.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![我的资料](http://upload-images.jianshu.io/upload_images/2825702-806de922ef73f27b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![自定义上传皮肤](http://upload-images.jianshu.io/upload_images/2825702-dd2ec176ddfe1a60.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![自定义右键好友](http://upload-images.jianshu.io/upload_images/2825702-3f2f04a152686b28.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![自定义右键分组](http://upload-images.jianshu.io/upload_images/2825702-64d2021b6ffb7e96.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


![已经是好友不能添加](http://upload-images.jianshu.io/upload_images/2825702-2227b43c6dca4240.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![消息盒子](http://upload-images.jianshu.io/upload_images/2825702-1c403876ecaca756.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![群管理](http://upload-images.jianshu.io/upload_images/2825702-7a26d73871a0c64d.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![添加好友](http://upload-images.jianshu.io/upload_images/2825702-e37e634a7b90d123.gif?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![删除好友](http://upload-images.jianshu.io/upload_images/2825702-453f464a0da3bb6a.gif?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


开始之前，你要了解layui扩展第三方插件的方法，然后在环信注册帐号并创建应用。

1. layui绑定扩展


            layui.config({
                base: 'static/js/'
            }).extend({
                socket: 'socket',
            });


2. layim,socket初始化

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
                    ,systemSkin: {//选择系统皮肤
                        url: 'class/doAction.php?action=systemSkin'
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
                    ,title: '我的webim' 
                    ,copyright:true
                    , initSkin: '1.jpg' //1-5 设置初始背景
                    , notice: true //是否开启桌面消息提醒，默认false
                    , msgbox: layui.cache.dir + 'css/modules/layim/html/msgbox.html' //消息盒子页面地址，若不开启，剔除该项即可
                    , find: layui.cache.dir + 'css/modules/layim/html/find.html' //发现页面地址，若不开启，剔除该项即可
                    , chatLog: layui.cache.dir + 'css/modules/layim/html/chatLog.html' //聊天记录页面地址，若不开启，剔除该项即可
                });  
            });

3. socket.js
内容比较长就不贴出来了，需要源码的朋友可以下载查看

# WebIM移动端 功能
        本webim移动端是基于 [layim]( http://layim.layui.com/) 和[workerman](https://www.workerman.net/)开发而成的，本项目仅供学习使用，使用前请先到layim[官网]( http://layim.layui.com/)获取layim的授权许可 。
        目前已完成的功能有：
            1.好友/群内的文字、表情、图片、文件、视频、语音 在线/离线消息发送和接收。 
            2.查看群员列表
            3.查看群员信息
            4.查看好友信息/在线状态 
            5.修改头像签名
            6.发起群聊/邀请入群
            7.搜索好友/群
            8.添加好友/群
            9.二维码扫描加群加好友
            10.验证信息
            11.挤下线提醒
            12.群管理 全体/单个禁言/增删管理员/修改群名片
            13.群管理移除群员
            14.前端直传七牛云
            15.消息列表滑动删除历史消息
            16.查看历史消息
            17.默认生成名称头像


**觉得项目对您有用，请我喝杯咖啡吧。您的支持将鼓励我继续创作！**

![QQ截图20180904161534.jpg](https://upload-images.jianshu.io/upload_images/2825702-ae4567c3bf58fad4.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/320)
![QQ截图20180904161507.jpg](https://upload-images.jianshu.io/upload_images/2825702-ef48969aa5338754.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/320)


