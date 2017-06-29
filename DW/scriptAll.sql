-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema sitexxi
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `sitexxi` ;

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

-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema sitexxi_etl
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `sitexxi_etl` ;

-- -----------------------------------------------------
-- Schema sitexxi_etl
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `sitexxi_etl` DEFAULT CHARACTER SET utf8 ;
USE `sitexxi_etl` ;

-- -----------------------------------------------------
-- Table `sitexxi_etl`.`AR_Extract_Cliente1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi_etl`.`AR_Extract_Cliente1` (
  `id_cliente` INT NULL,
  `nome` VARCHAR(100) NULL,
  `email` VARCHAR(50) NULL,
  `data_nascimento` DATE NULL,
  `sexo` CHAR(1) NULL,
  `nr_telemovel` VARCHAR(20) NULL,
  `data_registo` DATETIME NULL,
  `cidade` VARCHAR(45) NULL,
  `pais` VARCHAR(45) NULL,
  `operation` CHAR(1) NULL,
  `operation_timestamp` TIMESTAMP(6) NULL,
  `source` INT NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitexxi_etl`.`AR_Extract_Venda1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi_etl`.`AR_Extract_Venda1` (
  `id_venda` INT NULL,
  `id_cliente` INT NULL,
  `id_jogo` INT NULL,
  `quantidade` INT NULL,
  `preco` DECIMAL(7,2) NULL,
  `desconto` DECIMAL(5,2) NULL,
  `data_compra` DATETIME NULL,
  `operation` CHAR(1) NULL,
  `operation_timestamp` TIMESTAMP(6) NULL,
  `source` INT NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitexxi_etl`.`AR_Extract_Jogo1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi_etl`.`AR_Extract_Jogo1` (
  `id_jogo` INT NULL,
  `nome` VARCHAR(50) NULL,
  `data_lancamento` DATETIME NULL,
  `idade_minima` INT NULL,
  `stock` INT NULL,
  `preco` DECIMAL(7,2) NULL,
  `desconto` DECIMAL(5,2) NULL,
  `produtor` VARCHAR(45) NULL,
  `operation` CHAR(1) NULL,
  `operation_timestamp` TIMESTAMP(6) NULL,
  `source` INT NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitexxi_etl`.`AR_Cleanup_Cliente1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi_etl`.`AR_Cleanup_Cliente1` (
  `id_cliente` INT NULL,
  `nome` VARCHAR(100) NULL,
  `email` VARCHAR(50) NULL,
  `data_nascimento` DATE NULL,
  `sexo` CHAR(1) NULL,
  `nr_telemovel` VARCHAR(20) NULL,
  `data_registo` DATETIME NULL,
  `cidade` VARCHAR(45) NULL,
  `pais` VARCHAR(45) NULL,
  `operation` CHAR(1) NULL,
  `operation_timestamp` TIMESTAMP(6) NULL,
  `source` INT NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitexxi_etl`.`AR_Cleanup_Jogo1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi_etl`.`AR_Cleanup_Jogo1` (
  `id_jogo` INT NULL,
  `nome` VARCHAR(50) NULL,
  `data_lancamento` DATETIME NULL,
  `idade_minima` INT NULL,
  `stock` INT NULL,
  `preco` DECIMAL(7,2) NULL,
  `desconto` DECIMAL(5,2) NULL,
  `produtor` VARCHAR(45) NULL,
  `operation` CHAR(1) NULL,
  `operation_timestamp` TIMESTAMP(6) NULL,
  `source` INT NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitexxi_etl`.`AR_Cleanup_Venda1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi_etl`.`AR_Cleanup_Venda1` (
  `id_venda` INT NULL,
  `id_cliente` INT NULL,
  `id_jogo` INT NULL,
  `quantidade` INT NULL,
  `preco` DECIMAL(7,2) NULL,
  `desconto` DECIMAL(5,2) NULL,
  `data_compra` DATETIME NULL,
  `operation` CHAR(1) NULL,
  `operation_timestamp` TIMESTAMP(6) NULL,
  `source` INT NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitexxi_etl`.`AR_SK_Data`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi_etl`.`AR_SK_Data` (
  `id_data` INT NULL,
  `data` DATE NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitexxi_etl`.`AR_Last_Extract`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi_etl`.`AR_Last_Extract` (
  `mysql` DATETIME NULL,
  `mongodb` DATETIME NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitexxi_etl`.`AR_SK_Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi_etl`.`AR_SK_Cliente` (
  `id_DIM_Cliente` INT NOT NULL AUTO_INCREMENT,
  `source` INT NOT NULL,
  `id_source` INT NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_DIM_Cliente`, `source`, `id_source`, `email`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitexxi_etl`.`AR_SK_Jogo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi_etl`.`AR_SK_Jogo` (
  `id_DIM_Jogo` INT NOT NULL AUTO_INCREMENT,
  `source` INT NOT NULL,
  `id_source` INT NOT NULL,
  `nome` VARCHAR(50) NOT NULL,
  `stock` INT NULL,
  `preco` DECIMAL(7,2) NULL,
  `desconto` DECIMAL(5,2) NULL,
  PRIMARY KEY (`id_DIM_Jogo`, `source`, `id_source`, `nome`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitexxi_etl`.`AR_DIM_Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi_etl`.`AR_DIM_Cliente` (
  `id_cliente` INT NULL,
  `nome` VARCHAR(100) NULL,
  `email` VARCHAR(50) NULL,
  `data_nascimento` DATE NULL,
  `sexo` CHAR(1) NULL,
  `nr_telemovel` VARCHAR(20) NULL,
  `data_registo` DATETIME NULL,
  `cidade` VARCHAR(45) NULL,
  `pais` VARCHAR(45) NULL,
  `last_update` TIMESTAMP(6) NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitexxi_etl`.`AR_TF_Venda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi_etl`.`AR_TF_Venda` (
  `id_data` INT NULL,
  `id_cliente` INT NULL,
  `id_jogo` INT NULL,
  `quantidade` INT NULL,
  `preco_unidade` DECIMAL(7,2) NULL,
  `preco_total` DECIMAL(9,2) NULL,
  `desconto` DECIMAL(5,2) NULL,
  `idade_cliente` INT NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitexxi_etl`.`AR_DIM_Jogo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi_etl`.`AR_DIM_Jogo` (
  `id_jogo` INT NULL,
  `nome` VARCHAR(50) NULL,
  `data_lancamento` DATETIME NULL,
  `idade_minima` INT NULL,
  `stock` INT NULL,
  `preco` DECIMAL(7,2) NULL,
  `desconto` DECIMAL(5,2) NULL,
  `produtor` VARCHAR(45) NULL,
  `last_update` TIMESTAMP(6) NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitexxi_etl`.`AR_QUAR_Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi_etl`.`AR_QUAR_Cliente` (
  `id_cliente` INT NULL,
  `nome` VARCHAR(100) NULL,
  `email` VARCHAR(50) NULL,
  `data_nascimento` DATE NULL,
  `sexo` CHAR(1) NULL,
  `nr_telemovel` VARCHAR(20) NULL,
  `data_registo` DATETIME NULL,
  `cidade` VARCHAR(45) NULL,
  `pais` VARCHAR(45) NULL,
  `operation` CHAR(1) NULL,
  `operation_timestamp` TIMESTAMP(6) NULL,
  `descricao` TEXT NULL,
  `source` INT NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitexxi_etl`.`AR_QUAR_Jogo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi_etl`.`AR_QUAR_Jogo` (
  `id_jogo` INT NULL,
  `nome` VARCHAR(50) NULL,
  `data_lancamento` DATETIME NULL,
  `idade_minima` INT NULL,
  `stock` INT NULL,
  `preco` DECIMAL(7,2) NULL,
  `desconto` DECIMAL(5,2) NULL,
  `produtor` VARCHAR(45) NULL,
  `operation` CHAR(1) NULL,
  `operation_timestamp` TIMESTAMP(6) NULL,
  `descricao` TEXT NULL,
  `source` INT NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitexxi_etl`.`AR_Extract_Cliente2`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi_etl`.`AR_Extract_Cliente2` (
  `id_cliente` INT NULL,
  `nome` VARCHAR(100) NULL,
  `email` VARCHAR(50) NULL,
  `data_nascimento` DATE NULL,
  `sexo` CHAR(1) NULL,
  `nr_telemovel` VARCHAR(20) NULL,
  `data_registo` DATETIME NULL,
  `cidade` VARCHAR(45) NULL,
  `pais` VARCHAR(45) NULL,
  `operation` CHAR(1) NULL,
  `operation_timestamp` TIMESTAMP(6) NULL,
  `source` INT NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitexxi_etl`.`AR_Extract_Venda2`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi_etl`.`AR_Extract_Venda2` (
  `id_venda` INT NULL,
  `id_cliente` INT NULL,
  `id_jogo` INT NULL,
  `quantidade` INT NULL,
  `preco` DECIMAL(7,2) NULL,
  `desconto` DECIMAL(5,2) NULL,
  `data_compra` DATETIME NULL,
  `operation` CHAR(1) NULL,
  `operation_timestamp` TIMESTAMP(6) NULL,
  `source` INT NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitexxi_etl`.`AR_Extract_Jogo2`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi_etl`.`AR_Extract_Jogo2` (
  `id_jogo` INT NULL,
  `nome` VARCHAR(50) NULL,
  `data_lancamento` DATETIME NULL,
  `idade_minima` INT NULL,
  `stock` INT NULL,
  `preco` DECIMAL(7,2) NULL,
  `desconto` DECIMAL(5,2) NULL,
  `produtor` VARCHAR(45) NULL,
  `operation` CHAR(1) NULL,
  `operation_timestamp` TIMESTAMP(6) NULL,
  `source` INT NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitexxi_etl`.`AR_Cleanup_Cliente2`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi_etl`.`AR_Cleanup_Cliente2` (
  `id_cliente` INT NULL,
  `nome` VARCHAR(100) NULL,
  `email` VARCHAR(50) NULL,
  `data_nascimento` DATE NULL,
  `sexo` CHAR(1) NULL,
  `nr_telemovel` VARCHAR(20) NULL,
  `data_registo` DATETIME NULL,
  `cidade` VARCHAR(45) NULL,
  `pais` VARCHAR(45) NULL,
  `operation` CHAR(1) NULL,
  `operation_timestamp` TIMESTAMP(6) NULL,
  `source` INT NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitexxi_etl`.`AR_Cleanup_Venda2`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi_etl`.`AR_Cleanup_Venda2` (
  `id_venda` INT NULL,
  `id_cliente` INT NULL,
  `id_jogo` INT NULL,
  `quantidade` INT NULL,
  `preco` DECIMAL(7,2) NULL,
  `desconto` DECIMAL(5,2) NULL,
  `data_compra` DATETIME NULL,
  `operation` CHAR(1) NULL,
  `operation_timestamp` TIMESTAMP(6) NULL,
  `source` INT NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitexxi_etl`.`AR_Cleanup_Jogo2`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi_etl`.`AR_Cleanup_Jogo2` (
  `id_jogo` INT NULL,
  `nome` VARCHAR(50) NULL,
  `data_lancamento` DATETIME NULL,
  `idade_minima` INT NULL,
  `stock` INT NULL,
  `preco` DECIMAL(7,2) NULL,
  `desconto` DECIMAL(5,2) NULL,
  `produtor` VARCHAR(45) NULL,
  `operation` CHAR(1) NULL,
  `operation_timestamp` TIMESTAMP(6) NULL,
  `source` INT NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitexxi_etl`.`AR_Conformity_Cliente1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi_etl`.`AR_Conformity_Cliente1` (
  `id_cliente` INT NULL,
  `nome` VARCHAR(100) NULL,
  `email` VARCHAR(50) NULL,
  `data_nascimento` DATE NULL,
  `sexo` CHAR(1) NULL,
  `nr_telemovel` VARCHAR(20) NULL,
  `data_registo` DATETIME NULL,
  `cidade` VARCHAR(45) NULL,
  `pais` VARCHAR(45) NULL,
  `operation` CHAR(1) NULL,
  `operation_timestamp` TIMESTAMP(6) NULL,
  `source` INT NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitexxi_etl`.`AR_Conformity_Venda1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi_etl`.`AR_Conformity_Venda1` (
  `id_venda` INT NULL,
  `id_cliente` INT NULL,
  `id_jogo` INT NULL,
  `quantidade` INT NULL,
  `preco` DECIMAL(7,2) NULL,
  `desconto` DECIMAL(5,2) NULL,
  `data_compra` DATETIME NULL,
  `operation` CHAR(1) NULL,
  `operation_timestamp` TIMESTAMP(6) NULL,
  `source` INT NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitexxi_etl`.`AR_Conformity_Jogo1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi_etl`.`AR_Conformity_Jogo1` (
  `id_jogo` INT NULL,
  `nome` VARCHAR(50) NULL,
  `data_lancamento` DATETIME NULL,
  `idade_minima` INT NULL,
  `stock` INT NULL,
  `preco` DECIMAL(7,2) NULL,
  `desconto` DECIMAL(5,2) NULL,
  `produtor` VARCHAR(45) NULL,
  `operation` CHAR(1) NULL,
  `operation_timestamp` TIMESTAMP(6) NULL,
  `source` INT NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitexxi_etl`.`AR_Conformity_Cliente2`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi_etl`.`AR_Conformity_Cliente2` (
  `id_cliente` INT NULL,
  `nome` VARCHAR(100) NULL,
  `email` VARCHAR(50) NULL,
  `data_nascimento` DATE NULL,
  `sexo` CHAR(1) NULL,
  `nr_telemovel` VARCHAR(20) NULL,
  `data_registo` DATETIME NULL,
  `cidade` VARCHAR(45) NULL,
  `pais` VARCHAR(45) NULL,
  `operation` CHAR(1) NULL,
  `operation_timestamp` TIMESTAMP(6) NULL,
  `source` INT NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitexxi_etl`.`AR_Conformity_Venda2`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi_etl`.`AR_Conformity_Venda2` (
  `id_venda` INT NULL,
  `id_cliente` INT NULL,
  `id_jogo` INT NULL,
  `quantidade` INT NULL,
  `preco` DECIMAL(7,2) NULL,
  `desconto` DECIMAL(5,2) NULL,
  `data_compra` DATETIME NULL,
  `operation` CHAR(1) NULL,
  `operation_timestamp` TIMESTAMP(6) NULL,
  `source` INT NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitexxi_etl`.`AR_Conformity_Jogo2`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi_etl`.`AR_Conformity_Jogo2` (
  `id_jogo` INT NULL,
  `nome` VARCHAR(50) NULL,
  `data_lancamento` DATETIME NULL,
  `idade_minima` INT NULL,
  `stock` INT NULL,
  `preco` DECIMAL(7,2) NULL,
  `desconto` DECIMAL(5,2) NULL,
  `produtor` VARCHAR(45) NULL,
  `operation` CHAR(1) NULL,
  `operation_timestamp` TIMESTAMP(6) NULL,
  `source` INT NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitexxi_etl`.`AR_Update_Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi_etl`.`AR_Update_Cliente` (
  `id_cliente` INT NULL,
  `nr_telemovel` VARCHAR(20) NULL,
  `cidade` VARCHAR(45) NULL,
  `pais` VARCHAR(35) NULL,
  `last_update` TIMESTAMP(6) NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitexxi_etl`.`AR_Update_Jogo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi_etl`.`AR_Update_Jogo` (
  `id_jogo` INT NULL,
  `stock` INT NULL,
  `preco` DECIMAL(7,2) NULL,
  `desconto` DECIMAL(5,2) NULL,
  `last_update` TIMESTAMP(6) NULL)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;



-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema sitexxi_dw
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `sitexxi_dw` ;

-- -----------------------------------------------------
-- Schema sitexxi_dw
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `sitexxi_dw` DEFAULT CHARACTER SET utf8 ;
USE `sitexxi_dw` ;

-- -----------------------------------------------------
-- Table `sitexxi_dw`.`DIM_Data`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi_dw`.`DIM_Data` (
  `id_data` INT NOT NULL,
  `data` DATE NOT NULL,
  `dia_semana` VARCHAR(10) NOT NULL,
  `dia` INT NOT NULL,
  `mes` INT NOT NULL,
  `ano` INT NOT NULL,
  `trimestre` INT NOT NULL,
  PRIMARY KEY (`id_data`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitexxi_dw`.`DIM_Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi_dw`.`DIM_Cliente` (
  `id_cliente` INT NOT NULL,
  `nome` VARCHAR(100) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `data_nascimento` DATE NOT NULL,
  `sexo` CHAR(1) NOT NULL,
  `nr_telemovel` VARCHAR(20) NOT NULL,
  `data_registo` DATETIME NOT NULL,
  `cidade` VARCHAR(45) NOT NULL,
  `pais` VARCHAR(35) NOT NULL,
  `last_update` TIMESTAMP(6) NOT NULL,
  PRIMARY KEY (`id_cliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitexxi_dw`.`DIM_Jogo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi_dw`.`DIM_Jogo` (
  `id_jogo` INT NOT NULL,
  `nome` VARCHAR(50) NOT NULL,
  `data_lancamento` DATE NOT NULL,
  `idade_minima` INT NOT NULL,
  `stock` INT NOT NULL,
  `preco` DECIMAL(7,2) NOT NULL,
  `desconto` DECIMAL(5,2) NOT NULL,
  `produtor` VARCHAR(50) NOT NULL,
  `last_update` TIMESTAMP(6) NOT NULL,
  PRIMARY KEY (`id_jogo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitexxi_dw`.`TF_Venda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi_dw`.`TF_Venda` (
  `id_venda` INT NOT NULL AUTO_INCREMENT,
  `id_data` INT NOT NULL,
  `id_cliente` INT NOT NULL,
  `id_jogo` INT NOT NULL,
  `quantidade` INT NOT NULL,
  `preco_unidade` DECIMAL(7,2) NOT NULL,
  `preco_total` DECIMAL(9,2) NOT NULL,
  `desconto` DECIMAL(5,2) NOT NULL,
  `idade_cliente` INT NOT NULL,
  INDEX `fk_TF_Venda_DIM_Data_idx` (`id_data` ASC),
  INDEX `fk_TF_Venda_DIM_Cliente1_idx` (`id_cliente` ASC),
  INDEX `fk_TF_Venda_DIM_Jogo1_idx` (`id_jogo` ASC),
  PRIMARY KEY (`id_venda`),
  CONSTRAINT `fk_TF_Venda_DIM_Data`
    FOREIGN KEY (`id_data`)
    REFERENCES `sitexxi_dw`.`DIM_Data` (`id_data`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TF_Venda_DIM_Cliente1`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `sitexxi_dw`.`DIM_Cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TF_Venda_DIM_Jogo1`
    FOREIGN KEY (`id_jogo`)
    REFERENCES `sitexxi_dw`.`DIM_Jogo` (`id_jogo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sitexxi_dw`.`DIM_Cliente_Historia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitexxi_dw`.`DIM_Cliente_Historia` (
  `id_historia` INT NOT NULL AUTO_INCREMENT,
  `id_cliente` INT NOT NULL,
  `cidade` VARCHAR(45) NOT NULL,
  `pais` VARCHAR(35) NOT NULL,
  `last_update` TIMESTAMP(6) NOT NULL,
  INDEX `fk_DIM_Cliente_Historia_DIM_Cliente1_idx` (`id_cliente` ASC),
  PRIMARY KEY (`id_historia`),
  CONSTRAINT `fk_DIM_Cliente_Historia_DIM_Cliente1`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `sitexxi_dw`.`DIM_Cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


use sitexxi_etl;

drop procedure if exists sp_insert_cliente;
DELIMITER $$
create procedure sp_insert_cliente(
										in in_id_cliente int,
										in in_nome varchar(100),
										in in_email varchar(50),
										in in_data_nascimento date,
										in in_sexo char(1),
										in in_nr_telemovel varchar(20),
										in in_data_registo datetime,
										in in_cidade varchar(45),
										in in_pais varchar(45),
										in operation char(1),
										in operation_timestamp timestamp(6),
										in in_source int
									  )
begin
	SET @id = ( SELECT id_DIM_Cliente FROM AR_SK_Cliente WHERE source = in_source and id_source = in_id_cliente);
	if @id is not null then
		INSERT INTO AR_QUAR_Cliente
			(id_cliente,nome,email,data_nascimento,sexo,nr_telemovel,data_registo,cidade,pais,operation,operation_timestamp,descricao,source)
		values
			(in_id_cliente,in_nome,in_email,in_data_nascimento,in_sexo,in_nr_telemovel,in_data_registo,in_cidade,in_pais,operation,operation_timestamp,"Chave repetida",in_source);
	else
		set @id = (SELECT id_DIM_Cliente FROM AR_SK_Cliente WHERE email = in_email limit 1);
        if @id is not null then
			START TRANSACTION;
            INSERT INTO AR_SK_Cliente
            	(id_DIM_Cliente,source,id_source,email)
            values
				(@id,in_source,in_id_cliente,in_email);
			INSERT INTO AR_QUAR_Cliente
				(id_cliente,nome,email,data_nascimento,sexo,nr_telemovel,data_registo,cidade,pais,operation,operation_timestamp,descricao,source)
			values
				(in_id_cliente,in_nome,in_email,in_data_nascimento,in_sexo,in_nr_telemovel,in_data_registo,in_cidade,in_pais,operation,operation_timestamp,"Cliente repetido",in_source);
			COMMIT;
        ELSE 
			START TRANSACTION;
			INSERT INTO AR_SK_Cliente
            	(source,id_source,email)
            values
				(in_source,in_id_cliente,in_email);
			set @id = ( SELECT id_DIM_Cliente FROM AR_SK_Cliente WHERE source = in_source and id_source = in_id_cliente);
			INSERT INTO AR_DIM_Cliente
				(id_cliente,nome,email,data_nascimento,sexo,nr_telemovel,data_registo,cidade,pais,last_update)
			values
				(@id,in_nome,in_email,in_data_nascimento,in_sexo,in_nr_telemovel,in_data_registo,in_cidade,in_pais,operation_timestamp);
			COMMIT;
		END IF;
    END IF;
END $$
DELIMITER ;

drop procedure if exists sp_insert_jogo;
DELIMITER $$
create procedure sp_insert_jogo(
									in in_id_jogo int,
                                    in in_nome varchar(50), 
									in in_data_lancamento datetime,
                                    in in_idade_minima int,
                                    in in_stock int,
                                    in in_preco decimal(7,2),
                                    in in_desconto decimal(5,2),
                                    in in_produtor varchar(45),
                                    in operation char(1),
									in operation_timestamp timestamp(6),
									in in_source int
								)
BEGIN
	
    declare idJogo int;
    declare stockJ int;
    declare precoJ decimal(7,2);
    declare descontoJ decimal(5,2);
    
	declare erro bool default 0;
	declare continue handler for sqlexception set erro=1;
	
    start transaction;
    
	select id_DIM_Jogo into idJogo from AR_SK_Jogo where source = in_source and id_source = in_id_jogo;
    
	if idJogo is not null then
		insert into AR_QUAR_Jogo
			(id_jogo,nome,data_lancamento,idade_minima,stock,preco,desconto,produtor,operation,operation_timestamp,descricao,source)
		values
			(in_id_jogo,in_nome,in_data_lancamento,in_idade_minima,in_stock,in_preco,in_desconto,in_produtor,operation,operation_timestamp,"Chave repetida",in_source);
	else
		select id_DIM_Jogo into idJogo from AR_SK_Jogo where nome = in_nome limit 1;
        if idJogo is not null then
            insert into AR_SK_Jogo
            	(id_DIM_Jogo,source,id_source,nome,stock,preco,desconto)
            values
				(idJogo,in_source,in_id_jogo,in_nome,in_stock,in_preco,in_desconto);
			
            select stock into stockJ from AR_SK_Jogo where nome = in_nome limit 1;
            select preco into precoJ from AR_SK_Jogo where nome = in_nome limit 1;
            select desconto into descontoJ from AR_SK_Jogo where nome = in_nome limit 1;
			
            update AR_DIM_Jogo
				set stock = floor((in_stock+stockJ)/2.0),
                     preco = (in_preco+precoJ)/2.0,
                     desconto = (in_desconto+descontoJ)/2.0
                where id_jogo = idJogo;
		else 
            insert into AR_SK_Jogo
            	(source,id_source,nome,stock,preco,desconto)
            values
				(in_source,in_id_jogo,in_nome,in_stock,in_preco,in_desconto);
			
            select id_DIM_Jogo into idJogo from AR_SK_Jogo where source = in_source and id_source = in_id_jogo;
			
            insert into AR_DIM_Jogo
				(id_jogo,nome,data_lancamento,idade_minima,stock,preco,desconto,produtor,last_update)
			values
				(idJogo,in_nome,in_data_lancamento,in_idade_minima,in_stock,in_preco,in_desconto,in_produtor,operation_timestamp);
		end if;
	end if;
    
    if erro 
	then rollback;
	else commit;
	end if;

END $$
DELIMITER ;

drop procedure if exists sp_insert_venda;
DELIMITER $$
create procedure sp_insert_venda(
									in in_id_venda int,
									in in_id_cliente int,
                                    in in_id_jogo int,
									in in_quantidade int,
                                    in in_preco decimal(7,2),
                                    in in_desconto decimal(5,2),
                                    in in_data_compra datetime,
                                    in operation char(1),
									in operation_timestamp timestamp(6),
									in in_source int
								)
BEGIN
    declare data_nascimento date;
    declare id_data int;
    declare id_cliente int;
    declare id_jogo int ;
    
	select AR_SK_Data.id_data into id_data from AR_SK_Data where data = date(in_data_compra) limit 1;
    
	select id_DIM_Cliente into id_cliente from AR_SK_Cliente where source = in_source and id_source = in_id_cliente limit 1;
    
    select id_DIM_Jogo into id_jogo from AR_SK_Jogo where source = in_source and id_source = in_id_jogo limit 1;
	
    insert into AR_TF_Venda
				(id_data,id_cliente,id_jogo,quantidade,preco_unidade,preco_total,desconto,idade_cliente)
			values
				(id_data,id_cliente,id_jogo,in_quantidade,in_preco,in_preco*in_quantidade,in_desconto,23);

END $$
DELIMITER ;

drop procedure if exists sp_filter_mongo;

DELIMITER $$
create procedure sp_filter_mongo(
									in mongodb_last_extract timestamp(6)
								)
BEGIN
    
    delete from AR_Extract_Cliente2
		where operation_timestamp >= mongodb_last_extract;
        
	delete from AR_Extract_Jogo2
		where operation_timestamp >= mongodb_last_extract;
        
	delete from AR_Extract_Venda2
		where operation_timestamp >= mongodb_last_extract;

END $$
DELIMITER ;

drop procedure if exists sp_update_cliente;

DELIMITER $$
create procedure sp_update_cliente(
									  in in_id_cliente int,
									  in in_nome varchar(100),
									  in in_email varchar(50),
									  in in_data_nascimento date,
									  in in_sexo char(1),
									  in in_nr_telemovel varchar(20),
									  in in_data_registo datetime,
									  in in_cidade varchar(45),
									  in in_pais varchar(45),
									  in operation char(1),
									  in operation_timestamp timestamp(6),
									  in in_source int
								  )
begin
	set @id = ( select id_DIM_Cliente FROM AR_SK_Cliente WHERE source = in_source and id_source = in_id_cliente);
	
    if @id is not null then
		insert into AR_Update_Cliente
			(id_cliente,nr_telemovel,cidade,pais,last_update)
        values
			(@id,in_nr_telemovel,in_cidade,in_pais,operation_timestamp);
	else 
		insert into AR_QUAR_Cliente
			(id_cliente,nome,email,data_nascimento,sexo,nr_telemovel,data_registo,cidade,pais,operation,operation_timestamp,descricao,source)
		values
			(in_id_cliente,in_nome,in_email,in_data_nascimento,in_sexo,in_nr_telemovel,in_data_registo,in_cidade,in_pais,operation,operation_timestamp,"Cliente Não Existe",in_source);
    end if;
end $$
DELIMITER ;

drop procedure if exists sp_update_jogo;

DELIMITER $$
create procedure sp_update_jogo(
							       in in_id_jogo int,
                                   in in_nome varchar(50), 
								   in in_data_lancamento datetime,
                                   in in_idade_minima int,
                                   in in_stock int,
                                   in in_preco decimal(7,2),
								   in in_desconto decimal(5,2),
								   in in_produtor varchar(45),
								   in operation char(1),
								   in operation_timestamp timestamp(6),
							       in in_source int
							   )
BEGIN
	declare id_jogo int;
    declare stockJ int;
    declare precoJ decimal(7,2);
    declare descontoJ decimal(5,2);
    declare aux int;
    
    declare erro bool default 0;
	declare continue handler for sqlexception set erro=1;
	
    start transaction;
    
	select id_DIM_Jogo into id_jogo from AR_SK_Jogo where source = in_source and id_source = in_id_jogo;
	
    if id_jogo is not null then
		
        select id_DIM_jogo into aux from AR_SK_Jogo where nome = in_nome and source != in_source limit 1;
        
        if aux is not null then
        
			select stock into stockJ from AR_SK_Jogo where nome = in_nome and source != in_source limit 1;
			select preco into precoJ from AR_SK_Jogo where nome = in_nome and source != in_source limit 1;
			select desconto into descontoJ from AR_SK_Jogo where nome = in_nome and source != in_source limit 1;
			
			insert into AR_Update_Jogo
				(id_jogo,stock,preco,desconto,last_update)
			values
				(id_jogo,floor((in_stock+stockJ)/2.0),(in_preco+precoJ)/2.0,(in_desconto+descontoJ)/2.0,operation_timestamp);
			
			update AR_SK_Jogo
					set stock = in_stock,
						 preco = in_preco,
						 desconto = in_desconto
					where source = in_source and id_source = in_id_jogo;

        else
        
            insert into AR_Update_Jogo
				(id_jogo,stock,preco,desconto,last_update)
			values
				(id_jogo,in_stock,in_preco,in_desconto,operation_timestamp);
            
            update AR_SK_Jogo
					set stock = in_stock,
						 preco = in_preco,
						 desconto = in_desconto
					where source = in_source and id_source = in_id_jogo;
            
        end if;
        
	else 
		insert into AR_QUAR_Jogo
			(id_jogo,nome,data_lancamento,idade_minima,stock,preco,desconto,produtor,operation,operation_timestamp,descricao,source)
		values
			(in_id_jogo,in_nome,in_data_lancamento,in_idade_minima,in_stock,in_preco,in_desconto,in_produtor,operation,operation_timestamp,"Jogo Não Existe",in_source);
    end if;
    
    if erro 
	then rollback;
	else commit;
	end if;
    
end $$
DELIMITER ;

use sitexxi_dw;

drop procedure if exists sp_update_cliente;

DELIMITER $$
create procedure sp_update_cliente(
								      in in_id_cliente int,
                                      in in_nr_telemovel varchar(20),
									  in in_cidade varchar(45),
									  in in_pais varchar(35),
									  in in_last_update timestamp(6)
								  )
begin
	
    declare id_clienteC int;
    declare cidadeC varchar(45);
    declare paisC varchar(35);
    declare last_updateC timestamp(6);
    declare aux int;
    
    declare erro bool default 0;
	declare continue handler for sqlexception set erro=1;
	
    start transaction;
    
    select id_cliente into aux from DIM_Cliente where id_cliente = in_id_cliente and nr_telemovel != in_nr_telemovel;
    
    if aux is not null then
		
		update DIM_Cliente
			set nr_telemovel = in_nr_telemovel,
				last_update = in_last_update
			where id_cliente = in_id_cliente;
    end if;
    
    select cidade into cidadeC from DIM_Cliente where id_cliente = in_id_cliente limit 1;
    select pais into paisC from DIM_Cliente where id_cliente = in_id_cliente limit 1;
    select last_update into last_updateC from DIM_Cliente where id_cliente = in_id_cliente limit 1;
    
    insert into DIM_Cliente_Historia
		(id_cliente,cidade,pais,last_update)
    values
		(in_id_cliente,cidadeC,paisC,last_updateC);
    
    update DIM_Cliente
		set cidade = in_cidade,
			pais = in_pais,
            last_update = in_last_update
        where id_cliente = in_id_cliente;

    if erro 
	then rollback;
	else commit;
	end if;

end $$
DELIMITER ;

drop procedure if exists sp_update_jogo;

DELIMITER $$
create procedure sp_update_jogo(
							      in in_id_jogo int,
								  in in_stock int,
								  in in_preco decimal(7,2),
								  in in_desconto decimal(5,2),
								  in in_last_update timestamp(6)
							   )
begin
    
    update DIM_Jogo
		set stock = in_stock,
			preco = in_preco,
            desconto = in_desconto,
            last_update = in_last_update
		where id_jogo = in_id_jogo;
    
end $$
DELIMITER ;