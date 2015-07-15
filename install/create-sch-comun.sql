CREATE SCHEMA comun AUTHORIZATION tallerabm_user;
GRANT ALL ON SCHEMA comun TO tallerabm_user;
GRANT USAGE ON SCHEMA comun TO public;

-- Function: comun.para_ordenar_numeros(text)

-- DROP FUNCTION comun.para_ordenar_numeros(text);

CREATE OR REPLACE FUNCTION comun.para_ordenar_numeros(texto_con_numeros text)
  RETURNS text AS
$BODY$
declare
	rta text='';
	vPar record;
begin
	for vPar in 
		select regexp_matches(texto_con_numeros, E'([^0-9.]*|\\.)([0-9]*)', 'g') as conjunto
	loop
		rta=rta||vPar.conjunto[1];
		if vPar.conjunto[1]='.' then
			rta=rta||vPar.conjunto[2];
		elsif(length(vPar.conjunto[2])>0) then
			rta=rta||lpad(vPar.conjunto[2],9);
		end if;
	end loop;
	return rta;
end;
$BODY$
  LANGUAGE plpgsql IMMUTABLE;
ALTER FUNCTION comun.para_ordenar_numeros(text) OWNER TO tallerabm_user;
