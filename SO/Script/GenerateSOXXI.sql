-- MySQL Script generated by MySQL Workbench
-- Thu Jun 29 03:02:44 2017
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema sitexxi
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema sitexxi
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `sitexxi` DEFAULT CHARACTER SET utf8 ;
USE `sitexxi` ;

-- -----------------------------------------------------
-- Table `sitexxi`.`Pais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi`.`Pais` (
  `id_pais` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(35) NOT NULL,
  PRIMARY KEY (`id_pais`),
  UNIQUE INDEX `nome_UNIQUE` (`nome` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitexxi`.`Cidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi`.`Cidade` (
  `id_cidade` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `id_pais` INT NOT NULL,
  PRIMARY KEY (`id_cidade`),
  INDEX `fk_id_pais_idx` (`id_pais` ASC),
  UNIQUE INDEX `nome_UNIQUE` (`nome` ASC),
  CONSTRAINT `fk_Cidade_Pais`
    FOREIGN KEY (`id_pais`)
    REFERENCES `sitexxi`.`Pais` (`id_pais`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitexxi`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi`.`Cliente` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `data_nascimento` DATE NOT NULL,
  `sexo` CHAR(1) NOT NULL,
  `nr_telemovel` VARCHAR(20) NULL,
  `data_registo` DATETIME NOT NULL,
  `id_cidade` INT NOT NULL,
  PRIMARY KEY (`id_cliente`),
  INDEX `fk_id_cidade_idx` (`id_cidade` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  INDEX `fk_email_idx` (`email` ASC),
  CONSTRAINT `fk_Cliente_Cidade1`
    FOREIGN KEY (`id_cidade`)
    REFERENCES `sitexxi`.`Cidade` (`id_cidade`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitexxi`.`Produtor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi`.`Produtor` (
  `id_produtor` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_produtor`),
  UNIQUE INDEX `nome_UNIQUE` (`nome` ASC),
  INDEX `fk_nome_idx` (`nome` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitexxi`.`Jogo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi`.`Jogo` (
  `id_jogo` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(50) NOT NULL,
  `data_lancamento` DATE NOT NULL,
  `idade_minima` INT UNSIGNED NOT NULL,
  `stock` INT UNSIGNED NOT NULL,
  `preco` DECIMAL(7,2) UNSIGNED NOT NULL,
  `desconto` DECIMAL(5,2) UNSIGNED NOT NULL,
  `id_produtor` INT NOT NULL,
  PRIMARY KEY (`id_jogo`),
  UNIQUE INDEX `nome_UNIQUE` (`nome` ASC),
  INDEX `fk_id_produtor_idx` (`id_produtor` ASC),
  INDEX `fk_id_nome_idx` (`nome` ASC),
  CONSTRAINT `fk_Jogo_Produtor1`
    FOREIGN KEY (`id_produtor`)
    REFERENCES `sitexxi`.`Produtor` (`id_produtor`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitexxi`.`Categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi`.`Categoria` (
  `id_categoria` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_categoria`),
  UNIQUE INDEX `nome_UNIQUE` (`nome` ASC),
  INDEX `fk_nome_idx` (`nome` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitexxi`.`Avaliacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi`.`Avaliacao` (
  `id_cliente` INT NOT NULL,
  `id_jogo` INT NOT NULL,
  `avaliacao` TINYINT(1) NOT NULL,
  `descricao` TEXT NULL,
  `data_avaliacao` DATETIME NOT NULL,
  PRIMARY KEY (`id_cliente`, `id_jogo`),
  INDEX `fk_id_jogo_idx` (`id_jogo` ASC),
  INDEX `fk_id_cliente_idx` (`id_cliente` ASC),
  CONSTRAINT `fk_Cliente_has_Jogo_Cliente1`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `sitexxi`.`Cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Cliente_has_Jogo_Jogo1`
    FOREIGN KEY (`id_jogo`)
    REFERENCES `sitexxi`.`Jogo` (`id_jogo`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitexxi`.`Compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi`.`Compra` (
  `id_compra` INT NOT NULL AUTO_INCREMENT,
  `id_cliente` INT NOT NULL,
  `id_jogo` INT NOT NULL,
  `quantidade` INT UNSIGNED NOT NULL,
  `preco` DECIMAL(7,2) UNSIGNED NOT NULL,
  `desconto` DECIMAL(5,2) UNSIGNED NOT NULL,
  `data_compra` DATETIME NOT NULL,
  PRIMARY KEY (`id_compra`),
  INDEX `fk_id_jogo_idx` (`id_jogo` ASC),
  INDEX `fk_id_cliente_idx` (`id_cliente` ASC),
  CONSTRAINT `fk_Cliente_has_Jogo_Cliente2`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `sitexxi`.`Cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Cliente_has_Jogo_Jogo2`
    FOREIGN KEY (`id_jogo`)
    REFERENCES `sitexxi`.`Jogo` (`id_jogo`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitexxi`.`JogoCategoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi`.`JogoCategoria` (
  `id_jogo` INT NOT NULL,
  `id_categoria` INT NOT NULL,
  PRIMARY KEY (`id_jogo`, `id_categoria`),
  INDEX `fk_id_categoria_idx` (`id_categoria` ASC),
  INDEX `fk_id_jogo_idx` (`id_jogo` ASC),
  CONSTRAINT `fk_Jogo_has_Categoria_Jogo1`
    FOREIGN KEY (`id_jogo`)
    REFERENCES `sitexxi`.`Jogo` (`id_jogo`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Jogo_has_Categoria_Categoria1`
    FOREIGN KEY (`id_categoria`)
    REFERENCES `sitexxi`.`Categoria` (`id_categoria`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitexxi`.`Auditory_Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi`.`Auditory_Cliente` (
  `id_cliente` INT NOT NULL,
  `nome` VARCHAR(100) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `data_nascimento` DATE NOT NULL,
  `sexo` CHAR(1) NOT NULL,
  `nr_telemovel` VARCHAR(20) NOT NULL,
  `data_registo` DATETIME NOT NULL,
  `id_cidade` INT NOT NULL,
  `operation` CHAR(1) NOT NULL,
  `operation_timestamp` TIMESTAMP NOT NULL,
  INDEX `fk_email_idx` (`email` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitexxi`.`Auditory_Compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi`.`Auditory_Compra` (
  `id_compra` INT NOT NULL,
  `id_cliente` INT NOT NULL,
  `id_jogo` INT NOT NULL,
  `quantidade` INT NOT NULL,
  `preco` DECIMAL(7,2) NOT NULL,
  `desconto` DECIMAL(5,2) NOT NULL,
  `data_compra` DATETIME NOT NULL,
  `operation` CHAR(1) NOT NULL,
  `operation_timestamp` TIMESTAMP NOT NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitexxi`.`Auditory_Jogo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi`.`Auditory_Jogo` (
  `id_jogo` INT NOT NULL,
  `nome` VARCHAR(50) NOT NULL,
  `data_lancamento` DATE NOT NULL,
  `idade_minima` INT NOT NULL,
  `stock` INT NOT NULL,
  `preco` DECIMAL(7,2) NOT NULL,
  `desconto` DECIMAL(5,2) NOT NULL,
  `id_produtor` INT NOT NULL,
  `operation` CHAR(1) NOT NULL,
  `operation_timestamp` TIMESTAMP NOT NULL,
  INDEX `fk_id_nome_idx` (`nome` ASC))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
