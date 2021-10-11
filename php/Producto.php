<?php 
include 'db.php';
$query=$_POST['query'];
$que=$conn->query($query);
$result=array();
while($fetchData=$que->fetch_assoc())
{
    $result[]=$fetchData;
}
echo json_encode($result);