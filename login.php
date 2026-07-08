<?php
session_start(); // Démarre la session pour mémoriser l'utilisateur
require 'connexion.php'; // Appelle notre fichier de connexion

$erreur = ''; // Variable pour stocker les messages d'erreur

// Si le formulaire est soumis
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $prenom = $_POST['prenom'];
    $mot_de_passe = $_POST['mot_de_passe'];

    // On cherche l'utilisateur dans la base
    $stmt = $pdo->prepare("SELECT * FROM utilisateurs WHERE prenom = :prenom");
    $stmt->execute(['prenom' => $prenom]);
    $user = $stmt->fetch();

    // Vérification du mot de passe (on utilise password_verify pour lire le mot de passe crypté)
    if ($user && password_verify($mot_de_passe, $user['mot_de_passe'])) {
        // Succès : on enregistre les infos dans la session
        $_SESSION['id_utilisateur'] = $user['id_utilisateur'];
        $_SESSION['role'] = $user['role'];
        $_SESSION['prenom'] = $user['prenom'];

        // Redirection selon le rôle
        if ($user['role'] == 'admin') {
            header("Location: dashboard.php");
        } else {
            header("Location: caisse.php");
        }
        exit();
    } else {
        $erreur = "Prénom ou mot de passe incorrect.";
    }
}
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion - DDS Avicole</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light d-flex align-items-center" style="height: 100vh;">

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-4">
            <div class="card shadow-sm">
                <div class="card-body p-4">
                    <h3 class="text-center mb-4">DDS Avicole</h3>
                    
                    <?php if ($erreur): ?>
                        <div class="alert alert-danger"><?= $erreur ?></div>
                    <?php endif; ?>

                    <form method="POST" action="">
                        <div class="mb-3">
                            <label for="prenom" class="form-label">Prénom</label>
                            <input type="text" class="form-control" id="prenom" name="prenom" required>
                        </div>
                        <div class="mb-3">
                            <label for="mot_de_passe" class="form-label">Mot de passe</label>
                            <input type="password" class="form-control" id="mot_de_passe" name="mot_de_passe" required>
                        </div>
                        <button type="submit" class="btn btn-primary w-100">Se connecter</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>

