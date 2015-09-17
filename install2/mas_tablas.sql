create table reqper.usuarios (
  usuario text primary key,
  activo boolean default false,
  clavemd5 text
);
alter table reqper.usuarios owner to tallerabm_user;

insert into reqper.usuarios(usuario, activo, clavemd5) values 
   ('emilio', true, md5('prueba1'||'emilio')),
   ('estefania', true, md5('prueba1'||'estefania')),
   ('prueba', true, md5('prueba1'||'prueba')),
   ('sinclave', true, 'sarasasasasas'),
   ('inactivo', false, md5('prueba1'||'inactivo'));