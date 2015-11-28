create database SistemasVentas;
use SistemasVentas;

create table Regiones
(
	idRegion int(10),
    Nombre varchar(20),
    primary key (idRegion)
);

create table Vendedor
(
	idVendedor int(10),
    Nombres varchar(20),
    Apellidos varchar(20),
    Sexo varchar(10),
    Edad int(10),
    EstadoCivil varchar(20),
    primary key (idVendedor)
);

create table Vendedor_Region
(
	idVendedor int(10),   # LOS TIPOS DE PK DEBEN COINCIDIR CON LOS ORIGINALES 
    idRegion int(10),
    
    constraint PK_Vendedor_Region 
				primary key(idVendedor,idRegion), # <--- LA PRIMARY KEY ES COMPUESTA
    
    constraint FK_VenReg_REF_Vendedor
				foreign key (idVendedor) references Vendedor(idVendedor),
	constraint FK_VenReg_REF_Regiones
				foreign key (idRegion) references Regiones(idRegion)
);

create table Comuna
(
	idComuna int(10),
    Nombre varchar(20),
    idRegion int(10),
    
    constraint PK_Comuna
				primary key(idComuna),
    
    constraint FK_Comuna_REF_Regiones
				foreign key (idRegion) references Regiones(idRegion)
);

create table Cliente
(
	idCliente int(10),
    Nombres varchar(20),
    Apellidos varchar(20),
    Sexo varchar(10),
    Edad int(10),
    EstadoCivil varchar(20),
    
    constraint PK_Cliente
				primary key(idCliente)
);

create table Direccion
(
	idCliente int(10),
    tipoDireccion varchar(20),
    Calle varchar(20),
    Numero varchar(6),
    idComuna int(10),
    
    
    constraint PK_Direccion
				primary key(idCliente,tipoDireccion),
                
    constraint FK_Direccion_REF_Cliente
			    foreign key (idCliente) references Cliente(idCliente),
	constraint FK_Direccion_REF_Comuna
			    foreign key (idComuna) references Comuna(idComuna)
);

create table Orden
(
	numeroOrden int(10),
    FechaOrden datetime,
    idCliente int(10),
    idVendedor int(10),
    
    constraint PK_Orden
				primary key(numeroOrden),
                
    constraint FK_Orden_REF_Cliente
			    foreign key (idCliente) references Cliente(idCliente),
	constraint FK_Orden_REF_Vendedor
			    foreign key (idVendedor) references Vendedor(idVendedor)
);

create table Producto
(
	idProducto int(10),
    NombreProducto varchar(10),
    
    constraint PK_Producto
				primary key(idProducto)
);

create table DetalleOrden
(
	numeroOrden int(10),
    idProducto int(10),
    Cantidad int(10),
    PrecioUnitario int(10),
    ProcentajeDescuento int(3),
    
    constraint PK_Detalle_Orden
				primary key(numeroOrden,idProducto),
                
	constraint FK_DetOrd_REF_Orden
				foreign key(numeroOrden) references Orden(numeroOrden),
	constraint FK_DetOrd_REF_Producto
				foreign key(idProducto) references Producto(idProducto)
);

create table Proveedor
(
	idProveedor int(10),
    RazonSocial varchar(20),
    
    constraint PK_Proveedor
				primary key(idProveedor)
);

create table Proveedor_Producto
(
	idProveedor int(10),
    idProducto int(10),
    PrecioVenta int(6),
    
    constraint PK_Proveedor_Producto
				primary key(idProveedor,idProducto),
	
    constraint FK_ProvProd_REF_Proveedor
				foreign key(idProveedor) references Proveedor(idProveedor),
                
    constraint FK_ProvProd_REF_Producto
				foreign key(idProducto) references Producto(idProducto)
);

## Este es el usuario de la Base de datos (Para ingresar)
use mysql;
create user 'admin_SistemaVenta'@'localhost' identified by '';
grant all privileges on Empleados.* to 'admin_SistemaVenta'@'localhost';
flush privileges
