--------------
-----DDL-----

create database OBLIGATORIO_2024
USE OBLIGATORIO_2024

DROP TABLE  PASAJE;
DROP TABLE  MERCOSUR;
DROP TABLE TURISTA;
DROP TABLE  ASIENTO;
DROP TABLE BUSES;
DROP TABLE  TERMINAL;
DROP TABLE  DESTINO;
DROP TABLE  DEPARTAMENTO;

create table TURISTA (
	IdTurista int PRIMARY KEY,
	Nombre varchar(20),
	Apellido varchar(20),
	Documento varchar(20),
	FechaNacimiento DateTime,
	Correo varchar (50) unique,
	Telefono varchar(20),
	Contraseña varchar (20),
	);

CREATE TABLE MERCOSUR (
    IdTurista INT PRIMARY KEY,
    Nombre VARCHAR(20),
    Apellido VARCHAR(20),
    Documento INT,
    FechaNacimiento DATETIME,
    Correo VARCHAR(50),
    Telefono INT,
    Contraseña VARCHAR(20),
    Bonificacion varchar (100),
    FOREIGN KEY (IdTurista) REFERENCES TURISTA(IdTurista)
);


	
CREATE TABLE TERMINAL (
    IdTerminal Int PRIMARY KEY,
    Nombre VARCHAR(20)
);


	CREATE TABLE DESTINO (
    IdDestino INT PRIMARY KEY,
    FechaHoraSalida DATETIME,
    ImporteViaje INT,
    TerminalDestino INT,
    TerminalOrigen INT,
    DuracionAprox INT,
    InformacionGeneral VARCHAR(1000),
    FOREIGN KEY (TerminalDestino) REFERENCES TERMINAL(IdTerminal),
    FOREIGN KEY (TerminalOrigen) REFERENCES TERMINAL(IdTerminal),
	CHECK (TerminalDestino <> TerminalOrigen)
);

create table BUSES (
	IdBus int,
	MarcaYtipo varchar (50),
	CantidadAsiento int CHECK (CantidadAsiento BETWEEN 10 AND 40),
	primary key (IdBus),
);

	create table ASIENTO (
	Letra varchar (1),
	Fila int,
	idBus int,
	primary key (Letra, Fila,IdBus),
	foreign key (IdBus) references BUSES(IdBus)
);

create table PASAJE (
	IdPasaje int,
	Utilizado bit default 0,
	FechaDeCompra DateTime,
	primary key (IdPasaje),
	IdDestino int,
	Letra varchar (1),
	Fila int,
	IdTurista int,
	IdBus int,
	foreign key (Letra,Fila,idBus) references ASIENTO (Letra,Fila,IdBus),
	foreign key (IdDestino) references DESTINO (IdDestino),
	foreign key (IdTurista) references TURISTA(IdTurista),
);

create table DEPARTAMENTO (
	IdDepartamento int,
	Nombre varchar(20),
	IdTerminal int,
	primary key (IdDepartamento),
	foreign key (IdTerminal) references TERMINAL (IdTerminal)
);

