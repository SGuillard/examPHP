<?php

try {
    $bdd = new PDO('mysql:host=test_mysql:3306;dbname=test;charset=utf8', 'root', 'root');
    $reponse = $bdd->query("SELECT * FROM ok");
    foreach ($reponse as $rep) {
        var_dump($rep['col']);
        die;
    }
} catch (Exception $e) {
    die('Erreur : ' . $e->getMessage());
}

echo date_default_timezone_get();
die;
