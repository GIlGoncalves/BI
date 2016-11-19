-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema BI
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema BI
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS  `BI`;
CREATE SCHEMA IF NOT EXISTS `BI` DEFAULT CHARACTER SET utf8 ;
USE `BI` ;

-- -----------------------------------------------------
-- Table `BI`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BI`.`Cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `cidade` VARCHAR(45) NOT NULL,
  `pais` VARCHAR(45) NOT NULL,
  `dataRegisto` DATE NOT NULL,
  `dataNascimento` DATE NOT NULL,
  `email` VARCHAR(45) NOT NULL ,
  `nrTelemovel` INT NULL,
  `last_Update` TIMESTAMP NOT NULL,
  unique(email),
  unique(nrTelemovel),
  PRIMARY KEY (`idCliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BI`.`Editora`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BI`.`Editora` (
  `idEditora` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL unique,
  `last_Update` TIMESTAMP NOT NULL,
  PRIMARY KEY (`idEditora`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BI`.`Jogo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BI`.`Jogo` (
  `idJogo` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL unique,
  `dataLancamento` VARCHAR(45) NOT NULL,
  `idadeParaJogar` INT Unsigned NOT NULL ,
  `quantidade` INT Unsigned NOT NULL ,
  `precoBase` DECIMAL(10,5) Unsigned NOT NULL ,
  `idEditora` INT NOT NULL,
  `last_Update` TIMESTAMP NOT NULL,
  PRIMARY KEY (`idJogo`, `idEditora`),
  INDEX `fk_Jogo_Editora_idx` (`idEditora` ASC),
  CONSTRAINT `fk_Jogo_Editora`
    FOREIGN KEY (`idEditora`)
    REFERENCES `BI`.`Editora` (`idEditora`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BI`.`Categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BI`.`Categoria` (
  `idCategoria` INT NOT NULL AUTO_INCREMENT,
  `categoria` VARCHAR(45) NOT NULL unique,
  `last_Update` TIMESTAMP NOT NULL,
  PRIMARY KEY (`idCategoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BI`.`JogoCategoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BI`.`JogoCategoria` (
  `idJogo` INT NOT NULL ,
  `idCategoria` INT NOT NULL,
  `last_Update` TIMESTAMP NOT NULL,
  PRIMARY KEY (`idJogo`, `idCategoria`),
  INDEX `fk_Jogo_has_Categoria_Categoria1_idx` (`idCategoria` ASC),
  INDEX `fk_Jogo_has_Categoria_Jogo1_idx` (`idJogo` ASC),
  CONSTRAINT `fk_Jogo_has_Categoria_Jogo1`
    FOREIGN KEY (`idJogo`)
    REFERENCES `BI`.`Jogo` (`idJogo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Jogo_has_Categoria_Categoria1`
    FOREIGN KEY (`idCategoria`)
    REFERENCES `BI`.`Categoria` (`idCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BI`.`Compras`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BI`.`Compras` (
  `idCompras` INT NOT NULL AUTO_INCREMENT,
  `idJogo` INT NULL,
  `idCliente` INT NULL,
  `dataCompra` DATE NOT NULL,
  `precoVendido` DECIMAL(10,5) Unsigned NOT NULL,
  `quantidade` INT Unsigned NOT NULL,
  `desconto` DECIMAL(10,5) Unsigned NOT NULL ,
  `last_Update` TIMESTAMP NOT NULL,
  PRIMARY KEY (`idCompras`),
  INDEX `fk_Jogo_has_Cliente_Cliente1_idx` (`idCliente` ASC),
  INDEX `fk_Jogo_has_Cliente_Jogo1_idx` (`idJogo` ASC),
  CONSTRAINT `fk_Jogo_has_Cliente_Jogo1`
    FOREIGN KEY (`idJogo`)
    REFERENCES `BI`.`Jogo` (`idJogo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Jogo_has_Cliente_Cliente1`
    FOREIGN KEY (`idCliente`)
    REFERENCES `BI`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BI`.`Avaliacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BI`.`Avaliacao` (
  `idAvaliacao` INT NOT NULL AUTO_INCREMENT,
  `idJogo` INT NULL,
  `idCliente` INT NULL,
  `avaliacao` INT Unsigned NOT NULL,
  `last_Update` TIMESTAMP NOT NULL,
  INDEX `fk_Cliente_has_Jogo_Jogo1_idx` (`idJogo` ASC),
  INDEX `fk_Cliente_has_Jogo_Cliente1_idx` (`idCliente` ASC),
  PRIMARY KEY (`idAvaliacao`),
  CONSTRAINT `fk_Cliente_has_Jogo_Cliente1`
    FOREIGN KEY (`idCliente`)
    REFERENCES `BI`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cliente_has_Jogo_Jogo1`
    FOREIGN KEY (`idJogo`)
    REFERENCES `BI`.`Jogo` (`idJogo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
