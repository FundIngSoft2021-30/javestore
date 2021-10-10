<?php 
include 'db.php';
$query=$_POST['query'];
$query=$conn->query("SELECT * FROM Cuenta");
$result=array();
while($fetchData=$query->fetch_assoc())
{
    $result[]=$fetchData;
}
echo json_encode($result);
