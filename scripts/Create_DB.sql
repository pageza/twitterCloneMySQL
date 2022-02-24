-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema twatter
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema twatter
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `twatter` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema Users
-- -----------------------------------------------------
USE `twatter` ;

-- -----------------------------------------------------
-- Table `twatter`.`Users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `twatter`.`Users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fname` VARCHAR(45) NOT NULL,
  `lname` VARCHAR(45) NOT NULL,
  `uname` VARCHAR(45) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `uname_UNIQUE` (`uname` ASC) VISIBLE,
  UNIQUE INDEX `idUsers_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `twatter`.`Posts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `twatter`.`Posts` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `postTitle` VARCHAR(45) NOT NULL,
  `postContent` TEXT NOT NULL,
  `postImage` VARCHAR(255) NULL DEFAULT NULL,
  `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `userID` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idPosts_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Posts_Users_idx` (`userID` ASC) VISIBLE,
  CONSTRAINT `fk_Posts_Users`
    FOREIGN KEY (`userID`)
    REFERENCES `twatter`.`Users` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `twatter`.`Comments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `twatter`.`Comments` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `content` TEXT NOT NULL,
  `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `userID` INT NOT NULL,
  `postID` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idComments_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_Comments_Users1_idx` (`userID` ASC) VISIBLE,
  INDEX `fk_Comments_Posts1_idx` (`postID` ASC) VISIBLE,
  CONSTRAINT `fk_Comments_Posts1`
    FOREIGN KEY (`postID`)
    REFERENCES `twatter`.`Posts` (`id`),
  CONSTRAINT `fk_Comments_Users1`
    FOREIGN KEY (`userID`)
    REFERENCES `twatter`.`Users` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `twatter`.`Follows`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `twatter`.`Follows` (
  `follower_id` INT NOT NULL,
  `followee_id` INT NOT NULL,
  `createdAT` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`follower_id`, `followee_id`),
  INDEX `followee_id` (`followee_id` ASC) VISIBLE,
  CONSTRAINT `Follows_ibfk_1`
    FOREIGN KEY (`follower_id`)
    REFERENCES `twatter`.`Users` (`id`),
  CONSTRAINT `Follows_ibfk_2`
    FOREIGN KEY (`followee_id`)
    REFERENCES `twatter`.`Users` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `twatter`.`Likes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `twatter`.`Likes` (
  `userID` INT NOT NULL,
  `postID` INT NOT NULL,
  `createdAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`userID`, `postID`),
  INDEX `fk_Likes_Users1_idx` (`userID` ASC) VISIBLE,
  INDEX `fk_Likes_Posts1_idx` (`postID` ASC) VISIBLE,
  CONSTRAINT `fk_Likes_Posts1`
    FOREIGN KEY (`postID`)
    REFERENCES `twatter`.`Posts` (`id`),
  CONSTRAINT `fk_Likes_Users1`
    FOREIGN KEY (`userID`)
    REFERENCES `twatter`.`Users` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
