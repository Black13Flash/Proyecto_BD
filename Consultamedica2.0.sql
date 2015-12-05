-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema Consulta_Medica
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Consulta_Medica
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Consulta_Medica` DEFAULT CHARACTER SET utf8 ;
USE `Consulta_Medica` ;

-- -----------------------------------------------------
-- Table `Consulta_Medica`.`Personas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Consulta_Medica`.`Personas` (
  `Rut` INT NOT NULL,
  `Nombre` VARCHAR(45) NULL,
  `Apellido` VARCHAR(45) NULL,
  `FechaNacimiento` VARCHAR(45) NULL,
  `Sexo` CHAR(1) NULL,
  `EstadoCivil` CHAR(1) NULL,
  PRIMARY KEY (`Rut`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Consulta_Medica`.`Medico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Consulta_Medica`.`Medico` (
  `Especialidad` VARCHAR(45) NULL,
  `Personas_Rut` INT NOT NULL,
  PRIMARY KEY (`Personas_Rut`),
  INDEX `fk_Medico_Personas_idx` (`Personas_Rut` ASC),
  CONSTRAINT `fk_Medico_Personas`
    FOREIGN KEY (`Personas_Rut`)
    REFERENCES `Consulta_Medica`.`Personas` (`Rut`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Consulta_Medica`.`Paciente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Consulta_Medica`.`Paciente` (
  `Personas_Rut` INT NOT NULL,
  PRIMARY KEY (`Personas_Rut`),
  INDEX `fk_Paciente_Personas1_idx` (`Personas_Rut` ASC),
  CONSTRAINT `fk_Paciente_Personas1`
    FOREIGN KEY (`Personas_Rut`)
    REFERENCES `Consulta_Medica`.`Personas` (`Rut`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Consulta_Medica`.`Consulta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Consulta_Medica`.`Consulta` (
  `Medico_Personas_Rut` INT NULL,
  `Paciente_Personas_Rut` INT NULL,
  `fechaAtencion` VARCHAR(45) NULL,
  `horaAtencion` VARCHAR(45) NULL,
  `idConsulta` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idConsulta`),
  INDEX `fk_Consulta_Paciente1_idx` (`Paciente_Personas_Rut` ASC),
  CONSTRAINT `fk_Consulta_Medico1`
    FOREIGN KEY (`Medico_Personas_Rut`)
    REFERENCES `Consulta_Medica`.`Medico` (`Personas_Rut`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Consulta_Paciente1`
    FOREIGN KEY (`Paciente_Personas_Rut`)
    REFERENCES `Consulta_Medica`.`Paciente` (`Personas_Rut`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Consulta_Medica`.`especialidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Consulta_Medica`.`especialidad` (
  `IdEspecialidad` INT NOT NULL,
  `NombreEspecialidad` VARCHAR(45) NULL,
  `Medico_Personas_Rut` INT NOT NULL,
  PRIMARY KEY (`IdEspecialidad`, `Medico_Personas_Rut`),
  INDEX `fk_especialidad_Medico1_idx` (`Medico_Personas_Rut` ASC),
  CONSTRAINT `fk_especialidad_Medico1`
    FOREIGN KEY (`Medico_Personas_Rut`)
    REFERENCES `Consulta_Medica`.`Medico` (`Personas_Rut`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Consulta_Medica`.`SubEspecialidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Consulta_Medica`.`SubEspecialidad` (
  `idSubEspecialidad` INT NOT NULL,
  `NombreEspecialidad` VARCHAR(45) NULL,
  `especialidad_IdEspecialidad` INT NOT NULL,
  PRIMARY KEY (`idSubEspecialidad`, `especialidad_IdEspecialidad`),
  INDEX `fk_SubEspecialidad_especialidad1_idx` (`especialidad_IdEspecialidad` ASC),
  CONSTRAINT `fk_SubEspecialidad_especialidad1`
    FOREIGN KEY (`especialidad_IdEspecialidad`)
    REFERENCES `Consulta_Medica`.`especialidad` (`IdEspecialidad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Consulta_Medica`.`FichaPaciente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Consulta_Medica`.`FichaPaciente` (
  `Paciente_Personas_Rut` INT NOT NULL,
  `NumeroFicha` VARCHAR(45) NOT NULL,
  `fechaCreacion` VARCHAR(45) NULL,
  `estado` VARCHAR(45) NULL,
  PRIMARY KEY (`NumeroFicha`),
  CONSTRAINT `fk_FichaPaciente_Paciente1`
    FOREIGN KEY (`Paciente_Personas_Rut`)
    REFERENCES `Consulta_Medica`.`Paciente` (`Personas_Rut`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Consulta_Medica`.`DetalleFichaPaciente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Consulta_Medica`.`DetalleFichaPaciente` (
  `fechaAtencion` VARCHAR(45) NOT NULL,
  `Diagnostico` VARCHAR(100) NULL,
  `FichaPaciente_NumeroFicha` VARCHAR(45) NOT NULL,
  `Medico_Personas_Rut` INT NOT NULL,
  PRIMARY KEY (`fechaAtencion`, `FichaPaciente_NumeroFicha`, `Medico_Personas_Rut`),
  INDEX `fk_DetalleFichaPaciente_FichaPaciente1_idx` (`FichaPaciente_NumeroFicha` ASC),
  INDEX `fk_DetalleFichaPaciente_Medico1_idx` (`Medico_Personas_Rut` ASC),
  CONSTRAINT `fk_DetalleFichaPaciente_FichaPaciente1`
    FOREIGN KEY (`FichaPaciente_NumeroFicha`)
    REFERENCES `Consulta_Medica`.`FichaPaciente` (`NumeroFicha`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DetalleFichaPaciente_Medico1`
    FOREIGN KEY (`Medico_Personas_Rut`)
    REFERENCES `Consulta_Medica`.`Medico` (`Personas_Rut`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Consulta_Medica`.`recetas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Consulta_Medica`.`recetas` (
  `NumReceta` INT NOT NULL,
  `DetalleFichaPaciente_fechaAtencion` VARCHAR(45) NOT NULL,
  `DetalleFichaPaciente_FichaPaciente_NumeroFicha` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`NumReceta`, `DetalleFichaPaciente_fechaAtencion`, `DetalleFichaPaciente_FichaPaciente_NumeroFicha`),
  INDEX `fk_recetas_DetalleFichaPaciente1_idx` (`DetalleFichaPaciente_fechaAtencion` ASC, `DetalleFichaPaciente_FichaPaciente_NumeroFicha` ASC),
  CONSTRAINT `fk_recetas_DetalleFichaPaciente1`
    FOREIGN KEY (`DetalleFichaPaciente_fechaAtencion` , `DetalleFichaPaciente_FichaPaciente_NumeroFicha`)
    REFERENCES `Consulta_Medica`.`DetalleFichaPaciente` (`fechaAtencion` , `FichaPaciente_NumeroFicha`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Consulta_Medica`.`medicamentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Consulta_Medica`.`medicamentos` (
  `IdMedicamento` INT NOT NULL,
  `NombreMedicamento` VARCHAR(45) NULL,
  PRIMARY KEY (`IdMedicamento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Consulta_Medica`.`laboratorio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Consulta_Medica`.`laboratorio` (
  `IdLaboratorio` INT NOT NULL,
  `NombreLab` VARCHAR(45) NULL,
  PRIMARY KEY (`IdLaboratorio`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Consulta_Medica`.`lab/med`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Consulta_Medica`.`lab/med` (
  `medicamentos_IdMedicamento` INT NOT NULL,
  `laboratorio_IdLaboratorio` INT NOT NULL,
  PRIMARY KEY (`medicamentos_IdMedicamento`, `laboratorio_IdLaboratorio`),
  INDEX `fk_lab/med_laboratorio1_idx` (`laboratorio_IdLaboratorio` ASC),
  CONSTRAINT `fk_lab/med_medicamentos1`
    FOREIGN KEY (`medicamentos_IdMedicamento`)
    REFERENCES `Consulta_Medica`.`medicamentos` (`IdMedicamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lab/med_laboratorio1`
    FOREIGN KEY (`laboratorio_IdLaboratorio`)
    REFERENCES `Consulta_Medica`.`laboratorio` (`IdLaboratorio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Consulta_Medica`.`receta/medicamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Consulta_Medica`.`receta/medicamento` (
  `recetas_NumReceta` INT NOT NULL,
  `medicamentos_IdMedicamento` INT NOT NULL,
  `Indicaciones` VARCHAR(100) NULL,
  PRIMARY KEY (`recetas_NumReceta`, `medicamentos_IdMedicamento`),
  INDEX `fk_receta/medicamento_medicamentos1_idx` (`medicamentos_IdMedicamento` ASC),
  CONSTRAINT `fk_receta/medicamento_recetas1`
    FOREIGN KEY (`recetas_NumReceta`)
    REFERENCES `Consulta_Medica`.`recetas` (`NumReceta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_receta/medicamento_medicamentos1`
    FOREIGN KEY (`medicamentos_IdMedicamento`)
    REFERENCES `Consulta_Medica`.`medicamentos` (`IdMedicamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Consulta_Medica`.`Dia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Consulta_Medica`.`Dia` (
  `idDia` INT NOT NULL,
  `NombreDia` VARCHAR(45) NULL,
  PRIMARY KEY (`idDia`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Consulta_Medica`.`Turnos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Consulta_Medica`.`Turnos` (
  `idTurnos` INT NOT NULL,
  `Turnos` VARCHAR(45) NULL,
  PRIMARY KEY (`idTurnos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Consulta_Medica`.`Bloque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Consulta_Medica`.`Bloque` (
  `idBloque` INT NOT NULL,
  `Duracion_Bloque` VARCHAR(45) NULL,
  `Estado` VARCHAR(45) NULL,
  PRIMARY KEY (`idBloque`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Consulta_Medica`.`Bloque/turnos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Consulta_Medica`.`Bloque/turnos` (
  `Bloque_idBloque` INT NOT NULL,
  `Turnos_idTurnos` INT NOT NULL,
  PRIMARY KEY (`Bloque_idBloque`, `Turnos_idTurnos`),
  INDEX `fk_Bloque_has_Turnos_Turnos1_idx` (`Turnos_idTurnos` ASC),
  INDEX `fk_Bloque_has_Turnos_Bloque1_idx` (`Bloque_idBloque` ASC),
  CONSTRAINT `fk_Bloque_has_Turnos_Bloque1`
    FOREIGN KEY (`Bloque_idBloque`)
    REFERENCES `Consulta_Medica`.`Bloque` (`idBloque`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bloque_has_Turnos_Turnos1`
    FOREIGN KEY (`Turnos_idTurnos`)
    REFERENCES `Consulta_Medica`.`Turnos` (`idTurnos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Consulta_Medica`.`Turnos/dia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Consulta_Medica`.`Turnos/dia` (
  `Turnos_idTurnos` INT NOT NULL,
  `Dia_idDia` INT NOT NULL,
  PRIMARY KEY (`Turnos_idTurnos`, `Dia_idDia`),
  INDEX `fk_Turnos_has_Dia_Dia1_idx` (`Dia_idDia` ASC),
  INDEX `fk_Turnos_has_Dia_Turnos1_idx` (`Turnos_idTurnos` ASC),
  CONSTRAINT `fk_Turnos_has_Dia_Turnos1`
    FOREIGN KEY (`Turnos_idTurnos`)
    REFERENCES `Consulta_Medica`.`Turnos` (`idTurnos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Turnos_has_Dia_Dia1`
    FOREIGN KEY (`Dia_idDia`)
    REFERENCES `Consulta_Medica`.`Dia` (`idDia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Consulta_Medica`.`Horario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Consulta_Medica`.`Horario` (
  `Medico_Personas_Rut` INT NOT NULL,
  PRIMARY KEY (`Medico_Personas_Rut`),
  INDEX `fk_Medico_has_Dia_Medico1_idx` (`Medico_Personas_Rut` ASC),
  CONSTRAINT `fk_Medico_has_Dia_Medico1`
    FOREIGN KEY (`Medico_Personas_Rut`)
    REFERENCES `Consulta_Medica`.`Medico` (`Personas_Rut`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
