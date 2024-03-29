create database prograTres;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    create database prograTres;
use prograTres;

create table empleado(
idEmpleado int primary key not null identity(1,1), 
cedula int not null unique, 
idProvinciaEstado int not null,
fechaContratacion date not null, 
nombreEmpleadoLogin varchar(25) not null unique,
primerNombre varchar(30) not null,
segundoNombre varchar(30),
primerApellido varchar(30) not null,
segundoApellido varchar(30) not null,
correoElectronico varchar(30) not null unique,
idGenero int not null,
fechaNacimiento date not null,
idDepartamento int not null
)

create table departamento(
idDepartamento int primary key not null identity(1,1),
abreviaturaDepartamento varchar(8) not null unique,
detalle varchar(50) not null,
cuentaCorreoDepartamental varchar(30) not null unique
)

create table genero(
idGenero int primary key not null,
detalle varchar(30) not null
)

create table contactoDeEmergencia(
idContactoEmergencia int primary key not null, --cedula del contacto
primerNombre varchar(30) not null,
primerApellido varchar(30) not null,
telefono int not null unique,
idParentesco int not null,
idEmpleado int not null unique,
idGenero int not null
)

create table parentesco(
idParentesco int primary key not null identity(1,1),
detalle varchar(30) not null
)

create table pais(
idPais int primary key not null identity(1,1),
abreviaturaPais varchar(3) not null unique,
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
sennas varchar(30),
idTipoCliente int not null,
correoElectronico varchar(30) not null unique
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
telefono int not null unique,
idProvinciaEstado int not null,
estaActivo varchar(4) not null,
constraint activoCk check (estaActivo = 'si' or estaActivo = 'no')
)

create table vendedor(
idVendedor int primary key not null identity(1,1),
idProveedor int not null,
nombre varchar(30) not null,
puesto varchar(30) not null,
correoElectronico varchar(30) not null unique,
telefonoOficina int not null unique,
idDepartamento int not null,
telefonoMovil int not null unique,
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
estaDescontinuado varchar(4) not null,
constraint descontinuadoCk check (estaDescontinuado = 'si' or estaDescontinuado = 'no')
)

create table ordenDeCompra(
idOrden int primary key not null identity(1,1),
fecha date not null,
cedulaCliente int not null,
montoTotal money not null,
idEstado int not null,
idCuponDescuento int,
fechaAplicacionCupon date,
montoDescuento money default 0
)

create table ordenDeCompraEstado(
idEstado int primary key not null identity(1,1),
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
estaActivado varchar(4) not null,
constraint activadoCk check (estaActivado = 'si' or estaActivado = 'no')
)

create table ordenCompraCancelada(
idOrden int primary key not null,
fechaCancelacion date not null,
explicacionCliente varchar(30) not null
)

-- llaves for�neas
-- empleado
alter table empleado 
add foreign key (idGenero) references genero(idGenero)
alter table empleado 
add foreign key (idDepartamento) references departamento(idDepartamento)
alter table proveedor
add foreign key (idProvinciaEstado) references provinciaEstado(idProvinciaEstado)

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
alter table proveedor
add foreign key (idProvinciaEstado) references provinciaEstado(idProvinciaEstado)

-- clienteF�sico
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
values ('mam�')
insert into parentesco(detalle)
values ('pap�')
insert into parentesco(detalle)
values ('abuela')
insert into parentesco(detalle)
values ('abuelo')
insert into parentesco(detalle)
values ('hermano')
insert into parentesco(detalle)
values ('hermana')
insert into parentesco(detalle)
values ('t�o')
insert into parentesco(detalle)
values ('t�a')
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
values ('PER', 'Per�')
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
values (11, 1, 'San Jos�')
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
values (17, 1, 'Lim�n')

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
values (39, 3, 'C�piz')

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
values (58, 5, 'Islas J�nicas')
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

-- cliente
insert into cliente(cedulaCliente, idProvinciaEstado, sennas, idTipoCliente, correoElectronico)
values(117800471, 11, 'Casa de color amarilla',	1, 'catasanchez@icloud.com')
insert into cliente(cedulaCliente, idProvinciaEstado, sennas, idTipoCliente, correoElectronico)
values(215873698, 12, 'Por el palo de mangos', 4, 'diego@tec.com')
insert into cliente(cedulaCliente, idProvinciaEstado, sennas, idTipoCliente, correoElectronico)
values(578961454, 33, 'A la orilla del mar', 3, 'santorini@grecia.com')
insert into cliente(cedulaCliente, idProvinciaEstado, idTipoCliente, correoElectronico)
values(869745328, 56, 2, 'mariahill@tec.cr')
insert into cliente(cedulaCliente, idProvinciaEstado, sennas, idTipoCliente, correoElectronico)
values(896541237, 61, 'Contiguo a la agencia',	1, 'alemb@tec.cr')

insert into cliente(cedulaCliente, idProvinciaEstado, sennas, idTipoCliente, correoElectronico)
values(485697125, 15, 'Escuela de comunicaci�n', 1, 'comunicacion@tec.cr')
insert into cliente(cedulaCliente, idProvinciaEstado, sennas, idTipoCliente, correoElectronico)
values(548796321, 14, 'Escuela de artes, UCR', 4, 'artes@tec.cr')
insert into cliente(cedulaCliente, idProvinciaEstado, idTipoCliente, correoElectronico)
values(569823144, 11, 1, 'agencia@tec.cr')
insert into cliente(cedulaCliente, idProvinciaEstado, sennas, idTipoCliente, correoElectronico)
values(654782143, 13, 'Escuela de medicina, UCR', 3, 'medicina@tec.cr')
insert into cliente(cedulaCliente, idProvinciaEstado, sennas, idTipoCliente, correoElectronico)
values(789632541, 12, 'Contiguo al TEC', 2, 'carros@tec.cr')

-- clienteF�sico
insert into clienteFisico(cedulaCliente, primerNombre, segundoNombre, primerApellido, segundoApellido, idGenero)
values(117800471, 'Mar�a', 'Catalina', 'S�nchez', 'Mart�nez', 01)
insert into clienteFisico(cedulaCliente, primerNombre, primerApellido, segundoApellido, idGenero)
values(215873698, 'Diego', 'Rodriguez', 'Soto', 02)
insert into clienteFisico(cedulaCliente, primerNombre, primerApellido, segundoApellido, idGenero)
values(578961454, 'Artemisa', 'Lopez', 'Mora', 03)
insert into clienteFisico(cedulaCliente, primerNombre, primerApellido, segundoApellido, idGenero)
values(869745328, 'Mar�a', 'Hill', 'Avenger', 01)
insert into clienteFisico(cedulaCliente, primerNombre, segundoNombre, primerApellido, segundoApellido, idGenero)
values(896541237, 'Alexander', 'Josu�', 'Morales', 'Barrantes', 02)

-- clienteJuridico
insert into clienteJuridico(cedulaCliente, razonSocial)
values(485697125, 'Escuela de comunicaci�n')
insert into clienteJuridico(cedulaCliente, razonSocial)
values(548796321, 'Escuela de artes')
insert into clienteJuridico(cedulaCliente, razonSocial)
values(569823144, 'Agencia SA')
insert into clienteJuridico(cedulaCliente, razonSocial)
values(654782143, 'Escuela de medicina')
insert into clienteJuridico(cedulaCliente, razonSocial)
values(789632541, 'Carros de alquiler SA')

-- ordenDeCompraEstado
insert into ordenDeCompraEstado(detalle)
values ('En preparaci�n')
insert into ordenDeCompraEstado(detalle)
values ('En tr�nsito')
insert into ordenDeCompraEstado(detalle)
values ('Cancelada')
insert into ordenDeCompraEstado(detalle)
values ('Entregada')
insert into ordenDeCompraEstado(detalle)
values ('Con retraso')
insert into ordenDeCompraEstado(detalle)
values ('Extraviado')

-- tipoRegistroAuditoria
insert into tipoRegistroAuditoria(detalle)
values('cuponCreado')
insert into tipoRegistroAuditoria(detalle)
values('cuponAplicado')
insert into tipoRegistroAuditoria(detalle)
values('ordenCreada')
insert into tipoRegistroAuditoria(detalle)
values('cantidadMinimaSuperada')
insert into tipoRegistroAuditoria(detalle)
values('proveedorCreado')
insert into tipoRegistroAuditoria(detalle)
values('proveedorDadoDeBaja')

-- proovedor
insert into proveedor(nombreCompannia, telefono, idProvinciaEstado, estaActivo)
values('El Bombillo SA', 22587698, 11, 'si')
insert into proveedor(nombreCompannia, telefono, idProvinciaEstado, estaActivo)
values('El Camino SA', 22563214, 12, 'si')
insert into proveedor(nombreCompannia, telefono, idProvinciaEstado, estaActivo)
values('El Sol SA', 22563548, 13, 'no')
insert into proveedor(nombreCompannia, telefono, idProvinciaEstado, estaActivo)
values('Sabemas SA', 22365789, 14, 'no')
insert into proveedor(nombreCompannia, telefono, idProvinciaEstado, estaActivo)
values('Forever 34 SA', 22322657, 15, 'si')

-- cuponDescuento
insert into cuponDescuento(detalleCodigo, porcentajeDescuento, fechaInicioVigencia, fechaFinVigencia, montoMinimoCompraParaAplicarCupon, disponibleParaClientesTipo, estaActivado)
values('Para sopa azteca', 30, '2017-05-12', '2017-05-16', 35, 4, 'si')
insert into cuponDescuento(detalleCodigo, porcentajeDescuento, fechaInicioVigencia, fechaFinVigencia, montoMinimoCompraParaAplicarCupon, disponibleParaClientesTipo, estaActivado)
values('Para comprar l�pices', 20, '2017-12-12', '2017-12-24', 40, 2, 'si')
insert into cuponDescuento(detalleCodigo, porcentajeDescuento, fechaInicioVigencia, fechaFinVigencia, montoMinimoCompraParaAplicarCupon, disponibleParaClientesTipo, estaActivado)
values('Compra de bombillos', 10, '2017-10-12', '2018-10-18', 50, 3, 'no')
insert into cuponDescuento(detalleCodigo, porcentajeDescuento, fechaInicioVigencia, fechaFinVigencia, montoMinimoCompraParaAplicarCupon, disponibleParaClientesTipo, estaActivado)
values('Alquiler de pel�culas', 35, '2018-06-11', '2018-06-22', 15, 1, 'si')
insert into cuponDescuento(detalleCodigo, porcentajeDescuento, fechaInicioVigencia, fechaFinVigencia, montoMinimoCompraParaAplicarCupon, disponibleParaClientesTipo, estaActivado)
values('Para adornos de navidad', 40, '2019-10-12', '2019-11-11', 30, 1, 'si')

-- departamento
insert into departamento(abreviaturaDepartamento, detalle, cuentaCorreoDepartamental)
values('INF', 'Depto. de Inform�tica', 'informatica@tec.cr')
insert into departamento(abreviaturaDepartamento, detalle, cuentaCorreoDepartamental)
values('FYC', 'Depto. de Finanzas y Contabilidad', 'finycon@tec.cr')
insert into departamento(abreviaturaDepartamento, detalle, cuentaCorreoDepartamental)
values('RHS', 'Depto. de Recursos Humanos', 'recursosh@tec.cr')
insert into departamento(abreviaturaDepartamento, detalle, cuentaCorreoDepartamental)
values('PYM', 'Depto. de Publicidad y Mercadotecnia', 'publiymerca@tec.cr')
insert into departamento(abreviaturaDepartamento, detalle, cuentaCorreoDepartamental)
values('DGN', 'Depto. Direcci�n General', 'direccion@tec.cr')

-- empleado
insert into empleado(cedula, idProvinciaEstado, fechaContratacion, nombreEmpleadoLogin, primerNombre, segundoNombre, primerApellido, segundoApellido, correoElectronico, idGenero, fechaNacimiento, idDepartamento)
values(11458763, 11, '2015-06-11', 'hstyles', 'Harry', 'Edward', 'Styles', 'Mora', 'hstyles@tec.cr', 02, '1994-02-01', 3)
insert into empleado(cedula, idProvinciaEstado, fechaContratacion, nombreEmpleadoLogin, primerNombre, segundoNombre, primerApellido, segundoApellido, correoElectronico, idGenero, fechaNacimiento, idDepartamento)
values(125489630, 12, '2016-07-12', 'zmalik', 'Zayn', 'Jaavad', 'Malik', 'Coto', 'zmalik@tec.cr', 02, '1993-01-12', 4)
insert into empleado(cedula, idProvinciaEstado, fechaContratacion, nombreEmpleadoLogin, primerNombre, segundoNombre, primerApellido, segundoApellido, correoElectronico, idGenero, fechaNacimiento, idDepartamento)
values(154728963, 13, '2017-08-13', 'ltommo', 'Louis', 'William', 'Tomlinson', 'Ruiz', 'ltommo@tec.cr', 02, '1991-12-24', 5)
insert into empleado(cedula, idProvinciaEstado, fechaContratacion, nombreEmpleadoLogin, primerNombre, segundoNombre, primerApellido, segundoApellido, correoElectronico, idGenero, fechaNacimiento, idDepartamento)
values(125478365, 14, '2018-09-14', 'solange', 'Solange', 'Piaget', 'Knowles', 'Borges', 'solange@tec.cr', 01, '1986-06-24', 1)
insert into empleado(cedula, idProvinciaEstado, fechaContratacion, nombreEmpleadoLogin, primerNombre, segundoNombre, primerApellido, segundoApellido, correoElectronico, idGenero, fechaNacimiento, idDepartamento)
values(201547896, 15, '2019-10-15', 'ssmith', 'Sam', 'Frederick', 'Smith', 'Carter', 'ssmith@tec.cr', 03, '1992-05-19', 2)

-- bitacoraRegistroAuditoria
insert into bitacoraRegistroAuditoria(idTipoRegistroAuditoria, idEmpleado, fechaHora, detalle)
values(1, 5, '04:20', 'Nuevo proveedor registrado')
insert into bitacoraRegistroAuditoria(idTipoRegistroAuditoria, idEmpleado, fechaHora, detalle)
values(2, 4, '05:30', 'Cantidad m�nima superada')
insert into bitacoraRegistroAuditoria(idTipoRegistroAuditoria, idEmpleado, fechaHora, detalle)
values(3, 3, '06:40', 'Creaci�n de una nueva orden')
insert into bitacoraRegistroAuditoria(idTipoRegistroAuditoria, idEmpleado, fechaHora, detalle)
values(4, 2, '07:50', 'Aplicaci�n de un cup�n')
insert into bitacoraRegistroAuditoria(idTipoRegistroAuditoria, idEmpleado, fechaHora, detalle)
values(5, 1, '08:35', 'Creaci�n de un cup�n')

-- contactoDeEmegencia
insert into contactoDeEmergencia(idContactoEmergencia, primerNombre, primerApellido, telefono, idParentesco, idEmpleado, idGenero)
values (125478963, 'Jose', 'Osorio', 70589632, 5, 1, 02)
insert into contactoDeEmergencia(idContactoEmergencia, primerNombre, primerApellido, telefono, idParentesco, idEmpleado, idGenero)
values (125470369, 'Benito', 'Mart�nez', 84579658, 4, 2, 02)
insert into contactoDeEmergencia(idContactoEmergencia, primerNombre, primerApellido, telefono, idParentesco, idEmpleado, idGenero)
values (201563489, 'Carolina', 'Osorio', 80236587, 3, 3, 01)
insert into contactoDeEmergencia(idContactoEmergencia, primerNombre, primerApellido, telefono, idParentesco, idEmpleado, idGenero)
values (325698741, 'Kevin', 'D�az', 88568974, 2, 4, 02)
insert into contactoDeEmergencia(idContactoEmergencia, primerNombre, primerApellido, telefono, idParentesco, idEmpleado, idGenero)
values (354896521, 'Alexa', 'Rojas', 70253698, 1, 5, 01)

-- ordenDeCompra
insert into ordenDeCompra(fecha, cedulaCliente, montoTotal, idEstado, idCuponDescuento, fechaAplicacionCupon, montoDescuento)
values('2018-02-14', 117800471, 70, 6, 1, '2018-02-14', 25)
insert into ordenDeCompra(fecha, cedulaCliente, montoTotal, idEstado, idCuponDescuento, fechaAplicacionCupon, montoDescuento)
values('2017-01-13', 215873698, 100, 5, 2, '2017-01-13', 20)
insert into ordenDeCompra(fecha, cedulaCliente, montoTotal, idEstado, idCuponDescuento, fechaAplicacionCupon, montoDescuento)
values('2016-12-12', 485697125, 95, 4, 3, '2016-12-12', 35)
insert into ordenDeCompra(fecha, cedulaCliente, montoTotal, idEstado, idCuponDescuento, fechaAplicacionCupon, montoDescuento)
values('2015-11-11', 548796321, 80, 3, 4, '2015-11-11', 30)
insert into ordenDeCompra(fecha, cedulaCliente, montoTotal, idEstado, idCuponDescuento, fechaAplicacionCupon, montoDescuento)
values('2014-10-10', 569823144, 85, 2, 5, '2014-10-10', 45)
insert into ordenDeCompra(fecha, cedulaCliente, montoTotal, idEstado, idCuponDescuento, fechaAplicacionCupon, montoDescuento)
values('2019-03-15', 578961454, 75, 1, 4, '2019-03-15', 40)
insert into ordenDeCompra(fecha, cedulaCliente, montoTotal, idEstado, idCuponDescuento, fechaAplicacionCupon, montoDescuento)
values('2020-04-16', 654782143, 105, 2, 3, '2020-04-16', 55)
insert into ordenDeCompra(fecha, cedulaCliente, montoTotal, idEstado, idCuponDescuento, fechaAplicacionCupon, montoDescuento)
values('2021-05-17', 789632541, 200, 3, 2, '2021-05-17', 50)
insert into ordenDeCompra(fecha, cedulaCliente, montoTotal, idEstado, idCuponDescuento, fechaAplicacionCupon, montoDescuento)
values('2022-06-15', 869745328, 250, 4, 1, '2022-06-15', 65)
insert into ordenDeCompra(fecha, cedulaCliente, montoTotal, idEstado, idCuponDescuento, fechaAplicacionCupon, montoDescuento)
values('2018-08-22', 896541237, 150, 5, 2, '2018-08-22', 60)

-- proveedor
insert into proveedor(nombreCompannia, telefono, idProvinciaEstado, estaActivo)
values('El Sue�o SA', 22578965, 15, 'si')
insert into proveedor(nombreCompannia, telefono, idProvinciaEstado, estaActivo)
values('El Camino SA', 22589632, 14, 'si')
insert into proveedor(nombreCompannia, telefono, idProvinciaEstado, estaActivo)
values('Alpa SA', 22364789, 13, 'no')
insert into proveedor(nombreCompannia, telefono, idProvinciaEstado, estaActivo)
values('La Europea SA', 22675631, 12, 'si')
insert into proveedor(nombreCompannia, telefono, idProvinciaEstado, estaActivo)
values('Malvados y Asociados', 220135587, 11, 'si')

-- producto 
insert into producto(nombre, idProveedor, precioUnitario, estaDescontinuado)
values('bombillos', 3, 12.05, 'no')
insert into producto(nombre, idProveedor, precioUnitario, estaDescontinuado)
values('bombillos', 3, 12.05, 'no')

--Funcion #1
go
create function productoMasVendido(@fechaInicio date,@fechaFin date)
	returns table as 
	return
	select top(1) idProducto from 
	(select producto.idProducto,cantidad from producto
	join 
	item on producto.idProducto=item.idProducto
	inner join 
	ordenDeCompra on item.idOrden=ordenDeCompra.idOrden where ordenDeCompra.fecha>=@fechaInicio and ordenDeCompra.fecha<=@fechaFin
	) as productosVendidos
	order by
	productosVendidos.cantidad;
go

--Funcion 2
go
create  function descuentoAplicado(@idCupon int,@idOrden int)
	returns money as
		begin
		declare @montoDescuento money;
		declare @montoMinimo money;
		declare @montoCompra money;
		declare @porcentaje float;
		set @montoMinimo = (select montoMinimoCompra from cuponDescuento where idCuponDescuento=@idCupon);
		set @montoCompra = (select montoTotal from ordenDeCompra where idOrden=@idOrden);

		if @montoMinimo>@montoCompra
			set @montoDescuento = 0;
		else
			set @porcentaje = (select porcentajeDescuento from cuponDescuento where idCuponDescuento=@idCupon);
			set @montoDescuento = @montoCompra*@porcentaje;
		return @montoDescuento;
		end
go

--Funcion #3
go
create function promedioCompras(@idCliente int, @mes int, @a�o int)
	returns int as
		begin
		declare @promedioCompras int;
		select @promedioCompras = avg(montoCompras) from 
		(
		select montoTotal as montoCompras
		from ordenDeCompra
		where 
		cedulacliente=@idCliente 
		and 
		datepart(month,fecha)=@mes
		and
		datepart(year,fecha)=@a�o
		) as comprasCliente
		return @promedioCompras
		end
go

go



--Procedimiento #4
go
create procedure ingresarCupon(@id int,@idEstado int,@tipocliente varchar(50),
						@montoMinimo money,@fechaInicio date,@fechaExpiracion date,@porcentaje float,@detalle varchar(50))
	as begin
	insert into cuponDescuento values(@id,@idEstado,@tipocliente,@montoMinimo,@fechaInicio,@fechaExpiracion,@porcentaje,@detalle);
	declare @correoClientes table (emails varchar(50))
	insert into @correoClientes (emails) select email from cliente;
	declare @cantidadCorreos int;
	declare @correoRecipiente varchar(50);
	select @cantidadCorreos = count(email) from cliente;
	while @cantidadCorreos>0
		begin
			begin try
			set @correoRecipiente = (select top(1) emails from @correoClientes);
			select @correoRecipiente;
			EXEC msdb.dbo.sp_send_dbmail
			@profile_name = 'Notifications',
			@recipients = @correoRecipiente,
			@body = 'Estimado usuario, un nuevo cupon de descuento est� disponible',
			@subject = 'Aviso de nuevo cupon de descuento';
			end try
			begin catch
			select ERROR_MESSAGE();
			end catch
		--enviar correo
		delete top(1) from @correoClientes;
		set @cantidadCorreos=@cantidadCorreos-1;
		end
	end
go

--Procedimiento #5
go
create procedure informacionCupones(@idOrden int, @fechaInicio date, @fechaFin date)
	as begin
	select A.*,B.estado,(C.montoTotal*A.porcentajeDescuento) as montoDescuentoAplicado from cuponDescuento A inner join estado B
								on A.idEstado=B.idEstado,ordenDeCompra C
								where fechaInicioVigencia>=@fechaInicio
								and fechaFinVigencia<=@fechaFin
								and estado='Disponible'
								and C.idOrden=@idOrden;
	end
go

--Procedimiento #6
go
create procedure aplicarCupon(@idOrden int,@idCupon int)
	as begin
		if (select idCuponDescuento from ordenDeCompra where idCuponDescuento=@idCupon) = @idCupon
			select 'Cupon ya utilizado'
		else
			if (select estado from cuponDescuento A join estado B on A.idEstado=B.idEstado where A.idCuponDescuento=@idCupon)='Disponible'
				update ordenDeCompra set idCuponDescuento=@idCupon,montoDescuento = dbo.descuentoAplicado(@idCupon,@idOrden),fechaAplicacionDescuento=CONVERT(VARCHAR(10), getdate(), 111)
					where idOrden=@idOrden;
			else
				select 'Cupon no v�lido'
	end
go

--Procedimiento #7
go
create procedure ingresarProducto(@idProducto int,
									@idProveedor int,
									@nombre varchar(25),
									@precioUnitario money,
									@idEstado int,
									@cantidadD int,
									@cantidadM int,
									@fechaIngreso date)
as begin
	insert into producto values(@idProducto,@nombre,@precioUnitario,@idEstado,@idProveedor);
	insert into inventario values(@idProducto,@fechaIngreso,@cantidadD,@cantidadM);
end
go

--TRIGGERS

--8
create trigger cantidadProducto on inventario
after update
as begin
if (select cantidadDisponible from inserted)<(select cantidadMinimaDisponible from inserted)
begin
	EXEC msdb.dbo.sp_send_dbmail
     @profile_name = 'Notifications',
     @recipients = 'cata506@gmail.com',
     @body = 'La cantidad disponible del producto es menor a la cantidad minima disponible.',
     @subject = 'Compras Inventario';
end
end
GO

--9
create trigger ordenCancelada on ordenDeCompra
after update
as begin
if (select idEstado from inserted)=3
	begin
	set nocount on;
	insert into ordenCompraCancelada(idOrden, fechaCancelacion, explicacionCliente)
	select i.idOrden, GETDATE(), 'orden cancelada por motivos personales' from inserted as i;
	EXEC msdb.dbo.sp_send_dbmail
     @profile_name = 'Notifications',
     @recipients = 'cata506@gmail.com',
     @body = 'Orden de compra cancelada, realizar seguimiento respectivo.',
     @subject = 'Orden Cancelada';
	end 
end
GO

--10 
create trigger registroAuditoria on proveedor
	after insert,delete 
	as begin
	if exists (select 1 from inserted) and not exists (select 1 from deleted)
		begin
		declare @insercionAuditoria int set @insercionAuditoria = (select idTipoRegistro from tipoRegistro where tipo =  'proveedorCreado')
		insert into BitacoraRegistroAuditoria values ('',5, getdate(), @insercionAuditoria ) 
		set nocount on;
		end

	else if not exists (select 1 from inserted) and exists (select 1 from deleted)
		begin
		declare @eliminarAuditoria int set @eliminarAuditoria = (select idTipoRegistro from tipoRegistro where tipo =  'proveedorDadoDeBaja')
		insert into BitacoraRegistroAuditoria values ('',6, GETDATE(), @eliminarAuditoria ) 
		set nocount on;
		end
end
go


--Vistas

--11
go
create view clientesCompraDescuento as
select cliente.cedula, email, primerNombre, primerApellido, montoTotal as precioOrden, montoDescuento,(montoTotal-montoDescuento) as totalPagar from cliente, persona, ordenDeCompra where cliente.cedula = persona.cedula and 
ordenDeCompra.cedulacliente = cliente.cedula and idCuponDescuento is not null;
go

--12
go
create view ordenesCanceladas as
select cedulaCliente,ordenCompraCancelada.idOrden, ordenCompraCancelada.fechaCancelacion, ordenCompraCancelada.explicacionCliente from ordenCompraCancelada, ordenDeCompra 
where ordenDeCompra.idOrden= ordenCompraCancelada.idOrden group by cedulacliente,ordenCompraCancelada.idOrden,ordenCompraCancelada.fechaCancelacion, ordenCompraCancelada.explicacionCliente;
go

--13
go
create view detalleProductos as
select producto.idProducto, producto.idProveedor, producto.idEstado, producto.nombre, producto.precioUnitario from producto, item 
where producto.idProducto not in(select idProducto from item);
go
--INDICES
CREATE NONCLUSTERED INDEX indiceCliente ON cliente (email);

CREATE NONCLUSTERED INDEX indiceProducto ON producto (nombre);

CREATE NONCLUSTERED INDEX indiceItem ON item (monto);

CREATE NONCLUSTERED INDEX indiceOrdenDeCompra ON ordenDeCompra (idCuponDescuento,fecha);

CREATE NONCLUSTERED INDEX indiceProveedor ON proveedor (nombreCompa�ia);

CREATE NONCLUSTERED INDEX indiceEmpleado ON empleado (nombreEmpleadoLogin);

CREATE NONCLUSTERED INDEX indiceDepartamento ON departamento (abreviaturaDepartamento);
























