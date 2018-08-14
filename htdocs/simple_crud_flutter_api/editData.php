<?php

include('conn.php');

$notepad_title = $_POST['notepad_title'];
$notepad_body = $_POST['notepad_body'];
$notepad_id = $_POST['notepad_id'];


$sql = "UPDATE `note` SET `notepad_title` = '$notepad_title', `notepad_body` = '$notepad_body', `notepad_time` = CURRENT_TIMESTAMP WHERE `note`.`notepad_id` = '$notepad_id'";
if(mysqli_query($conn, $sql)){
	echo "1";
}else{
	echo "err";
};


?>

