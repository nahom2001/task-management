<?php
    mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);
    $dbServer = "localhost";
    $dbUsername = "root";
    $dbPassword = "";
    $dbDatabase = "tms_db";

    $connection = mysqli_connect($dbServer, $dbUsername, $dbPassword);
?>