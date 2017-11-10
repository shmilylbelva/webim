<?php
if(!isset($_SESSION["user_id"])){
    echo "<script>window.parent.location.href='login.php';</script>";
}else{
    $uinfo = $_SESSION['info'];
}
