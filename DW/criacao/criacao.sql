-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema DW
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema DW
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `DW` DEFAULT CHARACTER SET utf8 ;
USE `DW` ;

-- -----------------------------------------------------
-- Table `DW`.`dim_Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DW`.`dim_Cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `nomeCliente` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `numeroTelemovel` INT NOT NULL,
  `cidade` VARCHAR(45) NOT NULL,
  `pais` VARCHAR(45) NOT NULL,
  `dataNascimento` DATE NOT NULL,
  `dataRegisto` DATE NOT NULL,
  `sexo` VARCHAR(1) NOT NULL,
  `last_update` TIMESTAMP NOT NULL,
  PRIMARY KEY (`idCliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DW`.`dim_Data`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DW`.`dim_Data` (
  `idData` INT NOT NULL AUTO_INCREMENT,
  `data` DATE NOT NULL,
  `ano` INT NOT NULL,
  `mes` INT NOT NULL,
  `diaMes` INT NOT NULL,
  `diaSemana` VARCHAR(45) NOT NULL,
  `trimeste` INT NOT NULL,
  `last_update` TIMESTAMP NOT NULL,
  PRIMARY KEY (`idData`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DW`.`dim_Jogo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DW`.`dim_Jogo` (
  `idJogo` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `precoBase` DECIMAL(10,5) NOT NULL,
  `quantidadeDisponivel` INT NOT NULL,
  `idadeParaJogar` INT NOT NULL,
  `desconto` DECIMAL(10,5) NOT NULL,
  `produtor` VARCHAR(45) NOT NULL,
  `dataLancamento` DATE NOT NULL,
  `last_update` TIMESTAMP NOT NULL,
  PRIMARY KEY (`idJogo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DW`.`ft_VendasJogos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DW`.`ft_VendasJogos` (
  `idVendasJogos` INT NOT NULL AUTO_INCREMENT,
  `quantidadeComprada` INT NOT NULL,
  `precoCompradoUnidade` DECIMAL(10,5) NOT NULL,
  `precoTotal` DECIMAL(10,5) NOT NULL,
  `descontoVenda` DECIMAL(10,5) NOT NULL,
  `idadeCliente` INT NOT NULL,
  `idCliente` INT NOT NULL,
  `idData` INT NOT NULL,
  `idJogo` INT NOT NULL,
  `last_update` TIMESTAMP NOT NULL,
  PRIMARY KEY (`idVendasJogos`),
  INDEX `fk_ft_VendasJogos_dim_Cliente_idx` (`idCliente` ASC),
  INDEX `fk_ft_VendasJogos_dim_Data1_idx` (`idData` ASC),
  INDEX `fk_ft_VendasJogos_dim_jogo1_idx` (`idJogo` ASC),
  CONSTRAINT `fk_ft_VendasJogos_dim_Cliente`
    FOREIGN KEY (`idCliente`)
    REFERENCES `DW`.`dim_Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ft_VendasJogos_dim_Data1`
    FOREIGN KEY (`idData`)
    REFERENCES `DW`.`dim_Data` (`idData`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ft_VendasJogos_dim_jogo1`
    FOREIGN KEY (`idJogo`)
    REFERENCES `DW`.`dim_Jogo` (`idJogo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DW`.`cliente_Historia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DW`.`cliente_Historia` (
  `idCliente` INT NOT NULL,
  `cidade` VARCHAR(45) NOT NULL,
  `pais` VARCHAR(45) NOT NULL,
  `last_update` TIMESTAMP NOT NULL,
  INDEX `fk_cliente_Historia_dim_Cliente1_idx` (`idCliente` ASC),
  CONSTRAINT `fk_cliente_Historia_dim_Cliente1`
    FOREIGN KEY (`idCliente`)
    REFERENCES `DW`.`dim_Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DW`.`jogo_Historia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DW`.`jogo_Historia` (
  `precoBase` DECIMAL(10,5) NOT NULL,
  `desconto` DECIMAL(10,5) NOT NULL,
  `idJogo` INT NOT NULL,
  `last_update` TIMESTAMP NOT NULL,
  INDEX `fk_jogo_Historia_dim_jogo1_idx` (`idJogo` ASC),
  CONSTRAINT `fk_jogo_Historia_dim_jogo1`
    FOREIGN KEY (`idJogo`)
    REFERENCES `DW`.`dim_Jogo` (`idJogo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
