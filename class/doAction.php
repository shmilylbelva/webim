<?php

#包含所需文件
require_once 'config.php';
require_once 'PdoMySQL.class.php';
require '../vendor/qiniuSDK/autoload.php';
use Qiniu\Auth;
use Qiniu\Storage\UploadManager;
#实例化pdo，redis，并设置redis监听端口
$PdoMySQL = new PdoMySQL;
date_default_timezone_set("Asia/Shanghai");
#执行动作获取
$act = empty($_GET['action']) ? null : $_GET['action'];
switch ($act) {

    #user login
    case 'login':
        $param['name'] = $_POST['name'];
        $param['pwd'] = $_POST['pwd'];
        $get_user = $PdoMySQL->find($tables, 'memberIdx = "' . $param['name'] . '"', 'memberPWD,signature,userToken,memberName,oauth_token,memberIdx');
        $pwd = md5(md5($param['pwd']).$get_user['userToken']);
        if (empty($get_user)) {
            echo '{"code":"002","status":"n","info":"您输入的用户名不存在，请查证后重试"}';
            exit;
        } else {
            if ($pwd !== $get_user['memberPWD']) {
                echo '{"code":"002","status":"n","info":"您输入的密码错误，请查证后重试"}';
                exit;
            } else {
                $_SESSION['user_id'] = $get_user['memberIdx'];
                $_SESSION['user_name'] = $get_user['memberName'];
                /******获取token*********/
                $user_token = getUserToken($param['name']);
                /**********************/
                #获取token，成功则保存session
                $arr = array(
                    'id' => $get_user['memberIdx'],
                    // 'status' => 'online',
                    'sign' => $get_user['signature'],
                    'username' => $get_user['memberName'],
                    'oauth_token'=>$get_user['oauth_token'],
                    'easemob_token'=>md5($get_user['memberIdx'].'easemob'),
                    'access_token'=>$user_token['access_token'],
                    'avatar'=>$APIURL.'person/'.$get_user['memberIdx'].'.jpg',
                );
                $_SESSION['info'] = $arr;
                echo '{"code":"0","status":"y","info":"欢迎回来"}';
            }
        }
        break;
    #获取用户信息，好友列表
    case 'get_user_data':
        $authorization = 'Bearer '.$_SESSION['info']['access_token'];  
        $headers = array('Authorization:'.$authorization);
//获取好友
        $uid = $_SESSION['info']['id'];
        // $url_friend = $BASEURL.'users/'.$uid.'/contacts/users';
        // $data_info = json_decode(Get($headers,$url_friend),true);
//获取群组
        // $url_group = $BASEURL.'users/'.$uid.'/joined_chatgroups';
        // $data_group = json_decode(Get($headers,$url_group),true);
//获取默认皮肤
        $get_skin = $PdoMySQL->find($tb_skin, 'memberIdx = "' . $_SESSION['info']['id'] . '"', 'url,memberIdx,isUserUpload');
//获取未读消息数量
        $sql_msg = "select COUNT(*) as count from tb_msg where (`to` = ".$_SESSION['info']['id'] ." AND (msgType = ".ADD_USER_MSG ." OR msgType = ".ADD_GROUP_MSG.") AND status = ".UNREAD." ) 
        OR ( `from` = ".$_SESSION['info']['id']." AND (msgType = ".ADD_USER_SYS." OR msgType = ".ADD_GROUP_SYS." ) AND (status = ".AGREE_BY_TO." OR status = ".DISAGREE_BY_TO.") )";
        $msgBox = $PdoMySQL->getRow($sql_msg);
//获取我的好友分组        
        $memberIdx = $_SESSION['info']['id'];
        $sql_my_group = sprintf("SELECT mygroupIdx,mygroupName as groupname FROM tb_my_group WHERE memberIdx = $memberIdx order by weight");
        $get_my_group = $PdoMySQL->getAll($sql_my_group);
        foreach ($get_my_group as $key => $value) {
            $mygroupIdx = $value['mygroupIdx'];
            $sql_my_fiend = sprintf("SELECT a.memberIdx AS id ,c.nickName,a.memberName,a.signature FROM tb_person AS a
                 LEFT JOIN tb_my_friend AS c ON c.memberIdx = a.memberIdx 
                where c.mygroupIdx = $mygroupIdx ");
            $get_my_friend = $PdoMySQL->getAll($sql_my_fiend);
            foreach ($get_my_friend as $k => $v) {
                $get_my_friend[$k]['username'] = $v['nickName'];
                if (!$v['nickName']) {
                    $get_my_friend[$k]['username'] = $v['memberName'];
                }
                $get_my_friend[$k]['avatar'] = $APIURL.'person/'.$v['id'].'.jpg';
                $get_my_friend[$k]['sign'] = $v['signature'];
                $get_my_group[$key]['list']= $get_my_friend;
            }
            $get_my_group[$key]['id'] = $value['mygroupIdx'];                
        }

        $sql_group = sprintf("SELECT b.type as manager,b.gagTime as gagTime,a.groupName as groupname,concat('../uploads/person/',a.groupIdx,'.jpg ')  as avatar, a.groupIdx AS id FROM tb_group AS a
             LEFT JOIN tb_group_member AS b ON b.groupIdx = a.groupIdx where b.memberIdx = $memberIdx ");
        $group = $PdoMySQL->getAll($sql_group);
        // foreach ($group as $k => $v) {
        //     $group[$k]['owner'] = '911117';
        //     $group[$k]['manager'][0] = '1570845';
        //     $group[$k]['manager'][1] = '1570855';
        // }
        // $get_my_groups = json_encode($get_my_group);
        // $group = json_encode($group);
        $res['code'] = 0;
        $res['msg'] = "";
        $res['data']['mine'] = $_SESSION['info'];
        $res['data']['friend'] = $get_my_group;
        $res['data']['group'] = $group;
        $res['data']['mine']['skin'] = $get_skin['isUserUpload'] == 1? "./uploads/skin/".$get_skin['url']:"./static/layui/css/modules/layim/skin/".$get_skin['url'];
        $res['data']['mine']['msgBox'] = $msgBox['count'];
        echo  json_encode($res);         
        break;
    case 'userStatus':
        $id = $_GET['id'];
        $access_token = getUserToken($id);
        if ($access_token) {
            $authorization = 'Bearer '.$access_token['access_token'];  
            $headers = array('Authorization:'.$authorization);
            $url_friend = $BASEURL.'users/'.$id.'/status';
            $online = json_decode(Get($headers,$url_friend),true); 
            $res['code'] = 0;
            $res['msg'] = '';
            $res['data'] = $online['data'][$id];
            echo  json_encode($res);             
        }else{
            $res['code'] = -1;
            $res['msg'] = '';
            $res['data'] = '';
            echo  json_encode($res); 
        }
       
        break;
    case 'uploadImage':
        $url = $BASEURL.'chatfiles';
        $headers = array('Content-type: multipart/form-data','Authorization:Bearer '.$_SESSION['info']['access_token'],'restrict-access: true');
        $file = file_get_contents($_FILES['file']['tmp_name']);
        $Upload_data = array('file'=>$file);
        $data_info = Post($Upload_data,$url,$headers);
        echo '{"code": 0 ,"msg": ""  ,"data": '.$data_info.'}';
        break;
    case 'uploadFile':
        $auth = new Auth(AK, SK);
        $bucket = 'lite-im';
        // 生成上传Token
        $token = $auth->uploadToken($bucket);
        // 要上传文件的本地路径
        $file = $_FILES['file'];
        $uploadfile = $file['tmp_name'];
        // 上传到七牛后保存的文件名
        $key = $file['name'];
        // 初始化 UploadManager 对象并进行文件的上传。
        $uploadMgr = new UploadManager();
        // 调用 UploadManager 的 putFile 方法进行文件的上传。
        list($ret, $err) = $uploadMgr->putFile($token, $key, $uploadfile);
        if ($err !== null) {
            $res['code'] = -1;
            $res['msg'] = $err;
            $res['data'] = '';
            echo  json_encode($res); 
        } else {
            $res['code'] = 0;
            $res['msg'] = "";
            $res['data']['src'] = QN_FILE.$ret['key'];
            $res['data']['name'] = $key;
            echo  json_encode($res); 
        }       
        break;            
    // case 'uploadFile':
    //     $url = $BASEURL.'chatfiles';
    //     $headers = array('Content-type: multipart/form-data','Authorization:Bearer '.$_SESSION['info']['access_token'],'restrict-access: true');
    //     $file = file_get_contents($_FILES['file']['tmp_name']);
    //     $Upload_data = array('file'=>$file);
    //     $data_ = Post($Upload_data,$url,$headers);
    //     $data_info = json_decode($data_,true);
    //     if ($data_info['entities']['0']['uuid']) {
    //         $imageURL = $url.'/'.$data_info['entities']['0']['uuid'];
    //     }
    //     $res['code'] = 0;
    //     $res['msg'] = "";
    //     $res['data']['src'] = $imageURL;
    //     $res['data']['name'] = $_FILES['file']['name'];
    //     echo  json_encode($res);        
    //     break;  
    // case 'groupMembers':

    //     $id = $_GET['id'];
    //     $url = $BASEURL.'chatgroups/'.$id;
    //     $headers = array('Authorization:Bearer '.$_SESSION['info']['access_token']);
    //     $data_group = json_decode(Get($headers,$url),true);
    //     foreach ($data_group['data'][0]['affiliations'] as $key => $value) {
    //         $userid = array_values($value)[0];
    //         $group[$key]['id'] = $userid;
    //         $get_user = $PdoMySQL->find($tables, 'memberIdx = "' . $userid . '"', 'memberName,memberIdx');
    //         $group[$key]['username'] = $get_user['memberName'];
    //         $group[$key]['avatar'] = $APIURL.'/person/'.$userid.'.jpg';
    //     }
    //     $res['code'] = 0;
    //     $res['msg'] = "";
    //     $res['data']['list'] = $group;
    //     echo  json_encode($res);
    //     break;      
    case 'groupMembers':
        $id = $_GET['id'];
        $memberIdx = $_SESSION['info']['id'];
        $sql_group = sprintf("SELECT a.memberIdx AS id,concat('../uploads/person/',a.memberIdx,'.jpg ')  as avatar, concat(ifnull(b.nickName,a.memberName),'(',a.memberIdx,')') AS username ,b.type,b.gagTime as gagTime from tb_person AS a LEFT JOIN tb_group_member AS b ON a.memberIdx = b.memberIdx
         WHERE b.groupIdx = $id AND b.status = 1 order by b.type");
        $group = $PdoMySQL->getAll($sql_group);//全部群成员    

        $sql_friend = sprintf("SELECT b.memberIdx AS id from tb_my_group AS a INNER JOIN tb_my_friend AS b ON a.mygroupIdx = b.mygroupIdx
         WHERE a.memberIdx = $memberIdx");
        $friend = $PdoMySQL->getAll($sql_friend);//我的好友
        foreach ($group as $key => $value) {
            $group[$key]['friendship'] = 0;
            foreach ($friend as $k => $v) {
                if ($v['id'] == $value['id']) {
                    $group[$key]['friendship'] = 1;
                }
            }            
        }
        $res['code'] = 0;
        $res['msg'] = "";
        $res['data']['list'] = $group;
        echo  json_encode($res);
        break;       
    case 'change_sign':
        $data['signature'] = $_POST['sign'];
        $memberIdx = $_SESSION['info']['id'];
        $success = $PdoMySQL->update($data,$tables, 'memberIdx = "' . $memberIdx . '"');
        echo  json_encode($success);
        break;     
    case 'uploadSkin':
        $memberIdx = $_SESSION['info']['id'];
        $isSetSkin = $PdoMySQL->find($tb_skin, 'memberIdx = "' . $memberIdx . '"', 'url,isUserUpload'); 
        $file = $_FILES['file'];
        $ext = explode('.',$file['name']);
        if ($file['type'] != 'image/jpeg' && $file['type'] != 'image/png') {
            echo '{"code":"9999","status":"n","info":"请上传格式为jpg或png的图片"}';
        }
        $data['url'] =  $memberIdx.'_'.time().'.'.$ext[count($ext)-1];         
        move_uploaded_file($file['tmp_name'],'../uploads/skin/'.$data['url']); 
        $data['isUserUpload'] = '1';
        if ($isSetSkin) {
            if ($isSetSkin['isUserUpload'] == 1) {
                unlink('../uploads/skin/'.$isSetSkin['url']);
            }
            $success = $PdoMySQL->update($data,$tb_skin, 'memberIdx = "' . $memberIdx . '"');            
        }else{
            $data['memberIdx'] = $memberIdx;
            $success = $PdoMySQL->add($data, $tb_skin);
        }
        $res['data']['src'] = '/uploads/skin/'.$data['url'];
        $res['code'] = 0;
        $res['msg'] = "";
        
        echo  json_encode($res);        
        break;  
    case 'systemSkin':
        $memberIdx = $_SESSION['info']['id'];
        $type = $_POST['type'];
        $isSetSkin = $PdoMySQL->find($tb_skin, 'memberIdx = "' . $memberIdx . '"', 'url'); 
        $skin = explode('/',$type);
        $data['url'] = $skin[count($skin)-1];
        $data['isUserUpload'] = 0;
        
        if ($isSetSkin) {
            $success = $PdoMySQL->update($data,$tb_skin, 'memberIdx = "' . $memberIdx . '"');            
        }else{
            $data['memberIdx'] = $memberIdx;
            $success = $PdoMySQL->add($data, $tb_skin);
        }
        $res['code'] = 0;
        $res['msg'] = "";
        $res['data']['src'] = $type;
        echo  json_encode($res); 
        break;     
    case 'getRecommend'://获取默认好友推荐
        $sql = "select memberIdx,memberName,signature,birthday,memberSex from tb_person order by rand() limit 16 ";
        $get_recommend = $PdoMySQL->getAll($sql);        
        $res['code'] = 0;
        $res['msg'] = "";
        $res['data'] = $get_recommend;
        echo  json_encode($res); 
        break;    
    case 'findFriendTotal'://获取总的条数
        $type = $_GET['type'];
        $value = $_GET['value'];
        $rows = 16;//每页显示数量
        if ($type == 'friend') {//好友
            $sql = "select COUNT(*) as count from tb_person where (memberIdx LIKE '%{$value}%' OR memberName LIKE '%{$value}%' OR phoneNumber LIKE '%{$value}%' OR emailAddress LIKE '%{$value}%')";
        }else{
            $sql = "select COUNT(*) as count from tb_group where (groupIdx LIKE '%{$value}%' OR groupName LIKE '%{$value}%' OR des LIKE '%{$value}%')"; 
        }
        $count = $PdoMySQL->getRow($sql);
        if ($count) {
            $res['code'] = 0;
        }else{
            $res['code'] = -1;
        }
        $res['count'] = "";
        $res['data']['count'] = $count['count'];
        $res['data']['limit'] = $rows;
        echo  json_encode($res);
        break;              
    case 'findFriend'://查找好友或群
        $type = $_GET['type'];
        $value = $_GET['value'];
        $page = $_GET['page'] ;//当前页
        $page = $page?$page:1;
        $rows = 16;//每页显示数量
        $select_from = ($page-1) * $rows;         
        if ($type == 'friend') {//好友
            $sql = "select memberIdx,memberName,signature,memberAge,memberSex from tb_person where (memberIdx LIKE '%{$value}%' OR memberName LIKE '%{$value}%' OR phoneNumber LIKE '%{$value}%' OR emailAddress LIKE '%{$value}%') limit ".$select_from. ','.$rows;
        }else{
            $sql = "select groupIdx,groupName,des,number,approval from tb_group where (groupIdx LIKE '%{$value}%' OR groupName LIKE '%{$value}%' OR des LIKE '%{$value}%') limit ".$select_from. ','.$rows;  
        }
        $get_friend = $PdoMySQL->getAll($sql);        
        $res['code'] = 0;
        $res['msg'] = "";
        $res['data'] = $get_friend;
        echo  json_encode($res); 
        break;  
    case 'getInformation'://获取好友资料
        $id = $_GET['?id'];//好友/群 id      
        $type = $_GET['type'] ;//当前类型
        if ($type == 'friend') {//好友
            $sql = "select memberIdx,memberName,memberSex,birthday,signature,emailAddress,phoneNumber,blood_type,job,qq,wechat from tb_person where memberIdx = ".$id;
        }else{
            break; 
        }
        $getInformation = $PdoMySQL->getRow($sql);   
        $getInformation['type'] = $type;     
        $res['code'] = 0;
        $res['msg'] = "";
        $res['data'] = $getInformation;
        echo  json_encode($res); 
        break;       
    case 'saveMyInformation'://保存资料
        $data = $_POST['key_value'];//好友/群 id      
        $arr = array_filter($data);
        $memberIdx = $_SESSION['info']['id'] ;
        if (!$memberIdx) {
            exit();
        } 
        $arr['updateTime'] = date('Y-m-d H:i:s');
        $success = $PdoMySQL->update($arr,$tables,'memberIdx = "' . $memberIdx . '"');
        $res['code'] = 0;
        $res['msg'] = "";
        $res['data'] = $success;
        echo  json_encode($res); 
        break;   
               
    case 'userMaxGroupNumber'://判断用户最大建群数
        $memberIdx = $_SESSION['info']['id'] ;
        if (!$memberIdx) {
            exit();
        }        
        $sql = "select count(*) as cn from tb_group where belong = '{$memberIdx}' ";
        $cn = $PdoMySQL->getRow($sql);       
        if ($cn['cn'] < 6) {//最多建5个群
            $res['code'] = 0;
            $res['msg'] = "";
            $res['data'] = $groupIdx;            
        }else{
            $res['code'] = -1;
            $res['msg'] = "超过最大建群数 5";
            $res['data'] = '';
        }
        echo  json_encode($res);         
        break;  
    case 'commitGroupInfo'://提交建群信息
        $data_group['memberIdx'] = $data['belong'] = $_SESSION['info']['id'] ;
        $data_group['groupIdx'] = $data['groupIdx'] = $_GET['groupIdx'];
        $data['groupName'] = $_GET['groupName'];
        $data['des'] = $_GET['des'];
        $data['number'] = $_GET['number'];
        $data['approval'] = $_GET['approval'];
        $groupIdx = $PdoMySQL->find($tb_group, 'groupIdx ="'.$data['groupIdx'].'" OR groupName = "'.$data['groupName'].'"', 'groupIdx'); 
        $sql = "select count(*) as cn from tb_group where belong = '{$data['belong']}' ";
        $cn = $PdoMySQL->getRow($sql);       
        if (!$groupIdx['groupIdx'] && $cn['cn'] < 6) {//最多建5个群
            $success = $PdoMySQL->add($data,$tb_group);
            $data_group['addTime'] = time();
            $data_group['type'] = 1;//群主
            $PdoMySQL->add($data_group,$tb_group_member);
            $res['code'] = 0;
            $res['msg'] = "群 ".$data['groupName']." 创建成功";
            $res['data'] = $groupIdx;            
        }else{
            $res['code'] = -1;
            $res['msg'] = "群名称已存在或超过最大建群数 5";
            $res['data'] = '';
        }
        echo  json_encode($res); 
        break; 
    case 'get_one_user_data'://获取好友信息
        $memberIdx = $_GET['memberIdx'];
        $user = $PdoMySQL->find($tables, 'memberIdx = "' . $memberIdx . '"','memberIdx,memberName,signature,memberSex');       
        $res['code'] = 0;
        $res['msg'] = "";
        $res['data'] = $user;
        echo  json_encode($res); 
        break;  
    case 'get_one_group_data'://获取默群信息
        $groupIdx = $_GET['groupIdx'];
        $group = $PdoMySQL->find($tb_group, 'groupIdx = "' . $groupIdx . '"','groupName');       
        $res['code'] = 0;
        $res['msg'] = "";
        $res['data'] = $group;
        echo  json_encode($res); 
        break;             
    case 'subscribed'://好友请求已通过
        $to = $_GET['memberIdx'];
        $from = $_SESSION['info']['id'];
        $sql = sprintf(" SELECT a.memberIdx,a.memberName,a.signature,a.memberSex,b.mygroupIdx FROM tb_person AS a 
            LEFT JOIN tb_msg AS b ON a.memberIdx = b.to WHERE b.from = $from AND b.to = $to");
        $user = $PdoMySQL->getRow($sql);
        if ($user) {
            $data_my_friend['mygroupIdx'] = $user['mygroupIdx'];
            $data_my_friend['memberIdx'] = $user['memberIdx'];
            $PdoMySQL->add($data_my_friend,$tb_my_friend);  
        }
        $res['code'] = 0;
        $res['msg'] = "";
        $res['data'] = $user;
        echo  json_encode($res); 
        break;  
    case 'getMsgBox'://获取消息盒子
        $memberIdx = $_SESSION['info']['id'] ;
        $page = $_GET['page'] ;
        $rows= 10;//每页显示数量
        $select_from = ($page - 1) * $rows;         
        $sql_msg = "select * from tb_msg where (`to` = ".$memberIdx ." OR `from` = ".$memberIdx." OR find_in_set(".$memberIdx.", adminGroup) ) ORDER BY  time DESC  limit ".$select_from. ','.$rows;
        $msgBox = $PdoMySQL->getAll($sql_msg); 
        foreach ($msgBox as $key => &$value) {
            if ($value['msgType'] == ADD_USER_MSG || $value['msgType'] == ADD_USER_SYS) {
                if ($value['to'] == $memberIdx) {
                    $userId = $value['from'];//收到加好友消息（被添加者接收消息）
                }elseif($value['from'] == $memberIdx ){
                    $userId = $value['to'];//收到系统消息(申请是否通过) 加好友消息（添加者接收消息）
                }              
            }
            if ($value['msgType'] == ADD_GROUP_MSG || $value['msgType'] == ADD_GROUP_SYS) {//收到加群消息（群主接收消息）
                $userId = $value['from'];//发出消息的人
                $sql_msg = "select groupName from tb_group where groupIdx = ".$value['to'];
                $group = $PdoMySQL->getRow($sql_msg); 
                $value['groupName'] = $group['groupName'];
                $value['groupIdx'] = $value['to'];
                if ($value['handle']) {
                    $username = $PdoMySQL->find($tables, 'memberIdx = "' . $value['handle'] . '"', 'memberName'); 
                    $value['handle'] = $username['memberName']; //处理该请求的管理员
                }
            }; 
            if ($userId) {
                $username = $PdoMySQL->find($tables, 'memberIdx = "' . $userId . '"', 'memberName,signature'); 
                $value['username'] = $username['memberName']; 
                $value['signature'] = $username['signature']; 
            }else{//平台发布消息
                $value['username'] = '平台发布';
            }              
        } 
        $sql_msg = "select COUNT(*) as count from tb_msg where (`to` = ".$memberIdx ." OR `from` = ".$memberIdx." OR find_in_set(".$memberIdx.", adminGroup) )";
        $pages = $PdoMySQL->getRow($sql_msg);         
        $res['code'] = 0;
        $res['pages'] = ceil($pages['count']/$rows);
        $res['data'] = $msgBox;
        $res['memberIdx'] = $memberIdx;
        echo  json_encode($res); 
        break; 
    case 'add_msg'://请求添加
        $data['msgType'] = $_GET['msgType'];
        $data['from'] = $_SESSION['info']['id'];        
        $data['to'] = $_GET['to'];
        $data['remark'] = $_GET['remark'];
        $mygroupIdx = $_GET['mygroupIdx'];
        if ($mygroupIdx) {
            $data['mygroupIdx'] = $mygroupIdx;
        }
        $data['sendTime'] = $data['time'] = time();
        $data['status'] = 1;
        $msgIdx = $PdoMySQL->find($tb_msg, '( `to` = "'.$data['to'].'" AND `from` = "' . $data['from'] . '")', 'msgIdx'); //发出的申请是否已存在            
        if (!$data['to'] || !$data['from']) {
            $res['code'] = -1;
            $res['msg'] = "";
            $res['data'] = -1;
            echo  json_encode($res); 
            exit();
        }
        if ($msgIdx['msgIdx']) {
            $success = $PdoMySQL->update($data,$tb_msg,'msgIdx = "' . $msgIdx['msgIdx'] . '"');
        }else{
            $success = $PdoMySQL->add($data,$tb_msg);
        }
        $res['code'] = 0;
        $res['msg'] = "";
        $res['data'] = $success;
        echo  json_encode($res); 
        break; 
    case 'add_admin_msg':
        $data['from'] = $_GET['from'];        
        $data['to'] = $_GET['to'];
        if (!$data['to'] || !$data['from']) {
            $res['code'] = -1;
            $res['msg'] = "";
            $res['data'] = -1;
            echo  json_encode($res); 
            exit();
        }        
        $data['adminGroup'] = $_GET['adminGroup'];
        $msgIdx = $PdoMySQL->find($tb_msg, '( `to` = "'.$data['to'].'" AND `from` = "' . $data['from'] . '")', 'msgIdx,adminGroup'); //发出的申请是否已存在            
        if ($msgIdx['msgIdx']) {
            if ($msgIdx['adminGroup'] && $msgIdx['adminGroup'] != $data['adminGroup']) {
                $data['adminGroup'] = $msgIdx['adminGroup'].','.$data['adminGroup'];
            }
            $success = $PdoMySQL->update($data,$tb_msg,'msgIdx = "' . $msgIdx['msgIdx'] . '"');
        }
        $res['code'] = 0;
        $res['msg'] = "";
        $res['data'] = $success;
        echo  json_encode($res); 
        break;
    case 'set_allread'://系统消息全部设置为已读
        $memberIdx = $_SESSION['info']['id'] ;
        $sql_msg = "select msgIdx,status from tb_msg where  ( `from` = ".$memberIdx." AND ( `status` = ".AGREE_BY_TO." OR `status` = ".DISAGREE_BY_TO." ) ) ";
        $msgBox = $PdoMySQL->getAll($sql_msg); 
        foreach ($msgBox as $key => $value) {
            $data['status'] = $value['status']+2;
            $username = $PdoMySQL->update($data,$tb_msg,'msgIdx = "' . $value['msgIdx'] . '"');
        } 
        $res['code'] = 0;
        $res['msg'] = "";
        echo  json_encode($res);  
        break;           
    case 'modify_msg'://修改添加状态
        $data['msgType'] = $_GET['msgType'];  
        $msgIdx = $_GET['msgIdx'];
        $status = $_GET['status'];         
        $data['status'] = $status == AGREE_BY_TO?AGREE_BY_TO:DISAGREE_BY_TO;
        $data_group_member['addTime']= $data['readTime'] = $data['time'] = time();
        $memberIdx = $_SESSION['info']['id'];          
        if ($data['msgType'] == 2) {//添加好友
            $friendIdx = $_GET['friendIdx'];//好友id    
            $mygroupIdx = $_GET['mygroupIdx']; //好友分组 
            $from = $PdoMySQL->find($tb_msg, 'msgIdx ='.$msgIdx, 'from'); 
            if ($friendIdx != $from['from']) {
                $res['code'] = -1;
                $res['msg'] = "非法请求";  
                $res['data'] = "";  
                echo  json_encode($res);          
                break;
            }
            $success = $PdoMySQL->update($data,$tb_msg,' `to` = "'.$memberIdx.'"  AND `msgIdx` = "' . $msgIdx . '"');
            if ($success) {
                $isfriend = $PdoMySQL->find($tb_my_friend, 'mygroupIdx ='.$mygroupIdx.' AND memberIdx = '.$friendIdx, 'myfriendIdx');
                if (!$isfriend['myfriendIdx']) {
                    $data_my_friend['mygroupIdx'] = $mygroupIdx;
                    $data_my_friend['memberIdx'] = $friendIdx;
                    $PdoMySQL->add($data_my_friend,$tb_my_friend);
                }
                $res['code'] = 0;
            }else{
                $res['code'] = -1;
            }
            $res['msg'] = "";
        }else{
            $data['handle'] = $memberIdx;
            $handle = $PdoMySQL->find($tb_msg, 'msgIdx ='.$msgIdx, 'handle,to,from');
            if ($handle['handle']) {
                $res['msg'] = "群消息已处理"; 
                $res['code'] = 1;
            }else{
                $success = $PdoMySQL->update($data,$tb_msg,'find_in_set("'.$memberIdx.'", adminGroup) AND `msgIdx` = "' . $msgIdx . '"');
                if ($success) {
                    $data_group_member['groupIdx'] = $handle['to'];
                    $data_group_member['memberIdx'] = $handle['from'];
                    $PdoMySQL->add($data_group_member,$tb_group_member);//加入群                 
                    $res['code'] = 0;
                    $res['msg'] = "群消息处理成功"; 
                }else{
                    $res['code'] = -1;
                    $res['msg'] = "群消息处理失败"; 
                }
            }
        }
        echo  json_encode($res); 
        break;          
    case 'addChatLog'://记录聊天记录
        $data['to'] = $_GET['to'];       
        $data['content'] = $_GET['content'];
        $data['sendTime'] = $_GET['sendTime'];
        $data['type'] = $_GET['type'];
        $data['from'] = $_SESSION['info']['id'];
        if (!$data['from']) {
            $res['code'] = -1;
            echo  json_encode($res); 
            exit();   
        }        
        if ($_GET['sysLog']) {
            $data['from'] = 0;
        }
        $success = $PdoMySQL->add($data,$tb_chatlog);
        if ($success) {
            $res['code'] = 0;
        }else{
            $res['code'] = -1;
        }
        $res['msg'] = "";
        echo  json_encode($res); 
        break; 
    case 'getChatLogTotal'://获取总的条数
        $id = $_GET['?id'];//好友/群 id
        $type = $_GET['type'];//好友/群 id
        $memberIdx = $_SESSION['info']['id'];
        $rows = 20;//每页显示数量
        $sql = "select COUNT(*) as count from tb_chatlog where ((`to` = ".$memberIdx ." AND `from` = ".$id." ) 
        OR (`to` = ".$id ." AND `from` = ".$memberIdx.") AND status = 1 )";
        if ($type == 'group') {
            $sql = "select COUNT(*) as count from tb_chatlog where `to` = ".$id ."  AND status = 1 ";
        }
        $count = $PdoMySQL->getRow($sql);
        if ($count) {
            $res['code'] = 0;
        }else{
            $res['code'] = -1;
        }
        $res['count'] = "";
        $res['data']['count'] = $count['count'];
        $res['data']['limit'] = $rows;
        echo  json_encode($res);
        break;         
    case 'getChatLog'://读取聊天记录
        $id = $_GET['?id'];//好友/群 id      
        $page = $_GET['page'] ;//当前页
        $type = $_GET['type'] ;//当前页
        $rows = 20;//每页显示数量
        $select_from = ($page-1) * $rows;            
        $memberIdx = $_SESSION['info']['id'];
        if ($type == 'friend') {
            $sql_msg = "select c.content,c.sendTime AS timestamp,c.from,p1.memberName as fromName,p2.memberName as toName from tb_chatlog as c JOIN tb_person as p1 ON c.from = p1.memberIdx LEFT JOIN tb_person as p2 ON c.to = p2.memberIdx    where ((c.to = ".$memberIdx ." AND c.from = ".$id." ) OR (c.to = ".$id ." AND c.from = ".$memberIdx.") AND c.status = 1 ) limit ".$select_from. ','.$rows;
        }elseif($type == 'group'){
            $sql_msg = "select c.content,c.sendTime AS timestamp,c.from,p1.memberName as fromName,p2.groupName as toName from tb_chatlog as c LEFT JOIN tb_person as p1 ON c.from = p1.memberIdx LEFT JOIN tb_group as p2 ON c.to = p2.groupIdx where c.to = '".$id."' limit ".$select_from. ','.$rows;
        }
        $ChatLog = $PdoMySQL->getAll($sql_msg);
        if ($ChatLog) {
            $res['code'] = 0;
        }else{
            $res['code'] = -1;
        }
        $res['count'] = "";
        $res['data'] = $ChatLog;
        echo  json_encode($res); 
        break;     
    case 'addMyGroup'://添加好友分组        
        $memberIdx = $_SESSION['info']['id'];
        $sql_msg = sprintf(" SELECT count(*) AS count from tb_my_group where memberIdx = $memberIdx");
        $count = $PdoMySQL->getRow($sql_msg);
        if ($count['count'] >= 20) {
            $res['code'] = -1;
            $res['msg'] = '最多创建20个分组';
        }else{
            $data['memberIdx'] = $memberIdx;
            $data['mygroupName'] = '未命名';
            $data['weight'] = ($count['count']+1);
            $id = $PdoMySQL->add($data, $tb_my_group);
            $res['code'] = 0;
            $res['msg'] = "创建成功";
            $res['data']['name'] = $data['mygroupName'];             
            $res['data']['id'] = $PdoMySQL->getLastInsertId();             
        }
        echo  json_encode($res);
        break;    
    case 'delMyGroup'://删除分组     
        $mygroupIdx = $_GET['mygroupIdx'];   
        $memberIdx = $_SESSION['info']['id'];
        $sql_msg = sprintf(" SELECT count(*) AS count from tb_my_group where memberIdx = $memberIdx AND mygroupIdx = $mygroupIdx");
        $count = $PdoMySQL->getRow($sql_msg);
        if ($count['count']) {//存在分组
            $sql_msg = sprintf(" SELECT mygroupIdx from tb_my_group where memberIdx = $memberIdx");
            $default_group = $PdoMySQL->getRow($sql_msg); //获取第一个分组为默认分组           
            $PdoMySQL->delete($tb_my_group, "mygroupIdx=".$mygroupIdx);
            $data_group['mygroupIdx'] = $default_group['mygroupIdx'];
            $PdoMySQL->update($data_group,$tb_my_friend, 'mygroupIdx = "' . $mygroupIdx . '"');
            $res['code'] = 0;
            $res['msg'] = "删除成功";            
            $res['data'] = $default_group['mygroupIdx'];            
        }else{
            $res['code'] = 0;
            $res['msg'] = "删除成功";            
        }
        echo  json_encode($res);
        break;    
    case 'editGroupName'://编辑分组名称     
        $mygroupIdx = $_GET['mygroupIdx'];   
        $mygroupName = $_GET['mygroupName'];   
        $memberIdx = $_SESSION['info']['id'];
        $sql_msg = sprintf(" SELECT mygroupIdx from tb_my_group where memberIdx = $memberIdx AND mygroupName = '$mygroupName'");
        $mygroup = $PdoMySQL->getRow($sql_msg);
        if ($mygroup['mygroupIdx'] != $mygroupIdx && $mygroup['mygroupIdx']) {//存在分组名
            $res['code'] = -1;
            $res['msg'] = "分组名已存在，换一个名字吧";            
            $res['data'] = '';            
        }else{
            $data_group['mygroupName'] = $mygroupName;
            $PdoMySQL->update($data_group,$tb_my_group, 'mygroupIdx = "' . $mygroupIdx . '"');            
            $res['code'] = 0;
            $res['msg'] = "修改成功";            
        }
        echo  json_encode($res);
        break;    
    case 'editNickName'://编辑好友名称     
        $friend_id = $_GET['friend_id'];   
        $nickName = $_GET['nickName'];   
        $memberIdx = $_SESSION['info']['id'];
        $sql_msg = sprintf(" SELECT a.myfriendIdx from tb_my_friend AS a INNER JOIN tb_my_group AS b ON a.mygroupIdx = b.mygroupIdx where b.memberIdx = $memberIdx AND a.memberIdx = $friend_id");
        $myfriendIdx = $PdoMySQL->getRow($sql_msg);
        if ($myfriendIdx['myfriendIdx']) {//存在该好友
            $data_friend['nickName'] = $nickName;
            if (!$nickName || $nickName == '') {
                $friendName = $PdoMySQL->find($tables, 'memberIdx = "' . $friend_id . '"', 'memberName');
                $nickName = $friendName['memberName'];
            }           
            $data = $PdoMySQL->update($data_friend,$tb_my_friend,'myfriendIdx = '.$myfriendIdx['myfriendIdx']);
            $res['code'] = 0;
            $res['msg'] = "修改成功";                       
            $res['data'] = $nickName;            
        }else{
            $res['code'] = -1;
            $res['msg'] = "参数错误";            
        }
        echo  json_encode($res);
        break;        
    case 'moveFriend'://移动好友     
        $friend_id = $_GET['friend_id'];   
        $data_friend['mygroupIdx'] = $_GET['groupidx'];   
        $memberIdx = $_SESSION['info']['id'];
        $sql_msg = sprintf(" SELECT a.myfriendIdx from tb_my_friend AS a INNER JOIN tb_my_group AS b ON a.mygroupIdx = b.mygroupIdx where b.memberIdx = $memberIdx AND a.memberIdx = $friend_id");
        $myfriendIdx = $PdoMySQL->getRow($sql_msg);
        if ($myfriendIdx['myfriendIdx']) {//存在该好友

            $data = $PdoMySQL->update($data_friend,$tb_my_friend,'myfriendIdx = '.$myfriendIdx['myfriendIdx']);
            $res['code'] = 0;
            $res['msg'] = "修改成功";                       
            $res['data'] = $data_friend['mygroupIdx'];            
        }else{
            $res['code'] = -1;
            $res['msg'] = "参数错误";            
        }
        echo  json_encode($res);
        break;         
    case 'removeFriends'://删除好友     
        $friend_id = $_GET['friend_id'];   
        $memberIdx = $_SESSION['info']['id'];
        $sql_msg = sprintf(" SELECT a.myfriendIdx from tb_my_friend AS a INNER JOIN tb_my_group AS b ON a.mygroupIdx = b.mygroupIdx where b.memberIdx = $memberIdx AND a.memberIdx = $friend_id");
        $myfriendIdx = $PdoMySQL->getRow($sql_msg);
        if ($myfriendIdx['myfriendIdx']) {//存在该好友
            $PdoMySQL->delete($tb_my_friend, "myfriendIdx=".$myfriendIdx['myfriendIdx']);//从我的好友列表删除
            $sql_msg = sprintf(" SELECT a.myfriendIdx from tb_my_friend AS a INNER JOIN tb_my_group AS b ON a.mygroupIdx = b.mygroupIdx where b.memberIdx = $friend_id AND a.memberIdx = $memberIdx");
            $friendIdx = $PdoMySQL->getRow($sql_msg);  
            $PdoMySQL->delete($tb_my_friend, "myfriendIdx=".$friendIdx['myfriendIdx']);//从好友列表删除我          
            $PdoMySQL->delete($tb_msg, '(`from` = '.$friend_id .' AND `to` = '.$memberIdx .') OR (`from` = '.$memberIdx .' AND `to` = '.$friend_id .')' );//删除消息记录
            $res['code'] = 0;
            $res['msg'] = "修改成功";                       
            $res['data'] = $nickName;            
        }else{
            $res['code'] = -1;
            $res['msg'] = "参数错误";            
        }
        echo  json_encode($res);
        break;      
    case 'editGroupNickName'://编辑群名片     
        $memberIdx = $_GET['memberIdx'];//传递过来的用户
        $groupIdx = $_GET['groupIdx'];   
        $data_group_name['nickName'] = $_GET['nickName'];   
        $memberIdx_AT = $_SESSION['info']['id'];//当前登陆的用户
        if ($memberIdx == $memberIdx_AT) {//修改自己的名片
            $data = $PdoMySQL->update($data_group_name,$tb_group_member,'memberIdx = '.$memberIdx.' AND groupIdx='.$groupIdx);
            $res['code'] = 0;
            $res['msg'] = "修改成功";                       
            $res['data'] = $data_group_name['nickName'];         
        }else{
            $sql = sprintf(" SELECT type from tb_group_member  where groupIdx = $groupIdx AND memberIdx = $memberIdx");
            $memberType = $PdoMySQL->getRow($sql);

            $sql = sprintf(" SELECT type from tb_group_member  where groupIdx = $groupIdx AND memberIdx = $memberIdx_AT");
            $manager = $PdoMySQL->getRow($sql);
            if ($manager['type'] == 1 || ($manager['type'] == 2 && $memberType['type'] == 3)) {//群主 或者群管理并且被修改的是群员
                $data = $PdoMySQL->update($data_group_name,$tb_group_member,'memberIdx = '.$memberIdx.' AND groupIdx='.$groupIdx);
                $res['code'] = 0;
                $res['msg'] = "修改成功";                       
                $res['data'] = $data_group_name['nickName'];            
            }else{
                $res['code'] = -1;
                $res['msg'] = "参数错误"; 
            }
        }
        echo  json_encode($res);
        break;     
    case 'setAdmin'://设置群管理     
        $manager = $_GET['memberIdx'];   
        $groupIdx = $_GET['groupidx'];   
        $type = $_GET['type'];   
        $memberIdx = $_SESSION['info']['id'];
        $sql_msg = sprintf(" SELECT groupMemberIdx,type from tb_group_member where memberIdx = $memberIdx AND groupIdx = $groupIdx");
        $belong = $PdoMySQL->getRow($sql_msg);
        if ($belong['type'] == 1) {//群主
            $sql_msg = sprintf(" SELECT groupMemberIdx,type from tb_group_member where memberIdx = $manager AND groupIdx = $groupIdx");
            $member = $PdoMySQL->getRow($sql_msg); //群员
            if ($type == 2) {//设置为管理
                if($member['type'] == 3){
                    $data_manager['type'] = 2;
                    $data = $PdoMySQL->update($data_manager,$tb_group_member,'groupMemberIdx = '.$member['groupMemberIdx']);
                    $res['code'] = 0;
                    $res['msg'] = "设置成功";             
                }elseif($member['type'] == 2){
                    $res['code'] = 1;
                    $res['msg'] = "请勿重复设置"; 
                }
            }else{
                if($member['type'] == 2){
                    $data_manager['type'] = 3;
                    $data = $PdoMySQL->update($data_manager,$tb_group_member,'groupMemberIdx = '.$member['groupMemberIdx']);
                    $res['code'] = 0;
                    $res['msg'] = "设置成功";             
                }elseif($member['type'] == 3){
                    $res['code'] = 1;
                    $res['msg'] = "请勿重复设置"; 
                }
            }

            $res['data'] = '';            
        }else{
            $res['code'] = -1;
            $res['msg'] = "参数错误";            
        }
        echo  json_encode($res);
        break; 
    case 'groupAllMemberGag'://全员禁言
        $groupIdx = $_GET['groupidx'];  
        $memberIdx_AT = $_SESSION['info']['id'];//当前登陆的用户
        $sql = sprintf(" SELECT type from tb_group_member  where groupIdx = $groupIdx AND memberIdx = $memberIdx_AT");
        $manager = $PdoMySQL->getRow($sql);
        if ($manager['type'] == 1 || $manager['type'] == 2 ) {//群主 或者群管理并且被修改的是群员
            $data_gag['gagTime'] = -1;//长久禁言
            $data = $PdoMySQL->update($data_gag,$tb_group_member,'groupIdx = '.$groupIdx .' AND type = 3');
            $res['code'] = 0;
            $res['msg'] = "修改成功";                       
            $res['data'] = '';            
        }else{
            $res['code'] = -1;
            $res['msg'] = "参数错误"; 
        }
        echo  json_encode($res);   
        break;       
    case 'liftGroupAllMemberGag'://解除全员禁言
        $groupIdx = $_GET['groupidx'];  
        $memberIdx_AT = $_SESSION['info']['id'];//当前登陆的用户
        $sql = sprintf(" SELECT type from tb_group_member  where groupIdx = $groupIdx AND memberIdx = $memberIdx_AT");
        $manager = $PdoMySQL->getRow($sql);
        if ($manager['type'] == 1 || $manager['type'] == 2 ) {//群主 或者群管理并且被修改的是群员
            $data_gag['gagTime'] = 0;//解除长久禁言
            $data = $PdoMySQL->update($data_gag,$tb_group_member,'groupIdx = '.$groupIdx .' AND type = 3');
            $res['code'] = 0;
            $res['msg'] = "修改成功";                       
            $res['data'] = '';            
        }else{
            $res['code'] = -1;
            $res['msg'] = "参数错误"; 
        }
        echo  json_encode($res);   
        break;            
    case 'groupMemberGag'://群员禁言
        $memberIdx = $_GET['friend_id'];//传递过来的用户
        $groupIdx = $_GET['groupidx'];   
        $gagTime = $_GET['gagTime'];   
        $memberIdx_AT = $_SESSION['info']['id'];//当前登陆的用户
        $sql = sprintf(" SELECT type,groupMemberIdx from tb_group_member  where groupIdx = $groupIdx AND memberIdx = $memberIdx");
        $memberType = $PdoMySQL->getRow($sql);
        $sql = sprintf(" SELECT type from tb_group_member  where groupIdx = $groupIdx AND memberIdx = $memberIdx_AT");
        $manager = $PdoMySQL->getRow($sql);
        if ($manager['type'] == 1 || ($manager['type'] == 2 && $memberType['type'] == 3)) {//群主 或者群管理并且被修改的是群员
            $arr = preg_split("/([0-9]+)/", $gagTime, 0, PREG_SPLIT_NO_EMPTY | PREG_SPLIT_DELIM_CAPTURE);  
            switch ($arr[1]) {
                case 's'://禁言多少秒
                    $gagTime = $arr[0];
                    break;
                case 'm'://禁言多少分钟
                    $gagTime = $arr[0]*60;
                    break;
                case 'h'://禁言多少小时
                    $gagTime = $arr[0]*3600;
                    break;  
                case 'd'://禁言多少天
                    $gagTime = $arr[0]*3600*24;
                    break;  
            }
            $data_gag['gagTime'] = ($gagTime+time()).'000';
            // $data_gag['type'] = $memberType['type']+2;
            $data = $PdoMySQL->update($data_gag,$tb_group_member,'groupMemberIdx = '.$memberType['groupMemberIdx']);
            $res['code'] = 0;
            $res['msg'] = "修改成功";                       
            $res['data']['gagTime'] = $data_gag['gagTime'];            
            $res['data']['time'] = time().'000';            
            $res['data']['s'] = $gagTime;          
        }else{
            $res['code'] = -1;
            $res['msg'] = "参数错误"; 
        }
        echo  json_encode($res);   
        break; 
    case 'liftGroupMemberGag'://解除群员禁言
        $memberIdx = $_GET['friend_id'];//传递过来的用户
        $groupIdx = $_GET['groupidx'];   
        $memberIdx_AT = $_SESSION['info']['id'];//当前登陆的用户
        $sql = sprintf(" SELECT type,groupMemberIdx from tb_group_member  where groupIdx = $groupIdx AND memberIdx = $memberIdx");
        $memberType = $PdoMySQL->getRow($sql);
        $sql = sprintf(" SELECT type from tb_group_member  where groupIdx = $groupIdx AND memberIdx = $memberIdx_AT");
        $manager = $PdoMySQL->getRow($sql);
        if ($manager['type'] == 1 || ($manager['type'] == 2 && $memberType['type'] == 3)) {//群主 或者群管理并且被修改的是群员
            $data_gag['gagTime'] = 0;
            $data = $PdoMySQL->update($data_gag,$tb_group_member,'groupMemberIdx = '.$memberType['groupMemberIdx']);
            $res['code'] = 0;
            $res['msg'] = "修改成功";                       
            $res['data'] = '';            
        }else{
            $res['code'] = -1;
            $res['msg'] = "参数错误"; 
        }
        echo  json_encode($res);   
        break;     
    case 'leaveGroup'://退群
        $memberIdx = $_GET['memberIdx'];//传递过来的用户
        if (!$memberIdx) {
            $list = $_GET['list'];
            $memberIdx = $list[0];
        }
        $groupIdx = $_GET['groupIdx'];   
        $memberIdx_AT = $_SESSION['info']['id'];//当前登陆的用户
        $sql = sprintf(" SELECT type from tb_group_member  where groupIdx = $groupIdx AND memberIdx = $memberIdx");
        $memberType = $PdoMySQL->getRow($sql);
        if (!$memberType['type']) {//群员不存在
            $res['code'] = -2;
            $res['msg'] = "群员不存在";                       
            $res['data'] = '';   
            echo  json_encode($res);
            return false;
        }
        $sql = sprintf(" SELECT type from tb_group_member  where groupIdx = $groupIdx AND memberIdx = $memberIdx_AT");
        $manager = $PdoMySQL->getRow($sql);
        if ($memberIdx_AT == $memberIdx || $manager['type'] == 1 || ($manager['type'] == 2 && $memberType['type'] == 3)) {//自己退群 群主 或者群管理并且被踢的是群员
            $PdoMySQL->delete($tb_group_member, "memberIdx=".$memberIdx.' AND groupIdx = '.$groupIdx);//从群员列表删除        
            $PdoMySQL->delete($tb_msg, '`from` = '.$memberIdx .' AND `to` = '.$groupIdx);//删除消息记录
            $res['code'] = 0;
            $res['msg'] = "修改成功";                       
            $res['data'] = $memberIdx;            
        }else{
            $res['code'] = -1;
            $res['msg'] = "参数错误"; 
        }
        echo  json_encode($res);   
        break; 
    default :
        echo '{"code":"9999","status":"n","info":"关键参数传入错误，请返回请求来源网址"}';
        break;
}

    function getUserToken($memberIdx){
        require_once 'config.php';
        require_once 'PdoMySQL.class.php';
        $PdoMySQL = new PdoMySQL;    
        $tables = 'tb_person';    
        $get_user = $PdoMySQL->find($tables, 'memberIdx = "' . $memberIdx . '"', 'easemob_token,loginTime,expires_in');
        if ($get_user['loginTime'] && $get_user['expires_in']) {
            $lastTime = $get_user['loginTime']+$get_user['expires_in']-3600*24*5;//还有5天则更新token
        }else{
            $lastTime = 1;
        }
        $time = time();
        if ($time >= $lastTime) {//token失效
            $url = 'http://a1.easemob.com/1199170801115017/layim/token';
            $pwd = md5($memberIdx.'easemob');
            $data = array('grant_type'=>'password','password'=>$pwd,'username'=>$memberIdx);        
            $json_data = json_encode($data);
            $info = Post($json_data,$url);
            $user_token = json_decode($info,true); 
            $data_token['easemob_token'] = $user_token['access_token'];
            $data_token['loginTime'] = $time;
            $data_token['expires_in'] = $user_token['expires_in'];
            $PdoMySQL->update($data_token,$tables, 'memberIdx = "' . $memberIdx . '"');//更新token
        }else{
            $user_token['access_token'] = $get_user['easemob_token'];
        }       
        return $user_token;
    }

    function Get($headers,$url){
        $curl = curl_init();
        curl_setopt($curl, CURLOPT_URL, $url);
        curl_setopt($curl, CURLOPT_HEADER, false);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
        $return_str = curl_exec($curl);
        curl_close($curl);
        return $return_str;
    }  


    function Post($curlPost,$url,$headers=''){
        $curl = curl_init(); 
        curl_setopt($curl, CURLOPT_URL, $url);
        curl_setopt($curl, CURLOPT_HEADER, false);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
        if ($headers) {
           curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
        }
        curl_setopt($curl, CURLOPT_NOBODY, true);
        curl_setopt($curl, CURLOPT_POST, true);
        curl_setopt($curl, CURLOPT_POSTFIELDS, $curlPost);
        $return_str = curl_exec($curl);
        curl_close($curl);
        return $return_str;
    }   
