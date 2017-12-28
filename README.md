# WebIM
##简述
>本webim是基于 [layim]( http://layim.layui.com/) 和[环信webim3.X](https://www.easemob.com/)开发而成的，本项目仅供学习使用，使用前请先到layim[官网]( http://layim.layui.com/)获取layim的授权许可 。目前已完成的功能有：
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
##说明 
>1 群组管理相关功能不久就能完成了
---
原则上是不建议自行修改layim.js文件的，因为这样不利于后期的维护升级。

---
>部分截图如下
![好友间聊天](http://upload-images.jianshu.io/upload_images/2825702-7b39cfff734f1e8f.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


![自定义上传皮肤](http://upload-images.jianshu.io/upload_images/2825702-dd2ec176ddfe1a60.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![获取群成员](http://upload-images.jianshu.io/upload_images/2825702-1d63105222ec4e5b.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![自定义右键好友](http://upload-images.jianshu.io/upload_images/2825702-3f2f04a152686b28.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![已经是好友不能添加](http://upload-images.jianshu.io/upload_images/2825702-2227b43c6dca4240.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![消息盒子](http://upload-images.jianshu.io/upload_images/2825702-1c403876ecaca756.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![群管理](http://upload-images.jianshu.io/upload_images/2825702-56a71442f7475ac3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![添加好友](http://upload-images.jianshu.io/upload_images/2825702-e37e634a7b90d123.gif?imageMogr2/auto-orient/strip%7CimageView2/2/w/700)
![删除好友](http://upload-images.jianshu.io/upload_images/2825702-453f464a0da3bb6a.gif?imageMogr2/auto-orient/strip%7CimageView2/2/w/700)

体验地址：test.guoshanchina.com

体验帐号：

用户名：911088 密码：123456

用户名：1570855 密码：123456

用户名：1570845 密码：123456

用户名：911058 密码：123456

用户名：910992 密码：123456

用户名：911067 密码：123456

用户名：911100 密码：123456

用户名：911085 密码：123456


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
内容比较长就不贴出来了，需要源码的朋友可以在这里[下载](https://github.com/shmilylbelva/webim)https://github.com/shmilylbelva/webim,当然最好是star一下，因为我会继续完善该项目的。

【注意】github 上传的代码已去除layim.js，所以下载代码后请在你获取到 layim.js授权后将 layim.js 拖进 static / layui / lay / modules / 文件夹内方可运行。



