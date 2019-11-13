create database prograTres;
use prograTres;

create table empleado(
idEmpleado int primary key not null identity(1,1), 
cedula int not null, 
fechaContratacion date not null, 
nombreEmpleadoLogin varchar(25) not null,
primerNombre varchar(30) not null,
segundoNombre varchar(30),
primerApellido varchar(30) not null,
segundoApellido varchar(30) not null,
correoElectronico varchar(30) not null,
idGenero int not null,
fechaNacimiento date not null,
idDepartamento int not null
)

create table departamento(
idDepartamento int primary key not null identity(1,1),
abreviaturaDepartamento varchar(8) not null,
detalle varchar(30) not null,
cuentaCorreoDepartamental varchar(30) not null
)

create table genero(
idGenero int primary key not null,
detalle varchar(30) not null
)

create table contactoDeEmergencia(
idContactoEmergencia int primary key not null,
primerNombre varchar(30) not null,
primerApellido varchar(30) not null,
telefono int not null,
idParentesco int not null,
idEmpleado int not null,
idGenero int not null
)

create table parentesco(
idParentesco int primary key not null identity(1,1),
detalle varchar(30) not null
)

create table pais(
idPais int primary key not null identity(1,1),
abreviaturaPais varchar(3) not null,
detalle varchar(30) not null
)

create table provinciaEstado(
idProvinciaEstado int primary key not null,
idPais int not null,
nombre varchar(30) not null
)

create table cliente(
cedulaCliente int primary key not null,
idProvinciaEstado int not null,
sennas varchar(30) not null,
idTipoCliente int not null,
correoElectronico varchar(30) not null
)

create table tipoCliente(
idTipoCliente int primary key not null identity(1,1),
detalle varchar(30) not null
)

create table clienteFisico(
cedulaCliente int primary key not null,
primerNombre varchar(30) not null,
segundoNombre varchar(30),
primerApellido varchar(30) not null,
segundoApellido varchar(30) not null,
idGenero int not null
)

create table clienteJuridico(
cedulaCliente int primary key not null,
razonSocial varchar(30) not null
)

create table proveedor(
idProveedor int primary key not null identity(1,1),
nombreCompannia varchar(30) not null,
telefono int not null,
idProvinciaEstado int not null,
estaActivo varchar(4) not null
)

create table vendedor(
idVendedor int primary key not null identity(1,1),
idProveedor int not null,
nombre varchar(30) not null,
puesto varchar(30) not null,
correoElectronico varchar(30) not null,
telefonoOficina int not null,
idDepartamento int not null,
telefonoMovil int not null,
idGenero int not null
)

create table inventario(
idProducto int primary key not null,
cantidadDisponible int not null,
cantidadMinimaPermitida int not null,
fechaIngreso date not null
)

create table producto(
idProducto int primary key not null identity(1,1),
nombre varchar(30) not null,
idProveedor int not null,
precioUnitario int not null,
estaDescontinuado varchar(4) not null
)

create table ordenDeCompra(
idOrden int primary key not null identity(1,1),
fecha date not null,
cedulaCliente int not null,
montoTotal money not null,
idEstado int not null,
idCuponDescuento int,
fechaAplicacionCupon int,
montoDescuento money default 0
)

create table ordenDeCompraEstado(
idEstado int primary key not null,
detalle varchar(30) not null
)

create table item(
idItem int primary key not null identity(1,1),
idOrden int not null,
idProducto int not null,
cantidad int not null,
monto money not null
)

create table bitacoraRegistroAuditoria(
idRegistroAuditoria int primary key not null identity(1,1),
idTipoRegistroAuditoria int not null,
idEmpleado int not null,
fechaHora smalldatetime not null,
detalle varchar(30) not null
)

create table tipoRegistroAuditoria(
idTipoRegistroAuditoria int primary key not null identity(1,1),
detalle varchar(30) not null
)

create table cuponDescuento(
idCuponDescuento int primary key not null identity(1,1),
detalleCodigo varchar(30) not null,
porcentajeDescuento int not null,
fechaInicioVigencia date not null,
fechaFinVigencia date not null,
montoMinimoCompraParaAplicarCupon int not null,
disponibleParaClientesTipo int not null,
estaActivado varchar(4) not null
)

create table ordenCompraCancelada(
idOrden int primary key not null,
fechaCancelacion date not null,
explicacionCliente varchar(30) not null
)

-- llaves foráneas
-- empleado
alter table empleado 
add foreign key (idGenero) references genero(idGenero)
alter table empleado 
add foreign key (idDepartamento) references departamento(idDepartamento)

-- contactoDeEmergencia
alter table contactoDeEmergencia 
add foreign key (idParentesco) references parentesco(idParentesco)
alter table contactoDeEmergencia 
add foreign key (idEmpleado) references empleado(idEmpleado)
alter table contactoDeEmergencia 
add foreign key (idGenero) references genero(idGenero)

-- provinciaEstado
alter table provinciaEstado 
add foreign key (idPais) references pais(idPais)

-- cliente
alter table cliente 
add foreign key (idProvinciaEstado) references provinciaEstado(idProvinciaEstado)
alter table cliente 
add foreign key (idTipoCliente) references tipoCliente(idTipoCliente)

-- clienteFísico
alter table clienteFisico
add foreign key (idGenero) references genero(idGenero)
alter table clienteFisico
add foreign key (cedulaCliente) references cliente(cedulaCliente)

-- clienteJuridico
alter table clienteJuridico
add foreign key (cedulaCliente) references cliente(cedulaCliente)

-- proveedor
alter table proveedor
add foreign key (idProvinciaEstado) references provinciaEstado(idProvinciaEstado)

-- vendedor
alter table vendedor
add foreign key (idProveedor) references proveedor(idProveedor)
alter table vendedor
add foreign key (idDepartamento) references departamento(idDepartamento)
alter table vendedor
add foreign key (idGenero) references genero(idGenero)

-- inventario
alter table inventario
add foreign key (idProducto) references producto(idProducto)

-- ordenDeCompra
alter table ordenDeCompra
add foreign key (cedulaCliente) references cliente(cedulaCliente)
alter table ordenDeCompra
add foreign key (idEstado) references ordenDeCompraEstado(idEstado)
alter table ordenDeCompra
add foreign key (idCuponDescuento) references cuponDescuento(idCuponDescuento)

-- item
alter table item
add foreign key (idOrden) references ordenDeCompra(idOrden)
alter table item
add foreign key (idProducto) references producto(idProducto)

-- bitacoraRegistroAuditoria
alter table bitacoraRegistroAuditoria
add foreign key (idTipoRegistroAuditoria) references tipoRegistroAuditoria(idTipoRegistroAuditoria)
alter table bitacoraRegistroAuditoria
add foreign key (idEmpleado) references empleado(idEmpleado)

-- cuponDescuento
alter table cuponDescuento
add foreign key (disponibleParaClientesTipo) references tipoCliente(idTipoCliente)

-- ordenCompraCancelada
alter table ordenCompraCancelada
add foreign key (idOrden) references ordenDeCompra(idOrden)

-- inserciones 
-- genero 
insert into genero (idGenero, detalle) 
values (01, 'mujer')
insert into genero (idGenero, detalle) 
values (02, 'hombre')
insert into genero (idGenero, detalle) 
values (03, 'no binario')

-- parentesco 
insert into parentesco(detalle)
values ('mamá')
insert into parentesco(detalle)
values ('papá')
insert into parentesco(detalle)
values ('abuela')
insert into parentesco(detalle)
values ('abuelo')
insert into parentesco(detalle)
values ('hermano')
insert into parentesco(detalle)
values ('hermana')
insert into parentesco(detalle)
values ('tío')
insert into parentesco(detalle)
values ('tía')
insert into parentesco(detalle)
values ('primo')
insert into parentesco(detalle)
values ('prima')
insert into parentesco(detalle)
values ('sobrina')
insert into parentesco(detalle)
values ('sobrino')

-- pais 
insert into pais(abreviaturaPais, detalle)
values ('CRC', 'Costa Rica')
insert into pais(abreviaturaPais, detalle)
values ('PER', 'Perú')
insert into pais(abreviaturaPais, detalle)
values ('PHL', 'Filipinas')
insert into pais(abreviaturaPais, detalle)
values ('BEL', 'Belgica')
insert into pais(abreviaturaPais, detalle)
values ('GRC', 'Grecia')
insert into pais(abreviaturaPais, detalle)
values ('FJI', 'Fiji')

-- provinciaEstado
insert into provinciaEstado(idProvinciaEstado, idPais, nombre)
values (11, 1, 'San José')
insert into provinciaEstado(idProvinciaEstado, idPais, nombre)
values (12, 1, 'Alajuela')
insert into provinciaEstado(idProvinciaEstado, idPais, nombre)
values (13, 1, 'Cartago')
insert into provinciaEstado(idProvinciaEstado, idPais, nombre)
values (14, 1, 'Heredia')
insert into provinciaEstado(idProvinciaEstado, idPais, nombre)
values (15, 1, 'Guanacaste')
insert into provinciaEstado(idProvinciaEstado, idPais, nombre)
values (16, 1, 'Puntarenas')
insert into provinciaEstado(idProvinciaEstado, idPais, nombre)
values (17, 1, 'Limón')

insert into provinciaEstado(idProvinciaEstado, idPais, nombre)
values (21, 2, 'Amazonas')
insert into provinciaEstado(idProvinciaEstado, idPais, nombre)
values (22, 2, 'Ancash')
insert into provinciaEstado(idProvinciaEstado, idPais, nombre)
values (23, 2, 'Apurimac')
insert into provinciaEstado(idProvinciaEstado, idPais, nombre)
values (24, 2, 'Arequipa')
insert into provinciaEstado(idProvinciaEstado, idPais, nombre)
values (25, 2, 'Ayacucho')
insert into provinciaEstado(idProvinciaEstado, idPais, nombre)
values (26, 2, 'Cajamarca')
insert into provinciaEstado(idProvinciaEstado, idPais, nombre)
values (27, 2, 'Callao')
insert into provinciaEstado(idProvinciaEstado, idPais, nombre)
values (28, 2, 'Cusco')
insert into provinciaEstado(idProvinciaEstado, idPais, nombre)
values (29, 2, 'Huanuco')

insert into provinciaEstado(idProvinciaEstado, idPais, nombre)
values (31, 3, 'Ifugao')
insert into provinciaEstado(idProvinciaEstado, idPais, nombre)
values (32, 3, 'Isabela')
insert into provinciaEstado(idProvinciaEstado, idPais, nombre)
values (33, 3, 'Kalinga')
insert into provinciaEstado(idProvinciaEstado, idPais, nombre)
values (34, 3, 'Cotabato')
insert into provinciaEstado(idProvinciaEstado, idPais, nombre)
values (35, 3, 'Leyte')
insert into provinciaEstado(idProvinciaEstado, idPais, nombre)
values (36, 3, 'Masbate')
insert into provinciaEstado(idProvinciaEstado, idPais, nombre)
values (37, 3, 'Palaban')
insert into provinciaEstado(idProvinciaEstado, idPais, nombre)
values (38, 3, 'Pampanga')
insert into provinciaEstado(idProvinciaEstado, idPais, nombre)
values (39, 3, 'Cápiz')

insert into provinciaEstado(idProvinciaEstado, idPais, nombre)
values (41, 4, 'Flandes Occidental')
insert into provinciaEstado(idProvinciaEstado, idPais, nombre)
values (42, 4, 'Flandes Oriental')
insert into provinciaEstado(idProvinciaEstado, idPais, nombre)
values (43, 4, 'Ambares')
insert into provinciaEstado(idProvinciaEstado, idPais, nombre)
values (44, 4, 'Limburgo')
insert into provinciaEstado(idProvinciaEstado, idPais, nombre)
values (45, 4, 'Lieja')
insert into provinciaEstado(idProvinciaEstado, idPais, nombre)
values (46, 4, 'Luxemburgo')
insert into provinciaEstado(idProvinciaEstado, idPais, nombre)
values (47, 4, 'Limburgo')
insert into provinciaEstado(idProvinciaEstado, idPais, nombre)
values (48, 4, 'Henao')
insert into provinciaEstado(idProvinciaEstado, idPais, nombre)
values (49, 4, 'Namur')

insert into provinciaEstado(idProvinciaEstado, idPais, nombre)
values (51, 5, 'Tracia')
insert into provinciaEstado(idProvinciaEstado, idPais, nombre)
values (52, 5, 'Macedonia')
insert into provinciaEstado(idProvinciaEstado, idPais, nombre)
values (53, 5, 'Tesalia')
insert into provinciaEstado(idProvinciaEstado, idPais, nombre)
values (54, 5, 'Epiro')
insert into provinciaEstado(idProvinciaEstado, idPais, nombre)
values (55, 5, 'Grecia Central')
insert into provinciaEstado(idProvinciaEstado, idPais, nombre)
values (56, 5, 'Peloponeso')
insert into provinciaEstado(idProvinciaEstado, idPais, nombre)
values (57, 5, 'Islas del Egeo')
insert into provinciaEstado(idProvinciaEstado, idPais, nombre)
values (58, 5, 'Islas Jónicas')
insert into provinciaEstado(idProvinciaEstado, idPais, nombre)
values (59, 5, 'Creta')

insert into provinciaEstado(idProvinciaEstado, idPais, nombre)
values (61, 6, 'Suva')
insert into provinciaEstado(idProvinciaEstado, idPais, nombre)
values (62, 6, 'Labasa')
insert into provinciaEstado(idProvinciaEstado, idPais, nombre)
values (63, 6, 'Levuka')
insert into provinciaEstado(idProvinciaEstado, idPais, nombre)
values (64, 6, 'Lautoka')

-- tipoCliente
insert into tipoCliente (detalle)
values ('a')
insert into tipoCliente (detalle)
values ('b')
insert into tipoCliente (detalle)
values ('c')
insert into tipoCliente (detalle)
values ('d')


