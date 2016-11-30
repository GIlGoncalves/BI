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
-- Table `BI`.`Pais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BI`.`Pais` (
  `idPais` INT NOT NULL AUTO_INCREMENT ,
  `nomePais` VARCHAR(45) NOT NULL UNIQUE,
  `last_Updade` TIMESTAMP NOT NULL,
  PRIMARY KEY (`idPais`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BI`.`Cidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BI`.`Cidade` (
 `idCidade` INT NOT NULL AUTO_INCREMENT,
  `cidade` VARCHAR(45) NOT NULL UNIQUE,
  `idPais` INT NOT NULL,
  `last_Updade` TIMESTAMP NOT NULL,
  PRIMARY KEY (`idCidade`),
  INDEX `fk_Cidade_Pais1_idx` (`idPais` ASC),
  CONSTRAINT `fk_Cidade_Pais1`
    FOREIGN KEY (`idPais`)
    REFERENCES `BI`.`Pais` (`idPais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BI`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BI`.`Cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `dataRegisto` DATE NOT NULL,
  `dataNascimento` DATE NOT NULL,
  `email` VARCHAR(45) NOT NULL unique,
  `nrTelemovel` INT NULL unique,
  `last_Update` TIMESTAMP NOT NULL,
  `idCidade` INT NOT NULL,
  `sexo` VARCHAR(1) NOT NULL,
  PRIMARY KEY (`idCliente`),
  INDEX `fk_Cliente_Cidade1_idx` (`idCidade` ASC),
  CONSTRAINT `fk_Cliente_Cidade1`
    FOREIGN KEY (`idCidade`)
    REFERENCES `BI`.`Cidade` (`idCidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BI`.`Produtor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BI`.`Produtor` (
   `idProdutor` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL unique,
  `last_Update` TIMESTAMP NOT NULL,
  PRIMARY KEY (`idProdutor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BI`.`Jogo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BI`.`Jogo` (
  `idJogo` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL unique,
  `dataLancamento` date NOT NULL,
  `idadeParaJogar` INT Unsigned NOT NULL ,
  `quantidade` INT Unsigned NOT NULL ,
  `precoBase` DECIMAL(10,5) Unsigned NOT NULL ,
  `idProdutor` INT NOT NULL,
  `last_Update` TIMESTAMP NOT NULL,
  `desconto` DECIMAL(10,5) Unsigned NOT NULL,
  PRIMARY KEY (`idJogo`),
  INDEX `fk_Jogo_Produtor1_idx` (`idProdutor` ASC),
  CONSTRAINT `fk_Jogo_Produtor1`
    FOREIGN KEY (`idProdutor`)
    REFERENCES `BI`.`Produtor` (`idProdutor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
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
  `idJogo` INT NOT NULL,
  `idCliente` INT NOT NULL,
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
  `idJogo` INT NOT NULL,
  `idCliente` INT NOT NULL,
   `avaliacao` INT Unsigned NOT NULL,
  `last_Update` TIMESTAMP NOT NULL,
  `descricao` TEXT NULL,
  INDEX `fk_Cliente_has_Jogo_Jogo1_idx` (`idJogo` ASC),
  INDEX `fk_Cliente_has_Jogo_Cliente1_idx` (`idCliente` ASC),
  PRIMARY KEY (`idJogo`, `idCliente`),
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
