# WebIM

PHP + layIM + 融云 版 Web IM

M-finder博客  www.m-finder.com

IT行业交流群   295721957

本版本只是简单实现了聊天功能，因为还没有获取授权，完整功能就等获取授权以后吧



所用插件：

layIM 3.0.4          本项目中已去除layim.js

融云开源Server SDK    server-sdk-php



体验地址：www.m-finder.com/webim

体验帐号：

用户名：Luffy   密码：admin888 

用户名：Shanks  密码：admin888 

用户名：Buggy   密码：admin888 





开始之前，你要了解layui扩展第三方插件的方法，然后在融云注册帐号并创建应用，最后在融云的server开发指南中下载php版sdk。

1. layui绑定扩展


layui.config({

    base: 'static/js/'      //第三方扩展路径
    
}).extend({

    rmlib: 'rmlib',         //static/js/rmlib.js        对应于融云的http(s)://cdn.ronghub.com/RongIMLib-2.2.5.min.js
    
    protobuf: 'protobuf',   //static/js/protobuf.js     对应于融云的http(s)://cdn.ronghub.com/protobuf-2.1.5.min.js
    
    socket: 'socket',       //融云的方法和layim的方法封装
    
});


2. layim,socket初始化

layui.use(['layim', 'jquery', 'socket'], function (layim, socket) {

    var $ = layui.jquery;
    var socket = layui.socket;
    var token = $('body').data('token');
    var rykey = $('body').data('rykey');
    
    socket.config({     // socket初始化。
        key: rykey,
        token: token,
        layim: layim,
    });

    layim.config({
        init: {
            url: 'class/doAction.php?action=get_user_data', data: {}
        },
        //…… layui基础配置，直接复制官网
    });  
}

3. socket.js

如果看不懂，可以参照着融云的web im通讯能力库文档和layim的文档，这里就是两者的结合。


