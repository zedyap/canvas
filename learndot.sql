SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema learndot
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema learndot
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `learndot` DEFAULT CHARACTER SET utf8 ;
USE `learndot` ;

-- -----------------------------------------------------
-- Table `learndot`.`contact`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `learndot`.`contact` (
  `id` BIGINT(20) NOT NULL,
  `email` VARCHAR(64) NULL DEFAULT NULL,
  `firstName` VARCHAR(32) NULL DEFAULT NULL,
  `lastName` VARCHAR(40) NULL DEFAULT NULL,
  `street1` VARCHAR(128) NULL DEFAULT NULL,
  `street2` VARCHAR(128) NULL DEFAULT NULL,
  `city` VARCHAR(64) NULL DEFAULT NULL,
  `region` VARCHAR(64) NULL DEFAULT NULL,
  `postalCode` VARCHAR(32) NULL DEFAULT NULL,
  `country_alpha2code` VARCHAR(2) NULL DEFAULT NULL,
  `birthDate` DATE NULL DEFAULT NULL,
  `title` VARCHAR(128) NULL DEFAULT NULL,
  `lastSuccessfulLogin` DATETIME NULL DEFAULT NULL,
  `department` VARCHAR(128) NULL DEFAULT NULL,
  `salutation` VARCHAR(128) NULL DEFAULT NULL,
  `officephone` VARCHAR(32) NULL DEFAULT NULL,
  `mobilephone` VARCHAR(32) NULL DEFAULT NULL,
  `homephone` VARCHAR(32) NULL DEFAULT NULL,
  `fax` VARCHAR(32) NULL DEFAULT NULL,
  `emailverified` BIT(1) NULL DEFAULT NULL,
  `enabled` BIT(1) NULL DEFAULT NULL,
  `staffEnabled` BIT(1) NULL DEFAULT NULL,
  `taxID` VARCHAR(64) NULL DEFAULT NULL,
  `lastPasswordReset` DATETIME NULL DEFAULT NULL,
  `numberOfSuccessfulLogins` INT(11) NULL DEFAULT NULL,
  `numberOfForumPosts` INT(11) NULL DEFAULT NULL,
  `created` DATE NULL DEFAULT NULL,
  `account_id` BIGINT(20) NULL DEFAULT NULL,
  `name` VARCHAR(73) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `learndot`.`account`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `learndot`.`account` (
  `id` BIGINT(20) NOT NULL,
  `name` VARCHAR(128) NULL DEFAULT NULL,
  `country_alpha2Code` VARCHAR(2) NULL DEFAULT NULL,
  `city` VARCHAR(64) NULL DEFAULT NULL,
  `region` VARCHAR(64) NULL DEFAULT NULL,
  `postalCode` VARCHAR(32) NULL DEFAULT NULL,
  `taxID` VARCHAR(64) NULL DEFAULT NULL,
  `phone` VARCHAR(32) NULL DEFAULT NULL,
  `fax` VARCHAR(32) NULL DEFAULT NULL,
  `logo` VARCHAR(255) NULL DEFAULT NULL,
  `modified` DATETIME NULL DEFAULT NULL,
  `modifiedBy_id` BIGINT(20) NULL DEFAULT NULL,
  `created` DATETIME NULL DEFAULT NULL,
  `createdBy_id` BIGINT(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_modifiedBy_id_account_idx` (`modifiedBy_id` ASC),
  INDEX `fk_createdBy_id_account_idx` (`createdBy_id` ASC),
  CONSTRAINT `fk_createdBy_id_account`
    FOREIGN KEY (`createdBy_id`)
    REFERENCES `learndot`.`contact` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_modifiedBy_id_account`
    FOREIGN KEY (`modifiedBy_id`)
    REFERENCES `learndot`.`contact` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `learndot`.`catalogitem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `learndot`.`catalogitem` (
  `identifier` VARCHAR(41) NOT NULL,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  `type` VARCHAR(23) NOT NULL,
  `status` VARCHAR(32) NULL DEFAULT NULL,
  `priceCurrency` VARCHAR(3) NULL DEFAULT NULL,
  `priceAmount` DECIMAL(19,2) NULL DEFAULT NULL,
  PRIMARY KEY (`identifier`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `learndot`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `learndot`.`category` (
  `identifier` VARCHAR(39) NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`identifier`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `learndot`.`course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `learndot`.`course` (
  `id` BIGINT(20) NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `type` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `learndot`.`learningcomponent`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `learndot`.`learningcomponent` (
  `id` BIGINT(20) NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `language` VARCHAR(128) NULL DEFAULT NULL,
  `type` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `learndot`.`location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `learndot`.`location` (
  `id` BIGINT(20) NOT NULL,
  `city` VARCHAR(64) NULL DEFAULT NULL,
  `region` VARCHAR(64) NULL DEFAULT NULL,
  `country_alpha2Code` VARCHAR(2) NULL DEFAULT NULL,
  `postalCode` VARCHAR(32) NULL DEFAULT NULL,
  `name` VARCHAR(128) NOT NULL,
  `timezone` VARCHAR(64) NOT NULL,
  `online` BIT(1) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `learndot`.`provider`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `learndot`.`provider` (
  `id` BIGINT(20) NOT NULL,
  `name` VARCHAR(64) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `learndot`.`event`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `learndot`.`event` (
  `capacity` INT(11) NULL DEFAULT NULL,
  `course_id` BIGINT(20) NOT NULL,
  `id` BIGINT(20) NOT NULL,
  `location_id` BIGINT(20) NULL DEFAULT NULL,
  `totalHours` DECIMAL(24,4) NULL DEFAULT NULL,
  `provider_id` BIGINT(20) NULL DEFAULT NULL,
  `type` VARCHAR(18) NULL DEFAULT NULL,
  `language` VARCHAR(128) NULL DEFAULT NULL,
  `equipmentProvided` BIT(1) NULL DEFAULT NULL,
  `refreshmentsProvided` BIT(1) NULL DEFAULT NULL,
  `foodProvided` BIT(1) NULL DEFAULT NULL,
  `snacksProvided` BIT(1) NULL DEFAULT NULL,
  `startTime` DATETIME NULL DEFAULT NULL,
  `status` VARCHAR(32) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_location_id_idx` (`location_id` ASC),
  INDEX `fk_provider_id_idx` (`provider_id` ASC),
  CONSTRAINT `fk_location_id_event`
    FOREIGN KEY (`location_id`)
    REFERENCES `learndot`.`location` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_provider_id_event`
    FOREIGN KEY (`provider_id`)
    REFERENCES `learndot`.`provider` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `learndot`.`payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `learndot`.`payment` (
  `id` BIGINT(20) NOT NULL,
  `firstName` VARCHAR(40) NOT NULL,
  `lastName` VARCHAR(40) NOT NULL,
  `account_id` VARCHAR(128) NULL DEFAULT NULL,
  `taxId` VARCHAR(64) NULL DEFAULT NULL,
  `taxcountry_alpha2Code` VARCHAR(2) NULL DEFAULT NULL,
  `phone` VARCHAR(32) NULL DEFAULT NULL,
  `email` VARCHAR(64) NULL DEFAULT NULL,
  `currency` VARCHAR(3) NOT NULL,
  `failureMessage` LONGTEXT NULL DEFAULT NULL,
  `status` VARCHAR(16) NOT NULL,
  `street1` VARCHAR(128) NULL DEFAULT NULL,
  `street2` VARCHAR(128) NULL DEFAULT NULL,
  `city` VARCHAR(64) NULL DEFAULT NULL,
  `region` VARCHAR(64) NULL DEFAULT NULL,
  `postalCode` VARCHAR(32) NULL DEFAULT NULL,
  `country_alpha2Code` VARCHAR(2) NULL DEFAULT NULL,
  `processingDate` DATETIME NULL DEFAULT NULL,
  `processingNumber` VARCHAR(384) NULL DEFAULT NULL,
  `type` VARCHAR(15) NULL DEFAULT NULL,
  `amount` DECIMAL(19,2) NOT NULL,
  `order_id` BIGINT(20) NULL DEFAULT NULL,
  `created` DATETIME NULL DEFAULT NULL,
  `valueAmount` DECIMAL(19,2) NULL DEFAULT NULL,
  `valueCurrency` VARCHAR(3) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `learndot`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `learndot`.`order` (
  `id` BIGINT(20) NOT NULL,
  `status` VARCHAR(32) NOT NULL,
  `contact_id` BIGINT(20) NULL DEFAULT NULL,
  `account_id` BIGINT(20) NULL DEFAULT NULL,
  `payment_id` BIGINT(20) NULL DEFAULT NULL,
  `created` DATETIME NOT NULL,
  `createdBy_id` BIGINT(20) NULL DEFAULT NULL,
  `modified` DATETIME NOT NULL,
  `modifiedBy_id` BIGINT(20) NULL DEFAULT NULL,
  `total` DECIMAL(64,2) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_contact_id_order_idx` (`contact_id` ASC),
  INDEX `fk_payment_id_order_idx` (`payment_id` ASC),
  INDEX `fk_createdBy_id_order_idx` (`createdBy_id` ASC),
  INDEX `fk_modifiedBy_id_order_idx` (`modifiedBy_id` ASC),
  INDEX `fk_account_id_order_idx` (`account_id` ASC),
  CONSTRAINT `fk_account_id_order`
    FOREIGN KEY (`account_id`)
    REFERENCES `learndot`.`account` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_contact_id_order`
    FOREIGN KEY (`contact_id`)
    REFERENCES `learndot`.`contact` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_createdBy_id_order`
    FOREIGN KEY (`createdBy_id`)
    REFERENCES `learndot`.`contact` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_modifiedBy_id_order`
    FOREIGN KEY (`modifiedBy_id`)
    REFERENCES `learndot`.`contact` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_payment_id_order`
    FOREIGN KEY (`payment_id`)
    REFERENCES `learndot`.`payment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `learndot`.`orderitem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `learndot`.`orderitem` (
  `category` VARCHAR(39) NULL DEFAULT NULL,
  `contact_id` BIGINT(20) NULL DEFAULT NULL,
  `created` DATETIME NOT NULL,
  `discount` DECIMAL(41,2) NOT NULL,
  `id` BIGINT(20) NOT NULL,
  `order_id` BIGINT(20) NULL DEFAULT NULL,
  `account_id` BIGINT(20) NULL DEFAULT NULL,
  `paid` BIGINT(20) NOT NULL,
  `payment_id` BIGINT(20) NULL DEFAULT NULL,
  `priceAmount` DECIMAL(19,2) NOT NULL,
  `provider_id` BIGINT(20) NULL DEFAULT NULL,
  `status` VARCHAR(32) NOT NULL,
  `catalogItem` VARCHAR(41) NULL DEFAULT NULL,
  `taxAmount` DECIMAL(19,2) NOT NULL,
  `total` DECIMAL(42,2) NOT NULL,
  `trainingCredits` DECIMAL(19,5) NOT NULL,
  `valueAmount` DECIMAL(19,2) NULL DEFAULT NULL,
  `valueCurrency` VARCHAR(3) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_contact_id_orderitem_idx` (`contact_id` ASC),
  INDEX `fk_order_id_orderitem_idx` (`order_id` ASC),
  INDEX `fk_payment_id_orderitem_idx` (`payment_id` ASC),
  INDEX `fk_provider_id_orderitem_idx` (`provider_id` ASC),
  INDEX `fk_account_id_orderitem_idx` (`account_id` ASC),
  CONSTRAINT `fk_account_id_orderitem`
    FOREIGN KEY (`account_id`)
    REFERENCES `learndot`.`account` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_contact_id_orderitem`
    FOREIGN KEY (`contact_id`)
    REFERENCES `learndot`.`contact` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_id_orderitem`
    FOREIGN KEY (`order_id`)
    REFERENCES `learndot`.`order` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_payment_id_orderitem`
    FOREIGN KEY (`payment_id`)
    REFERENCES `learndot`.`payment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_provider_id_orderitem`
    FOREIGN KEY (`provider_id`)
    REFERENCES `learndot`.`provider` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `learndot`.`enrollment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `learndot`.`enrollment` (
  `status` VARCHAR(32) NOT NULL,
  `completionDate` DATETIME NULL DEFAULT NULL,
  `expiryDate` DATETIME NULL DEFAULT NULL,
  `score` DOUBLE NULL DEFAULT NULL,
  `totalSecondsTracked` BIGINT(20) NULL DEFAULT NULL,
  `confidence` DOUBLE NULL DEFAULT NULL,
  `id` BIGINT(20) NOT NULL,
  `component_id` BIGINT(20) NULL DEFAULT NULL,
  `contact_id` BIGINT(20) NOT NULL,
  `event_id` BIGINT(20) NULL DEFAULT NULL,
  `created` DATETIME NOT NULL,
  `modified` DATETIME NULL DEFAULT NULL,
  `provider_id` BIGINT(20) NULL DEFAULT NULL,
  `orderitem_id` BIGINT(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_contact_id_idx` (`contact_id` ASC),
  INDEX `fk_event_id_idx` (`event_id` ASC),
  INDEX `fk_provider_id_idx` (`provider_id` ASC),
  INDEX `fk_order_id_idx` (`orderitem_id` ASC),
  INDEX `fk_component_id_enrollment_idx` (`component_id` ASC),
  CONSTRAINT `fk_component_id_enrollment`
    FOREIGN KEY (`component_id`)
    REFERENCES `learndot`.`learningcomponent` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_contact_id_enrollment`
    FOREIGN KEY (`contact_id`)
    REFERENCES `learndot`.`contact` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_event_id_enrollment`
    FOREIGN KEY (`event_id`)
    REFERENCES `learndot`.`event` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_id_enrollment`
    FOREIGN KEY (`orderitem_id`)
    REFERENCES `learndot`.`orderitem` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_provider_id_enrollment`
    FOREIGN KEY (`provider_id`)
    REFERENCES `learndot`.`provider` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `learndot`.`instructor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `learndot`.`instructor` (
  `contact_id` BIGINT(20) NOT NULL,
  `courseevent_id` BIGINT(20) NOT NULL,
  `id` BIGINT(20) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_contact_id_idx` (`contact_id` ASC),
  INDEX `fk_courseevent_id_instructor_idx` (`courseevent_id` ASC),
  CONSTRAINT `fk_contact_id_instructor`
    FOREIGN KEY (`contact_id`)
    REFERENCES `learndot`.`contact` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_courseevent_id_instructor`
    FOREIGN KEY (`courseevent_id`)
    REFERENCES `learndot`.`event` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `learndot`.`lead`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `learndot`.`lead` (
  `id` BIGINT(20) NOT NULL,
  `status` VARCHAR(32) NOT NULL,
  `created` DATETIME NOT NULL,
  `contact_id` BIGINT(19) NULL DEFAULT NULL,
  `subject` VARCHAR(128) NULL DEFAULT NULL,
  `quantity` BIGINT(21) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_contact_id_lead_idx` (`contact_id` ASC),
  CONSTRAINT `fk_contact_id_lead`
    FOREIGN KEY (`contact_id`)
    REFERENCES `learndot`.`contact` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `learndot`.`trainingcreditaccount`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `learndot`.`trainingcreditaccount` (
  `id` BIGINT(20) NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `created` DATETIME NULL DEFAULT NULL,
  `balance` DECIMAL(19,5) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `learndot`.`trainingcreditexpiry`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `learndot`.`trainingcreditexpiry` (
  `account_id` BIGINT(20) NOT NULL,
  `expiry` DATETIME NULL DEFAULT NULL,
  `amount` DECIMAL(42,5) NULL DEFAULT NULL,
  INDEX `fk_account_id_trainingcreditexpiry_idx` (`account_id` ASC),
  CONSTRAINT `fk_account_id_trainingcreditexpiry`
    FOREIGN KEY (`account_id`)
    REFERENCES `learndot`.`trainingcreditaccount` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `learndot`.`trainingcreditredemptionrequest`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `learndot`.`trainingcreditredemptionrequest` (
  `amount` DECIMAL(19,5) NOT NULL,
  `id` BIGINT(20) NOT NULL,
  `status` VARCHAR(16) NOT NULL,
  `account_id` BIGINT(20) NOT NULL,
  `order_id` BIGINT(20) NULL DEFAULT NULL,
  `requester_id` BIGINT(20) NOT NULL,
  `payment_id` BIGINT(20) NOT NULL,
  `created` DATETIME NOT NULL,
  `expiry` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_order_id_trainingcreditredemptionrequest_idx` (`order_id` ASC),
  INDEX `fk_requester_id_trainingcreditredemptionrequest_idx` (`requester_id` ASC),
  INDEX `fk_payment_id_trainingcreditredemptionrequest_idx` (`payment_id` ASC),
  INDEX `fk_account_id_trainingcreditredemptionrequest_idx` (`account_id` ASC),
  CONSTRAINT `fk_account_id_trainingcreditredemptionrequest`
    FOREIGN KEY (`account_id`)
    REFERENCES `learndot`.`trainingcreditaccount` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_id_trainingcreditredemptionrequest`
    FOREIGN KEY (`order_id`)
    REFERENCES `learndot`.`order` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_payment_id_trainingcreditredemptionrequest`
    FOREIGN KEY (`payment_id`)
    REFERENCES `learndot`.`payment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_requester_id_trainingcreditredemptionrequest`
    FOREIGN KEY (`requester_id`)
    REFERENCES `learndot`.`contact` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `learndot`.`trainingcredittransaction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `learndot`.`trainingcredittransaction` (
  `amount` DECIMAL(19,5) NOT NULL,
  `reconciled` BIT(1) NOT NULL,
  `account_id` BIGINT(20) NOT NULL,
  `created` DATETIME NOT NULL,
  `valueAmount` DECIMAL(19,2) NULL DEFAULT NULL,
  `valueCurrency` VARCHAR(3) NULL DEFAULT NULL,
  INDEX `fk_account_id_trainingcredittransaction_idx` (`account_id` ASC),
  CONSTRAINT `fk_account_id_trainingcredittransaction`
    FOREIGN KEY (`account_id`)
    REFERENCES `learndot`.`trainingcreditaccount` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
