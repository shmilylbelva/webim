<?php

#包含所需文件
require_once 'config.php';
require_once 'PdoMySQL.class.php';

#实例化pdo，redis，并设置redis监听端口
$PdoMySQL = new PdoMySQL;

#执行动作获取
$act = empty($_GET['action']) ? null : $_GET['action'];
$BASEURL = 'http://a1.easemob.com/XXXXXXXXXXXXXX/XXX/';
$APIURL = '../uploads/';
$tables = 'tb_person';
$tb_skin = 'tb_skin';
$tb_msg = 'tb_msg';
$tb_chatlog = 'tb_chatlog';
const ADD_USER_MSG = 1;//为请求添加用户
const ADD_USER_SYS = 2;//为系统消息（添加好友
const ADD_GROUP_MSG = 3;//为请求加群
const ADD_GROUP_SYS = 4;//为系统消息（添加群）
const ALLUSER_SYS = 5;// 全体会员消息
const UNREAD = 1;//未读
const AGREE_BY_TO= 2;//同意
const DISAGREE_BY_TO = 3;//拒绝
const AGREE_BY_FROM = 4;//同意且返回消息已读
const DISAGREE_BY_FROM = 5;//拒绝且返回消息已读
const READ = 6;//全体消息已读

switch ($act) {

    #user login
    case 'login':
        $param['name'] = $_POST['name'];
        $param['pwd'] = $_POST['pwd'];
        $tables = 'tb_person';
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
                $url = $BASEURL.'token';
                $pwd = md5($get_user['memberIdx'].'easemob');
                $data = array('grant_type'=>'password','password'=>$pwd,'username'=>$param['name']);        
                $json_data = json_encode($data);
                $info = Post($json_data,$url);
                $user_token = json_decode($info,true);
                /**********************/
                #获取token，成功则保存session
                $arr = array(
                    'id' => $get_user['memberIdx'],
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
        $url_friend = $BASEURL.'users/'.$uid.'/contacts/users';
        $data_info = json_decode(Get($headers,$url_friend),true);
//获取群组
        $url_group = $BASEURL.'users/'.$uid.'/joined_chatgroups';
        $data_group = json_decode(Get($headers,$url_group),true);
//获取默认皮肤
        $get_skin = $PdoMySQL->find($tb_skin, 'memberIdx = "' . $_SESSION['info']['id'] . '"', 'url,memberIdx,isUserUpload');
//获取未读消息数量
        $sql_msg = "select COUNT(*) as count from tb_msg where (`to` = ".$_SESSION['info']['id'] ." AND (msgType = ".ADD_USER_MSG ." OR msgType = ".ADD_GROUP_MSG.") AND status = ".UNREAD." ) 
        OR ( `from` = ".$_SESSION['info']['id']." AND (msgType = ".ADD_USER_SYS." OR msgType = ".ADD_GROUP_SYS." ) AND (status = ".AGREE_BY_TO." OR status = ".DISAGREE_BY_TO.") )";
        $msgBox = $PdoMySQL->getRow($sql_msg);
        // print_r($msgBox);
        $get_my_group[0]['groupname'] = '我的好友';
        $get_my_group[0]['id'] = '1';
        $get_my_group[0]['online'] = '1';              
        foreach ($data_info['data'] as $key => $value) {
            $sql2 = "select memberIdx AS id ,memberName AS username,signature from tb_person where memberIdx = '{$value}' ";
            $get_my_friend = $PdoMySQL->getRow($sql2);
            $get_my_friend['avatar'] = $APIURL.'person/'.$get_my_friend['id'].'.jpg';
            $get_my_friend['sign'] = $get_my_friend['signature'];
            $get_my_group[0]['list'][$key]= $get_my_friend;
        }
        foreach ($data_group['data'] as $k => $v) {
            $group[$k]['groupname'] = $v['groupname'];
            $group[$k]['id'] = $v['groupid'];
            $group[$k]['avatar'] = 'static/img/tel.jpg';
        }
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
    case 'uploadImage':
        $url = $BASEURL.'chatfiles';
        $headers = array('Content-type: multipart/form-data','Authorization:Bearer '.$_SESSION['info']['access_token'],'restrict-access: true');
        $file = file_get_contents($_FILES['file']['tmp_name']);
        $Upload_data = array('file'=>$file);
        $data_info = Post($Upload_data,$url,$headers);
        echo '{"code": 0 ,"msg": ""  ,"data": '.$data_info.'}';
        break;
    case 'uploadFile':
        $url = $BASEURL.'chatfiles';
        $headers = array('Content-type: multipart/form-data','Authorization:Bearer '.$_SESSION['info']['access_token'],'restrict-access: true');
        $file = file_get_contents($_FILES['file']['tmp_name']);
        $Upload_data = array('file'=>$file);
        $data_ = Post($Upload_data,$url,$headers);
        $data_info = json_decode($data_,true);
        if ($data_info['entities']['0']['uuid']) {
            $imageURL = $url.'/'.$data_info['entities']['0']['uuid'];
        }
        $res['code'] = 0;
        $res['msg'] = "";
        $res['data']['src'] = $imageURL;
        $res['data']['name'] = $_FILES['file']['name'];
        echo  json_encode($res);        
        break;  
    case 'groupMembers':

        $id = $_GET['id'];
        $url = $BASEURL.'chatgroups/'.$id;
        $headers = array('Authorization:Bearer '.$_SESSION['info']['access_token']);
        $data_group = json_decode(Get($headers,$url),true);
        foreach ($data_group['data'][0]['affiliations'] as $key => $value) {
            $userid = array_values($value)[0];
            $group[$key]['id'] = $userid;
            $get_user = $PdoMySQL->find($tables, 'memberIdx = "' . $userid . '"', 'memberName,memberIdx');
            $group[$key]['username'] = $get_user['memberName'];
            $group[$key]['avatar'] = $APIURL.'/person/'.$userid.'.jpg';
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
        $sql = "select memberIdx,memberName,signature,memberAge,memberSex from tb_person order by rand() limit 16 ";
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
            $sql = "select groupIdx,groupName,des,number from tb_group where (groupIdx LIKE '%{$value}%' OR groupName LIKE '%{$value}%' OR des LIKE '%{$value}%') limit ".$select_from. ','.$rows;  
        }
        $get_friend = $PdoMySQL->getAll($sql);        
        $res['code'] = 0;
        $res['msg'] = "";
        $res['data'] = $get_friend;
        echo  json_encode($res); 
        break;          
    case 'get_one_user_data'://获取默认好友推荐
        $memberIdx = $_GET['memberIdx'];
        $user = $PdoMySQL->find($tables, 'memberIdx = "' . $memberIdx . '"','memberIdx,memberName,signature,memberAge,memberSex');       
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
            print_r($value['status']);
            $data['status'] = $value['status']+2;
            $username = $PdoMySQL->update($data,$tb_msg,'msgIdx = "' . $value['msgIdx'] . '"');
        } 
        $res['code'] = 0;
        $res['msg'] = "";
        echo  json_encode($res);  
        break;           
    case 'modify_msg'://修改添加状态
        $msgType = $_GET['msgType'];    
        $memberIdx = $_SESSION['info']['id'];   
        $data['msgType'] = $msgType == ADD_USER_SYS?ADD_USER_SYS:ADD_GROUP_SYS;   
        if ($data['msgType'] == ADD_GROUP_SYS) {
            $data['handle'] = $memberIdx;
        }    
        $msgIdx = $_GET['msgIdx'];
        $status = $_GET['status'];
        $data['status'] = $status == AGREE_BY_TO?AGREE_BY_TO:DISAGREE_BY_TO;
        $data['time'] = time();
        $data['readTime'] = $data['time'];
        $success = $PdoMySQL->update($data,$tb_msg,'( `to` = "'.$memberIdx.'" OR find_in_set("'.$memberIdx.'", adminGroup)) AND `msgIdx` = "' . $msgIdx . '"');
        if ($success) {
            $res['code'] = 0;
        }else{
            $res['code'] = -1;
        }
        $res['msg'] = "";
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
        $memberIdx = $_SESSION['info']['id'];
        $rows = 20;//每页显示数量
        $sql = "select COUNT(*) as count from tb_chatlog where ((`to` = ".$memberIdx ." AND `from` = ".$id." ) 
        OR (`to` = ".$id ." AND `from` = ".$memberIdx.") AND status = 1 )";
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
            $sql_msg = "select c.content,c.sendTime AS timestamp,c.from,p1.memberName as fromName,p2.groupName as toName from tb_chatlog as c JOIN tb_person as p1 ON c.from = p1.memberIdx LEFT JOIN tb_group as p2 ON c.to = p2.groupIdx where c.to = '".$id."' limit ".$select_from. ','.$rows;
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
    default :
        echo '{"code":"9999","status":"n","info":"关键参数传入错误，请返回请求来源网址"}';
        break;
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