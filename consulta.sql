-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 02-12-2015 a las 04:17:14
-- Versión del servidor: 10.1.8-MariaDB
-- Versión de PHP: 5.6.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `consulta`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `especialidad`
--

CREATE TABLE `especialidad` (
  `id_especialidad` int(11) NOT NULL,
  `Nombre` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `especialidad`
--

INSERT INTO `especialidad` (`id_especialidad`, `Nombre`) VALUES
(1, 'general'),
(2, 'pediatra');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `medico`
--

CREATE TABLE `medico` (
  `Rut_medico` int(11) NOT NULL,
  `Nombre_Medico` varchar(50) DEFAULT NULL,
  `Apellido` varchar(50) DEFAULT NULL,
  `Direccion` varchar(255) DEFAULT NULL,
  `telefono` varchar(255) DEFAULT NULL,
  `id_especialidad` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `medico`
--

INSERT INTO `medico` (`Rut_medico`, `Nombre_Medico`, `Apellido`, `Direccion`, `telefono`, `id_especialidad`) VALUES
(1, 'ricardo', 'palma', '123', '123', 1),
(2, 'juan', 'yañez', '123', '123', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `paciente`
--

CREATE TABLE `paciente` (
  `Rut_paciente` int(11) NOT NULL,
  `Nombre_Paciente` varchar(50) DEFAULT NULL,
  `Apellido` varchar(50) DEFAULT NULL,
  `Direccion` varchar(255) DEFAULT NULL,
  `Telefono` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `paciente`
--

INSERT INTO `paciente` (`Rut_paciente`, `Nombre_Paciente`, `Apellido`, `Direccion`, `Telefono`) VALUES
(1, 'javier', 'polanco', '123', '123'),
(2, 'erick', 'araya', '123', NULL),
(3, 'Disponible', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reservacion`
--

CREATE TABLE `reservacion` (
  `id_reserva` int(11) NOT NULL,
  `Fecha` varchar(50) DEFAULT NULL,
  `Hora` int(3) DEFAULT NULL,
  `Rut_paciente` int(11) DEFAULT NULL,
  `Rut_medico` int(11) DEFAULT NULL,
  `Estado` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `reservacion`
--

INSERT INTO `reservacion` (`id_reserva`, `Fecha`, `Hora`, `Rut_paciente`, `Rut_medico`, `Estado`) VALUES
(1, '02/12/2015', 9, 3, 1, 'Disponible'),
(2, '02/12/2015', 10, 3, 1, 'Disponible'),
(3, '02/12/2015', 11, 3, 1, 'Disponible'),
(4, '02/12/2015', 12, 3, 1, 'Disponible'),
(5, '02/12/2015', 13, 3, 1, 'Disponible'),
(6, '02/12/2015', 14, 2, 2, 'Ocupado'),
(7, '02/12/2015', 15, 3, 2, 'Disponible'),
(8, '02/12/2015', 16, 3, 2, 'Disponible'),
(9, '02/12/2015', 17, 3, 2, 'Disponible'),
(10, '02/12/2015', 18, 1, 2, 'Ocupado');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `especialidad`
--
ALTER TABLE `especialidad`
  ADD PRIMARY KEY (`id_especialidad`);

--
-- Indices de la tabla `medico`
--
ALTER TABLE `medico`
  ADD PRIMARY KEY (`Rut_medico`),
  ADD KEY `category_id` (`id_especialidad`);

--
-- Indices de la tabla `paciente`
--
ALTER TABLE `paciente`
  ADD PRIMARY KEY (`Rut_paciente`);

--
-- Indices de la tabla `reservacion`
--
ALTER TABLE `reservacion`
  ADD PRIMARY KEY (`id_reserva`),
  ADD KEY `pacient_id` (`Rut_paciente`),
  ADD KEY `medic_id` (`Rut_medico`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `especialidad`
--
ALTER TABLE `especialidad`
  MODIFY `id_especialidad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `paciente`
--
ALTER TABLE `paciente`
  MODIFY `Rut_paciente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `reservacion`
--
ALTER TABLE `reservacion`
  MODIFY `id_reserva` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `medico`
--
ALTER TABLE `medico`
  ADD CONSTRAINT `medic_ibfk_1` FOREIGN KEY (`id_especialidad`) REFERENCES `especialidad` (`id_especialidad`);

--
-- Filtros para la tabla `reservacion`
--
ALTER TABLE `reservacion`
  ADD CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`Rut_paciente`) REFERENCES `paciente` (`Rut_paciente`),
  ADD CONSTRAINT `reservation_ibfk_2` FOREIGN KEY (`Rut_medico`) REFERENCES `medico` (`Rut_medico`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
