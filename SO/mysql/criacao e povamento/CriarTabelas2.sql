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
DROP SCHEMA IF EXISTS  `sitexxi`;
CREATE SCHEMA IF NOT EXISTS `sitexxi` DEFAULT CHARACTER SET utf8 ;
USE `sitexxi` ;

-- -----------------------------------------------------
-- Table `sitexxi`.`Pais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi`.`Pais` (
  `idPais` INT NOT NULL AUTO_INCREMENT ,
  `nomePais` VARCHAR(45) NOT NULL UNIQUE,
  `last_Updade` TIMESTAMP NOT NULL,
  PRIMARY KEY (`idPais`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitexxi`.`Cidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi`.`Cidade` (
 `idCidade` INT NOT NULL AUTO_INCREMENT,
  `cidade` VARCHAR(45) NOT NULL UNIQUE,
  `idPais` INT NOT NULL,
  `last_Updade` TIMESTAMP NOT NULL,
  PRIMARY KEY (`idCidade`),
  INDEX `fk_Cidade_Pais1_idx` (`idPais` ASC),
  CONSTRAINT `fk_Cidade_Pais1`
    FOREIGN KEY (`idPais`)
    REFERENCES `sitexxi`.`Pais` (`idPais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitexxi`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi`.`Cliente` (
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
    REFERENCES `sitexxi`.`Cidade` (`idCidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitexxi`.`Produtor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi`.`Produtor` (
   `idProdutor` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL unique,
  `last_Update` TIMESTAMP NOT NULL,
  PRIMARY KEY (`idProdutor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitexxi`.`Jogo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi`.`Jogo` (
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
    REFERENCES `sitexxi`.`Produtor` (`idProdutor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitexxi`.`Categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi`.`Categoria` (
   `idCategoria` INT NOT NULL AUTO_INCREMENT,
  `categoria` VARCHAR(45) NOT NULL unique,
  `last_Update` TIMESTAMP NOT NULL,
  PRIMARY KEY (`idCategoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitexxi`.`JogoCategoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi`.`JogoCategoria` (
  `idJogo` INT NOT NULL ,
  `idCategoria` INT NOT NULL,
  `last_Update` TIMESTAMP NOT NULL,
  PRIMARY KEY (`idJogo`, `idCategoria`),
  INDEX `fk_Jogo_has_Categoria_Categoria1_idx` (`idCategoria` ASC),
  INDEX `fk_Jogo_has_Categoria_Jogo1_idx` (`idJogo` ASC),
  CONSTRAINT `fk_Jogo_has_Categoria_Jogo1`
    FOREIGN KEY (`idJogo`)
    REFERENCES `sitexxi`.`Jogo` (`idJogo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Jogo_has_Categoria_Categoria1`
    FOREIGN KEY (`idCategoria`)
    REFERENCES `sitexxi`.`Categoria` (`idCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitexxi`.`Compras`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi`.`Compras` (
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
    REFERENCES `sitexxi`.`Jogo` (`idJogo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Jogo_has_Cliente_Cliente1`
    FOREIGN KEY (`idCliente`)
    REFERENCES `sitexxi`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitexxi`.`Avaliacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi`.`Avaliacao` (
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
    REFERENCES `sitexxi`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cliente_has_Jogo_Jogo1`
    FOREIGN KEY (`idJogo`)
    REFERENCES `sitexxi`.`Jogo` (`idJogo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `sitexxi`.`paisAuditoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi`.`paisAuditoria` (
  `idPaisAuditoria` INT NOT NULL AUTO_INCREMENT,
  `idPais` INT NULL,
  `nomePais` VARCHAR(45) NULL,
  `tipoOperacao` VARCHAR(1) NULL,
  `dataOperacao` TIMESTAMP NULL,
  PRIMARY KEY (`idPaisAuditoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitexxi`.`cidadeAuditoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi`.`cidadeAuditoria` (
  `idCidadeAuditoria` INT NOT NULL AUTO_INCREMENT,
  `idCidade` INT NULL,
  `nomeCidade` VARCHAR(45) NULL,
  `idPais` INT NULL,
  `tipoOperacao` VARCHAR(1) NULL,
  `dataOperacao` TIMESTAMP NULL,
  PRIMARY KEY (`idCidadeAuditoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitexxi`.`clienteAuditoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi`.`clienteAuditoria` (
  `idclienteAuditoria` INT NOT NULL AUTO_INCREMENT,
  `idCliente` INT NULL,
  `nomeCliente` VARCHAR(45) NULL,
  `dataRegisto` DATE NULL,
  `dataNascimento` DATE NULL,
  `email` VARCHAR(45) NULL,
  `nrTelemovel` INT NULL,
  `dataOperacao` TIMESTAMP NULL,
  `idCidade` INT NULL,
  `sexo` VARCHAR(1) NULL,
  `tipoOperacao` VARCHAR(1) NULL,
  PRIMARY KEY (`idclienteAuditoria`))
ENGINE = InnoDB;




-- -----------------------------------------------------
-- Table `sitexxi`.`avaliacaoAuditoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi`.`avaliacaoAuditoria` (
  `idavaliacaoAuditoria` INT NOT NULL AUTO_INCREMENT,
  `idJogo` INT NULL,
  `idCliente` INT NULL,
  `avaliacao` INT NULL,
  `dataOperacao` TIMESTAMP NULL,
  `descricao` TEXT NULL,
  `tipoOperacao` VARCHAR(1) NULL,
  PRIMARY KEY (`idavaliacaoAuditoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitexxi`.`comprasAuditoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi`.`comprasAuditoria` (
  `idcomprasAuditoria` INT NOT NULL AUTO_INCREMENT,
  `idCompra` INT NULL,
  `idJogo` INT NULL,
  `idCliente` INT NULL,
  `dataCompra` DATE NULL,
  `precoVendido` DECIMAL(10,5) NULL,
  `quantidade` INT NULL,
  `desconto` DECIMAL(10,5) NULL,
  `dataOperacao` TIMESTAMP NULL,
  `tipoOperacao` VARCHAR(1) NULL,
  PRIMARY KEY (`idcomprasAuditoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitexxi`.`jogoAuditoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi`.`jogoAuditoria` (
  `idjogoAuditoria` INT NOT NULL AUTO_INCREMENT,
  `idJogo` INT NULL,
  `nome` VARCHAR(45) NULL,
  `dataLancamento` DATE NULL,
  `idadeParaJogar` INT NULL,
  `quantidade` INT NULL,
  `precoBase` DECIMAL(10,5) NULL,
  `idProdutor` INT NULL,
  `dataOperacao` TIMESTAMP NULL,
  `desconto` DECIMAL(10,5) NULL,
  `tipoOperacao` VARCHAR(1) NULL,
  PRIMARY KEY (`idjogoAuditoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitexxi`.`produtorAuditoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi`.`produtorAuditoria` (
  `idprodutorAuditoria` INT NOT NULL AUTO_INCREMENT,
  `idProdutor` INT NULL,
  `nome` VARCHAR(45) NULL,
  `dataOperacao` TIMESTAMP NULL,
  `tipoOperacao` VARCHAR(1) NULL,
  PRIMARY KEY (`idprodutorAuditoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitexxi`.`jogoCategoriaAuditoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi`.`jogoCategoriaAuditoria` (
  `idjogoCategoriaAuditoria` INT NOT NULL AUTO_INCREMENT,
  `idJogo` INT NULL,
  `idCategoria` INT NULL,
  `dataOperacao` TIMESTAMP NULL,
  `tipoOperacao` VARCHAR(1) NULL,
  PRIMARY KEY (`idjogoCategoriaAuditoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitexxi`.`categoriaAuditoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi`.`categoriaAuditoria` (
  `idcategoriaAuditoria` INT NOT NULL AUTO_INCREMENT,
  `idCategoria` INT NULL,
  `categoria` VARCHAR(45) NULL,
  `dataOperacao` TIMESTAMP NULL,
  `tipoOperacao` VARCHAR(1) NULL,
  PRIMARY KEY (`idcategoriaAuditoria`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `sitexxi`.`dataUpdate`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sitexxi`.`dataUpdate` ;

CREATE TABLE IF NOT EXISTS `sitexxi`.`dataUpdate` (
  `ultimaInsercao` TIMESTAMP NOT NULL)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
