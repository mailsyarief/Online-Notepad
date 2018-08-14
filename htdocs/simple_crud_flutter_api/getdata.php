<?php

include('conn.php');

$queryResult = $conn->query("SELECT * FROM note ORDER BY `note`.`notepad_time` DESC");
$result=array();

while ($fetchData = $queryResult->fetch_assoc()) {
	$result[]=$fetchData;
}

echo json_encode($result);
?>

