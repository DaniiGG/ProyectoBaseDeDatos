CREATE TABLE Proyectos (
  codigo_referencia INT PRIMARY KEY,
  nombre VARCHAR(255),
  acronimo VARCHAR(50),
  presupuesto_total DECIMAL(10, 2),
  programa_financiamiento VARCHAR(100),
  fecha_inicio DATE,
  fecha_finalizacion DATE,
  descripcion VARCHAR(500)
);


CREATE TABLE Profesores (
  id_profesor INT PRIMARY KEY,
  nombre VARCHAR(100),
  apellidos VARCHAR(100),
  despacho VARCHAR(50),
  telefono VARCHAR(20),
  supervisor_id INT
);
alter table profesores add es_doctor varchar(10);
alter table profesores add FOREIGN KEY (supervisor_id) REFERENCES Profesores(id_profesor);


CREATE TABLE Participacion (
  id_participacion INT PRIMARY KEY,
  id_profesor INT,
  codigo_referencia INT,
  fecha_inicio DATE,
  fecha_fin DATE,
  es_investigador_principal varchar(10),
  FOREIGN KEY (id_profesor) REFERENCES Profesores(id_profesor),
  FOREIGN KEY (codigo_referencia) REFERENCES Proyectos(codigo_referencia)
);

CREATE TABLE Publicaciones (
  id_publicacion INT PRIMARY KEY,
  codigo_referencia INT,
  numero_secuencia INT,
  titulo VARCHAR(255),
  FOREIGN KEY (codigo_referencia) REFERENCES Proyectos(codigo_referencia)
);

CREATE TABLE PublicacionesCongreso (
  id_publicacion INT PRIMARY KEY,
  nombre_congreso VARCHAR(100),
  tipo_congreso VARCHAR(20),
  fecha_inicio DATE,
  fecha_fin DATE,
  lugar VARCHAR(100),
  pais VARCHAR(100),
  editorial_actas VARCHAR(100),
  FOREIGN KEY (id_publicacion) REFERENCES Publicaciones(id_publicacion)
);

CREATE TABLE PublicacionesRevista (
  id_publicacion INT PRIMARY KEY,
  nombre_revista VARCHAR(100),
  editorial_revista VARCHAR(100),
  volumen INT,
  numero INT,
  pagina_inicio INT,
  pagina_fin INT,
  FOREIGN KEY (id_publicacion) REFERENCES Publicaciones(id_publicacion)
);
CREATE TABLE LineasInvestigacion (
  codigo_linea INT PRIMARY KEY,
  nombre_linea VARCHAR(100),
  FOREIGN KEY (codigo_linea) REFERENCES Publicaciones(id_publicacion)
);

CREATE TABLE LineasInvestigacionProfesores (
  id_profesor INT,
  codigo_linea INT,
  FOREIGN KEY (id_profesor) REFERENCES Profesores(id_profesor),
  FOREIGN KEY (codigo_linea) REFERENCES LineasInvestigacion(codigo_linea)
);

-- Inserts para la tabla Proyectos
INSERT INTO Proyectos (codigo_referencia, nombre, acronimo, presupuesto_total, programa_financiamiento, fecha_inicio, fecha_finalizacion, descripcion)
VALUES (1, 'Proyecto A', 'PA', 10000.00, 'Programa X', TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'), 'Descripci�n del Proyecto A');

INSERT INTO Proyectos (codigo_referencia, nombre, acronimo, presupuesto_total, programa_financiamiento, fecha_inicio, fecha_finalizacion, descripcion)
VALUES (2, 'Proyecto B', 'PB', 15000.00, 'Programa Y', TO_DATE('2023-02-01', 'YYYY-MM-DD'), TO_DATE('2024-01-31', 'YYYY-MM-DD'), 'Descripci�n del Proyecto B');

-- Inserts para la tabla Profesores
INSERT INTO Profesores (id_profesor, nombre, apellidos, despacho, telefono, supervisor_id, es_doctor)
VALUES (1, 'Juan', 'P�rez', 'Despacho 101', '123456789', NULL, 'S�');

INSERT INTO Profesores (id_profesor, nombre, apellidos, despacho, telefono, supervisor_id, es_doctor)
VALUES (2, 'Mar�a', 'L�pez', 'Despacho 202', '987654321', 1, 'No');

-- Inserts para la tabla Participacion
INSERT INTO Participacion (id_participacion, id_profesor, codigo_referencia, fecha_inicio, fecha_fin, es_investigador_principal)
VALUES (1, 1, 1, TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2023-06-30', 'YYYY-MM-DD'), 'S�');

INSERT INTO Participacion (id_participacion, id_profesor, codigo_referencia, fecha_inicio, fecha_fin, es_investigador_principal)
VALUES (2, 2, 2, TO_DATE('2023-02-01', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'), 'No');

-- Inserts para la tabla Publicaciones
INSERT INTO Publicaciones (id_publicacion, codigo_referencia, numero_secuencia, titulo)
VALUES (1, 1, 1, 'Publicaci�n 1');

INSERT INTO Publicaciones (id_publicacion, codigo_referencia, numero_secuencia, titulo)
VALUES (2, 2, 1, 'Publicaci�n 2');

-- Inserts para la tabla PublicacionesCongreso
INSERT INTO PublicacionesCongreso (id_publicacion, nombre_congreso, tipo_congreso, fecha_inicio, fecha_fin, lugar, pais, editorial_actas)
VALUES (1, 'Congreso X', 'Tipo A', TO_DATE('2023-07-01', 'YYYY-MM-DD'), TO_DATE('2023-07-03', 'YYYY-MM-DD'), 'Lugar A', 'Pa�s X', 'Editorial A');

INSERT INTO PublicacionesCongreso (id_publicacion, nombre_congreso, tipo_congreso, fecha_inicio, fecha_fin, lugar, pais, editorial_actas)
VALUES (2, 'Congreso Y', 'Tipo B', TO_DATE('2023-08-01', 'YYYY-MM-DD'), TO_DATE('2023-08-03', 'YYYY-MM-DD'), 'Lugar B', 'Pa�s Y', 'Editorial B');

-- Inserts para la tabla PublicacionesRevista
INSERT INTO PublicacionesRevista (id_publicacion, nombre_revista, editorial_revista, volumen, numero, pagina_inicio, pagina_fin)
VALUES (1, 'Revista X', 'Editorial X', 10, 1, 100, 120);

INSERT INTO PublicacionesRevista (id_publicacion, nombre_revista, editorial_revista, volumen, numero, pagina_inicio, pagina_fin)
VALUES (2, 'Revista Y', 'Editorial Y', 5, 2, 50, 70);

-- Inserts para la tabla LineasInvestigacion
INSERT INTO LineasInvestigacion (codigo_linea, nombre_linea)
VALUES (1, 'L�nea 1');

INSERT INTO LineasInvestigacion (codigo_linea, nombre_linea)
VALUES (2, 'L�nea 2');

-- Inserts para la tabla LineasInvestigacionProfesores
INSERT INTO LineasInvestigacionProfesores (id_profesor, codigo_linea)
VALUES (1, 1);

INSERT INTO LineasInvestigacionProfesores (id_profesor, codigo_linea)
VALUES (2, 2);

##Obtener el nombre de los profesores que son investigadores principales en algún proyecto
SELECT p.nombre
FROM Profesores p
JOIN Participacion pa ON p.id_profesor = pa.id_profesor
WHERE pa.es_investigador_principal = 'S�';


--Esta consulta recupera el nombre del proyecto, el nombre y apellidos del profesor involucrado en la participaci�n de dicho proyecto.
--where de financiamiento especifico 
SELECT p.nombre AS proyecto, pr.nombre AS profesor, pr.apellidos AS apellidos
FROM Proyectos p
INNER JOIN Participacion pa ON p.codigo_referencia = pa.codigo_referencia
INNER JOIN Profesores pr ON pa.id_profesor = pr.id_profesor
WHERE p.programa_financiamiento = 'Programa X'
ORDER BY p.nombre, pr.apellidos;


--obtener el nombre de los proyectos y la cantidad de participantes asociados a cada uno

CREATE VIEW VistaProyectosParticipantes AS
SELECT p.nombre AS nombre_proyecto, COUNT(pt.id_profesor) AS cantidad_participantes
FROM Proyectos p
LEFT JOIN Participacion pt ON p.codigo_referencia = pt.codigo_referencia
GROUP BY p.nombre;

SELECT * FROM VistaProyectosParticipantes;




--El resultado del cursor será una lista de proyectos con su código, nombre y nombre del profesor asociado.
set serveroutput on;
DECLARE
CURSOR cursor_proyectos IS
SELECT p.codigo_referencia, p.nombre, pr.nombre AS nombre_profesor
    FROM Proyectos p
    INNER JOIN Participacion pa ON p.codigo_referencia = pa.codigo_referencia
    INNER JOIN Profesores pr ON pa.id_profesor = pr.id_profesor;
v_codigo_referencia Proyectos.codigo_referencia%TYPE;
  v_nombre_proyecto Proyectos.nombre%TYPE;
  v_nombre_profesor Profesores.nombre%TYPE;
BEGIN
  -- Abrir el cursor
  OPEN cursor_proyectos;
  
  -- Recorrer los registros del cursor
  LOOP
    -- Obtener los valores de las columnas en las variables
    FETCH cursor_proyectos INTO v_codigo_referencia, v_nombre_proyecto, v_nombre_profesor;
    
    -- Salir del loop si no hay m�s registros
    EXIT WHEN cursor_proyectos%NOTFOUND;
    
    -- Realizar acciones con los valores obtenidos
    -- Por ejemplo, imprimir los valores
    DBMS_OUTPUT.PUT_LINE('Proyecto: ' || v_nombre_proyecto || ', C�digo: ' || v_codigo_referencia || ', Profesor: ' || v_nombre_profesor);
  END LOOP;
  -- Cerrar el cursor
  CLOSE cursor_proyectos;
END;

--TRIGGER
/**
El objetivo del trigger ser� actualizar el campo "es_investigador_principal" en la tabla "Participacion" cuando se inserte o actualice un registro con el valor "S" (s�) en ese campo. 
Si hay otro registro para el mismo proyecto donde ya exista un investigador principal ("S"), se actualizar� ese registro a "N" (no).
**/

CREATE OR REPLACE TRIGGER actualizar_investigador_principal
AFTER INSERT OR UPDATE ON Participacion
FOR EACH ROW
DECLARE
  proyecto_id Participacion.codigo_referencia%TYPE := :new.codigo_referencia;
  investigador_principal Participacion.id_participacion%TYPE;
BEGIN
  IF :new.es_investigador_principal = 'S' THEN
    -- Buscar si ya hay un investigador principal para el mismo proyecto
    SELECT id_participacion INTO investigador_principal
    FROM Participacion
    WHERE codigo_referencia = proyecto_id
      AND es_investigador_principal = 'S�'
      AND id_participacion != :new.id_participacion;
      
    IF investigador_principal IS NOT NULL THEN
      -- Actualizar el registro existente a 'N' (no) ya que hay un nuevo investigador principal
      UPDATE Participacion
      SET es_investigador_principal = 'No'
      WHERE id_participacion = investigador_principal;
    END IF;
  END IF;
END;



##Posibilidad de borrar estructuras

DROP TABLE LineasInvestigacionProfesores;
DROP TABLE LineasInvestigacion;
DROP TABLE PublicacionesRevista;
DROP TABLE PublicacionesCongreso;
DROP TABLE Publicaciones;
DROP TABLE Participacion;
DROP TABLE Profesores;
DROP TABLE Proyectos;
