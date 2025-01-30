-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema utility_db
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `utility_db` ;

-- -----------------------------------------------------
-- Schema utility_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `utility_db` DEFAULT CHARACTER SET utf8 ;
USE `utility_db` ;

-- -----------------------------------------------------
-- Table `utility_db`.`person`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `utility_db`.`person` ;

CREATE TABLE IF NOT EXISTS `utility_db`.`person` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(255) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE)
ENGINE = InnoDB;

SET SQL_MODE = '';
DROP USER IF EXISTS utility_db;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'utility_db' IDENTIFIED BY '1234';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE `utility_db`.* TO 'utility_db';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
