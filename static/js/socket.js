layui.define(['jquery', 'layer','contextMenu','form'], function (exports) {
    var contextMenu = layui.contextMenu;
    var $ = layui.jquery;
    var layer = layui.layer;
    var form = layui.form;
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
                    im.contextMenu();
                });
                
                //监听查看群员
                layim.on('members', function (data) {
                });   

                $('body').on('click', '*[socket-event]', function(e){//自定义事件
                  var othis = $(this), methid = othis.attr('socket-event');
                  im[methid] ? im[methid].call(this, othis, e) : '';
                });                                         
                //监听聊天窗口的切换
                layim.on('chatChange', function (res) {
                    im.closeAllGroupList();                   
                    var type = res.data.type;

                    if (type === 'friend') {
                        //模拟标注好友状态
                        im.userStatus({
                            id: res.data.id
                        });
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

    // var ext = {

    // }

    var im = {
        init: function (user,pwd) { 
            this.initListener(user,pwd);    //初始化事件监听
        },
        contextMenu : function(){//定义右键操作
            var my_spread = $('.layim-list-friend >li');
            my_spread.mousedown(function(e){
                if (3 == e.which) {
                    var data = {
                        width: 140, // width
                        itemHeight: 30, // 菜单项height
                        bgColor: "#fff", // 背景颜色
                        color: "#333", // 字体颜色
                        fontSize: 15, // 字体大小
                        hoverBgColor: "#009bdd", // hover背景颜色
                        hoverColor: "#fff", // hover背景颜色
                        contextItem: "context-friend", // 添加class
                        target: function(ele) { // 当前元素
                            // console.log(ele[0].id);
                            $(".context-friend").attr("data-id",ele[0].id);
                            $(".context-friend").attr("data-name",ele.find("span").html());
                            $(".context-friend").attr("data-img",ele.find("img").attr('src'));
                        },
                        menu:[{ // 菜单项
                                text: "发送消息",
                                icon: "&#xe63a;",
                                callback: function(ele) {
                                    var othis = ele.parent(),
                                        friend_id = othis.data('id').replace(/^layim-friend/g, ''),
                                        friend_name = othis.data('name'),
                                        friend_avatar = othis.data('img');
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
                                    var othis = ele.parent(),friend_id = othis.data('id').replace(/^layim-friend/g, '');
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
                                    var othis = ele.parent(),friend_id = othis.data('id').replace(/^layim-friend/g, ''),
                                        friend_name = othis.data('name');
                                    im.getChatLog({
                                        name: friend_name,
                                        id: friend_id,
                                        type:'friend'
                                    });    
                                }
                            },
                            {
                                text: "修改好友备注",
                                icon: "&#xe6b2;",
                                events: "chat",
                                callback: function(ele) {
                                    var othis = ele.parent(),
                                        friend_id = othis.data('id').replace(/^layim-friend/g, ''),
                                        friend_name = othis.data('name');
                                    layer.prompt({title: '修改备注姓名', formType: 0,value: friend_name}, function(nickName, index){
                                        $.get('class/doAction.php?action=editNickName',{nickName:nickName,friend_id:friend_id},function(res){
                                            var data = eval('(' + res + ')');
                                            if (data.code == 0) {
                                                var friendName = $("#layim-friend"+friend_id).find('span');
                                                friendName.html(data.data);
                                                layer.close(index);
                                            }
                                            layer.msg(data.msg);
                                        });
                                    });     

                                }
                            }]
                    };
                    var currentGroupidx = e.currentTarget.firstChild.dataset.groupidx;//当前分组id
                    if(my_spread.length >= 2){ //当至少有两个分组时
                        var html = '<ul>';
                        for (var i = 0; i < my_spread.length; i++) {
                            var groupidx = my_spread.eq(i).find('h5').data('groupidx');
                            if (currentGroupidx != groupidx) {
                                var groupName = my_spread.eq(i).find('h5 span').html();
                                html += '<li class="ui-move-menu-item" data-groupidx="'+groupidx+'" data-groupName="'+groupName+'"><a href="javascript:void(0);"><span>'+groupName+'</span></a></li>'
                            };
                        };
                        html += '</ul>';
                        data.menu.push({
                                        text: "移动联系人",
                                        icon: "&#xe630;",
                                        nav: "move",//子导航的样式
                                        navIcon: "&#xe602;",//子导航的图标
                                        navBody: html,//子导航html
                                        callback: function(ele) {
                                            alert('开发中');                                              
                                        }
                                    });                
                    }
                    data.menu.push({
                                    text: "删除好友",
                                    icon: "&#xe640;",
                                    events: "removeFriends",
                                    callback: function(ele) {
                                        var othis = ele.parent(),
                                            friend_id = othis.data('id').replace(/^layim-friend/g, '');
                                        var username,sign;
                                        layui.each(cachedata.friend, function(index1, item1){
                                            layui.each(item1.list, function(index, item){
                                                if (item.id === friend_id) {
                                                    username = item.username;sign = item.sign;
                                                }
                                            });
                                        });
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
                                });
                    $(".layim-list-friend >li > ul > li").contextMenu(data);

                };
            })         

            $(".layim-list-friend >li > h5").contextMenu({
                width: 140, // width
                itemHeight: 30, // 菜单项height
                bgColor: "#fff", // 背景颜色
                color: "#333", // 字体颜色
                fontSize: 15, // 字体大小
                hoverBgColor: "#009bdd", // hover背景颜色
                hoverColor: "#fff", // hover背景颜色
                contextItem: "context-mygroup", // 添加class
                target: function(ele) { // 当前元素
                    $(".context-mygroup").attr("data-id",ele.data('groupidx'));
                    $(".context-mygroup").attr("data-name",ele.find("span").html());
                },
                menu: [
                    { // 菜单项
                        text: "添加分组",
                        icon: "&#xe654;",
                        callback: function(ele) {
                            im.addMyGroup();
                        }
                    },                
                    { // 菜单项
                        text: "重命名",
                        icon: "&#xe642;",
                        callback: function(ele) {
                            var othis = ele.parent(),mygroupIdx = othis.data('id'),groupName = othis.data('name');
                            layer.prompt({title: '请输入分组名，并确认', formType: 0,value: groupName}, function(mygroupName, index){
                                if (mygroupName) {
                                    $.get('class/doAction.php?action=editGroupName',{mygroupName:mygroupName,mygroupIdx:mygroupIdx},function(res){
                                        var data = eval('(' + res + ')');
                                        if (data.code == 0) {
                                            var friend_group = $(".layim-list-friend li");
                                            for(var j = 0; j < friend_group.length; j++){
                                                var groupidx = friend_group.eq(j).find('h5').data('groupidx');
                                                if(groupidx == mygroupIdx){//当前选择的分组
                                                    friend_group.eq(j).find('h5').find('span').html(mygroupName);
                                                }
                                            }
                                            im.contextMenu();            
                                            layer.close(index);
                                        }
                                        layer.msg(data.msg);
                                    });
                                }

                            });                            
                            // var friend_group = $(".layim-list-friend li"); 
                            // var html = '<input type="text" id="mygroup'+mygroupIdx+'">';         
                            // for(var j = 0; j < friend_group.length; j++){
                            //     var groupidx = friend_group.eq(j).find('h5').data('groupidx');
                            //     if(groupidx == mygroupIdx){//当前选择的分组
                            //         friend_group.eq(j).find('h5').find('span').remove();
                            //         friend_group.eq(j).find('h5').find('em').remove();
                            //         friend_group.eq(j).find('h5').append(html);
                            //     }
                            // }
                        }

                    },                
                    { // 菜单项
                        text: "删除该组",
                        icon: "&#x1006;",
                        callback: function(ele) {
                            var othis = ele.parent(),mygroupIdx = othis.data('id');
                            layer.confirm('<div style="float: left;width: 17%;margin-top: 14px;"><i class="layui-icon" style="font-size: 48px;color:#cc4a4a">&#xe607;</i></div><div style="width: 83%;float: left;"> 选定的分组将被删除，组内联系人将会移至默认分组。</div>', {
                                btn: ['确定','取消'], //按钮
                                title:['删除分组','background:#b4bdb8'],
                                shade: 0
                            }, function(){
                                im.delMyGroup(mygroupIdx); 
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
                contextItem: "context-group", // 添加class
                target: function(ele) { // 当前元素
                    $(".context-group").attr("data-id",ele[0].id);
                    $(".context-group").attr("data-name",ele.find("span").html());
                    $(".context-group").attr("data-img",ele.find("img").attr('src'));                    
                },
                menu: [
                    { // 菜单项
                        text: "发送群消息",
                        icon: "&#xe63a;",
                        callback: function(ele) {
                            var othis = ele.parent(),
                                group_id = othis.data('id').replace(/^layim-group/g, ''),
                                group_name = othis.data('name'),
                                group_avatar = othis.data('img');
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
                            var othis = ele.parent(),group_id = othis.data('id').replace(/^layim-group/g, '');
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
                                group_id = othis.data('id').replace(/^layim-group/g, ''),
                                groupname = othis.data('name');
                                // groupname = othis[0].dataset.name;
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
                                group_id = othis.data('id').replace(/^layim-group/g, ''),  
                                groupname = othis.data('name');
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
            $('.groupMembers > li').mousedown(function(e){
                var data = {
                    width: 140, // width
                    itemHeight: 30, // 菜单项height
                    bgColor: "#fff", // 背景颜色
                    color: "#333", // 字体颜色
                    fontSize: 15, // 字体大小
                    hoverBgColor: "#009bdd", // hover背景颜色
                    hoverColor: "#fff", // hover背景颜色
                    contextItem: "context-group-member", // 添加class
                    isfriend: $(".context-group-member").data("isfriend"), // 添加class
                    target: function(ele) { // 当前元素
                        $(".context-group-member").attr("data-id",ele[0].id);
                        $(".context-group-member").attr("data-img",ele.find("img").attr('src'));
                        $(".context-group-member").attr("data-name",ele.find("span").html());
                        $(".context-group-member").attr("data-isfriend",ele.attr('isfriend'));
                        $(".context-group-member").attr("data-manager",ele.attr('manager'));
                    },
                    menu:[{ // 菜单项
                            text: "发送消息",
                            icon: "&#xe63a;",
                            callback: function(ele) {
                                var othis = ele.parent(),
                                    friend_id = othis.data('id'),
                                    friend_avatar = othis.data('img');
                                    name = othis.data('name');                             
                                conf.layim.chat({
                                    name: name
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
                                var othis = ele.parent(),friend_id = othis.data('id');
                                im.getInformation({
                                    id: friend_id,
                                    type:'friend'
                                });                        
                            }
                        }]
                    };                 
                if(3 == e.which && $(this).attr('isfriend') == 0 && cachedata.mine.id !== $(this).attr('id')){ //点击右键并且不是好友
                    data.menu.push({ // 菜单项
                                text: "添加好友",
                                icon: "&#xe654;",
                                callback: function(ele) {
                                    var othis = ele;
                                    im.addFriendGroup(othis,'friend');                                                   
                                }
                            })
                }
                if (cachedata.mine.id == cachedata.group[1].owner) {//群主
                    data.menu.push({
                                    text: "踢出本群",
                                    icon: "&#x1006;",
                                    callback: function(ele) {
                                                                                              
                                    }
                                },{
                                    text: "禁言",
                                    icon: "&#xe60f;",
                                    nav: "gag",//子导航的样式
                                    navIcon: "&#xe602;",//子导航的图标
                                    navBody: '<ul><li class="ui-gag-menu-item"><a href="javascript:void(0);"><span>禁言10分钟</span></a></li><li class="ui-gag-menu-item"><a href="javascript:void(0);"><span>禁言1小时</span></a></li><li class="ui-gag-menu-item"><a href="javascript:void(0);"><span>禁言6小时</span></a></li><li class="ui-gag-menu-item"><a href="javascript:void(0);"><span>禁言12小时</span></a></li><li class="ui-gag-menu-item"><a href="javascript:void(0);"><span>禁言1天</span></a></li></ul>',//子导航html
                                    callback: function(ele) {
                                                                                              
                                    }
                                })
                }                
                $(".groupMembers > li").contextMenu(data);    
            })


        },        
        initListener: function (user,pwd) { //初始化监听
            // console.log('注册服务连接监听事件');
            // var layim = conf.layim;
            var options = { 
              apiUrl: WebIM.config.apiURL,
              user: user,
              pwd: pwd,
              appKey: WebIM.config.appkey
            };
            conn.open(options); 
            conn.listen({
                onOpened: function ( message ) { 
                    //连接成功回调
                    // 如果isAutoLogin设置为false，那么必须手动设置上线，否则无法收消息
                    // 手动上线指的是调用conn.setPresence(); 如果conn初始化时已将isAutoLogin设置为true
                    // 则无需调用conn.setPresence();             
                },  
                onClosed: function ( message ) {
                    layer.alert('该账号已在别处登陆，是否重新登陆？', {
                      skin: 'layui-layer-molv' //样式类名
                      ,closeBtn: 0
                    }, function(){
                        window.location.href = 'login.php';
                    });
                },         //连接关闭回调
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
                            $.get('class/doAction.php?action=subscribed',{memberIdx:message.from},function(res){
                                var data = eval('(' + res + ')');
                                conf.layim.addList({
                                    type: 'friend' //列表类型，只支持friend和group两种
                                    ,avatar: './uploads/person/'+message.from +'.jpg' //好友头像
                                    ,username: data.data.memberName || [] //好友昵称
                                    ,groupid: data.data.mygroupIdx //所在的分组id
                                    ,id: data.data.memberIdx || [] //好友id
                                    ,sign: data.data.signature || [] //好友签名
                                }); 
                                im.contextMenu();//更新右键点击事件
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
                        //     im.contextMenu();//更新右键点击事件
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
                                im.contextMenu();//更新右键点击事件                                
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
                onOffline: function () {
                    layer.alert('网络不稳定，点击确认刷新页面？', {
                      skin: 'layui-layer-molv' //样式类名
                      ,closeBtn: 0
                    }, function(){
                        window.location.href = 'index.php';
                    });                    
                },                 //本机网络掉线
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
            console.log(data);
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
            var li = othis.parents('li') || othis.parent()
                    , uid = li.data('uid') || li.data('id')
                    , approval = li.data('approval')
                    , name = li.data('name');
            if (uid == 'undifine' || !uid) {
                var uid = othis.parent().data('id'), name = othis.parent().data('name');
            }
            var avatar = './uploads/person/'+uid+'.jpg';
            var isAdd = false;
            if (type == 'friend') {
                var default_avatar = './uploads/person/empty2.jpg';
                if(cachedata.mine.id == uid){//添加的是自己
                    layer.msg('不能添加自己');
                    return false;
                }
                layui.each(cachedata.friend, function(index1, item1){
                    layui.each(item1.list, function(index, item){
                        if (item.id === uid) {isAdd = true;}//是否已经是好友
                    });
                });                
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
                ,group:  cachedata.friend || []
                ,type: type
                ,submit: function(group,remark,index){//确认发送添加请求
                    if (type == 'friend') {
                        $.get('class/doAction.php?action=add_msg', {to: uid,msgType:1,remark:remark,mygroupIdx:group}, function (res) {
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
                        , group: cachedata.friend || [] //获取好友分组数据
                        , submit: function (group, index) { 
                            $.get('class/doAction.php?action=modify_msg', {msgIdx: msgIdx,msgType:msgType,status:status,mygroupIdx:group,friendIdx:uid}, function (res) {
                                var data = eval('(' + res + ')');
                                if (data.code == 0) {
                                    //将好友 追加到主面板
                                    conf.layim.addList({
                                        type: 'friend'
                                        , avatar: im['IsExist'].call(this, avatar)?avatar:default_avatar //好友头像
                                        , username: username //好友昵称
                                        , groupid: group //所在的分组id
                                        , id: uid //好友ID
                                        , sign: signature //好友签名
                                    });
                                    conn.subscribed({//同意添加后通知对方
                                      to: uid,
                                      message : 'Success'
                                    });                                
                                    parent.layer.close(index);
                                    othis.parent().html('已同意');
                                    // parent.location.reload();
                                    im.contextMenu();//更新右键点击事件                          
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
                            im.contextMenu();//更新右键点击事件                          
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
        getMyInformation: function(){
            var index = layer.open({
                type: 2
                ,title: '我的资料'
                ,shade: false
                ,maxmin: false
                ,area: ['400px', '670px']
                ,skin: 'layui-box layui-layer-border'
                ,resize: true
                ,content: cachedata.base.Information+'?id='+cachedata.mine.id+'&type=friend'
            });           
        },
        getInformation: function(data){
           var id = data.id || {},type = data.type || {};
            var index = layer.open({
                type: 2
                ,title: type  == 'friend'?(cachedata.mine.id == id?'我的资料':'好友资料') :'群资料'
                ,shade: false
                ,maxmin: false
                // ,closeBtn: 0
                ,area: ['400px', '670px']
                ,skin: 'layui-box layui-layer-border'
                ,resize: true
                ,content: cachedata.base.Information+'?id='+id+'&type='+type
            });           
        },        
        userStatus: function(data){
            if (data.id) {
                $.get('class/doAction.php?action=userStatus', {id:data.id}, function (res) {
                    var data = eval('(' + res + ')');
                    if (data.code == 0) {  
                        if (data.data == 'online') {
                            conf.layim.setChatStatus('<span style="color:#FF5722;">在线</span>');
                        }else{
                            conf.layim.setChatStatus('<span style="color:#444;">离线</span>');
                        }                                          
                    }else{
                        //没有该用户
                    }
                });                 
            }
        },
        groupMembers: function(othis, e){
        var othis = $(this);
        var icon = othis.find('.layui-icon'), hide = function(){
            icon.html('&#xe602;');
            $("#layui-layim-chat > ul:eq(1)").remove();
            $(".layui-layim-group-search").remove();
            othis.data('show', null);
          };
          if(othis.data('show')){
            hide();
          } else {
            icon.html('&#xe603;');
            othis.data('show', true);
            var members = cachedata.base.members || {},ul = $("#layui-layim-chat"), li = '', membersCache = {};
            var info = JSON.parse(decodeURIComponent(othis.parent().data('json')));
            members.data = $.extend(members.data, {
              id: info.id
            });
            $.get(members, function(res){
                var resp = eval('(' + res + ')');
                var html = '<ul class="layui-unselect layim-group-list groupMembers" style="height: 510px; display: block;right:-200px;padding-top: 10px;">';
                layui.each(resp.data.list, function(index, item){
                    html += '<li  id="'+item.id+'" isfriend="'+item.friendship+'" manager="'+item.type+'"><img src="'+ item.avatar +'">';
                    item.type == 1?
                        (html += '<span style="color:#e24242">'+ item.username +'<i class="layui-icon" style="color:#e24242">&#xe612;</i></span>'):
                        (item.type == 2?
                            (html += '<span style="color:#de6039">'+ item.username +'<i class="layui-icon" style="color:#eaa48e">&#xe612;</i></span>'):
                            (html += '<span>'+ item.username +'</span>'));
                    html += '</li>';    
                    membersCache[item.id] = item;
                });
                html += '</ul>';
                html += '<div class="layui-layim-group-search" socket-event="groupSearch"><input placeholder="搜索"></div>';
                ul.append(html);
                im.contextMenu();
            });
          }
        },
        closeAllGroupList: function(){
            var othis = $(".groupMembers");
            othis.remove();//关闭全部的群员列表
            $(".layui-layim-group-search").remove();
            var icon = $('.layim-tool-groupMembers').find('.layui-icon');
            $('.layim-tool-groupMembers').data('show', null);
            icon.html('&#xe602;'); 
        },
        groupSearch: function(othis){
          var search = $("#layui-layim-chat").find('.layui-layim-group-search');
          var main = $("#layui-layim-chat").find('.groupMembers');
          var input = search.find('input'), find = function(e){
            var val = input.val().replace(/\s/);
            var data = [];
            var group = $(".groupMembers li") || [], html = '';        
            if(val === ''){
              for(var j = 0; j < group.length; j++){
                  group.eq(j).css("display","block");
              }
            } else {
                for(var j = 0; j < group.length; j++){
                    name = group.eq(j).find('span').html();
                    if(name.indexOf(val) === -1){
                        group.eq(j).css("display","none");
                    }else{
                        group.eq(j).css("display","block"); 
                    }
                }
            }
          };
          if(!cachedata.base.isfriend && cachedata.base.isgroup){
            events.tab.index = 1;
          } else if(!cachedata.base.isfriend && !cachedata.base.isgroup){
            events.tab.index = 2;
          }          
          search.show();
          input.focus();
          input.off('keyup', find).on('keyup', find);
        },
        addMyGroup: function(){//新增分组
            $.get('class/doAction.php?action=addMyGroup', {}, function (res) {
                var data = eval('(' + res + ')');
                if (data.code == 0) {
                    $('.layim-list-friend').append('<li><h5 layim-event="spread" lay-type="false" data-id="'+data.data.id+'"><i class="layui-icon">&#xe602;</i><span>'+data.data.name+'</span><em>(<cite class="layim-count"> 0</cite>)</em></h5><ul class="layui-layim-list"><span class="layim-null">该分组下暂无好友</span></ul></li>');
                    im.contextMenu();
                    location.reload();
                }else{
                    layer.msg(data.msg);
                }
            }); 
        },
        delMyGroup: function(groupidx){//删除分组
            $.get('class/doAction.php?action=delMyGroup', {mygroupIdx:groupidx}, function (res) {
                var data = eval('(' + res + ')');
                if (data.code == 0) {
                    var group = $('.layim-list-friend li') || [];
                    for(var j = 0; j < group.length; j++){
                        groupList = group.eq(j).find('h5').data('groupidx');
                        if(groupList === groupidx){
                            if (group.eq(j).find('ul span').hasClass('layim-null')) {
                                group.eq(j).remove();
                            }else{
                                var html = group.eq(j).find('ul').html();//被删除分组的好友
                                var number = group.eq(j).find('ul li').length;//被删除分组的好友个数
                                for(var k = 0; k < group.length; k++){
                                    var default_group = group.eq(k).find('h5').data('groupidx');
                                    if(default_group == data.data){//将好友添加到默认分并更新好友数量
                                        var default_html = group.eq(k).find('ul');
                                        default_html.append(html);
                                        var default_numnber = parseInt(group.eq(k).find('h5 em cite').text());//默认分组的好友数量
                                        var total = default_numnber + number;
                                        group.eq(k).find('h5 em cite').text(total);
                                        group.eq(j).remove();
                                    }
                                }
                            }

                        }
                    }
                    im.contextMenu();                    
                    layer.close(layer.index);                   
                }else{
                    layer.msg(data.msg);
                }
            }); 
        }                                                      
    };
    exports('socket', socket);
    exports('im', im);
});