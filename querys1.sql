CREATE DATABASE encuesta;
DROP DATABASE encuesta;

SELECT pg_terminate_backend(pg_stat_activity.pid)
FROM pg_stat_activity
WHERE pg_stat_activity.datname = 'encuesta'
AND pid <> pg_backend_pid();

--Eliminar base de datos

CREATE TABLE modulo_victimizacion(entidad varchar(2),
    viv varchar(5),
    hogar varchar(5), --Hogar
    upm varchar(5), --Unidad primaria de muestreo
    renglon varchar(20),
    tipo_delito int, --1,16
    num_delito int, --numero de delitos ocurridos
    nombre varchar(50),
    apellido varchar(50),
    perdida int --Cuánto perdió
);

SELECT * FROM modulo_victimizacion;

--DROP TABLE modulo_victimizacion;

INSERT INTO modulo_victimizacion(
 entidad, viv, hogar, upm, renglon, 
 tipo_delito, num_delito, nombre, apellido, perdida)
VALUES ('01','15','03','15','10', 3, 1, 'Luis', 'Miranda',2000),
       ('01','15','03','15','10', 3, 2, 'Luis', 'Miranda',3000),
       ('02','20','13','10','03', 4, 1, 'Oscar', 'Ruiz',1000),
       ('09','16','11','05','01', 5, 1, 'Raul', 'Ortiz',4500),
       ('32','15','01','03','01', 2, 1, 'Luisa', 'Ortiz',300),
       ('32','15','01','03','01', 2, 2, 'Luisa', 'Ortiz',500);
	   

insert into modulo_victimizacion
values ('01','01','01','01','01',6,1,'Jose','Uribe',5000);

SELECT tipo_delito, perdida FROM modulo_victimizacion;

SELECT * FROM modulo_victimizacion ORDER BY apellido ASC;

SELECT * FROM modulo_victimizacion WHERE perdida > 1000 ORDER BY tipo_delito DESC;

SELECT * FROM modulo_victimizacion WHERE entidad  = '01';

SELECT * FROM modulo_victimizacion WHERE perdida >= 2000 AND entidad = '01';

SELECT * FROM modulo_victimizacion WHERE perdida != 2000;

CREATE OR REPLACE FUNCTION perdidaMayor()
RETURNS TABLE(
	entidad varchar(2),
    viv varchar(5),
    hogar varchar(5), --Hogar
    upm varchar(5), --Unidad primaria de muestreo
    renglon varchar(20),
    tipo_delito int, --1,16
    num_delito int, --numero de delitos ocurridos
    nombre varchar(50),
    apellido varchar(50),
    perdida int --Cuánto perdió
)
AS
$$ SELECT * FROM modulo_victimizacion ORDER BY perdida DESC LIMIT 1 $$
LANGUAGE SQL;

SELECT * FROM perdidaMayor()

-- Quiero 1000 <= perdidas <= 3000
SELECT * FROM modulo_victimizacion WHERE perdida BETWEEN 1000 AND 3000

-- Quiero 1000 < perdidas <= 3000
SELECT * FROM modulo_victimizacion WHERE perdida BETWEEN 1001 AND 3000

-- Quiero 1000 <= perdidas < 3000
SELECT * FROM modulo_victimizacion WHERE perdida BETWEEN 1000 AND 2999

-- Quiero 1000 < perdidas < 3000
SELECT * FROM modulo_victimizacion WHERE perdida BETWEEN 1001 AND 2999




