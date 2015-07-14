create schema reqper authorization tallerabm_user;
set search_path=reqper;
-- Table: regper.requerimientos
-- DROP TABLE reqper.requerimientos;

CREATE TABLE requerimientos
(
  req_proy character varying(50) NOT NULL,
  req_req character varying(10) NOT NULL,
  req_titulo character varying(100),
  req_tiporeq character varying(50) NOT NULL,
  req_detalles text,
  req_grupo character varying(50),
  req_componente character varying(50),
  req_prioridad integer,
  req_costo integer,
  req_tlg bigint NOT NULL,
  req_desarrollo text,
  CONSTRAINT requerimientos_pkey PRIMARY KEY (req_proy, req_req)
);
ALTER TABLE reqper.requerimientos
  OWNER TO tallerabm_user;

-- Table: reqper.personas

-- DROP TABLE reqper.personas;

CREATE TABLE personas
(
  dni integer NOT NULL,
  seleccionado character(1),
  estado_de_seleccion integer,
  nombre character varying(80),
  telefono character varying(50),
  direccion character varying(100),
  barrio character varying(50),
  cuit_l character varying(50),
  cuit_l_verif boolean,
  fecha_nacim character varying(50),
  mail character varying(50),
  cod_niv_estud smallint DEFAULT 1,
  cod_area_estud smallint,
  estudios character varying(100),
  orien_secundario smallint,
  fecha_rec_cv timestamp with time zone,
  fecha_ult_cv timestamp with time zone,
  cod_exper_e smallint,
  cod_exper_r smallint,
  cod_exper_sup smallint,
  cod_exper_i smallint,
  cod_exper_in smallint,
  tipo_experiencia text,
  cod_tipo_operativo smallint,
  referente character varying(50),
  procedencia text,
  observaciones character varying(250),
  se_postula_para character varying(50),
  llamar character varying(50),
  fecha_llamada timestamp with time zone,
  cod_resul_llamada smallint,
  comentarios_llam character varying(255),
  fe_entrev timestamp with time zone,
  hora_entrev character varying(50),
  fecha_hora_entrev timestamp with time zone,
  cod_entrevistador smallint,
  result_entrevista smallint,
  cod_entr_perfil smallint,
  cod_puesto_recom character varying(20),
  cod_puesto_alter character varying(20),
  comentarios_entrev text,
  otro_entrev character varying(50),
  result_ot_entr integer,
  otros_comentarios text,
  cod_ult_situacion smallint,
  ubicacion_dgeyc character varying(50),
  no character(1),
  fecha_ing character varying(50),
  tipo_contrato character varying(50),
  log timestamp with time zone,
  seleccion character varying(50),
  f48 character varying(255),
  formulario boolean,
  procencia character varying(255),
  sexo character varying(255),
  verif_aux boolean,
  CONSTRAINT personas_pkey PRIMARY KEY (dni),
  CONSTRAINT "no puede haber un DNI 0" CHECK (dni > 0) NOT VALID
);
ALTER TABLE reqper.personas
  OWNER TO tallerabm_user;


--Inserción en tablas.
--personas
INSERT INTO personas(
            dni, seleccionado, estado_de_seleccion, nombre, telefono, direccion, 
            barrio, cuit_l, cuit_l_verif, fecha_nacim, mail, cod_niv_estud, 
            cod_area_estud, estudios, orien_secundario, fecha_rec_cv, fecha_ult_cv, 
            cod_exper_e, cod_exper_r, cod_exper_sup, cod_exper_i, cod_exper_in, 
            tipo_experiencia, cod_tipo_operativo, referente, procedencia, 
            observaciones, se_postula_para, llamar, fecha_llamada, cod_resul_llamada, 
            comentarios_llam, fe_entrev, hora_entrev, fecha_hora_entrev, 
            cod_entrevistador, result_entrevista, cod_entr_perfil, cod_puesto_recom, 
            cod_puesto_alter, comentarios_entrev, otro_entrev, result_ot_entr, 
            otros_comentarios, cod_ult_situacion, ubicacion_dgeyc, no, fecha_ing, 
            tipo_contrato, log, seleccion, f48, formulario, procencia, sexo, 
            verif_aux) 
VALUES 
    (61216957, '0', 0, 'Juan López', '01234-999-8888 // 99-9878-9090', 'Etchevez 1340', 'Milano', '23-99009999-9', true, '25/03/1992', 'jjjj@yahoo.com.ar', 5, 4, NULL, 2, '2013-07-01 00:00:00-03', '2013-07-01 00:00:00-03', 99, 99, 99, 99, 99, NULL, 0, NULL, NULL, NULL, NULL, NULL, '2013-07-05 00:00:00-03', 4, 'Busca trabajo', '1900-01-01 00:00:00-04:16:48', NULL, '1900-01-01 01:01:01-04:16:48', 0, 0, 0, 'N/A', 'N/A', NULL, NULL, 0, '', 99, NULL, '0', NULL, NULL, '2013-07-02 08:13:59-03', NULL, NULL, true, NULL, 'V', NULL),
    (14485840, '0', 0, 'Alberto Gutierrez', '9999-7777 // 99-9999-9999', 'Wilson E 321', 'Albuces', '99-99999999-9', true, '17/07/1989', 'aaa@gmail.com', 3, 88, 'Profes. Educ. Física', 2, '2015-04-09 00:00:00-03', '2015-04-09 00:00:00-03', 99, 99, 99, 99, 99, NULL, 0, 'Referente', NULL, 'Sec en 2 años adultos', NULL, NULL, '2015-04-23 00:00:00-03', 1, 'Secundario completo.', '2015-04-27 00:00:00-03', '10:00', '1900-01-01 01:01:01-04:16:48', 2, 0, 0, 'N/A', 'N/A', NULL, NULL, 0, 'Entrevista para el 24/04/2015 pero que no llega.', 0, NULL, '0', NULL, NULL, '2015-02-10 09:57:15-03', NULL, NULL, true, NULL, 'V', NULL),
    (77974383, '0', 0, 'María Gonzáles', '99-9999-9999', 'Parque Avenida 222', 'Parque Dos', '27-99099999-9', true, '31/12/1989', 'mmm@hotmail.com', 5, 1, NULL, 2, '2014-09-02 00:00:00-03', '2014-09-02 00:00:00-03', 99, 99, 99, 99, 99, NULL, 0, NULL, NULL, 'Con trabajo', 'Experiencia en encuestas', NULL, '2015-01-23 00:00:00-03', 1, NULL, '2015-01-29 00:00:00-03', '08:45', '1900-01-01 01:01:01-04:16:48', 8, 63, 1, 'E', 'N/A', 'Se comunica de forma fluida. Estudiante de estadística, buena presencia', NULL, 0, '', 0, NULL, '0', NULL, NULL, '2015-09-03 14:36:24-03', NULL, NULL, true, NULL, 'M', NULL),
    (16979103, '0', 0, 'José Gomez', '99-9999-9999', 'Washington 678', 'Parque Dos', '99-99099999-0', true, '12/12/1989', 'jggg@yahoo.com', 5, 13, 'Maestría en Teatro', 2, '2013-08-26 00:00:00-03', '2013-08-26 00:00:00-03', 99, 99, 99, 99, 99, 'Experiencia aplicada', 0, 'Referente auxiliar', NULL, 'VER CONDICIONES', 'E', NULL, '2013-09-04 00:00:00-03', 1, 'intento comunicarme pero no atiende', '2013-09-06 00:00:00-03', '14:30', '2013-09-06 14:30:00-03', 8, 70, 1, 'E', 'N/A', 'Alguna vez programó pero no es lo que más le agrada', NULL, 0, NULL, 99, NULL, '0', NULL, NULL, '2013-08-27 08:22:11-03', NULL, NULL, true, NULL, 'V', NULL),
    (83325571, '0', 0, 'Martín Martinez', '9909-9999 // 99-9990-9999', 'Mosquera 9099 9° "X"', 'Coronado', '23-99099999-9', true, '09/12/1989', 't1234@gmail.com', 5, 6, 'Lic en Ciencias de la Educación', 1, '2009-03-31 00:00:00-03', '2009-03-31 00:00:00-03', 99, 99, 99, 99, 99, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, '1900-01-01 00:00:00-04:16:48', NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, '0', NULL, NULL, '2010-05-28 14:32:53-03', NULL, NULL, false, NULL, 'V', NULL),
    (98720197, '0', 0, 'Laura Paz', '9999-9999 // 99-9999-9999', 'Luanas 1022 9° 99°', 'Uxxel', '27-99099999-9', true, '15/12/1989', 'lpaz98@yahoo.com', 3, 9, 'PROF EN FISICA', 2, '2011-08-30 00:00:00-03', '2011-08-30 00:00:00-03', 88, 88, 88, 88, 88, NULL, 0, NULL, NULL, NULL, NULL, NULL, '2011-09-02 00:00:00-03', 1, NULL, '2011-09-06 00:00:00-03', '14:30', '1900-01-01 01:01:01-04:16:48', 1, 67, 1, 'E', 'N/A', 'No realizó encuestas, pero tiene buena predisposición para aprender e integrarse al equipo', NULL, 0, '', 77, NULL, '0', NULL, NULL, '2011-08-31 14:42:09-03', NULL, NULL, false, NULL, 'M', NULL),
    (71184210, '0', 0, 'Gabriel García', '99-9099-9999 // 9909-9999', 'Duarte 9999 09', 'Sampedro', '99-99099999-9', true, '06/12/1989', 'gg32@hotmail.com', 5, 88, 'Lic. en Matemática', 2, '2015-02-03 00:00:00-03', '2015-02-03 00:00:00-03', 99, 99, 99, 99, 99, NULL, 0, NULL, NULL, 'Actualmente trabaja, pero quiere dejar la docencia', 'E', NULL, '1900-01-01 00:00:00-04:16:48', 0, NULL, '1900-01-01 00:00:00-04:16:48', NULL, '1900-01-01 01:01:01-04:16:48', 0, 0, 0, 'N/A', 'N/A', NULL, NULL, 0, '', 0, NULL, '0', NULL, NULL, '2015-02-18 09:20:36-03', NULL, NULL, true, NULL, 'V', NULL),
    (81457114, '0', 0, 'Ana Estevez', '9999-9999 // 99-9999-9909', 'Coresa 6754 9', 'Saint Thomas ', '99-11111111-9', true, '29/12/1989', 'ae89@gmail.com', 5, 8, 'Ingenieria en Alimentos', 2, '2009-05-06 00:00:00-03', '2009-05-06 00:00:00-03', 1, 99, 99, 99, 99, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, '1900-01-01 00:00:00-04:16:48', NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, '', 0, NULL, '0', NULL, NULL, '2010-05-28 14:32:53-03', NULL, NULL, false, NULL, 'M', NULL),
    (79959947, '0', 0, 'Paula Acevedo ', '99-9099-9909', 'Lunge 9999', 'Santa Ana', '27-99033335-9', true, '15/01/1990', 'pace22@aol.com', 5, 1, NULL, 2, '2012-08-07 00:00:00-03', '2012-08-07 00:00:00-03', 3, 99, 99, 99, 99, 'Call Center', 3, 'Referente de otra empresa', NULL, 'No puede asistir en la fecha estipulada', NULL, NULL, '2012-08-07 00:00:00-03', 1, NULL, '2012-08-09 00:00:00-03', '12:00', '1900-01-01 01:01:01-04:16:48', 5, 77, 1, 'E', 'N/A', 'Idiomas 3', NULL, 0, 'Llamarla nuevamente', 2, NULL, '0', NULL, NULL, '2012-08-15 12:36:07-03', NULL, NULL, false, NULL, 'M', NULL),
    (12549616, '0', 0, 'Pablo Urquizaz', '9999-9990 // 99-9999-9909', 'Playada 3456', 'Esquina', '23-99099999-2', true, '28/12/1989', 'up56@gmail.com', 3, 88, 'Curso de enfermería', 2, '2010-03-11 00:00:00-03', '2010-03-11 00:00:00-03', 99, 99, 99, 99, 99, NULL, 0, 'Busca un trabajo adicional mientras estudia', NULL, NULL, NULL, NULL, '2010-08-24 00:00:00-03', 3, NULL, '1900-01-01 00:00:00-04:16:48', NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, '', 66, 'Hospital', '0', NULL, NULL, '2010-05-28 14:32:53-03', NULL, NULL, false, NULL, 'V', NULL);

--requerimientos

INSERT INTO requerimientos(
            req_proy, req_req, req_titulo, req_tiporeq, req_detalles, req_grupo, 
            req_componente, req_prioridad, req_costo, req_tlg, req_desarrollo)
VALUES 
    ('PROYORIG',1,'Incluir botón Borrar en Pantallas','funcional','Mensaje antes de borrar','diseño','diseño',8,NULL,1,NULL),
    ('PROYORIG',2,'Agrandar campo texto Pregunta 2','funcional',NULL,'diseño','diseño',6,NULL,1,NULL),
    ('PROYORIG',3,'Error:No existe la columna totales','error','Fue mal renombrada','procesamiento',NULL,9,NULL,1,NULL),
    ('TALLER',4,'Verificar valores posibles pregunta Educación','proceso',NULL,'procesamiento',NULL,5,NULL,1,NULL),
    ('TALLER',5,'Controlar valor máximo de variables','proceso','Algunas se ven fuera de rango','procesamiento',NULL,10,NULL,1,NULL),
    ('TALLER',6,'Más encuestas deben ser tomadas de ejemplo','funcional','No alcanza','planificacion','circuito',9,NULL,1,NULL),
    ('NUEVOPROY',7,'Eliminar botón mirar encuesta','funcional',NULL,'planificacion','circuito',8,NULL,1,NULL),
    ('NUEVOPROY',8,'Error:circuito erroneo','funcional','Paso 2 se lo saltea','procesamiento','circuito',10,NULL,1,NULL),
    ('NUEVOPROY',9,'Cargar filas tablas personas','proceso','Adicionales','procesamiento',NULL,9,NULL,1,NULL),
    ('NUEVOPROY',10,'Agregar tabla que coordine personas con requerimientos','funcional','Posterior','planificacion',NULL,4,NULL,1,NULL);
