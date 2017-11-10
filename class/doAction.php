<?php

#包含所需文件
require_once 'config.php';
require_once 'PdoMySQL.class.php';

#实例化pdo，redis，并设置redis监听端口
$PdoMySQL = new PdoMySQL;

#执行动作获取
$act = empty($_GET['action']) ? null : $_GET['action'];
$BASEURL = 'http://a1.easemob.com/1199170801115017/layim/';
$APIURL = '../uploads/';
$tables = 'tb_person';
$tb_skin = 'tb_skin';
switch ($act) {

    #user login
    case 'login':
    // print_r(md5('911117easemob'));
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
                $easemobpwd = md5($get_user['memberIdx'].'easemob');
                $data = array('grant_type'=>'password','password'=>$easemobpwd,'username'=>$param['name']);        
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
        $res['data']['mine']['skin'] = $get_skin['isUserUpload'] == 1? "http://localhost:888/uploads/skin/".$get_skin['url']:"http://localhost:888/static/layui/css/modules/layim/skin/".$get_skin['url'];
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
        $url = $BASEURL.'/chatgroups/'.$id;
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