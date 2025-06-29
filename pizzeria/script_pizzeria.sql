-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pizzeria` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `pizzeria` ;

-- -----------------------------------------------------
-- Table `pizzeria`.`botiga`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`botiga` (
  `id_botiga` INT NOT NULL,
  `adreca` VARCHAR(150) NOT NULL,
  `codi_postal` INT NOT NULL,
  `localitat` VARCHAR(45) NOT NULL,
  `provincia` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_botiga`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`client` (
  `id_client` INT NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  `cognom1` VARCHAR(45) NOT NULL,
  `cognom2` VARCHAR(45) NULL DEFAULT NULL,
  `telefon` VARCHAR(15) NOT NULL,
  `adreca` VARCHAR(150) NOT NULL,
  `codi_postal` INT NOT NULL,
  `localitat` VARCHAR(45) NOT NULL,
  `provincia` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_client`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria`.`empleat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`empleat` (
  `id_empleat` INT NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  `cognom1` VARCHAR(45) NOT NULL,
  `cognom2` VARCHAR(45) NULL DEFAULT NULL,
  `nif` VARCHAR(45) NOT NULL,
  `telefon` VARCHAR(45) NULL DEFAULT NULL,
  `posicio` VARCHAR(10) NOT NULL,
  `id_botiga` INT NOT NULL,
  PRIMARY KEY (`id_empleat`),
  INDEX `fk_id_botiga_idx` (`id_botiga` ASC) VISIBLE,
  CONSTRAINT `fk_id_botiga`
    FOREIGN KEY (`id_botiga`)
    REFERENCES `pizzeria`.`botiga` (`id_botiga`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria`.`comanda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`comanda` (
  `id_comanda` INT NOT NULL,
  `dia_hora` DATETIME NOT NULL,
  `local_o_recollir` VARCHAR(8) NOT NULL,
  `cuantitat_productes` INT NOT NULL,
  `pvp` DOUBLE NOT NULL,
  `id_client` INT NOT NULL,
  `id_botiga` INT NOT NULL,
  `id_repartidor` INT NOT NULL,
  PRIMARY KEY (`id_comanda`),
  INDEX `id_client_idx` (`id_client` ASC) VISIBLE,
  INDEX `id_botiga_idx` (`id_botiga` ASC) VISIBLE,
  INDEX `id_repartidor_idx` (`id_repartidor` ASC) VISIBLE,
  CONSTRAINT `id_botiga`
    FOREIGN KEY (`id_botiga`)
    REFERENCES `pizzeria`.`botiga` (`id_botiga`),
  CONSTRAINT `id_client`
    FOREIGN KEY (`id_client`)
    REFERENCES `pizzeria`.`client` (`id_client`),
  CONSTRAINT `id_repartidor`
    FOREIGN KEY (`id_repartidor`)
    REFERENCES `pizzeria`.`empleat` (`id_empleat`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pizzeria`.`producte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`producte` (
  `id_producte` INT NOT NULL,
  `tipus_categoria` VARCHAR(45) NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  `descripcio` VARCHAR(200) NOT NULL,
  `foto` VARCHAR(45) NULL DEFAULT NULL,
  `preu` VARCHAR(45) NOT NULL,
  `id_comanda` INT NOT NULL,
  PRIMARY KEY (`id_producte`),
  INDEX `fk_id_comanda_idx` (`id_comanda` ASC) VISIBLE,
  CONSTRAINT `fk_id_comanda`
    FOREIGN KEY (`id_comanda`)
    REFERENCES `pizzeria`.`comanda` (`id_comanda`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;
INSERT INTO botiga (id_botiga, adreca, codi_postal, localitat, provincia) VALUES
(4, "Calle falsa, 123", 08206, "Sabadell", "Barcelona"),
(2, "Paseo Can Faso, 5", 08400, "Vic", "Barcelona"),
(3, "Calle valencia, 119", 07500, "Valencia", "Valencia");
INSERT INTO client (id_client, nom, cognom1, cognom2, telefon, adreca, codi_postal, localitat, provincia) VALUES
(1, "Jose", "Gonzalez", "Perez", 111111111, "Calle socrates, 10", 08206, "Sabadell", "Barcelona"),
(2, "Aina", "Casademunt", "Roig", 222222222, "Carretera de caldes, 5", 08410, "Caldes de montbui", "Barcelona"),
(3, "Pepe", "Leches", "Agrias", "333333333", "Avenida del percebe, 4", 02006, "Fuenteovejuna", "Cordoba");
INSERT INTO empleat (id_empleat, nom, cognom1, cognom2, nif, telefon, posicio, id_botiga) VALUES
(1, "Laura", "Martínez", "García", "12345678A", "612345678", "cocina", 4),
(2, "Carlos", "Ruiz", "López", "23456789B", "622345679", "reparto", 4),
(3, "Ana", "Sánchez", "Moreno", "34567890C", "632345680", "reparto", 2),
(4, "David", "Torres", "Jiménez", "45678901D", "642345681", "reparto", 3);
INSERT INTO producte (id_producte, tipus_categoria, nom, descripcio, foto, preu, id_comanda) VALUES
(1, "pizza estandard", "margarita", "tomate y queso", "foto", 8.99, 1),
(2, "pizza estandard", "carbonara", "salsa carbonara y bacon", "foto", 9.99, 1),
(3, "pizza premium", "putuflu", "tomate de huerta ecologica, jamón de unicornio y queso de cabra del himalaya", "foto", 39.99, 1),
(4, "pizza premium", "salvaje", "tomate picante mexicano", "costilla desmenuzada a la bbq con bourbon y queso mozarella", "foto", 15.99, 1),
(5, "complemento", "tiras de pollo rebozadas", "tiras de pollo rebozadas", "foto", 6.50, 1),
(6, "complemento", "pimientos del padrón", "unos pican y otros no", "foto", 6.00, 1),
(7, "bebida", "cola", "cola", "foto", 1.95, 1),
(8, "bebida", "cerveza", "cerveza", "foto", 1.95,1);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
