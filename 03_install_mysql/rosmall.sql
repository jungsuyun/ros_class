-- MySQL Script generated by MySQL Workbench
-- 2020년 08월 31일 (월) 오후 12시 24분 32초
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema rosmall
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema rosmall
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `rosmall` DEFAULT CHARACTER SET utf8 ;
USE `rosmall` ;

-- -----------------------------------------------------
-- Table `rosmall`.`Bank`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rosmall`.`Bank` (
  `BankId` INT NOT NULL AUTO_INCREMENT,
  `Name` NVARCHAR(1024) NOT NULL,
  PRIMARY KEY (`BankId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rosmall`.`Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rosmall`.`Employee` (
  `EmployeeId` INT NOT NULL AUTO_INCREMENT,
  `Name` NVARCHAR(1024) NOT NULL,
  `Department` NVARCHAR(1024) NOT NULL,
  `PhoneNumber` INT NOT NULL,
  PRIMARY KEY (`EmployeeId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rosmall`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rosmall`.`Customer` (
  `CustomerId` NVARCHAR(1024) NOT NULL,
  `Name` NVARCHAR(1024) NOT NULL,
  `Birthday` DATE NULL,
  `PhoneNumber` INT NOT NULL,
  `Address` NVARCHAR(1024) NOT NULL,
  `BankId` INT NULL,
  `BankAccount` INT NULL,
  `IsMale` TINYINT(1) NOT NULL,
  `EmployeeId` INT NULL,
  PRIMARY KEY (`CustomerId`),
  INDEX `fk_Customer_Bank_idx` (`BankId` ASC),
  INDEX `fk_Customer_Employee1_idx` (`EmployeeId` ASC),
  CONSTRAINT `fk_Customer_Bank`
    FOREIGN KEY (`BankId`)
    REFERENCES `rosmall`.`Bank` (`BankId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Customer_Employee1`
    FOREIGN KEY (`EmployeeId`)
    REFERENCES `rosmall`.`Employee` (`EmployeeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rosmall`.`Category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rosmall`.`Category` (
  `CategoryId` INT NOT NULL AUTO_INCREMENT,
  `Category` NVARCHAR(1024) NOT NULL,
  PRIMARY KEY (`CategoryId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rosmall`.`Product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rosmall`.`Product` (
  `ProductId` INT NOT NULL AUTO_INCREMENT,
  `Name` NVARCHAR(1024) NOT NULL,
  `CategoryId` INT NOT NULL,
  PRIMARY KEY (`ProductId`),
  INDEX `fk_Product_Category1_idx` (`CategoryId` ASC),
  CONSTRAINT `fk_Product_Category1`
    FOREIGN KEY (`CategoryId`)
    REFERENCES `rosmall`.`Category` (`CategoryId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rosmall`.`Invoice`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rosmall`.`Invoice` (
  `InvoidId` INT NOT NULL,
  `CustomerId` NVARCHAR(1024) NOT NULL,
  `ShippingNumber` INT NOT NULL,
  PRIMARY KEY (`InvoidId`, `ShippingNumber`),
  INDEX `fk_Invoice_Customer1_idx` (`CustomerId` ASC),
  CONSTRAINT `fk_Invoice_Customer1`
    FOREIGN KEY (`CustomerId`)
    REFERENCES `rosmall`.`Customer` (`CustomerId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rosmall`.`Invoiceline`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `rosmall`.`Invoiceline` (
  `InvoidId` INT NOT NULL,
  `ProductId` INT NOT NULL,
  PRIMARY KEY (`InvoidId`, `ProductId`),
  INDEX `fk_Invoiceline_Product1_idx` (`ProductId` ASC),
  CONSTRAINT `fk_Invoiceline_Product1`
    FOREIGN KEY (`ProductId`)
    REFERENCES `rosmall`.`Product` (`ProductId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Invoiceline_Invoice1`
    FOREIGN KEY (`InvoidId`)
    REFERENCES `rosmall`.`Invoice` (`InvoidId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
