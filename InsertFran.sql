						--Procedimiento-- difenrente forma
--	Implementa un procedimiento almacenado GrabaSencilla que grabe
-- un boleto con una sola apuesta simple. Datos de entrada: El sorteo y los seis números
CREATE PROCEDURE GrabaSencilla
	@IDSorteo SMALLINT
	,@Num1 TINYINT
	,@Num2 TINYINT
	,@Num3 TINYINT
	,@Num4 TINYINT
	,@Num5 TINYINT
	,@Num6 TINYINT
AS
BEGIN

	DECLARE @ReintregoAleatorio TINYINT =ROUND(((8 - 0) * RAND() + 1), 0)
	DECLARE @FechaHoraCreacion SMALLDATETIME=GETDATE()
	DECLARE @ID_Boleto SMALLINT
	BEGIN TRANSACTION	
		INSERT Boletos values(@FechaHoraCreacion,1,@ReintregoAleatorio,@IDSorteo)
		SELECT @ID_Boleto=MAX(ID) FROM Boletos WHERE ID_Sorteo=@IDSorteo

		INSERT Combinaciones values( 1,@Num1,'Simple', @ID_Boleto),
									( 1,@Num2,'Simple', @ID_Boleto),
									( 1,@Num3,'Simple', @ID_Boleto),
									( 1,@Num4,'Simple', @ID_Boleto),
									( 1,@Num5,'Simple', @ID_Boleto),
									( 1,@Num6,'Simple', @ID_Boleto)
	
	COMMIT
END

		--Procedimiento--
--	Implementa un procedimiento GrabaSencillaAleatoria que genere 
-- un boleto con n apuestas sencillas, cuyos números se generarán de forma aleatoria.
-- Entradas: un entero que es el ID del sorteo y otro entero que es el Nº de apuestas a grabar
--AQUI
GO
--CREATE PROCEDURE GrabaSencillaAleatoria 
CREATE PROCEDURE GrabaSencillaAleatorias--Mecla de lo dos
	@IDSorteo SMALLINT
	,@NumApuesta TINYINT
AS
BEGIN
	DECLARE @Num1 TINYINT
	DECLARE @Num2 TINYINT
	DECLARE @Num3 TINYINT
	DECLARE @Num4 TINYINT
	DECLARE @Num5 TINYINT
	DECLARE @Num6 TINYINT
	DECLARE @Sigue BIT 
	
	WHILE(@NumApuesta>0)
	BEGIN
		SET @Sigue=0
		SET @Num1 =ROUND(((49 - 1) * RAND() + 1), 0)
		
		--SET @Num3 =ROUND(((49 - 1) * RAND() + 1), 0)
		--SET @Num4 =ROUND(((49 - 1) * RAND() + 1), 0)
		--SET @Num5 =ROUND(((49 - 1) * RAND() + 1), 0)
		--SET @Num6 =ROUND(((49 - 1) * RAND() + 1), 0)
		WHILE(@Sigue=0)
		BEGIN
			SET @Num2 =ROUND(((49 - 1) * RAND() + 1), 0)
			IF(@Num2 != @Num1)
			BEGIN 
				 SET @Sigue=1
			END
		END
		SET @Sigue=0

		WHILE(@Sigue=0)
		BEGIN
			SET @Num3 =ROUND(((49 - 1) * RAND() + 1), 0)
			IF(@Num3 != @Num1 AND @Num3 != @Num2 )
			BEGIN 
				 SET @Sigue=1
			END
		END
		SET @Sigue=0

		WHILE(@Sigue=0)
		BEGIN
			SET @Num4 =ROUND(((49 - 1) * RAND() + 1), 0)
			IF(@Num4 != @Num1 AND @Num4 != @Num2 AND @Num4 != @Num3 )
			BEGIN 
				 SET @Sigue=1
			END
		END
		SET @Sigue=0

		WHILE(@Sigue=0)
		BEGIN
			SET @Num5 =ROUND(((49 - 1) * RAND() + 1), 0)
			IF(@Num5 != @Num1 AND @Num5 != @Num2 AND @Num5 != @Num3  AND @Num5 != @Num4)
			BEGIN 
				 SET @Sigue=1
			END
		END
		SET @Sigue=0

		WHILE(@Sigue=0)
		BEGIN
			SET @Num6 =ROUND(((49 - 1) * RAND() + 1), 0)
			IF(@Num6 != @Num1 AND @Num6 != @Num2 AND @Num6 != @Num3  AND @Num6 != @Num4 AND @Num6 != @Num5)
			BEGIN 
				 SET @Sigue=1
			END
		END
		
		
		EXEC dbo.GrabaSencilla @IDSorteo, @Num1, @Num2, @Num3, @Num4, @Num5, @Num6
		SET @NumApuesta-=1
	END
END
GO
GO




--INSERT de sorteos

INSERT INTO [dbo].[Sorteos]
          ([FechaHora]
           ,[Abierto]
           ,[Num1]
           ,[Num2]
           ,[Num3]
           ,[Num4]
           ,[Num5]
           ,[Num6]
           ,[Reintegro]
           ,[Complementario])
     VALUES
           ('2017-12-20 20:00:00',1,4,2,3,4,5,6,8,1)
		   
	
--INSERT de Boletos	   
		   --Pruebas
INSERT INTO [dbo].[Boletos]
           ([FechaHora]
           ,[Importe]
           ,[Reintegro]
           ,[ID_Sorteo])
     VALUES
            ('2017-12-20 18:30:00'
           ,1
           ,8
           ,2)
GO
--Procedimiento--
EXEC dbo.GrabaSencilla 1, 14, 15, 28, 6, 42, 6
EXEC dbo.GrabaSencillaAleatoria 1, 9
EXEC dbo.GrabaMuchasSencillas 1, 2 
EXEC GrabaMultiple 1,1,2,3,4,5

select * from Sorteos
Select * from Boletos
Select * from Combinaciones order by ID_Boleto

DELETE FROM [dbo].[Combinaciones]  
DELETE FROM [dbo].[Boletos]

BEGIN TRANSACTION
EXECUTE dbo.GrabaMuchasSencillas 2,100000
EXECUTE dbo.GrabaMuchasSencillas 1,10000
ROLLBACK
COMMIT


DELETE FROM [dbo].[Sorteos]



SET DATEFORMAT ymd --formato de la fecha

