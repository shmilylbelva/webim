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
                });                

                //监听聊天窗口的切换
                layim.on('chatChange', function (res) {
                    var type = res.data.type;
                    if (type === 'friend') {
                        //模拟标注好友状态
                        //layim.setChatStatus('<span style="color:#FF5722;">在线</span>');
                    } else if (type === 'group') {
                        //模拟系统消息
                       // layim.getMessage({
                       //     system: true
                       //     , id: res.data.id
                       //     , type: "group"
                       //     , content: '模拟群员' + (Math.random() * 100 | 0) + '加入群聊'
                       // });
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
                width: 140, // width
                itemHeight: 30, // 菜单项height
                bgColor: "#fff", // 背景颜色
                color: "#333", // 字体颜色
                fontSize: 15, // 字体大小
                hoverBgColor: "#009bdd", // hover背景颜色
                hoverColor: "#fff", // hover背景颜色
                target: function(ele) { // 当前元素
                    // console.log(ele[0].id);
                    $(".ul-context-menu").attr("data-id",ele[0].id);
                    $(".ul-context-menu").attr("data-name",ele.find("span").html());
                    $(".ul-context-menu").attr("data-img",ele.find("img").attr('src'));
                },
                menu: [
                    { // 菜单项
                        text: "发送消息",
                        icon: "&#xe63a;",
                        callback: function(ele) {
                            var othis = ele.parent(),
                                friend_id = othis[0].dataset.id.replace(/^layim-friend/g, ''),
                                friend_name = othis[0].dataset.name,
                                friend_avatar = othis[0].dataset.img;
                            conf.layim.chat({
                                name: friend_name
                                ,type: 'friend'
                                ,avatar: friend_avatar
                                ,id: friend_id
                            });
                        }
                    },                
                    { // 菜单项
                        text: "查看资料",
                        icon: "&#xe62a;",
                        callback: function(ele) {
                            var othis = ele.parent(),friend_id = othis[0].dataset.id.replace(/^layim-friend/g, '');
                            im.getInformation({
                                id: friend_id,
                                type:'friend'
                            });                        
                        }
                    },
                    {
                        text: "聊天记录",
                        icon: "&#xe60e;",
                        callback: function(ele) {
                            var othis = ele.parent(),
                                friend_id = othis[0].dataset.id.replace(/^layim-friend/g, ''),
                                friend_name = othis[0].dataset.name;
                            im.getChatLog({
                                name: friend_name,
                                id: friend_id,
                                type:'friend'
                            });    
                        }
                    },
                    {
                        text: "修改备注名称",
                        icon: "&#xe6b2;",
                        callback: function(ele) {
                            alert('开发中');                                                   
                        }
                    },     
                    {
                        text: "移动联系人至",
                        icon: "&#xe630;",
                        callback: function(ele) {
                            alert('开发中');                                              
                        }
                    }, 
                    {
                        text: "删除好友",
                        icon: "&#xe640;",
                        callback: function(ele) {
                            var othis = ele.parent(),
                                friend_id = othis[0].dataset.id.replace(/^layim-friend/g, ''); 
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
                width: 140, // width
                itemHeight: 30, // 菜单项height
                bgColor: "#fff", // 背景颜色
                color: "#333", // 字体颜色
                fontSize: 15, // 字体大小
                hoverBgColor: "#009bdd", // hover背景颜色
                hoverColor: "#fff", // hover背景颜色
                target: function(ele) { // 当前元素
                    $(".ul-context-menu").attr("data-id",ele[0].id);
                    $(".ul-context-menu").attr("data-name",ele.find("span").html());
                    $(".ul-context-menu").attr("data-img",ele.find("img").attr('src'));                    
                },
                menu: [
                    { // 菜单项
                        text: "发送群消息",
                        icon: "&#xe63a;",
                        callback: function(ele) {
                            var othis = ele.parent(),
                                group_id = othis[0].dataset.id.replace(/^layim-group/g, ''),
                                group_name = othis[0].dataset.name,
                                group_avatar = othis[0].dataset.img;
                            conf.layim.chat({
                                name: group_name
                                ,type: 'group'
                                ,avatar: group_avatar
                                ,id: group_id
                            });
                        }
                    },
                    { // 菜单项
                        text: "查看资料",
                        icon: "&#xe62a;",
                        callback: function(ele) {
                            var othis = ele.parent(),group_id = othis[0].dataset.id.replace(/^layim-group/g, '');
                            im.getInformation({
                                id: group_id,
                                type:'group'
                            });  
                        }
                    },
                    {
                        text: "聊天记录",
                        icon: "&#xe60e;",
                        callback: function(ele) {
                            var othis = ele.parent(),
                                group_id = othis[0].dataset.id.replace(/^layim-group/g, ''),
                                groupname = othis[0].dataset.name;
                            im.getChatLog({
                                name: groupname,
                                id: group_id,
                                type:'group'
                            });   
                        }
                    },                    
                    {
                        text: "修改备注名称",
                        icon: "&#xe6b2;",
                        callback: function(ele) {

                        }
                    },
                    {
                        text: "退出该群",
                        icon: "&#xe613;",
                        callback: function(ele) {
                            var othis = ele.parent(),
                                group_id = othis[0].dataset.id.replace(/^layim-group/g, ''),  
                                groupname = othis[0].dataset.name;
                                avatar = othis[0].dataset.img;
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
                    console.log(message);
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
                    }else if(message.type == 'joinGroupNotifications'){//群管理收到加群申请 将该管理员加入消息组
                        $.get('class/doAction.php?action=add_admin_msg', {from: message.from,adminGroup: message.to,to: message.gid}, function (res) {
                            // var data = eval('(' + res + ')');
                            // if (data.code == 0) {                             
                            //     layer.msg('你申请加入'+message.toNick+'的消息已发送。请等待管理员确认');
                            // }else{
                            //     layer.msg('你申请加入'+message.toNick+'的消息发送失败。请刷新浏览器后重试');
                            // }
                        });                          
                        im.audio('新');
                    }else if(message.type == 'memberJoinPublicGroupSuccess'){
                        // $.get('class/doAction.php?action=get_one_user_data',{memberIdx:message.mid},function(res){
                            // var data = eval('(' + res + ')');
                            // conf.layim.addList({
                            //     type: 'group' //列表类型，只支持friend和group两种
                            //     ,avatar: './uploads/person/'+message.mid +'.jpg' //好友头像
                            //     ,groupname: data.data.memberName || [] //好友昵称
                            //     ,id: message.from //群组id
                            // }); 
                        //     ext.init();//更新右键点击事件
                        // })                         
                    }else if(message.type == 'joinPublicGroupSuccess'){
                        im.audio('新');
                        var default_avatar = './uploads/person/empty1.jpg';
                        var avatar = './uploads/person/'+resp.data[0].id +'.jpg';
                        var options = {
                            groupId: message.from,
                            success: function(resp){
                                conf.layim.addList({
                                    type: 'group' //列表类型，只支持friend和group两种
                                    ,avatar: im['IsExist'].call(this, avatar)?avatar:default_avatar   //群头像
                                    ,groupname: resp.data[0].name || [] //群名称
                                    ,id: resp.data[0].id  //群组id
                                }); 
                                ext.init();//更新右键点击事件                                
                            },
                            error: function(){}
                        };
                        conn.getGroupInfo(options);                        
                    }
                },//处理“广播”或“发布-订阅”消息，如联系人订阅请求、处理群组、聊天室被踢解散等消息
                onRoster: function ( message ) {
                    console.log('处理“广播”');
                    if (message[0].subscription == 'to' && message[0].ask == 'subscribe') {
                        $.get('class/doAction.php?action=get_one_user_data',{memberIdx:message[0].name},function(res){
                            var data = eval('(' + res + ')');
                            layer.msg('你申请添加 '+data.data.memberName+' 为好友的消息已发送。请等待对方确认');
                            
                        });                             
                    }
                },         //处理好友申请
                onInviteMessage: function ( message ) {
                    console.log('处理群组邀请');
                },  //处理群组邀请
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
            if (message.ext.system) {//如果是系统消息                
                conf.layim.getMessage({
                  system: true //系统消息
                  ,id: message.to //聊天窗口ID
                  ,type: "group" //聊天窗口类型
                  ,content: message.ext.username + '已加入该群'
                }); 
                return; 
            }
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
                // $.get('class/doAction.php?action=get_one_user_data', {memberIdx:message.from}, function (res) {
                //     var res_data = eval('(' + res + ')');
                //     if (res_data.code == 0) {
                //         var username = res_data.data.memberName; 
                //         // var data = {mine: false,cid: 0,username:username,avatar:"./uploads/person/"+message.from+".jpg",content:msg,id:id,fromid: message.from,timestamp:timestamp,type:type}                                              
                //         // conf.layim.getMessage(data);
                //     }
                // });                
                var timestamp = Date.parse(new Date(message.delay));                   
            }else{
                var timestamp = (new Date()).valueOf(); 
                // for (i in cachedata.friend[0].list)
                // { 
                //     if (cachedata.friend[0].list[i].id === message.from) {var username = cachedata.friend[0].list[i].username;}
                // }                
            }  
                var data = {mine: false,cid: 0,username:message.ext.username,avatar:"./uploads/person/"+message.from+".jpg",content:msg,id:id,fromid: message.from,timestamp:timestamp,type:type}
                conf.layim.getMessage(data);            

        }, 
        sendMsg: function (data) {  //根据layim提供的data数据，进行解析
            var id = conn.getUniqueId();
            var content = data.mine.content;
            var msg = new WebIM.message('txt', id);      // 创建文本消息
            // var url = content.replace(/img\[([^\s\[\]]+?)\]/g, function(img){  //转义图片
            //   var msg = new WebIM.message('img', id); 
            //   return img.replace(/^img/g, '');
            // });  // 生成本地消息id
            if (data.to.id == data.mine.id) {
                layer.msg('不能给自己发送消息');
                return;
            }
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
            msg.body.ext.username = cachedata.mine.username;
            if (data.to.system == 'system') {
                msg.body.ext.system = 'system';
            }
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
        getChatLog: function (data){
            if(!cachedata.base.chatLog){
            return layer.msg('未开启更多聊天记录');
            }
            var index = layer.open({
                type: 2
                ,maxmin: true
                ,title: '与 '+ data.name +' 的聊天记录'
                ,area: ['450px', '600px']
                ,shade: false
                ,skin: 'layui-box'
                ,anim: 2
                ,id: 'layui-layim-chatlog'
                ,content: cachedata.base.chatLog + '?id=' + data.id + '&type=' + data.type
            });
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
        addFriendGroup:function(othis,type){
            var li = othis.parents('li')
                    , uid = li.data('uid')
                    , approval = li.data('approval')
                    , name = li.data('name');
            var avatar = './uploads/person/'+uid+'.jpg';
            var isAdd = false;
            if (type == 'friend') {
                var default_avatar = './uploads/person/empty2.jpg';
                if(cachedata.mine.id == uid){//添加的是自己
                    layer.msg('不能添加自己');
                    return false;
                }
                for (i in cachedata.friend[0].list)//是否已经是好友
                {
                    if (cachedata.friend[0].list[i].id == uid) {isAdd = true;break;}
                }
            }else{
                var default_avatar = './uploads/person/empty1.jpg';
                for (i in cachedata.group)//是否已经加群
                {
                    if (cachedata.group[i].id == uid) {isAdd = true;break;}
                }
            }
            parent.layui.layim.add({//弹出添加好友对话框
                isAdd: isAdd
                ,approval: approval
                ,username: name || []
                ,uid:uid
                ,avatar: im['IsExist'].call(this, avatar)?avatar:default_avatar
                ,group:  parent.layui.layim.cache().friend || []
                ,type: type
                ,submit: function(group,remark,index){//确认发送添加请求
                    if (type == 'friend') {
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
                    }else{
                        var options = {
                            groupId: uid,
                            success: function(resp) {
                                if (approval == '1') {
                                    $.get('class/doAction.php?action=add_msg', {to: uid,msgType:3,remark:remark}, function (res) {
                                        var data = eval('(' + res + ')');
                                        if (data.code == 0) {                        
                                            layer.msg('你申请加入'+name+'的消息已发送。请等待管理员确认');
                                        }else{
                                            layer.msg('你申请加入'+name+'的消息发送失败。请刷新浏览器后重试');
                                        }
                                    });                                      
                                    
                                }else{
                                    layer.msg('你已加入 '+name+' 群');
                                } 

                                // console.log("Response: ", resp);
                            },
                            error: function(e) {
                                if(e.type == 17){
                                    layer.msg('您已经在这个群组里了');
                                }
                            }
                        };
                        conn.joinGroup(options);                           
                    }
                },function(){
                    layer.close(index);
                }
            });            

        },
        receiveAddFriendGroup:function(othis,agree){//确认添加好友或群
            var li = othis.parents('li')
                    , type = li.data('type')
                    , uid = li.data('uid')
                    , username = li.data('name')
                    , signature = li.data('signature')
                    , msgIdx = li.data('id'); 
            if (type == 1) {
                type = 'friend';
                var avatar = './uploads/person/'+uid+'.jpg';                
                msgType = 2;
            }else{
                type = 'group';
                var groupIdx = li.data('groupidx');
                msgType = 4;  
            }
            var status = agree == 2?2:3; 
            if (agree == 2) {
                if (msgType == 2) {
                    var default_avatar = './uploads/person/empty2.jpg';
                    conf.layim.setFriendGroup({
                        type: type
                        , username: username//用户名称或群组名称
                        , avatar: im['IsExist'].call(this, avatar)?avatar:default_avatar
                        , group: parent.layui.layim.cache().friend //获取好友分组数据
                        , submit: function (group, index) { 
                            $.get('class/doAction.php?action=modify_msg', {msgIdx: msgIdx,msgType:msgType,status:status}, function (res) {
                                var data = eval('(' + res + ')');
                                if (data.code == 0) {
                                    //将好友 追加到主面板
                                    parent.layui.layim.addList({
                                        type: 'friend'
                                        , avatar: im['IsExist'].call(this, avatar)?avatar:default_avatar //好友头像
                                        , username: username //好友昵称
                                        , groupid: group //所在的分组id
                                        , id: '"'+uid+'"' //好友ID
                                        , sign: signature //好友签名
                                    });
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
                }else if(msgType = 4){
                    var default_avatar = './uploads/person/empty1.jpg';
                    $.get('class/doAction.php?action=modify_msg', {msgIdx: msgIdx,msgType:msgType,status:status}, function (res) {
                        var data = eval('(' + res + ')');
                        if (data.code == 0) {
                            var options = {
                                    applicant: uid,
                                    groupId: groupIdx,
                                    success: function(resp){  
                                        conn.subscribed({//同意添加后通知对方
                                          to: uid,
                                          message : 'addGroupSuccess'
                                        }); 
                                        im.sendMsg({//系统消息
                                            mine:{
                                                content:username
                                            },
                                            to:{
                                                id:groupIdx,
                                                type:'group',
                                                system:'system'
                                            }
                                        });
                                    },
                                    error: function(e){}
                                };
                            conn.agreeJoinGroup(options);                           
                            othis.parent().html('已同意');
                            // parent.location.reload();
                            ext.init();//更新右键点击事件                          
                        }else{
                            console.log('添加失败');
                        }
                    });                    
                }

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

        },
        //创建群
        createGroup: function(othis){
            var index = layer.open({
                type: 2
                ,title: '创建群'
                ,shade: false
                ,maxmin: false
                ,area: ['550px', '400px']
                ,skin: 'layui-box layui-layer-border'
                ,resize: false
                ,content: cachedata.base.createGroup
            });
        },
        commitGroupInfo: function(othis,data){
            if (!data.groupName) {
                return false;
            }
            $.get('class/doAction.php?action=userMaxGroupNumber', {}, function(res){
                var resData = eval('(' + res + ')');
                if(resData.code == 0){
                    var options = {
                        data: {
                            groupname: data.groupName,
                            desc: data.des,
                            maxusers:data.number,
                            public: true,
                            approval: data.approval == '1'?true:false,
                            allowinvites: true
                        },
                        success: function (respData) {
                            if (respData.data.groupid) {
                                $.get('class/doAction.php?action=commitGroupInfo', {groupIdx:respData.data.groupid,groupName: data.groupName,des:data.des,number:data.number,approval:data.approval}, function(respdata){
                                    var res = eval('(' + respdata + ')');
                                    if(res.code == 0){
                                        //将群 追加到主面板
                                        var avatar = './uploads/person/'+respData.data.groupid+'.jpg'; 
                                        var default_avatar = './static/img/tel.jpg';
                                        console.log(data);
                                        layer.msg(res.msg);
                                        parent.layui.layim.addList({
                                            type: 'group'
                                            , avatar: im['IsExist'].call(this, avatar)?avatar:default_avatar //好友头像
                                            , groupname: data.groupName //群名称
                                            , id: respData.data.groupid //群id
                                        });
                                    }else{
                                        return layer.msg(res.msg);
                                    }
                                    layer.close(layer.index);
                                });   
                            }                  
                            
                        },
                        error: function () {}
                    };
                    conn.createGroupNew(options);
                }else{
                    return layer.msg(resData.msg);
                }
                layer.close(layer.index);
            });
        },
        getInformation: function(data){
           var id = data.id || {},type = data.type || {};
            var index = layer.open({
                type: 2
                ,title: type  == 'friend'? '好友资料':'群资料'
                ,shade: false
                ,maxmin: false
                ,area: ['400px', '700px']
                ,skin: 'layui-box layui-layer-border'
                ,resize: true
                ,content: cachedata.base.getInformation+'?id='+id+'&type='+type
            });           
        }                             
    };
    exports('socket', socket);
    exports('im', im);
});