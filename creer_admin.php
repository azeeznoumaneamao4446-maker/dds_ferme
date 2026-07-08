<?php
require 'connexion.php'; //on se connecte à la bd
$nom = 'Kouakou';
$prenom = 'Alain';
$mot_de_passe = "admin123"; //mot de passe a la connexion
$role = 'admin';
//cryptage du mot de passe 
$mot_de_passe_crypte = password_hash($mot_de_passe, PASSWORD_DEFAULT);
$pdo;
//Insertion dans la base
$sql = "INSERT INTO utilisateurs (nom, prenom, mot_de_passe, role) VALUES (?, ?, ?, ?)";
$smt = $pdo->prepare($sql);

if ($smt->execute([$nom, $prenom, $mot_de_passe_crypte, $role])) {
    echo "<h1>Succes !</h1>";
    echo "<p>Le compte administateur a été créé avec succes.</p>";
    echo "<p>Prenom : <b>$prenom</b></p>";
    echo "<p>Mot de passe : <b>$mot_de_passe</b></p>";
    echo '<a href="login.php">Aller à la page de connexion</a>';
} else {
    echo "Erreur lors de la creation du compte.";
}
?>
