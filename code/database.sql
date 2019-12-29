-- MySQL Script generated by MySQL Workbench
-- So 28. prosince 2019, 11:31:59 CET
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema db_dev
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema db_dev
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db_dev` ;
USE `db_dev` ;

-- -----------------------------------------------------
-- Table `db_dev`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_dev`.`users` (
  `user_id` INT(6) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `created` DATETIME NOT NULL,
  `description` TEXT NOT NULL,
  `role` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB;

INSERT INTO `users` (`user_id`, `role`, `username`, `email`, `password`, `created`, `description`) VALUES
(1, 'admin', 'admin', 'admin@admin.cz', '21232f297a57a5a743894a0e4a801fc3', '2019-12-28 11-59-36', 'administrátor webu'),
(3, 'inzerent', 'prvni', 'prvni@gmail.com', '3926efd781f7d330f3779b43426d2cf7', '2019-12-28 11-59-45', 'popis uživatele');
-- -----------------------------------------------------
-- Table `db_dev`.`categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_dev`.`categories` (
  `category_id` INT(2) NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`category_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_dev`.`regions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_dev`.`regions` (
  `region_id` INT(2) NOT NULL,
  `name` VARCHAR(75) NOT NULL,
  PRIMARY KEY (`region_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_dev`.`rooms`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_dev`.`rooms` (
  `room_id` INT(2) NOT NULL,
  `name` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`room_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_dev`.`items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_dev`.`items` (
  `item_id` INT(5) NOT NULL,
  `publication_date` DATETIME NOT NULL,
  `modification_date` DATETIME NULL,
  `price` INT(7) NOT NULL,
  `USERS_user_id` INT(6) NOT NULL,
  `CATEGORY_category_id` INT(2) NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `description` TEXT NOT NULL,
  `REGION_region_id` INT(2) NOT NULL,
  `ROOMS_room_id` INT(2) NOT NULL,
  PRIMARY KEY (`item_id`),
  INDEX `fk_ITEM_USERS1_idx` (`USERS_user_id` ASC) VISIBLE,
  INDEX `fk_ITEM_CATEGORY1_idx` (`CATEGORY_category_id` ASC) VISIBLE,
  INDEX `fk_ITEM_REGION1_idx` (`REGION_region_id` ASC) VISIBLE,
  INDEX `fk_ITEMS_ROOMS1_idx` (`ROOMS_room_id` ASC) VISIBLE,
  CONSTRAINT `fk_ITEM_USERS1`
    FOREIGN KEY (`USERS_user_id`)
    REFERENCES `db_dev`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ITEM_CATEGORY1`
    FOREIGN KEY (`CATEGORY_category_id`)
    REFERENCES `db_dev`.`categories` (`category_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ITEM_REGION1`
    FOREIGN KEY (`REGION_region_id`)
    REFERENCES `db_dev`.`regions` (`region_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ITEMS_ROOMS1`
    FOREIGN KEY (`ROOMS_room_id`)
    REFERENCES `db_dev`.`rooms` (`room_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_dev`.`messages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_dev`.`messages` (
  `message_id` INT(6) NOT NULL,
  `message` TEXT NOT NULL,
  `publication_date` DATETIME NOT NULL,
  `USERS_sender_id` INT(6) NOT NULL,
  `USERS_reciever_id1` INT(6) NOT NULL,
  PRIMARY KEY (`message_id`),
  INDEX `fk_ITEM_COMMENT_USERS1_idx` (`USERS_sender_id` ASC) VISIBLE,
  INDEX `fk_MESSAGES_USERS1_idx` (`USERS_reciever_id1` ASC) VISIBLE,
  CONSTRAINT `fk_ITEM_COMMENT_USERS1`
    FOREIGN KEY (`USERS_sender_id`)
    REFERENCES `db_dev`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MESSAGES_USERS1`
    FOREIGN KEY (`USERS_reciever_id1`)
    REFERENCES `db_dev`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_dev`.`cities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_dev`.`cities` (
  `city_id` INT(5) NOT NULL,
  `name` VARCHAR(75) NOT NULL,
  `ITEM_LOCATION_i_location_id` INT(3) NOT NULL,
  `ITEM_LOCATION_ITEM_item_id` INT(5) NOT NULL,
  `REGION_region_id` INT(2) NOT NULL,
  PRIMARY KEY (`city_id`),
  INDEX `fk_CITY_REGION1_idx` (`REGION_region_id` ASC) VISIBLE,
  CONSTRAINT `fk_CITY_REGION1`
    FOREIGN KEY (`REGION_region_id`)
    REFERENCES `db_dev`.`regions` (`region_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;