-- use TimeToTravelApp
CREATE PROC SP_GET_USUARIOS(
													@limite int = 5,
													@desde int = 0
)
AS
set nocount on

if exists(select * from t_Usuario where idEstado=1)
begin

	DECLARE @hasta int
	SET @hasta = (SELECT TOP (1) idUsuario FROM t_Usuario ORDER BY idUsuario DESC)

	SELECT TOP (@limite)
	U.idUsuario as 'id',U.nombre,U.apellido,U.email,U.imagen,E.estado,R.rol ,G.google
	FROM t_Usuario U
	INNER JOIN t_Estado E
	ON E.idEstado =U.idEstado 
	INNER JOIN t_Rol R
	ON R.idRol =U.idRol
	INNER JOIN t_Google G
	ON G.idGoogle =U.idGoogle
	WHERE U.idEstado=1 and U.idUsuario BETWEEN @desde AND @hasta

end
-- exec SP_GET_USUARIOS 10,10

go

CREATE PROC SP_GET_USUARIO_x_ID_EMAIL(
													@idEmail varchar(50)=''
)
AS
set nocount on
begin try
	DECLARE @id int
	if exists(select * from t_Usuario where email = @idEmail and idEstado=1)
	begin
		SET @id = (SELECT TOP (1) idUsuario FROM t_Usuario where email = @idEmail and idEstado=1)
	end
	ELSE
	BEGIN
		if exists(select * from t_Usuario where idUsuario = @idEmail and idEstado=1)
		begin
			SET @id = cast(@idEmail as int)
		END
	END
	SELECT U.idUsuario as 'id',U.nombre,U.apellido,U.email,U.imagen,E.estado,R.rol ,G.google
	FROM t_Usuario U
	INNER JOIN t_Estado E
	ON E.idEstado =U.idEstado 
	INNER JOIN t_Rol R
	ON R.idRol =U.idRol
	INNER JOIN t_Google G
	ON G.idGoogle =U.idGoogle
	WHERE U.idEstado=1 and U.idUsuario =@id

end try
begin catch

end catch
-- exec SP_GET_USUARIO_x_ID_EMAIL 'test1@test.com'
-- exec SP_GET_USUARIO_x_ID_EMAIL 'tedsfrgthst1@test.com'
-- exec SP_GET_USUARIO_x_ID_EMAIL dfgkjnsdlakjfgreag

go

CREATE PROC SP_GET_ROL (
										@rol varchar(100) = ''
										)
AS
set nocount on

if exists(select * from t_Rol where rol = @rol)
begin

	select top (1) idRol	from t_Rol
	WHERE rol = @rol

end

	-- exec SP_GET_ROL 'ROL_ADMIN'

go

/*
CREATE PROC SP_GET_ESTADO (
										@estado varchar(100) = ''
										)
AS
set nocount on

if exists(select * from t_Estado where estado = @estado)
begin

	select top (1) idEstado	from t_Estado
	WHERE estado = @estado

end

	-- exec SP_GET_ESTADO 'activo'

go

CREATE PROC SP_GET_GOOGLE (
										@google varchar(100) = ''
										)
AS
set nocount on

if exists(select * from t_Google where google = @google)
begin

	select top (1) idGoogle	from t_Google
	WHERE google = @google

end

	-- exec SP_GET_GOOGLE 'activo'

go

*/

CREATE PROC SP_POST_USUARIO(
										@nombre varchar(50),
										@apellido varchar(50),
										@email varchar(50),
										@pass varchar(100),
										@imagen varchar(100)='default',
										@rol varchar(50) ='ROL_USUARIO',
										@google varchar(50)='NO ACTIVO'
									)
AS
set nocount on


if not exists(select * from t_Usuario where email=@email and idEstado=1)
begin
	DECLARE		@elRol int,
						@cuentaGoogle int
	if exists(select TOP (1) idRol from t_Rol where	rol = @rol)
	begin

		if exists(select TOP (1) idGoogle from t_Google where	google = @google)
		begin

			SET @elRol = (select TOP (1) idRol from t_Rol where	rol = @rol)
			SET @cuentaGoogle = (select TOP (1) idGoogle from t_Google where	google = @google)
			insert into t_Usuario(nombre,apellido,email,pass,imagen,idRol,idEstado,idGoogle)
			values (@nombre,@apellido,@email,@pass,@imagen,@elRol,1,@cuentaGoogle)
	
			declare @UltimoId int
			set @UltimoId = @@IDENTITY

			exec SP_GET_USUARIO_x_ID_EMAIL @UltimoId
			--exec SP_GET_USUARIOS_x_ID 7
		end
	end
end
-- exec SP_POST_USUARIO 'test12','test12','test12@test.com','123456','aca','ROL_USUARIO','NO ACTIVO'

go

CREATE PROC SP_PUT_USUARIO_x_ID_EMAIL(
										@idEmail varchar(50)='',
										@nombre varchar(50),
										@apellido varchar(50),
										@email varchar(50),
										@pass varchar(200),
										@imagen varchar(80),
										@rol varchar(80),
										@estado varchar(80),
										@google varchar(80)
									)
AS
set nocount on

begin try
	DECLARE @id int
	if exists(select * from t_Usuario where email = @idEmail and idEstado=1)
	begin
		SET @id = (SELECT TOP (1) idUsuario FROM t_Usuario where email = @idEmail and idEstado=1)
	end
	ELSE
	BEGIN
		if exists(select * from t_Usuario where idUsuario = @idEmail and idEstado=1)
		begin
			SET @id = cast(@idEmail as int)
		END
	END
	DECLARE		@elRol int,
						@elEstado INT,
						@cuentaGoogle int

	SET @elRol = (select TOP (1) idRol from t_Rol where	rol = @rol)
	SET @elEstado = (select TOP (1) idEstado	from t_Estado where	estado = @estado)
	SET @cuentaGoogle = (select TOP (1) idGoogle from t_Google where	google = @google)

	UPDATE t_Usuario SET nombre =@nombre,
											 apellido=@apellido,
											 email=@email,
											 pass=@pass,
											 imagen=@imagen,
											 idRol=@elRol,
											 idEstado=@elEstado,
											 idgoogle=@cuentaGoogle
	WHERE idUsuario = @id

	exec SP_GET_USUARIO_x_ID_EMAIL @id

end try
begin catch

end catch

--exec SP_PUT_ACTUALIZAR_USUARIO 16,'odi','odi','test12@test.com','123456','default','ROL_USUARIO','ACTIVO','NO ACTIVO'


go

CREATE PROC SP_DELETE_USUARIO_x_ID_EMAIL(
															@idEmail varchar(50)=''
														)
AS
set nocount on

begin try
	DECLARE @id int
	if exists(select * from t_Usuario where email = @idEmail and idEstado=1)
	begin
		SET @id = (SELECT TOP (1) idUsuario FROM t_Usuario where email = @idEmail and idEstado=1)
	end
	ELSE
	BEGIN
		if exists(select * from t_Usuario where idUsuario = @idEmail and idEstado=1)
		begin
			SET @id = cast(@idEmail as int)
		END
	END
	exec SP_GET_USUARIO_x_ID_EMAIL @id
	UPDATE t_Usuario SET idEstado = 2
	WHERE idUsuario = @id

end try
begin catch

end catch

--exec SP_DELETE_USUARIO 16
--exec SP_DELETE_USUARIO 'test17@test.com'

go

CREATE PROC PATCH_SP_PASS_x_ID_EMAIL(
										@idEmail varchar(50)='',
										@pass varchar(200) 
									)
AS
set nocount on

begin try
	DECLARE @id int
	if exists(select * from t_Usuario where email = @idEmail and idEstado=1)
	begin
		SET @id = (SELECT TOP (1) idUsuario FROM t_Usuario where email = @idEmail and idEstado=1)
	end
	ELSE
	BEGIN
		if exists(select * from t_Usuario where idUsuario = @idEmail and idEstado=1)
		begin
			SET @id = cast(@idEmail as int)
		END
	END
	UPDATE t_Usuario SET pass = @pass
	WHERE idUsuario = @id
	exec SP_GET_USUARIO_x_ID_EMAIL @id

end try
begin catch

end catch

	-- exec PATCH_SP_ACTUALIZAR_PASS 1,'123456789'

-- SELECT * FROM t_Usuario
-- SELECT * FROM t_Estado
-- SELECT * FROM t_Rol
-- SELECT * FROM t_Google 