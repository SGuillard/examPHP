<?php

try {
    $conn = new mysqli('myapp_mysql:3306', 'root', 'root');

    // Check connection
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }
    echo "Connected successfully" . PHP_EOL;
} catch (Exception $e) {
    die('Erreur : ' . $e->getMessage());
}
die;
