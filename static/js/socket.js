layui.define(['jquery', 'layer','contextMenu'], function (exports) {
    var contextMenu = layui.contextMenu;
    var $ = layui.jquery;
    var layer = layui.layer;
    var cachedata =  layui.layim.cache();  
    var conf = {
        uid: 0, //
        key: '', //
        layim: null,
        token: null,
    };

    var conn = new WebIM.connection({
        isMultiLoginSessions: WebIM.config.isMultiLoginSessions,
        https: typeof WebIM.config.https === 'boolean' ? WebIM.config.https : location.protocol === 'https:',
        url: WebIM.config.xmppURL,
        heartBeatWait: WebIM.config.heartBeatWait,
        autoReconnectNumMax: WebIM.config.autoReconnectNumMax,
        autoReconnectInterval: WebIM.config.autoReconnectInterval,
        apiUrl: WebIM.config.apiURL,
        isAutoLogin: true
    }); 
    var socket = {
        config: function (options) {
            conf = $.extend(conf, options); //把layim继承出去，方便在register中使用
            this.register();
            im.init(options.user,options.pwd);
        },
        register: function () {
            var layim = conf.layim;
            if (layim) {
                //监听在线状态的切换事件
                layim.on('online', function (data) {
                    console.log('在线状态'+data);
                });
                //监听签名修改
                layim.on('sign', function (value) {
                    $.post('class/doAction.php?action=change_sign', {sign: value}, function (data) {
                        console.log('签名修改'+data);
                    });
                });
                //监听layim建立就绪
                layim.on('ready', function (res) {
                    if (cachedata.mine.msgBox != 0) {
                        layim.msgbox(cachedata.mine.msgBox); //消息盒子有新消息
                    };
                    ext.init();
                });
                
                //监听查看群员
                layim.on('members', function (data) {
                    console.log(data);
                });                

                //监听聊天窗口的切换
                layim.on('chatChange', function (res) {
                    var type = res.data.type;
                    if (type === 'friend') {
                        //模拟标注好友状态
                        //layim.setChatStatus('<span style="color:#FF5722;">在线</span>');
                    } else if (type === 'group') {
                        //模拟系统消息
//                        layim.getMessage({
//                            system: true
//                            , id: res.data.id
//                            , type: "group"
//                            , content: '模拟群员' + (Math.random() * 100 | 0) + '加入群聊'
//                        });
                    }
                });
                layim.on('sendMessage', function (data) { //监听发送消息
                    im.sendMsg(data);
                });
            }
        }          
    }; 

    var ext = {
        init : function(){//定义右键操作
            $(".layim-list-friend >li > ul > li").contextMenu({
                width: 110, // width
                itemHeight: 25, // 菜单项height
                bgColor: "#fff", // 背景颜色
                color: "#333", // 字体颜色
                fontSize: 12, // 字体大小
                hoverBgColor: "#009bdd", // hover背景颜色
                hoverColor: "#fff", // hover背景颜色
                target: function(ele) { // 当前元素
                    // console.log(ele);
                    $(".ul-context-menu>li").attr("data-id",ele[0].id);
                },
                menu: [{ // 菜单项
                        text: "查看资料",
                        icon: "static/img/add.png",
                        callback: function(ele) {
                            console.log(ele[0].dataset.id);

                        }
                    },
                    {
                        text: "聊天记录",
                        icon: "static/img/paste.png",
                        callback: function(ele) {
                            alert("粘贴");
                        }
                    },
                    {
                        text: "删除好友",
                        icon: "static/img/del.png",
                        callback: function(ele) {
                            var friend_id = ele[0].dataset.id.replace(/^layim-friend/g, '');   

                            for (i in cachedata.friend[0].list)
                            {
                                if (cachedata.friend[0].list[i].id === friend_id) {var username = cachedata.friend[0].list[i].username;var sign = cachedata.friend[0].list[i].sign;}
                            }
                            layer.confirm('删除后对方将从你的好友列表消失，且以后不会再接收此人的会话消息。<div class="layui-layim-list"><li layim-event="chat" data-type="friend" data-index="0"><img src="./uploads/person/'+friend_id+'.jpg"><span>'+username+'</span><p>'+sign+'</p></li></div>', {
                                btn: ['确定','取消'], //按钮
                                title:['删除好友','background:#b4bdb8'],
                                shade: 0
                            }, function(){
                                im.removeFriends(friend_id);  
                            }, function(){
                                var index = layer.open();
                                layer.close(index);
                            });                                                    
                        }
                    }
                ]
            });

            $(".layim-tab-content >li > .layim-list-group > li").contextMenu({
                width: 110, // width
                itemHeight: 25, // 菜单项height
                bgColor: "#fff", // 背景颜色
                color: "#333", // 字体颜色
                fontSize: 12, // 字体大小
                hoverBgColor: "#009bdd", // hover背景颜色
                hoverColor: "#fff", // hover背景颜色
                target: function(ele) { // 当前元素
                    $(".ul-context-menu>li").attr("data-id",ele[0].id);
                },
                menu: [{ // 菜单项
                        text: "查看资料",
                        icon: "static/img/add.png",
                        callback: function(ele) {
                            alert("新增");
                        }
                    },
                    {
                        text: "聊天记录",
                        icon: "static/img/paste.png",
                        callback: function(ele) {
                            alert("粘贴");
                        }
                    },
                    {
                        text: "退出该群",
                        icon: "static/img/del.png",
                        callback: function(ele) {
                            var group_id = ele[0].dataset.id.replace(/^layim-group/g, '');   
                            for (i in cachedata.group)
                            {
                                if (cachedata.group[i].id === group_id) {var groupname = cachedata.group[i].groupname;var avatar = cachedata.group[i].avatar;}
                            }
                            layer.confirm('您真的要退出该群吗？退出后你将不会再接收此群的会话消息。<div class="layui-layim-list"><li layim-event="chat" data-type="friend" data-index="0"><img src="'+avatar+'"><span>'+groupname+'</span></li></div>', {
                                btn: ['确定','取消'], //按钮
                                title:['提示','background:#b4bdb8'],
                                shade: 0
                            }, function(){
                                im.leaveGroup(group_id);  
                            }, function(){
                                var index = layer.open();  
                                layer.close(index);
                            }); 
                        }
                    }
                ]
            });            
        }
    }

    var im = {
        init: function (user,pwd) { 
            this.initListener(user,pwd);    //初始化事件监听
        },
        initListener: function (user,pwd) { //初始化监听
            // console.log('注册服务连接监听事件');
            // var layim = conf.layim;

            conn.listen({
                onOpened: function ( message ) { 
                    //连接成功回调
                    // 如果isAutoLogin设置为false，那么必须手动设置上线，否则无法收消息
                    // 手动上线指的是调用conn.setPresence(); 如果conn初始化时已将isAutoLogin设置为true
                    // 则无需调用conn.setPresence();             
                },  
                onClosed: function ( message ) {},         //连接关闭回调
                onTextMessage: function ( message ) {
                    im.defineMessage(message,'Text');
                },    //收到文本消息
                onEmojiMessage: function ( message ) {},   //收到表情消息
                onPictureMessage: function ( message ) {
                    im.defineMessage(message,'Picture');
                }, //收到图片消息
                onCmdMessage: function ( message ) {},     //收到命令消息
                onAudioMessage: function ( message ) {
                    var options = { url: message.url };
                    options.onFileDownloadComplete = function ( response ) { 
                        //音频下载成功，需要将response转换成blob，使用objectURL作为audio标签的src即可播放。
                        var objectURL = WebIM.utils.parseDownloadResponse.call(conn, response);
                        message.audio = objectURL;
                        im.defineMessage(message,'Audio');    
                    };  

                    options.onFileDownloadError = function () {
                      //音频下载失败 
                    };  
                    //通知服务器将音频转为mp3
                    options.headers = { 
                      'Accept': 'audio/mp3'
                    };
                    WebIM.utils.download.call(conn, options);
                         
                },     //收到音频消息
                onLocationMessage: function ( message ) {},//收到位置消息
                onFileMessage: function ( message ) {
                    im.defineMessage(message,'File');                    
                },    //收到文件消息
                onVideoMessage: function (message) {
                    var options = { url: message.url };
                    options.onFileDownloadComplete = function ( response ) { 
                        //音频下载成功，需要将response转换成blob，使用objectURL作为audio标签的src即可播放。
                        var objectURL = WebIM.utils.parseDownloadResponse.call(conn, response);
                        message.video = objectURL;
                        im.defineMessage(message,'Video');       
                    };  
                    options.onFileDownloadError = function () {
                      //音频下载失败 
                    };  
                    //通知服务器将音频转为mp4
                    options.headers = { 
                      'Accept': 'audio/mp4'
                    };

                    WebIM.utils.download.call(conn, options);
                },   //收到视频消息
                onPresence: function ( message ) {//监听对方的添加或者删除好友请求，并做相应的处理。
                    if (message.type == 'unsubscribe') {
                        conf.layim.removeList({//从我的列表删除
                          type: 'friend' //或者group
                          ,id: message.from //好友或者群组ID
                        }); 
                        im.removeHistory({//从我的列表删除
                          type: 'friend' //或者group
                          ,id: username //好友或者群组ID
                        });
                        parent.location.reload();                    
                    }else if(message.type =='subscribe'){//收到添加请求
                        im.audio('新');                                               
                    }else if(message.type =='subscribed'){//对方通过了你的好友请求
                        
                        if (message.to == cachedata.mine.id && message.status =='Success') {
                            im.audio('新');   
                            $.get('class/doAction.php?action=get_one_user_data',{memberIdx:message.from},function(res){
                                var data = eval('(' + res + ')');
                                conf.layim.addList({
                                    type: 'friend' //列表类型，只支持friend和group两种
                                    ,avatar: './uploads/person/'+message.from +'.jpg' //好友头像
                                    ,username: data.data.memberName || [] //好友昵称
                                    ,groupid: 1 //所在的分组id
                                    ,id: data.data.memberIdx || [] //好友id
                                    ,sign: data.data.signature || [] //好友签名
                                }); 
                                ext.init();//更新右键点击事件
                                 
                            })               
                        };

                    }else if (message.type == 'unsubscribed') {//拒绝好友申请
                        if (message.to == cachedata.mine.id && message.status =='rejectAddFriend') {
                            im.audio('新');          
                        };
                    }
                },//处理“广播”或“发布-订阅”消息，如联系人订阅请求、处理群组、聊天室被踢解散等消息
                onRoster: function ( message ) {
                    if (message[0].subscription == 'to' && message[0].ask == 'subscribe') {
                        $.get('class/doAction.php?action=get_one_user_data',{memberIdx:message[0].name},function(res){
                            var data = eval('(' + res + ')');
                            layer.msg('你申请添加 '+data.data.memberName+' 为好友的消息已发送。请等待对方确认');
                            
                        });                             
                    }
                },         //处理好友申请
                onInviteMessage: function ( message ) {},  //处理群组邀请
                onOnline: function () {},                  //本机网络连接成功
                onOffline: function () {},                 //本机网络掉线
                onError: function ( message ) {},          //失败回调
                onBlacklistUpdate: function (list) {       //黑名单变动
                    // 查询黑名单，将好友拉黑，将好友从黑名单移除都会回调这个函数，list则是黑名单现有的所有好友信息
                    console.log(list);
                },
                onReceivedMessage: function(message){},    //收到消息送达服务器回执
                onDeliveredMessage: function(message){},   //收到消息送达客户端回执
                onReadMessage: function(message){},        //收到消息已读回执
                onCreateGroup: function(message){},        //创建群组成功回执（需调用createGroupNew）
                onMutedMessage: function(message){}        //如果用户在A群组被禁言，在A群发消息会走这个回调并且消息不会传递给群其它成员
            }); 

            var options = { 
              apiUrl: WebIM.config.apiURL,
              user: user,
              pwd: pwd,
              appKey: WebIM.config.appkey
            };
            conn.open(options);
        },
        //自定义消息，把消息格式定义为layim的消息类型
        defineMessage: function (message,msgType) {
            var msg;
            switch (msgType) 
            {
                case 'Text': msg = message.data;break;
                case 'Picture': msg = 'img['+message.thumb+']';break;
                case 'Audio': msg = 'audio['+message.audio+']';break;
                case 'File': msg = 'file('+message.url+')['+message.filename+']';break;
                case 'Video': msg = 'video['+message.video+']';break;
            };
            if (message.type == 'chat') {
                var type = 'friend';
                var id = message.from;
            }else if(message.type == 'groupchat'){
                var type = 'group';
                var id = message.to;
            }               
            if (message.delay) {//离线消息获取不到本地cachedata用户名称需要从服务器获取
                $.get('class/doAction.php?action=get_one_user_data', {memberIdx:message.from}, function (res) {
                    var res_data = eval('(' + res + ')');
                    if (res_data.code == 0) {
                        var username = res_data.data.memberName; 
                        var data = {mine: false,cid: 0,username:username,avatar:"./uploads/person/"+message.from+".jpg",content:msg,id:id,fromid: message.from,timestamp:timestamp,type:type}                                              
                        conf.layim.getMessage(data);
                    }
                });                
                var timestamp = Date.parse(new Date(message.delay));                   
            }else{
                var timestamp = (new Date()).valueOf(); 
                for (i in cachedata.friend[0].list)
                { 
                    if (cachedata.friend[0].list[i].id === message.from) {var username = cachedata.friend[0].list[i].username;}
                } 
                conf.layim.getMessage(data);               
            }         
        }, 
        sendMsg: function (data) {  //根据layim提供的data数据，进行解析
            var id = conn.getUniqueId();
            var content = data.mine.content;
            var msg = new WebIM.message('txt', id);      // 创建文本消息
            // var url = content.replace(/img\[([^\s\[\]]+?)\]/g, function(img){  //转义图片
            //   var msg = new WebIM.message('img', id); 
            //   return img.replace(/^img/g, '');
            // });  // 生成本地消息id
            
            msg.set({
                msg: data.mine.content,   
                to: data.to.id,                          // 接收消息对象（用户id）
                roomType: false,
                success: function (id, serverMsgId) {//发送成功则记录信息到服务器
                    $.get('class/doAction.php?action=addChatLog', {to:data.to.id,content:data.mine.content,sendTime: data.mine.timestamp,type:data.to.type}, function (res) {
                        var data = eval('(' + res + ')');
                        if (data.code != 0) {
                            console.log('message record fail');                       
                        }
                        
                    });
                },
                fail: function(e){//发送失败移除发送消息并提示发送失败
                    var logid = cachedata.local.chatlog[data.to.type+data.to.id];
                        logid.pop();                 
                    var timestamp = '.timestamp'+data.mine.timestamp;
                    $(timestamp).html('<i class="layui-icon" style="color: #F44336;font-size: 20px;float: left;margin-top: 1px;">&#x1007;</i>发送失败 刷新页面试试！');  
                }
            });
            if (data.to.type == 'group') {
                msg.setGroup('groupchat');
                msg.body.chatType = 'chatRoom';
            }else{
                msg.body.chatType = 'singleChat';
            }

            // msg.body.chatType = 'singleChat';
            // msg.body.Type = 'img';
            conn.send(msg.body);
        },      
        removeFriends: function (username) {
            conn.removeRoster({
                to: username,
                success: function () {  // 删除成功
                    var index = layer.open();
                    layer.close(index);
                    conf.layim.removeList({//从我的列表删除
                        type: 'friend' //或者group
                        ,id: username //好友或者群组ID
                    });  
                    im.removeHistory({//从我的历史列表删除
                        type: 'friend' //或者group
                        ,id: username //好友或者群组ID
                    });
                    parent.location.reload();
                },
                error: function () { 
                    console.log('removeFriends faild');
                   // 删除失败
                }
            });
        },  
        leaveGroup: function (roomId) {
            var option = {
                to: 'admin',//乱填的
                roomId: roomId,
                success: function () {
                    var index = layer.open();
                    layer.close(index);
                    conf.layim.removeList({
                        type: 'group' //或者group
                        ,id: roomId //好友或者群组ID
                    });
                    im.removeHistory({//从我的历史列表删除
                        type: 'group' //或者group
                        ,id: roomId //好友或者群组ID
                    })                    
                    parent.location.reload();
                },
                error: function () {
                    console.log('群主不能离开/Leave room faild');
                }
            };
            conn.leaveGroupBySelf(option);
        }, 
        removeHistory: function(data){//删除好友或退出群后清除历史记录
           
            var history = cachedata.local.history;
            delete history[data.type+data.id];
            cachedata.local.history = history;
            layui.data('layim', {
              key: cachedata.mine.id
              ,value: cachedata.local
            });
            $('#layim-history'+data.id).remove();
            var hisElem = $('.layui-layim').find('.layim-list-history');
            var none = '<li class="layim-null">暂无历史会话</li>'        
            if(hisElem.find('li').length === 0){
              hisElem.html(none);
            }        
        },
        IsExist: function (avatar){ //判断头像是否存在
            var ImgObj=new Image();
            ImgObj.src= avatar;
             if(ImgObj.fileSize > 0 || (ImgObj.width > 0 && ImgObj.height > 0))
             {
               return true;
             } else {
               return false;
            }
        },  
        audio:function(msg){//消息提示
            conf.layim.msgbox(msg);
            var audio = document.createElement("audio");
            audio.src = layui.cache.dir+'css/modules/layim/voice/'+ cachedata.base.voice;
            audio.play(); //消息提示音              
        },
        addFriend:function(othis){
            var li = othis.parents('li')
                    , uid = li.data('uid')
                    , name = li.data('name');
            var avatar = './uploads/person/'+uid+'.jpg';
            var default_avatar = './uploads/empty2.jpg';

            var isAdd = false;
            if(cachedata.mine.id == uid){//添加的是自己
                layer.msg('不能添加自己');
                return false;
            }
            for (i in cachedata.friend[0].list)//是否已经是好友
            {
                if (cachedata.friend[0].list[i].id == uid) {isAdd = true;break;}
            }

            parent.layui.layim.add({//弹出添加好友对话框
                isAdd: isAdd
                ,username: name || []
                ,uid:uid
                ,avatar: im['IsExist'].call(this, avatar)?avatar:default_avatar
                ,group:  parent.layui.layim.cache().friend || []
                ,type: 'friend'
                ,submit: function(group,remark,index){//确认发送添加请求
                    $.get('class/doAction.php?action=add_msg', {to: uid,msgType:1,remark:remark}, function (res) {
                        var data = eval('(' + res + ')');
                        if (data.code == 0) {
                            conn.subscribe({
                                to: uid,
                                message: remark  
                            });                            
                            layer.msg('你申请添加'+name+'为好友的消息已发送。请等待对方确认');
                        }else{
                            layer.msg('你申请添加'+name+'为好友的消息发送失败。请刷新浏览器后重试');
                        }
                    });
                },function(){
                    layer.close(index);
                }
            });            

        },
        addGroup:function(othis){
            var li = othis.parents('li')
                    , uid = li.data('uid')
                    , name = li.data('name');
            var avatar = './uploads/person/'+uid+'.jpg';
            var default_avatar = './uploads/empty2.jpg';
            var isAdd = false;
            for (i in cachedata.group)//是否已经加群
            {
                if (cachedata.group[i].id == uid) {isAdd = true;break;}
            }

            parent.layui.layim.add({//弹出添加好友对话框
                isAdd: isAdd
                ,groupname: name || []
                ,uid:uid
                ,avatar: im['IsExist'].call(this, avatar)?avatar:default_avatar
                ,group:  parent.layui.layim.cache().friend || []
                ,type: 'group'
                ,submit: function(group,remark,index){//确认发送添加请求
                    $.get('class/doAction.php?action=add_msg', {to: uid,msgType:3,remark:remark}, function (res) {
                        var data = eval('(' + res + ')');
                        if (data.code == 0) {
                            var options = {
                                    groupId: uid,
                                    success: function(resp) {
                                        console.log("Response: ", resp);
                                    },
                                    error: function(e) {
                                        if(e.type == 17){
                                            console.log("您已经在这个群组里了");
                                        }
                                    }
                                };
                            conn.joinGroup(options);                          
                            layer.msg('你申请加入'+name+'的消息已发送。请等待管理员确认');
                        }else{
                            layer.msg('你申请加入'+name+'的消息发送失败。请刷新浏览器后重试');
                        }
                    });
                },function(){
                    layer.close(index);
                }
            });  
        },
        receiveAddFriendGroup:function(othis,agree){//确认添加好友或群
            var li = othis.parents('li')
                    , uid = li.data('uid')
                    , username = li.data('name')
                    , type = li.data('type')
                    , signature = li.data('signature')
                    , msgIdx = li.data('id'); 
            if (type == 1) {
                type = 'friend';
                msgType = 2;
            }else{
                type = 'group';               
                msgType = 4;  
            }
            var status = agree == 2?2:3;
            var avatar = './uploads/person/'+uid+'.jpg';
            var default_avatar = './uploads/empty2.jpg'; 
            if (agree == 2) {
                conf.layim.setFriendGroup({
                    type: type
                    , username: username//用户名称或群组名称
                    , avatar: im['IsExist'].call(this, avatar)?avatar:default_avatar
                    , group: parent.layui.layim.cache().friend //获取好友分组数据
                    , submit: function (group, index) { 
                        $.get('class/doAction.php?action=modify_msg', {msgIdx: msgIdx,msgType:msgType,status:status}, function (res) {
                            var data = eval('(' + res + ')');
                            if (data.code == 0) {
                                //将好友/群 追加到主面板
                                if (type == 'friend') {
                                    parent.layui.layim.addList({
                                        type: 'friend'
                                        , avatar: im['IsExist'].call(this, avatar)?avatar:default_avatar //好友头像
                                        , username: username //好友昵称
                                        , groupid: group //所在的分组id
                                        , id: '"'+uid+'"' //好友ID
                                        , sign: signature //好友签名
                                    });
                                }else{
                                    parent.layui.layim.addList({
                                        type: 'group'
                                        , avatar: default_group_avatar //默认群头像
                                        , groupname: username //群昵称
                                        , id: uid //群ID
                                    });
                                }
                                conn.subscribed({//同意添加后通知对方
                                  to: uid,
                                  message : 'Success'
                                });                                
                                parent.layer.close(index);
                                othis.parent().html('已同意');
                                parent.location.reload();
                                ext.init();//更新右键点击事件                          
                            }else{
                                console.log('添加失败');
                            }
                        });                    
                        layer.close(index);
                    }
                }); 
            }else{              
                $.get('class/doAction.php?action=modify_msg', {msgIdx: msgIdx,msgType:msgType,status:status}, function (res) {
                    var data = eval('(' + res + ')');
                    if (data.code == 0) {
                        conn.unsubscribed({
                          to: uid,
                          message : 'rejectAddFriend'
                        });  
                        othis.parent().html('<em>已拒绝</em>');                        
                    }
                    layer.close(layer.index);
                });                

            }

        }                          
    };
    exports('socket', socket);
    exports('im', im);
});