<?php

include('conn.php');

$notepad_title = $_POST['notepad_title'];
$notepad_body = $_POST['notepad_body'];

$sql = "INSERT INTO `note` (`notepad_id`, `notepad_title`, `notepad_body`, `notepad_time`) VALUES (NULL, '$notepad_title', '$notepad_body', CURRENT_TIMESTAMP)";
if(mysqli_query($conn, $sql)){
	echo "1";
}else{
	echo "err";
};


?>

