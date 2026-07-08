<?php
//parametre de connexion 
$host = 'localhost';
$dbname = 'dansdos_ferme';
$username = 'root';
$password = ''; 

try{
    //création de pdo
    $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8", $username, $password);
    //configuration pour afficher les erreurs sql
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    //arreter et afficher l'erreru au cas ou 
    die("Erreur de connexion à la base de données : " . $e->getMessage());
}
?>
