-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema veterinaria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema veterinaria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `veterinaria` DEFAULT CHARACTER SET utf8 ;
USE `veterinaria` ;

-- -----------------------------------------------------
-- Table `veterinaria`.`especialidades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `veterinaria`.`especialidades` (
  `id_especialidades` INT NOT NULL,
  `tipo_especialidades` VARCHAR(100) NULL,
  PRIMARY KEY (`id_especialidades`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `veterinaria`.`mascota`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `veterinaria`.`mascota` (
  `id_mascota` INT NOT NULL,
  `nombra_mascota` VARCHAR(100) NULL,
  `peso_mascota` VARCHAR(100) NULL,
  `tamaño_mascota` VARCHAR(100) NULL,
  `raza_mascota` VARCHAR(100) NULL,
  `fecha_nacimiento_mascota` DATE NULL,
  PRIMARY KEY (`id_mascota`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `veterinaria`.`Tipo identificacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `veterinaria`.`Tipo identificacion` (
  `idTipo identificacion` INT NOT NULL,
  `Tipo_identificacion` VARCHAR(45) NULL,
  PRIMARY KEY (`idTipo identificacion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `veterinaria`.`personas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `veterinaria`.`personas` (
  `id_personas` INT NOT NULL,
  `identificacion_per` BIGINT(20) NULL,
  `nombre_per` VARCHAR(100) NULL,
  `apellido_per` VARCHAR(100) NULL,
  `direccion_per` VARCHAR(45) NULL,
  `telefono_per` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `Tipo` VARCHAR(45) NULL,
  `especialidades_id_especialidades` INT NOT NULL,
  `mascota_id_mascota` INT NOT NULL,
  `Tipo identificacion_idTipo identificacion` INT NOT NULL,
  PRIMARY KEY (`id_personas`),
  INDEX `fk_veterinarios_especialidades_idx` (`especialidades_id_especialidades` ASC) VISIBLE,
  INDEX `fk_veterinarios_mascota1_idx` (`mascota_id_mascota` ASC) VISIBLE,
  INDEX `fk_veterinarios_Tipo identificacion1_idx` (`Tipo identificacion_idTipo identificacion` ASC) VISIBLE,
  CONSTRAINT `fk_veterinarios_especialidades`
    FOREIGN KEY (`especialidades_id_especialidades`)
    REFERENCES `veterinaria`.`especialidades` (`id_especialidades`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_veterinarios_mascota1`
    FOREIGN KEY (`mascota_id_mascota`)
    REFERENCES `veterinaria`.`mascota` (`id_mascota`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_veterinarios_Tipo identificacion1`
    FOREIGN KEY (`Tipo identificacion_idTipo identificacion`)
    REFERENCES `veterinaria`.`Tipo identificacion` (`idTipo identificacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `veterinaria`.`Receta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `veterinaria`.`Receta` (
  `idReceta` INT NOT NULL,
  `tipo_medicina` VARCHAR(45) NULL,
  PRIMARY KEY (`idReceta`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `veterinaria`.`historial`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `veterinaria`.`historial` (
  `idhistorial` INT NOT NULL,
  `fecha` DATETIME NULL,
  `tipo_visita` VARCHAR(100) NULL,
  `pago` DOUBLE NULL,
  `causa_visita` VARCHAR(100) NULL,
  `mascota_id_mascota` INT NOT NULL,
  `Receta_idReceta` INT NOT NULL,
  PRIMARY KEY (`idhistorial`),
  INDEX `fk_historial_mascota1_idx` (`mascota_id_mascota` ASC) VISIBLE,
  INDEX `fk_historial_Receta1_idx` (`Receta_idReceta` ASC) VISIBLE,
  CONSTRAINT `fk_historial_mascota1`
    FOREIGN KEY (`mascota_id_mascota`)
    REFERENCES `veterinaria`.`mascota` (`id_mascota`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_historial_Receta1`
    FOREIGN KEY (`Receta_idReceta`)
    REFERENCES `veterinaria`.`Receta` (`idReceta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `veterinaria`.`mascota_has_personas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `veterinaria`.`mascota_has_personas` (
  `mascota_id_mascota` INT NOT NULL,
  `personas_id_personas` INT NOT NULL,
  PRIMARY KEY (`mascota_id_mascota`, `personas_id_personas`),
  INDEX `fk_mascota_has_personas_personas1_idx` (`personas_id_personas` ASC) VISIBLE,
  INDEX `fk_mascota_has_personas_mascota1_idx` (`mascota_id_mascota` ASC) VISIBLE,
  CONSTRAINT `fk_mascota_has_personas_mascota1`
    FOREIGN KEY (`mascota_id_mascota`)
    REFERENCES `veterinaria`.`mascota` (`id_mascota`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mascota_has_personas_personas1`
    FOREIGN KEY (`personas_id_personas`)
    REFERENCES `veterinaria`.`personas` (`id_personas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `veterinaria`.`personas_has_historial`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `veterinaria`.`personas_has_historial` (
  `personas_id_personas` INT NOT NULL,
  `historial_idhistorial` INT NOT NULL,
  PRIMARY KEY (`personas_id_personas`, `historial_idhistorial`),
  INDEX `fk_personas_has_historial_historial1_idx` (`historial_idhistorial` ASC) VISIBLE,
  INDEX `fk_personas_has_historial_personas1_idx` (`personas_id_personas` ASC) VISIBLE,
  CONSTRAINT `fk_personas_has_historial_personas1`
    FOREIGN KEY (`personas_id_personas`)
    REFERENCES `veterinaria`.`personas` (`id_personas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_personas_has_historial_historial1`
    FOREIGN KEY (`historial_idhistorial`)
    REFERENCES `veterinaria`.`historial` (`idhistorial`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `veterinaria`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `veterinaria`.`usuarios` (
  `idusuarios` INT NOT NULL,
  `nombre_usuario` VARCHAR(45) NULL,
  `password` VARCHAR(100) NULL,
  `personas_id_personas` INT NOT NULL,
  PRIMARY KEY (`idusuarios`),
  INDEX `fk_usuarios_personas1_idx` (`personas_id_personas` ASC) VISIBLE,
  CONSTRAINT `fk_usuarios_personas1`
    FOREIGN KEY (`personas_id_personas`)
    REFERENCES `veterinaria`.`personas` (`id_personas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
