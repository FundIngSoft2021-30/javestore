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