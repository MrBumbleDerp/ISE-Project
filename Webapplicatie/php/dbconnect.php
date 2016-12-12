<?php
$serverName = "BERT\SQLEXPRESS";
$connectionInfo = array("Database"=>"VelibDB", "UID"=>"sa", "PWD"=>"password");
$conn = sqlsrv_connect( $serverName, $connectionInfo);

if($conn==0) {
    echo "Connection failed.<br>";
    die(print_r(sqlsrv_errors(), true));
}
?>
