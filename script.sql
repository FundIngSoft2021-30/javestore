<<<<<<< HEAD
CREATE TABLE Carrito (
  id        int(10) NOT NULL AUTO_INCREMENT, 
  Usuarioid int(10) NOT NULL, 
  estado    varchar(1) NOT NULL, 
  fecha     date NOT NULL, 
  PRIMARY KEY (id));
CREATE TABLE Carrito_Impuesto (
  Carritoid  int(10) NOT NULL, 
  Impuestoid int(10) NOT NULL, 
  PRIMARY KEY (Carritoid, 
  Impuestoid));
CREATE TABLE Categoria (
  id     int(10) NOT NULL AUTO_INCREMENT, 
  nombre varchar(255) NOT NULL UNIQUE, 
  PRIMARY KEY (id));
CREATE TABLE Compra (
  id         int(10) NOT NULL AUTO_INCREMENT, 
  cantidad   int(10) NOT NULL, 
  Carritoid  int(10) NOT NULL, 
  Productoid int(10) NOT NULL, 
  PRIMARY KEY (id));
CREATE TABLE Cuenta (
  id        int(10) NOT NULL AUTO_INCREMENT, 
  email     varchar(255) NOT NULL UNIQUE, 
  password  varchar(255) NOT NULL, 
  rol       varchar(1) NOT NULL, 
  Usuarioid int(10) NOT NULL, 
  PRIMARY KEY (id));
CREATE TABLE Descuento (
  id           int(10) NOT NULL AUTO_INCREMENT, 
  porcentaje   float NOT NULL, 
  fecha_inicio date NOT NULL, 
  fecha_final  date NOT NULL, 
  PRIMARY KEY (id));
CREATE TABLE Impuesto (
  id         int(10) NOT NULL AUTO_INCREMENT, 
  nombre     varchar(255) NOT NULL, 
  porcentaje int(2) NOT NULL, 
  PRIMARY KEY (id));
CREATE TABLE Moda (
  id         int(11) NOT NULL AUTO_INCREMENT, 
  talla      varchar(5) NOT NULL, 
  color      varchar(25) NOT NULL, 
  marca      varchar(25) NOT NULL, 
  Productoid int(10) NOT NULL, 
  PRIMARY KEY (id));
CREATE TABLE Pedido (
  id           int(10) NOT NULL AUTO_INCREMENT, 
  costo_envio  float NOT NULL, 
  metodo_envio varchar(1), 
  comentario   varchar(255), 
  Carritoid    int(10) NOT NULL, 
  PRIMARY KEY (id));
CREATE TABLE Producto (
  id          int(10) NOT NULL AUTO_INCREMENT, 
  cantidad    int(10) NOT NULL, 
  nombre      varchar(255) NOT NULL UNIQUE, 
  descripcion varchar(255) NOT NULL, 
  precio      float NOT NULL, 
  estado      varchar(1) NOT NULL, 
  Categoriaid int(10) NOT NULL, 
  Usuarioid   int(10) NOT NULL, 
  PRIMARY KEY (id));
CREATE TABLE Producto_Descuento (
  Productoid  int(10) NOT NULL, 
  Descuentoid int(10) NOT NULL, 
  PRIMARY KEY (Productoid, 
  Descuentoid));
CREATE TABLE Review (
  id         int(10) NOT NULL AUTO_INCREMENT, 
  texto      varchar(255) NOT NULL, 
  Productoid int(10) NOT NULL, 
  PRIMARY KEY (id));
CREATE TABLE Usuario (
  id        int(10) NOT NULL AUTO_INCREMENT, 
  nombre    varchar(255) NOT NULL, 
  apellido  varchar(255) NOT NULL, 
  direccion varchar(255), 
  numero    int(10) NOT NULL UNIQUE, 
  PRIMARY KEY (id));
CREATE TABLE Utiles (
  id         int(11) NOT NULL AUTO_INCREMENT, 
  dimesiones varchar(25) NOT NULL, 
  color      varchar(25) NOT NULL, 
  autor      varchar(25), 
  editorial  varchar(25) NOT NULL, 
  Productoid int(10) NOT NULL, 
  PRIMARY KEY (id));
ALTER TABLE Cuenta ADD CONSTRAINT FKCuenta619573 FOREIGN KEY (Usuarioid) REFERENCES Usuario (id);
ALTER TABLE Review ADD CONSTRAINT FKReview894314 FOREIGN KEY (Productoid) REFERENCES Producto (id);
ALTER TABLE Producto ADD CONSTRAINT FKProducto906784 FOREIGN KEY (Categoriaid) REFERENCES Categoria (id);
ALTER TABLE Compra ADD CONSTRAINT FKCompra51365 FOREIGN KEY (Carritoid) REFERENCES Carrito (id);
ALTER TABLE Producto ADD CONSTRAINT FKProducto91503 FOREIGN KEY (Usuarioid) REFERENCES Usuario (id);
ALTER TABLE Compra ADD CONSTRAINT FKCompra430828 FOREIGN KEY (Productoid) REFERENCES Producto (id);
ALTER TABLE Pedido ADD CONSTRAINT FKPedido251376 FOREIGN KEY (Carritoid) REFERENCES Carrito (id);
ALTER TABLE Carrito ADD CONSTRAINT FKCarrito928441 FOREIGN KEY (Usuarioid) REFERENCES Usuario (id);
ALTER TABLE Utiles ADD CONSTRAINT FKUtiles250278 FOREIGN KEY (Productoid) REFERENCES Producto (id);
ALTER TABLE Moda ADD CONSTRAINT FKModa189848 FOREIGN KEY (Productoid) REFERENCES Producto (id);
ALTER TABLE Producto_Descuento ADD CONSTRAINT FKProducto_D651871 FOREIGN KEY (Productoid) REFERENCES Producto (id);
ALTER TABLE Producto_Descuento ADD CONSTRAINT FKProducto_D19298 FOREIGN KEY (Descuentoid) REFERENCES Descuento (id);
ALTER TABLE Carrito_Impuesto ADD CONSTRAINT FKCarrito_Im909267 FOREIGN KEY (Carritoid) REFERENCES Carrito (id);
ALTER TABLE Carrito_Impuesto ADD CONSTRAINT FKCarrito_Im982415 FOREIGN KEY (Impuestoid) REFERENCES Impuesto (id);

--------------------------------------------------------------------------------------------------------------------

insert into Usuario(nombre,apellido,numero)
values('admin','admin',1234567890),('Nicolas','Tomatoe',1111111111);

insert into Cuenta(email,password,rol,Usuarioid)
values('admin@javestore.com','javestore','A',1),('tomatoe@gmail.com','tomatoe123','S',2);

insert into Categoria(nombre)
values('Moda'),('Utiles'),('Libros');

insert into Producto(cantidad,nombre,descripcion,precio,estado,categoriaid,usuarioid)
values(20,'100 Años de Soledad','Cien años de soledad es una novela del escritor colombiano Gabriel García Márquez, ganador del Premio Nobel de Literatura en 1982.',100.000,'A',3,1),(10,'Cuaderno Morado','Cuaderno pasta gruesa color morado',20.000,'A',2,1);

insert into Utiles(id,dimesiones,color,editorial,Productoid)
values(1,'3cmx3cm','Negro','Norma',2);

insert into Review(id,texto,Productoid)
values(1,'Muy buen producto duradero',2);

insert into Producto_Descuento(Productoid,Descuentoid)
values(1,1);

insert into Impuesto(nombre,porcentaje)
values('Iva',19);

insert into Carrito_Impuesto(Carritoid,Impuestoid)
values(1,1);    


describe Pedido;
=======
-- phpMyAdmin SQL Dump
-- version 4.9.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Oct 11, 2021 at 07:19 PM
-- Server version: 10.3.16-MariaDB
-- PHP Version: 7.3.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `id17746593_jave_store`
--

-- --------------------------------------------------------

--
-- Table structure for table `Carrito`
--

CREATE TABLE `Carrito` (
  `id` int(10) NOT NULL,
  `Usuarioid` int(10) NOT NULL,
  `estado` varchar(1) COLLATE utf8_unicode_ci NOT NULL,
  `fecha` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `Carrito`
--

INSERT INTO `Carrito` (`id`, `Usuarioid`, `estado`, `fecha`) VALUES
(1, 2, '0', '2021-10-06'),
(2, 2, '1', '2021-09-10');

-- --------------------------------------------------------

--
-- Table structure for table `Carrito_Impuesto`
--

CREATE TABLE `Carrito_Impuesto` (
  `Carritoid` int(10) NOT NULL,
  `Impuestoid` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `Carrito_Impuesto`
--

INSERT INTO `Carrito_Impuesto` (`Carritoid`, `Impuestoid`) VALUES
(1, 1),
(2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `Categoria`
--

CREATE TABLE `Categoria` (
  `id` int(10) NOT NULL,
  `nombre` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `Categoria`
--

INSERT INTO `Categoria` (`id`, `nombre`) VALUES
(1, 'Moda'),
(2, 'Utiles');

-- --------------------------------------------------------

--
-- Table structure for table `Compra`
--

CREATE TABLE `Compra` (
  `id` int(10) NOT NULL,
  `cantidad` int(10) NOT NULL,
  `Carritoid` int(10) NOT NULL,
  `Productoid` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `Compra`
--

INSERT INTO `Compra` (`id`, `cantidad`, `Carritoid`, `Productoid`) VALUES
(1, 5, 1, 2),
(2, 5, 1, 2),
(3, 2, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `Cuenta`
--

CREATE TABLE `Cuenta` (
  `id` int(10) NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `rol` varchar(1) COLLATE utf8_unicode_ci NOT NULL,
  `Usuarioid` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `Cuenta`
--

INSERT INTO `Cuenta` (`id`, `email`, `password`, `rol`, `Usuarioid`) VALUES
(1, 'admin@javestore.com', 'javestore', 'A', 1),
(2, 'tomatoe@gmail.com', 'tomatoe123', 'S', 2);

-- --------------------------------------------------------

--
-- Table structure for table `Descuento`
--

CREATE TABLE `Descuento` (
  `id` int(10) NOT NULL,
  `porcentaje` float NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_final` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `Descuento`
--

INSERT INTO `Descuento` (`id`, `porcentaje`, `fecha_inicio`, `fecha_final`) VALUES
(1, 0.19, '2021-10-05', '2021-10-06'),
(2, 0.19, '2021-10-05', '2021-10-06');

-- --------------------------------------------------------

--
-- Table structure for table `Impuesto`
--

CREATE TABLE `Impuesto` (
  `id` int(10) NOT NULL,
  `nombre` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `porcentaje` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `Impuesto`
--

INSERT INTO `Impuesto` (`id`, `nombre`, `porcentaje`) VALUES
(1, 'Iva', 19);

-- --------------------------------------------------------

--
-- Table structure for table `Moda`
--

CREATE TABLE `Moda` (
  `id` int(11) NOT NULL,
  `talla` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  `color` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `marca` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `Productoid` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Pedido`
--

CREATE TABLE `Pedido` (
  `id` int(10) NOT NULL,
  `costo_envio` decimal(19,2) DEFAULT NULL,
  `metodo_envio` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `comentario` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Carritoid` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `Pedido`
--

INSERT INTO `Pedido` (`id`, `costo_envio`, `metodo_envio`, `comentario`, `Carritoid`) VALUES
(1, NULL, NULL, NULL, 2);

-- --------------------------------------------------------

--
-- Table structure for table `Producto`
--

CREATE TABLE `Producto` (
  `id` int(10) NOT NULL,
  `cantidad` int(10) NOT NULL,
  `nombre` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `descripcion` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `precio` decimal(19,2) NOT NULL,
  `estado` varchar(1) COLLATE utf8_unicode_ci NOT NULL,
  `imagen` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Categoriaid` int(10) NOT NULL,
  `Usuarioid` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `Producto`
--

INSERT INTO `Producto` (`id`, `cantidad`, `nombre`, `descripcion`, `precio`, `estado`, `imagen`, `Categoriaid`, `Usuarioid`) VALUES
(1, 20, '100 Años de Soledad', 'Cien años de soledad es una novela del escritor colombiano Gabriel García Márquez, ganador del Premio Nobel de Literatura en 1982.', 100.00, 'A', 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwww.popularlibros.com%2Fimagenes_grandes%2F9788497%2F978849759220.JPG&f=1&nofb=1', 2, 1),
(2, 10, 'Cuaderno Morado', 'Cuaderno pasta gruesa color morado', 200.99, 'A', 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse3.mm.bing.net%2Fth%3Fid%3DOIP.6gfl6Q4iHAvLsaxUrerdlQHaFR%26pid%3DApi&f=1', 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `Producto_Descuento`
--

CREATE TABLE `Producto_Descuento` (
  `Productoid` int(10) NOT NULL,
  `Descuentoid` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `Producto_Descuento`
--

INSERT INTO `Producto_Descuento` (`Productoid`, `Descuentoid`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `Review`
--

CREATE TABLE `Review` (
  `id` int(10) NOT NULL,
  `texto` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `Productoid` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `Review`
--

INSERT INTO `Review` (`id`, `texto`, `Productoid`) VALUES
(1, 'Muy buen producto duradero', 2);

-- --------------------------------------------------------

--
-- Table structure for table `Usuario`
--

CREATE TABLE `Usuario` (
  `id` int(10) NOT NULL,
  `nombre` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `apellido` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `direccion` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `numero` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `Usuario`
--

INSERT INTO `Usuario` (`id`, `nombre`, `apellido`, `direccion`, `numero`) VALUES
(1, 'admin', 'admin', NULL, 1234567890),
(2, 'Nicolas', 'Tomatoe', NULL, 1111111111);

-- --------------------------------------------------------

--
-- Table structure for table `Utiles`
--

CREATE TABLE `Utiles` (
  `id` int(11) NOT NULL,
  `dimesiones` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `color` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `autor` varchar(25) COLLATE utf8_unicode_ci DEFAULT NULL,
  `editorial` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `Productoid` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `Utiles`
--

INSERT INTO `Utiles` (`id`, `dimesiones`, `color`, `autor`, `editorial`, `Productoid`) VALUES
(1, '3cmx3cm', 'Negro', NULL, 'Norma', 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Carrito`
--
ALTER TABLE `Carrito`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKCarrito928441` (`Usuarioid`);

--
-- Indexes for table `Carrito_Impuesto`
--
ALTER TABLE `Carrito_Impuesto`
  ADD PRIMARY KEY (`Carritoid`,`Impuestoid`),
  ADD KEY `FKCarrito_Im982415` (`Impuestoid`);

--
-- Indexes for table `Categoria`
--
ALTER TABLE `Categoria`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indexes for table `Compra`
--
ALTER TABLE `Compra`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKCompra51365` (`Carritoid`),
  ADD KEY `FKCompra430828` (`Productoid`);

--
-- Indexes for table `Cuenta`
--
ALTER TABLE `Cuenta`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `FKCuenta619573` (`Usuarioid`);

--
-- Indexes for table `Descuento`
--
ALTER TABLE `Descuento`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Impuesto`
--
ALTER TABLE `Impuesto`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Moda`
--
ALTER TABLE `Moda`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKModa189848` (`Productoid`);

--
-- Indexes for table `Pedido`
--
ALTER TABLE `Pedido`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKPedido251376` (`Carritoid`);

--
-- Indexes for table `Producto`
--
ALTER TABLE `Producto`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`),
  ADD KEY `FKProducto906784` (`Categoriaid`),
  ADD KEY `FKProducto91503` (`Usuarioid`);

--
-- Indexes for table `Producto_Descuento`
--
ALTER TABLE `Producto_Descuento`
  ADD PRIMARY KEY (`Productoid`,`Descuentoid`),
  ADD KEY `FKProducto_D19298` (`Descuentoid`);

--
-- Indexes for table `Review`
--
ALTER TABLE `Review`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKReview894314` (`Productoid`);

--
-- Indexes for table `Usuario`
--
ALTER TABLE `Usuario`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `numero` (`numero`);

--
-- Indexes for table `Utiles`
--
ALTER TABLE `Utiles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKUtiles250278` (`Productoid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Carrito`
--
ALTER TABLE `Carrito`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `Categoria`
--
ALTER TABLE `Categoria`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `Compra`
--
ALTER TABLE `Compra`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `Cuenta`
--
ALTER TABLE `Cuenta`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `Descuento`
--
ALTER TABLE `Descuento`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `Impuesto`
--
ALTER TABLE `Impuesto`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `Moda`
--
ALTER TABLE `Moda`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Pedido`
--
ALTER TABLE `Pedido`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `Producto`
--
ALTER TABLE `Producto`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `Review`
--
ALTER TABLE `Review`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `Usuario`
--
ALTER TABLE `Usuario`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `Utiles`
--
ALTER TABLE `Utiles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Carrito`
--
ALTER TABLE `Carrito`
  ADD CONSTRAINT `FKCarrito928441` FOREIGN KEY (`Usuarioid`) REFERENCES `Usuario` (`id`);

--
-- Constraints for table `Carrito_Impuesto`
--
ALTER TABLE `Carrito_Impuesto`
  ADD CONSTRAINT `FKCarrito_Im909267` FOREIGN KEY (`Carritoid`) REFERENCES `Carrito` (`id`),
  ADD CONSTRAINT `FKCarrito_Im982415` FOREIGN KEY (`Impuestoid`) REFERENCES `Impuesto` (`id`);

--
-- Constraints for table `Compra`
--
ALTER TABLE `Compra`
  ADD CONSTRAINT `FKCompra430828` FOREIGN KEY (`Productoid`) REFERENCES `Producto` (`id`),
  ADD CONSTRAINT `FKCompra51365` FOREIGN KEY (`Carritoid`) REFERENCES `Carrito` (`id`);

--
-- Constraints for table `Cuenta`
--
ALTER TABLE `Cuenta`
  ADD CONSTRAINT `FKCuenta619573` FOREIGN KEY (`Usuarioid`) REFERENCES `Usuario` (`id`);

--
-- Constraints for table `Moda`
--
ALTER TABLE `Moda`
  ADD CONSTRAINT `FKModa189848` FOREIGN KEY (`Productoid`) REFERENCES `Producto` (`id`);

--
-- Constraints for table `Pedido`
--
ALTER TABLE `Pedido`
  ADD CONSTRAINT `FKPedido251376` FOREIGN KEY (`Carritoid`) REFERENCES `Carrito` (`id`);

--
-- Constraints for table `Producto`
--
ALTER TABLE `Producto`
  ADD CONSTRAINT `FKProducto906784` FOREIGN KEY (`Categoriaid`) REFERENCES `Categoria` (`id`),
  ADD CONSTRAINT `FKProducto91503` FOREIGN KEY (`Usuarioid`) REFERENCES `Usuario` (`id`);

--
-- Constraints for table `Producto_Descuento`
--
ALTER TABLE `Producto_Descuento`
  ADD CONSTRAINT `FKProducto_D19298` FOREIGN KEY (`Descuentoid`) REFERENCES `Descuento` (`id`),
  ADD CONSTRAINT `FKProducto_D651871` FOREIGN KEY (`Productoid`) REFERENCES `Producto` (`id`);

--
-- Constraints for table `Review`
--
ALTER TABLE `Review`
  ADD CONSTRAINT `FKReview894314` FOREIGN KEY (`Productoid`) REFERENCES `Producto` (`id`);

--
-- Constraints for table `Utiles`
--
ALTER TABLE `Utiles`
  ADD CONSTRAINT `FKUtiles250278` FOREIGN KEY (`Productoid`) REFERENCES `Producto` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
>>>>>>> 02efb76881360d53e72097bd7e03bbd1f601f068
