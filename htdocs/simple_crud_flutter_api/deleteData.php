<?php

include('conn.php');

$notepad_id = $_POST['notepad_id'];

$sql = "DELETE FROM note WHERE `notepad_id` = '$notepad_id'";
if(mysqli_query($conn, $sql)){
	echo "1";
}else{
	echo "err";
};


?>

