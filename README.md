# WebIM
##简述
>本webim是基于 [layim v3.0.4 Pro 商用版]( http://layim.layui.com/) 和[环信webim3.X](https://www.easemob.com/)开发而成的，本项目仅供学习使用，使用前请先到layim[官网]( http://layim.layui.com/)获取layim的授权许可 。目前已完成的功能有：
1. 好友间的文字、表情、图片、文件的发送和接收。
2.群内的文字、表情、图片、文件的发送和接收，查看群员列表。
3.面板内通过昵称和帐号的快速查找好友。
4.面板右键自定义事件（【删除好友/退群】 好友双方同时删除对方，并删除与该好友的历史会话）
5.修改签名 至服务器
6.可自定义上传背景皮肤 且保存至服务器
7.搜索页面（只是静态页面）
8.如果你们同时也开发的app也是基于环信的，那么app是可以和web端聊天的，需要注意的是这里只支持一个账户登录一个端，需要多端同时登录首发信息需要到环信申请`增值服务-多设备同步`功能。
##说明 
>1）因为考虑到需要和app之间进行通信（表情，图片等），环信的表情定义为[/:u]类似的字符而layim则为face[/:u]的字符，为了同时满足两种情况，修改了layim.js的表情相关代码，请知晓
2） 自定义右键的删除功能借鉴的是layim的删除历史会话
3） 自定义上传皮肤功能，在layim.js添加了一个setSkinByUser的方法，并修改了皮肤寻则模版，对应的上传路径是class/doAction.php?action=uploadSkin
4） 面板内的搜索好友功能，修改了layim.js的search方法
---
原则上是不建议自行修改layim.js文件的，因为这样不利于后期的维护升级。

---
>部分截图如下
![好友间聊天](http://upload-images.jianshu.io/upload_images/2825702-7b39cfff734f1e8f.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


![自定义上传皮肤](http://upload-images.jianshu.io/upload_images/2825702-dd2ec176ddfe1a60.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![获取群成员](http://upload-images.jianshu.io/upload_images/2825702-1d63105222ec4e5b.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![Q自定义右键](http://upload-images.jianshu.io/upload_images/2825702-b4605403545b7e71.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![查找页面 静态](http://upload-images.jianshu.io/upload_images/2825702-6c60da9b8692baf7.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

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

用户名：911117 密码：123456



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
内容比较长就不贴出来了，需要源码的朋友可以在这里[下载](https://github.com/shmilylbelva/webim),当然最好是star一下，因为我会继续完善该项目的。



