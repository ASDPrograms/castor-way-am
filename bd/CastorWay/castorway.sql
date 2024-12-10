drop database if exists castorway;
create database castorway;

use castorway;

drop table if exists Castor;
create table Castor(
idCastor int primary key auto_increment,
codPresa varchar(12),
nombre varchar (100),
apellidos varchar (100),
edad int (3),
email varchar(50),
contraseña varchar(100),
ramitas int(10) default 0,
imagenPerfil varchar (100) default "../img/icono_Perfil_1.svg",
fechaRegistro datetime DEFAULT CURRENT_TIMESTAMP
);
ALTER TABLE Castor ADD INDEX (codPresa);

create table Kit(
idKit int primary key auto_increment,
codPresa varchar (12), 
nombreUsuario varchar (50),
nombre varchar (50),
apellidos varchar(50),
edad int(3),
etapaVida varchar (50),
ramitas int(10) default 0,
imagenPerfil varchar (100) default "../img/icono_Perfil_1.svg",
fechaRegistro datetime DEFAULT CURRENT_TIMESTAMP,
hojasCongeladas int(10) default 0
);
ALTER TABLE Kit
ADD CONSTRAINT codPresa
FOREIGN KEY (codPresa)
REFERENCES Castor(codPresa);


drop table if exists relKitCastor;
create table relKitCastor(
    idrelKitCastor int auto_increment primary key,
    codPresa varchar(12),
    idKit int,
    foreign key(idKit) references Kit(idKit),
    idCastor int,
    foreign key(idCastor) references Castor(idCastor)
);

create table relAct(
idRelAct int auto_increment primary key,
idKit int,
foreign key(idKit) references Kit(idKit),
idCastor int,
foreign key(idCastor) references Castor(idCastor)
);


drop table if exists Actividad;
create table Actividad(
idActividad int auto_increment primary key,
idKit int,
foreign key(idKit) references Kit(idKit),
idCastor int,
foreign key(idCastor) references Castor(idCastor),
nombreHabito varchar (100),
tipoHabito varchar(20),
numRamitas varchar(20),
repeticiones varchar(700),
diaInicioHabito date,
diaMetaHabito date,
horaInicioHabito time,
horaFinHabito time,
color varchar (30),
rutaImagenHabito varchar(255),
recordatorio varchar (20),
infoExtraHabito varchar (800),
estadoActividad INT DEFAULT 0,
infoActividadDevuelta varchar (350) default null, 
fechasActividad text,
fechasCompletadas text,
diasCompletados int
);





DROP TABLE IF EXISTS premios;
CREATE TABLE premios (
    idPremio INT AUTO_INCREMENT PRIMARY KEY,
    idCastor INT,
    nombrePremio VARCHAR(50),
    nivelPremio VARCHAR(50),
    categoriaPremio VARCHAR(50),
    tipoPremio VARCHAR(50),
    costoPremio INT,
    infoExtraPremio VARCHAR(350),
    estadoPremio INT DEFAULT 0,
    Favorito INT DEFAULT 0,
    rutaImagenHabito VARCHAR(255),
    FOREIGN KEY (idCastor) REFERENCES Castor(idCastor)
);

DROP TABLE IF EXISTS relPrem;
CREATE TABLE relPrem (
    idRelPrem INT AUTO_INCREMENT PRIMARY KEY,
    idKit INT,
    idCastor INT,
    idPremio INT,
    FOREIGN KEY (idKit) REFERENCES Kit(idKit),
    FOREIGN KEY (idCastor) REFERENCES Castor(idCastor),
    FOREIGN KEY (idPremio) REFERENCES premios(idPremio)
);



create table relDiario(
idRelDiario int auto_increment primary key,
idKit int,
foreign key(idKit) references Kit(idKit),
idCastor int,
foreign key(idCastor) references Castor(idCastor)
);

drop table if exists diario;
create table diario(
idDiario int auto_increment primary key,
idKit int,
foreign key (idKit) references Kit(idKit), 
titulo varchar (50),
info text,
imgPrivacidad varchar (50),
privacidad int,
imgSentimiento varchar (50),
diaCreacion datetime DEFAULT CURRENT_TIMESTAMP
);

drop table if exists notasBorradas;
CREATE TABLE notasBorradas (
    idDiario INT AUTO_INCREMENT PRIMARY KEY,
    idKit INT,
    titulo VARCHAR(50),
    info VARCHAR(700),
    imgPrivacidad VARCHAR(50),
    privacidad INT,
    imgSentimiento VARCHAR(50),
    diaCreacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    diaBorrado DATETIME DEFAULT CURRENT_TIMESTAMP
);

drop table if exists Chat;
create table Chat(
	idChat int auto_increment primary key, 
    idKit int, 
    foreign key(idKit) references Kit(idKit),
    idCastor int,
    foreign key(idCastor) references Castor(idCastor),
    contenido Text not null,
    emisor enum('Tutor', 'Kit'),
    fechaEnvio TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);



show tables;

select * from actividad;
select * from Castor;
select * from diario;
select * from notasBorradas;
select * from Kit;
select * from relKitCastor;
select * from premios;
select * from relact;
select * from reldiario;
select * from relprem;
select * from chat;


INSERT INTO Castor (codPresa, nombre, apellidos, edad, email, contraseña, ramitas, imagenPerfil)
VALUES 
('P00123456789', 'Castor1', 'Gómez', 5, 'castor1@example.com', 'contraseña1', 10, 'imagenes/castor1.jpg'),
('P00223456789', 'Castor2', 'López', 3, 'castor2@example.com', 'contraseña2', 15, 'imagenes/castor2.jpg'),
('P00312345678', 'Castor3', 'Martínez', 4, 'castor3@example.com', 'contraseña3', 20, 'imagenes/castor3.jpg'),
('P00412345678', 'Castor4', 'Fernández', 6, 'castor4@example.com', 'contraseña4', 25, 'imagenes/castor4.jpg'),
('P00512345678', 'Castor5', 'Sánchez', 2, 'castor5@example.com', 'contraseña5', 30, 'imagenes/castor5.jpg');

INSERT INTO Kit (codPresa, nombreUsuario, nombre, apellidos, edad, etapaVida, ramitas, imagenPerfil)
VALUES 
('P00123456789', 'usuario1', 'Juañ', 'Pérez', 5, 'Juvenil', 10, 'imagenes/kit1.jpg'),
('P00223456789', 'usuario2', 'Ana', 'García', 3, 'Crias', 15, 'imagenes/kit2.jpg'),
('P00312345678', 'usuario3', 'Luis', 'Hernández', 4, 'Juvenil', 20, 'imagenes/kit3.jpg'),
('P00412345678', 'usuario4', 'María', 'Lopez', 6, 'Adulto', 25, 'imagenes/kit4.jpg'),
('P00512345678', 'usuario5', 'Carlos', 'Martínez', 2, 'Crias', 30, 'imagenes/kit5.jpg');


-- INSERT INTO Actividad (idKit, idCastor, nombreHabito, tipoHabito, numRamitas, repeticiones, diaInicioHabito, diaMetaHabito, horaInicioHabito, horaFinHabito, color, rutaImagenHabito, diaSemana, recordatorio, infoExtraHabito) 
-- VALUES 
-- (7,6,'Pruebita 2', 'Salud', '5', '5', NOW(), '2024-10-20', '07:00:00', '08:00:00', 'Verde', 'ruta/a/imagen.png', 'Lunes', 'Recordatorio diario', 'Comenzar el día con energía'),
-- (7,6,'Pruebita no más 2', 'Salud', '5', '5', NOW(), '2024-10-16', '07:00:00', '08:00:00', 'Verde', 'ruta/a/imagen.png', 'Lunes', 'Recordatorio diario', 'Comenzar el día con energía'),
-- (7,6,'Pruebita no másx2 2', 'Salud', '5', '5', NOW(), '2024-10-16', '07:00:00', '08:00:00', 'Verde', 'ruta/a/imagen.png', 'Lunes', 'Recordatorio diario', 'Comenzar el día con energía'),
-- (7,6,'ahiquedóñ sjjss 2', 'Salud', '5', '5', NOW(), '2024-10-12', '07:00:00', '08:00:00', 'Verde', 'ruta/a/imagen.png', 'Lunes', 'Recordatorio diario', 'Comenzar el día con energía');