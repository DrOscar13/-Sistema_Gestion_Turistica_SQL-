------SQL

USE OBLIGATORIO_2024


---- Consluta 1
-- Listar el o los nombres de los pasajeros con la mayor cantidad de pasajes comprados a su nombre

SELECT Nombre, Apellido, COUNT(IdPasaje) AS CantidadPasajes
FROM TURISTA AS T
JOIN PASAJE AS P ON T.IdTurista = P.IdTurista
GROUP BY Nombre, Apellido
HAVING COUNT(IdPasaje) = (
    SELECT MAX(PasajesTotales)
    FROM (
        SELECT COUNT(IdPasaje) AS PasajesTotales
        FROM PASAJE
        GROUP BY IdTurista
    ) AS PasajesPorTurista
);

----Consulta 2
--Listar todos los datos de los buses con más de 35 asientos que no tengan asignado ningún destino que parta el día de mañana.

SELECT *
FROM BUSES B
JOIN DESTINO D ON B.IdBus = D.IdDestino
WHERE B.CantidadAsiento > 35
  AND (D.FechaHoraSalida < CAST(DATEADD(DAY, 1, CAST(GETDATE() AS DATE)) AS DATETIME) -- Inicio de mañana (00:00:00)
  or D.FechaHoraSalida > CAST(DATEADD(DAY, 2, CAST(GETDATE() AS DATE)) AS DATETIME)); -- Fin de mañana (23:59:59)

-----Consulta 3
-- Listar todos los datos de los pasajeros para los cuales haya registrados en el sistema más de 5 pasajes comprados.

SELECT T.*
FROM TURISTA T
JOIN PASAJE P ON T.IdTurista = P.IdTurista
GROUP BY T.IdTurista, T.Nombre, T.Apellido, T.Documento, T.FechaNacimiento, T.Correo, T.Telefono, T.Contraseña
HAVING COUNT(P.IdPasaje) > 5;

-----Consulta 4
-- Listar idpasajero, nombre, apellidos y asiento (idasiento y fila) que correspondan a pasajes comprados para el destino cuyo idviaje es 255

SELECT T.IdTurista as idPasajero , T.Nombre, T.Apellido, P.Letra, P.Fila
FROM TURISTA T
JOIN PASAJE P ON T.IdTurista = P.IdTurista
WHERE P.IdDestino = 255;

----- Consulta 5
--Listar todos los idviaje y cantidad de pasajes comprados durante el mes de Setiembre de
--este año para c/u de los destinos del pasajero cuyo correo es soyturista@gmail.com
--La lista debe estar ordenada por idviaje ascendente.

SELECT P.IdDestino AS IdViaje, COUNT(P.IdPasaje) AS CantidadPasajes
FROM PASAJE P
JOIN TURISTA T ON P.IdTurista = T.IdTurista
WHERE T.Correo = 'soyturista@gmail.com'
AND MONTH(P.FechaDeCompra) = 9
AND YEAR(P.FechaDeCompra) = 2024
GROUP BY P.IdDestino
ORDER BY IdViaje ASC;


