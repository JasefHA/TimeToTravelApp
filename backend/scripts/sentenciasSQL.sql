-- create DATABASE TimeToTravelApp
-- use TimeToTravelApp
-- use UserRecord


CREATE TABLE t_Estado(
	idEstado int IDENTITY NOT NULL,
	estado varchar(20) NOT NULL,
	CONSTRAINT PK_t_Estado PRIMARY KEY(idEstado)
)
CREATE TABLE t_Rol(
	idRol int IDENTITY NOT NULL,
	rol varchar(20) NOT NULL,
	CONSTRAINT PK_t_Rol PRIMARY KEY(idRol)
)
CREATE TABLE t_Google(
	idGoogle int IDENTITY NOT NULL,
	google varchar(20) NOT NULL,
	CONSTRAINT PK_t_Google PRIMARY KEY(idGoogle)
)
CREATE TABLE t_Usuario(
	idUsuario int IDENTITY NOT NULL,
	nombre varchar(50) NOT NULL,
	apellido varchar(50) NULL,
	email varchar(30) NOT NULL,
	pass varchar(30) NOT NULL,
	imagen varchar(200) NOT NULL,
	idEstado int NOT NULL,
	idRol int NOT NULL,
	idGoogle int NOT NULL,
	CONSTRAINT PK_t_Usuario PRIMARY KEY(idUsuario),
	CONSTRAINT FK_t_Estado FOREIGN KEY(idEstado) REFERENCES t_estado(idEstado),
	CONSTRAINT FK_t_Rol FOREIGN KEY(idRol) REFERENCES t_Rol(idRol),
	CONSTRAINT FK_t_Google FOREIGN KEY(idGoogle) REFERENCES t_Google(idGoogle),
)

INSERT INTO t_Estado(estado)VALUES ('ACTIVO'),('NO ACTIVO')
INSERT INTO t_Rol (rol)VALUES ('ROL_ADMIN'),('ROL_DEV'),('ROL_USUARIO'),('ROL_INVITADO')
INSERT INTO t_Google (google)VALUES ('ACTIVO'),('NO ACTIVO')

INSERT INTO t_Usuario (nombre,apellido,email,pass,imagen,idEstado,idRol,idGoogle)
					VALUES ('Leandro','Araoz','test1@test.com','123456','default',1,1,2),
								 ('Jean Pierre','Inca','test2@test.com','123456','default',1,1,2),
								 ('Renzo','Adrianzen','test3@test.com','123456','default',1,1,2),
								 ('Jasef','Huachambe','test4@test.com','123456','default',1,1,2),
								 ('Fernando','Lazo Barturen','test5@test.com','123456','default',1,1,2),
								 ('test6','test6','test6@test.com','123456','default',1,1,2),
								 ('test7','test7','test7@test.com','123456','default',1,1,2),
								 ('test8','test8','test8@test.com','123456','default',1,1,2),
								 ('test9','test9','test9@test.com','123456','default',1,1,2),
								 ('test10','test10','test10@test.com','123456','default',1,1,2),
								 ('test11','test11','test11@test.com','123456','default',1,1,2),
								 ('test12','test12','test12@test.com','123456','default',1,1,2),
								 ('test13','test13','test13@test.com','123456','default',1,1,2),
								 ('test14','test14','test14@test.com','123456','default',1,1,2),
								 ('test15','test15','test15@test.com','123456','default',1,1,2),
								 ('test16','test16','test16@test.com','123456','default',1,1,2),
								 ('test17','test17','test17@test.com','123456','default',1,1,2)