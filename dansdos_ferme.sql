-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mer. 08 juil. 2026 à 23:07
-- Version du serveur : 8.4.7
-- Version de PHP : 8.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `dansdos_ferme`
--

-- --------------------------------------------------------

--
-- Structure de la table `clients`
--

DROP TABLE IF EXISTS `clients`;
CREATE TABLE IF NOT EXISTS `clients` (
  `id_client` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `numero` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `adresse` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_client`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `depenses`
--

DROP TABLE IF EXISTS `depenses`;
CREATE TABLE IF NOT EXISTS `depenses` (
  `id_depense` int NOT NULL AUTO_INCREMENT,
  `categorie` enum('nourriture','vaccin','imprevu','autre') COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `montant` decimal(10,2) NOT NULL,
  `date_depense` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_depense`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `factures`
--

DROP TABLE IF EXISTS `factures`;
CREATE TABLE IF NOT EXISTS `factures` (
  `id_facture` int NOT NULL AUTO_INCREMENT,
  `id_client` int NOT NULL,
  `date_facturation` datetime DEFAULT CURRENT_TIMESTAMP,
  `montant_total` decimal(10,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id_facture`),
  KEY `fk_factures_clients` (`id_client`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `lots`
--

DROP TABLE IF EXISTS `lots`;
CREATE TABLE IF NOT EXISTS `lots` (
  `id_lot` int NOT NULL AUTO_INCREMENT,
  `type_lot` enum('poussin','adulte') COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantite_initiale` int NOT NULL,
  `date_arrivee` date NOT NULL,
  `statut` enum('en_cours','termine') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_lot`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `pertes`
--

DROP TABLE IF EXISTS `pertes`;
CREATE TABLE IF NOT EXISTS `pertes` (
  `id_perte` int NOT NULL AUTO_INCREMENT,
  `lot_id` int NOT NULL,
  `quantite` int NOT NULL,
  `cause` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_perte` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_perte`),
  KEY `fk_perte_lots` (`lot_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `utilisateurs`
--

DROP TABLE IF EXISTS `utilisateurs`;
CREATE TABLE IF NOT EXISTS `utilisateurs` (
  `id_utilisateur` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prenom` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mot_de_passe` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` enum('admin','receptionniste') COLLATE utf8mb4_unicode_ci DEFAULT 'receptionniste',
  PRIMARY KEY (`id_utilisateur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `ventes`
--

DROP TABLE IF EXISTS `ventes`;
CREATE TABLE IF NOT EXISTS `ventes` (
  `id_vente` int NOT NULL AUTO_INCREMENT,
  `lot_id` int NOT NULL,
  `facture_id` int NOT NULL,
  `methode_vente` enum('poids','unite') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quantite_tetes` int NOT NULL,
  `poids_total` decimal(10,2) DEFAULT NULL,
  `prix_unitaire` decimal(10,2) NOT NULL,
  `montant_total` decimal(10,2) NOT NULL,
  `date_vente` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_vente`),
  KEY `fk_lot_ventes` (`lot_id`),
  KEY `fk_facture_ventes` (`facture_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `factures`
--
ALTER TABLE `factures`
  ADD CONSTRAINT `fk_factures_clients` FOREIGN KEY (`id_client`) REFERENCES `clients` (`id_client`) ON DELETE CASCADE;

--
-- Contraintes pour la table `pertes`
--
ALTER TABLE `pertes`
  ADD CONSTRAINT `fk_perte_lots` FOREIGN KEY (`lot_id`) REFERENCES `lots` (`id_lot`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
