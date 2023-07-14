/*
Proyecto de Aplicación de Bases de Datos

Integrantes:
Sigrid Rojas Murillo 116280872
Yoel Rodríguez Rodríguez 402420352
Santiago Gerardo Álvarez Álvarez 207120637

EL proyecto se realizo en MySQL.
*/
Create database Academia;
show databases;
use Academia;

Create table Alumnos(
Id int (50) not null,
Nombre varchar(50) not null,
Edad int (10));
show tables;
describe Alumnos;

Create table Carreras(
Id int not null,
Nombre varchar (50),
IdSede int not null);
show tables;
describe Carreras;

Create table Sedes(
Id int not null,
Nombre varchar(50));
show tables;
describe Sedes;

Create table Aulas(
Id int not null,
Nombre varchar(50),
Cupo int not null);
show tables;
describe Aulas;

Create table Materias(
Id int not null,
IdCarrera int not null,
Nombre varchar (50),
Credito int not null);
show tables;
describe Materias;

Create table Cursos(
Id int not null,
IdMaterias int not null,
Inicio date,
Fin date,
IdAulas int not null);
show tables;
describe Cursos;

/*Primary keys*/
alter table Alumnos add constraint primary key (id);
describe Alumnos;

alter table Carreras add constraint primary key (id);
describe Carreras;

alter table Sedes add constraint primary key(id);
describe Sedes;

alter table Aulas add constraint primary key(id);
describe Aulas;

alter table Materias add constraint primary key(id);
describe Materias;

alter table Cursos add constraint primary key(id);
describe Materias;

/*Foreign keys*/
alter table Carreras add constraint fk_Carr_Sed foreign key(idSede) references Sedes(id);
describe Carreras;

Alter table Materias add constraint fk_Carr_Mat foreign key(idCarrera) references Carreras(id);
describe Materias;

Alter table Cursos add constraint fk_Aul_Cur foreign key(idAulas) references Aulas(id);
describe Cursos;

Alter table Cursos add constraint fkMat_Cur foreign key(idMaterias) references Materias(id);
describe Cursos;

/*Inserts*/
insert into Alumnos(Id, Nombre,Edad)
values('45','Jorge','28');

insert into Alumnos(Id, Nombre,Edad)
values('66','Ana','27');

insert into Alumnos(Id, Nombre,Edad)
values('82','David','28');

insert into Alumnos(Id, Nombre,Edad)
values('33','Esmeralda','26');

insert into Alumnos(Id, Nombre,Edad)
values('42','Daniela','26');

Select * 
from Alumnos;

insert into Sedes(Id, Nombre)
values('4', 'Heredia');

insert into Sedes(Id, Nombre)
values('5', 'Guanacaste');

insert into Sedes(Id, Nombre)
values('6', 'Puntarenas');

insert into Sedes(Id, Nombre)
values('7', 'Limon');

insert into Sedes(Id, Nombre)
values('1', 'San Jose');

Select * 
from Sedes;

insert into Carreras(Id, Nombre, IdSede)
values('100','Carrera 1','1');

insert into Carreras(Id, Nombre, IdSede)
values('101','Carrera 2', 4);

insert into Carreras(Id, Nombre, IdSede)
values('102','Carrera 3', '4');

insert into Carreras(Id, Nombre, IdSede)
values('103','Carrera 4',5);

insert into Carreras(Id, Nombre, IdSede)
values('104','Carrera 5','6');

Select * 
from Carreras;


insert into Aulas(Id,Nombre,Cupo)
values('01','Danza','50');

insert into Aulas(Id,Nombre,Cupo)
values('02','Crossfit','15');

insert into Aulas(Id,Nombre,Cupo)
values('03','Gymnacia','30');

insert into Aulas(Id,Nombre,Cupo)
values('04','Karate','20');

insert into Aulas(Id,Nombre,Cupo)
values('05','Danza','50');

Select * 
from Aulas;

insert into Materias(Id,IdCarrera,Nombre,Credito)
values('501',100,'Danza del Vientre','3');

insert into Materias(Id,IdCarrera,Nombre,Credito)
values('502',101,'Cinta Negra','6');

insert into Materias(Id,IdCarrera,Nombre,Credito)
values('503',102,'Salsa','3');

insert into Materias(Id,IdCarrera,Nombre,Credito)
values('504',103,'Peso Muerto','9');

insert into Materias(Id,IdCarrera,Nombre,Credito)
values('505',104,'Cintas','3');

Select * 
from Materias;

select * from Aulas;

Insert into Cursos(Id, IdMaterias, Inicio, Fin,IdAulas)
values ('200','501', '2021-01-15','2022-01-15','2');

Insert into Cursos(Id, IdMaterias, Inicio, Fin,IdAulas)
values ('300','502','2019-01-16','2021-01-17','3');

Insert into Cursos(Id, IdMaterias, Inicio, Fin,IdAulas)
values ('400','503','2017-03-01','2019-03-02','4');

Insert into Cursos(Id, IdMaterias, Inicio, Fin,IdAulas)
values ('600','504','2019-06-16','2025-06-24','5');

Insert into Cursos(Id, IdMaterias, Inicio, Fin,IdAulas)
values ('700','505','2022-09-16','2025-09-24','5');

/*Procedimientos almacenados de insercion de datos*/

delimiter //
Create procedure SPInsertaAlumnos (in pIDAlumno int, in pNombreAlumno varchar(50), in pEdadAlumno int)
begin
    set @vTemp = exists(select Id from Alumnos where Id = pIDAlumno);
    if (@vTemp = 0) then
        insert into Alumnos(Id, Nombre, Edad) values (pIDAlumno, pNombreAlumno, pEdadAlumno);
    elseif (@vTemp = 1) then
        select 'El alumno con el ID insertado ya existe' as 'Error';
    end if;
end;


call SPInsertaAlumnos('33', 'Juan', '24'); /*El alumno con ID 33 ya eiste*/
/*Inserts funcionales*/
call SPInsertaAlumnos('01', 'Andres', '24');
call SPInsertaAlumnos('02', 'Pablo', '24');
call SPInsertaAlumnos('04', 'Maria', '24');
call SPInsertaAlumnos('05', 'Andrea', '24');
select * from Alumnos;

delimiter //
Create procedure SPInsertaAulas (in pIDAula int, in pNombreAula varchar(50), in pCupoAula int)
begin
    set @vTemp = exists(select Id from Aulas where Id = pIDAula);
    if (@vTemp = 0) then
        insert into Aulas(Id, Nombre, Cupo) values (pIDAula, pNombreAula, pCupoAula);
    elseif (@vTemp = 1) then
        select 'El aula con el ID insertado ya existe' as 'Error';
    end if;
end;


call SPInsertaAulas('1', 'Aula 1', '30'); /*El aula con ID 1 ya existe*/
/*Inserts funcionales*/
call SPInsertaAulas('6', 'Aula 6', '30');
call SPInsertaAulas('7', 'Aula 7', '30');
call SPInsertaAulas('8', 'Aula 8', '30');
call SPInsertaAulas('9', 'Aula 9', '30');
select * from Aulas;

delimiter //
Create procedure SPInsertaCarreras (in pIDCarrera int, in pNombreCarrera varchar(50), in pIdSede int)
begin
    set @vTemp = exists(select Id from Aulas where Id = pIDCarrera);
    set @vSede = exists(select id from Sedes where id = pIDSede);
    if (@vTemp = 0 and @vSede = 1) then
        insert into Carreras(Id, Nombre, IdSede) values (pIDCarrera, pNombreCarrera, pIdSede);
    elseif (@vTemp = 1) then
        select 'La carrera con el ID insertado ya existe' as 'Error';
    elseif(@vSede = 0) then
        select 'La sede con el ID insertado no existe. Favor verificar.' as 'Error';
    end if;
end;


call SPInsertaCarreras(100, 'Carrera 1', 1); /*El aula con ID 100 ya existe. */
call SPInsertaCarreras(104, 'Carrera 1', 9); /* La sede con ID 9 no existe */
/*Inserts funcioanles*/
call SPInsertaCarreras(105, 'Carrera 8', 1);
call SPInsertaCarreras(106, 'Carrera 9', 2);
call SPInsertaCarreras(107, 'Carrera 10', 3);
call SPInsertaCarreras(108, 'Carrera 11', 4);
call SPInsertaCarreras(109, 'Carrera 12', 5);

select * from Carreras;
select * from Sedes;

delimiter //
Create procedure SPInsertaCursos (in pIDCursos int, in pIdMaterias int, in pInicio date, in pFinal date, in pIdAulas int)
begin
    set @vTemp = exists(select Id from Cursos where Id = pIDCursos);
    set @vMaterias = exists(select id from Materias where id = pIdMaterias);
    set @vAulas = exists(select id from Aulas where id = pIdAulas);
    if (@vTemp = 0 and @vSede = 1 and @vAulas = 1) then
        insert into Cursos(id, IdMaterias, Inicio, Fin, IdAulas) values (pIDCursos, pIdMaterias, pInicio, pFinal, pIdAulas);
    elseif (@vTemp = 1) then
        select 'El curso con el ID insertado ya existe' as 'Error';
    elseif (@vMaterias = 0) then
        select 'La materia con el ID insertado no existe' as 'Error';
    elseif (@vAulas = 0) then
        select 'El aula con el ID insertado no existe' as 'Error';
    end if;
end;


select * from Cursos;
select * from Aulas;
select * from Materias;
call SPInsertaCursos(400, 503, '2022-04-12', '2022-10-15', 3); /*El curso con ID 400 ya existe*/
call SPInsertaCursos(800, 510, '2022-04-12', '2022-10-15', 3);/*La materia con ID 510 no existe*/
call SPInsertaCursos(800, 503, '2022-04-12', '2022-10-15', 15);/*El aula con ID 15 no existe*/
/*Inserts funcionales*/
call SPInsertaCursos(800, 501, '2022-04-12', '2022-10-15', 1);
call SPInsertaCursos(900, 502, '2022-04-12', '2022-10-15', 2);
call SPInsertaCursos(901, 503, '2022-04-12', '2022-10-15', 3);
call SPInsertaCursos(902, 504, '2022-04-12', '2022-10-15', 4);
call SPInsertaCursos(903, 505, '2022-04-12', '2022-10-15', 5);
select * from Cursos;

delimiter //
Create procedure SPInsertaMaterias (in pIDMateria int, in pIDCarrera int, in pNombreMateria varchar(50), in pCreditos int)
begin
    set @vTemp = exists(select Id from Materias where Id = pIDMateria);
    set @vCarrera = exists(select id from Carreras where id = pIDCarrera);
    if (@vTemp = 0 and @vCarrera = 1) then
        insert into Materias(Id, IdCarrera, Nombre, Credito) values (pIDMateria, pIDCarrera, pNombreMateria, pCreditos);
    elseif (@vTemp = 1) then
        select 'La materia con el ID insertado ya existe' as 'Error';
    elseif(@vCarrera = 0) then
        select 'La carrera con el ID insertado no existe. Favor verificar.' as 'Error';
    end if;
end;


select * from Materias;
select * from Carreras;

call SPInsertaMaterias(505, 109, 'Materia 10', 3);/*Materia con ID 505 ya existe*/
call SPInsertaMaterias(510, 200, 'Materia 10', 3);/*Carrera con ID 200 no existe*/
/*Inserts funcionales*/
call SPInsertaMaterias(510, 100, 'Materia 10', 3);
call SPInsertaMaterias(511, 100, 'Materia 11', 3);
call SPInsertaMaterias(512, 101, 'Materia 12', 3);
call SPInsertaMaterias(513, 101, 'Materia 13', 3);
call SPInsertaMaterias(514, 102, 'Materia 14', 3);

select * from Materias;

delimiter //
Create procedure SPInsertaSedes (in pIDSede int, in pNombreSede varchar(50))
begin
    set @vTemp = exists(select Id from Sedes where Id = pIDSede);
    if (@vTemp = 0) then
        insert into Sedes(Id, Nombre) values (pIDSede, pNombreSede);
    elseif (@vTemp = 1) then
        select 'La sede con el ID insertado ya existe' as 'Error';
    end if;
end;


select * from Sedes;
call SPInsertaSedes(1, 'San Jose');/*ID 1 ya existe en Sedes*/
/*Inserts funcionales*/
call SPInsertaSedes(2, 'Cartago');
call SPInsertaSedes(3, 'Alajuela');
call SPInsertaSedes(8, 'San Carlos');
call SPInsertaSedes(9, 'Perez Zeledon');
call SPInsertaSedes(10, 'Sarapiqui');

select * from Sedes;

delimiter //

/*Procedimientos almacenados de modificación*/

delimiter //
Create procedure SPModificaAlumnos (in pIDAlumno int, in pNombreAlumno varchar(50), in pEdadAlumno int)
begin
    set @vTemp = exists(select Id from Alumnos where Id = pIDAlumno);
    if (@vTemp = 1) then
        update Alumnos set Nombre = pNombreAlumno, Edad = pEdadAlumno where id = pIDAlumno;
        select 'Alumno modificado con exito' as 'Resulatdo';
    elseif (@vTemp = 0) then
        select 'El alumno con el ID insertado no existe' as 'Error';
    end if;
end;


select * from Alumnos;

call SPModificaAlumnos(6,'Karla',23);/*Alumno con ID 6 no existe*/
/*update funcional*/
call SPModificaAlumnos(2,'Karla',23);

select * from Alumnos;

delimiter //
Create procedure SPModificaAulas (in pIDAula int, in pNombreAula varchar(50), in pCupoAula int)
begin
    set @vTemp = exists(select Id from Aulas where Id = pIDAula);
    if (@vTemp = 1) then
        update Aulas Set Nombre = pNombreAula, Cupo = pCupoAula where id=pIDAula;
    elseif (@vTemp = 0) then
        select 'El aula con el ID insertado no existe' as 'Error';
    end if;
end;


select * from Aulas;

call SPModificaAulas(10, 'Teatro', 20); /*El ID 20 del aula no existe*/
/*update funcional*/
call SPModificaAulas(6, 'Teatro', 20);

select * from Aulas;

delimiter //
Create procedure SPModificaCarreras (in pIDCarrera int, in pNombreCarrera varchar(50), in pIdSede int)
begin
    set @vTemp = exists(select Id from Carreras where Id = pIDCarrera);
    set @vSede = exists(select id from Sedes where id = pIDSede);
    if (@vTemp = 1 and @vSede = 1) then
        update Carreras set Nombre=pNombreCarrera, IdSede=pIdSede where Id = pIDCarrera;
    elseif (@vTemp = 0) then
        select 'La carrera con el ID insertado no existe' as 'Error';
    elseif(@vSede = 0) then
        select 'La sede con el ID insertado no existe. Favor verificar.' as 'Error';
    end if;
end;


select * from Carreras;

call SPModificaCarreras(110, 'Carrera 13', 1); /*La carrera con ID 110 no existe*/
call SPModificaCarreras(100, 'Carrera 13', 15); /*La sede con ID 15 no existe*/
/*update funcional*/
call SPModificaCarreras(105, 'Carrera 6', 1);

select * from Carreras;

delimiter //
Create procedure SPModificaCursos (in pIDCursos int, in pIdMaterias int, in pInicio date, in pFinal date, in pIdAulas int)
begin
    set @vTemp = exists(select Id from Cursos where Id = pIDCursos);
    set @vMaterias = exists(select id from Materias where id = pIdMaterias);
    set @vAulas = exists(select id from Aulas where id = pIdAulas);
    if (@vTemp = 1 and @vMaterias = 1 and @vAulas = 1) then
        update Cursos set IdMaterias = pIdMaterias, Inicio= pInicio, Fin= pFinal, IdAulas = pIdAulas where id = pIDCursos;
    elseif (@vTemp = 0) then
        select 'El curso con el ID insertado no existe' as 'Error';
    elseif (@vMaterias = 0) then
        select 'La materia con el ID insertado no existe' as 'Error';
    elseif (@vAulas = 0) then
        select 'El aula con el ID insertado no existe' as 'Error';
    end if;
end;


select * from Cursos;
select * from Materias;
select * from Aulas;

call SPModificaCursos(500, 501, '2022-08-04', '2022-08-04', 2); /*Curso con ID 500 no existe*/
call SPModificaCursos(400, 508, '2022-08-04', '2022-08-04', 2); /*Materia con ID 508 no existe*/
call SPModificaCursos(400, 501, '2022-08-04', '2022-08-04', 15); /*Aula con ID 15 no existe*/
/*update funcional*/
call SPModificaCursos(200, 504, '2022-08-04', '2022-08-04', 2);

select * from Cursos;

delimiter //
Create procedure SPModificaMaterias (in pIDMateria int, in pIDCarrera int, in pNombreMateria varchar(50), in pCreditos int)
begin
    set @vTemp = exists(select Id from Materias where Id = pIDMateria);
    set @vCarrera = exists(select id from Carreras where id = pIDCarrera);
    if (@vTemp = 1 and @vCarrera = 1) then
        update Materias set id = pIDMateria, IdCarrera = pIDCarrera, Nombre = pNombreMateria, Credito = pCreditos where Id = pIDMateria;
    elseif (@vTemp = 0) then
        select 'La materia con el ID insertado no existe' as 'Error';
    elseif(@vCarrera = 0) then
        select 'La carrera con el ID insertado no existe. Favor verificar.' as 'Error';
    end if;
end;

select * from Materias;
select * from Carreras;

call SPModificaMaterias(509, 101, 'Merengue', 3);/*La materia con ID 509 no existe*/
call SPModificaMaterias(501, 120, 'Merengue', 3);/*La carrera con ID 120 no existe*/
/*update funcional*/
call SPModificaMaterias(501, 101, 'Merengue', 3);

delimiter //
Create procedure SPModificaSedes (in pIDSede int, in pNombreSede varchar(50))
begin
    set @vTemp = exists(select Id from Sedes where Id = pIDSede);
    if (@vTemp = 1) then
        update Sedes set id = pIDSede, nombre = pNombreSede where Id = pIDSede;
    elseif (@vTemp = 0) then
        select 'La sede con el ID insertado no existe' as 'Error';
    end if;
end;


select * from Sedes;

call SPModificaSedes(20, 'Santo Domingo');/*La sede con ID 20 no existe*/
/*update funcional*/
call SPModificaSedes(1, 'Calle Blancos');

select * from Sedes;

/*Vistas*/

/*Consulta de varias tablas
  Muestra la Materia, su Aula asignada, el Cupo del Aula y el Curso al que pertenece dicha materia.
  */
create view vConsultarMateriasAulas as
select M.Id as 'Código de materia', M.Nombre 'Nombre de la materia', C.id as 'Código del curso', C.idAulas 'Número de aula', A.cupo 'Capacidad del aula' from Materias M, Cursos C, Aulas A
                                                             where C.IdMaterias = M.Id and
                                                                   C.IdAulas = A.Id;

select * from vConsultarMateriasAulas;

/*Vistas con funciones incorporadas*/
/*Calcula la duración total de un curso y muestra el nombre de las materias por llevar*/

create view vConsultarDuracionCursos as
select C.Id as 'Código del curso', DATEDIFF(C.Fin, C.Inicio) as 'Duración', M.Nombre 'Materia' from Cursos C, Materias M where C.IdMaterias = M.Id;

select * from vConsultarDuracionCursos;

/*Vistas con having*/

/*Muestra el número del aula, su capacidad máxima y lo ordena de forma descendiente, además filtra
  solamente las aulas con más de 20 personas de cupo/capacidad*/

create view vConsultarAulasGrandes as
select Cupo, Id as 'Número del aula' from Aulas group by Id, Cupo having Cupo>20 order by Cupo desc;

select * from vConsultarAulasGrandes;

										-- FUNCIONES --
                                        
/*
Busca a un alumno por medio del ID, y devuelve el nombre
*/
delimiter $$
create function FBuscaNombreAlumno(Id int)
returns varchar(50)
deterministic
begin
	declare vIdAlumno int;
    declare vNombreAlumno varchar(50);
    set vIdAlumno = Id;
    if exists (select Alumnos.Id
               from Alumnos
               where Alumnos.Id = vIdAlumno)
	then
    begin
		set vNombreAlumno = (select Alumnos.Nombre
                             from Alumnos
							 where Alumnos.Id = vIdAlumno);
    end;
    else
    begin
		set vNombreAlumno = 'El ID no coincide con ningun alumno(a)';
    end;
    end if;
    return vNombreAlumno;
end$$
delimiter ;

/*
Cuenta la cantidad de alumnos ingresados, y devuelve el dato
*/
delimiter $$
create function FCantidadAlumnos()
returns int
deterministic
begin
	declare cantidadAlumnos int;
    set cantidadAlumnos = (select count(alumnos.id)
                           from Alumnos);
    return cantidadAlumnos;
end$$
delimiter ;

-- Pruebas FUNCIONES --

Select FBuscaNombreAlumno(66);
Select FCantidadAlumnos();


										-- TRIGGERS --
Create table Bitacora(
Consecutivo int NOT NULL auto_increment,
Tabla varchar (20),
Operacion varchar (20),
Fecha datetime,
Usuario varchar(20),
Primary key (Consecutivo)
);

-- Alumnos --
-- El Trigger se ejecuta después de realizar un insert en la tabla Alumnos y realiza un insert en la tabla Bitacora con los datos solicitados. --
delimiter $$
Create trigger TrAlumnosHistoricoInsert after Insert on Alumnos 
for each row 
begin
     insert into Bitacora (tabla, operacion, fecha, usuario)
     values ('Alumnos', 'Insert', sysdate(), system_user());
end$$
delimiter ;
delimiter $$
-- El Trigger se ejecuta después de realizar un update en la tabla Alumnos y realiza un insert en la tabla Bitacora con los datos solicitados. --
Create trigger TrAlumnosHistoricoUpdate after Update on Alumnos 
for each row 
begin
     insert into Bitacora (tabla, operacion, fecha, usuario)
     values ('Alumnos', 'Update', sysdate(), system_user());
end$$
delimiter ;

-- Carreras --
-- El Trigger se ejecuta después de realizar un insert en la tabla Carreras y realiza un insert en la tabla Bitacora con los datos solicitados. --
delimiter $$
Create trigger TrCarrerasHistoricoInsert after Insert on Carreras 
for each row 
begin
     insert into Bitacora (tabla, operacion, fecha, usuario)
     values ('Carreras', 'Insert', sysdate(), system_user());
end$$
delimiter ;
delimiter $$
-- El Trigger se ejecuta después de realizar un update en la tabla Carreras y realiza un insert en la tabla Bitacora con los datos solicitados. --
Create trigger TrCarrerasHistoricoUpdate after Update on Carreras 
for each row 
begin
     insert into Bitacora (tabla, operacion, fecha, usuario)
     values ('Carreras', 'Update', sysdate(), system_user());
end$$
delimiter ;

-- Sedes --
-- El Trigger se ejecuta después de realizar un insert en la tabla Sedes y realiza un insert en la tabla Bitacora con los datos solicitados. --
delimiter $$
Create trigger TrSedesHistoricoInsert after Insert on Sedes 
for each row 
begin
     insert into Bitacora (tabla, operacion, fecha, usuario)
     values ('Sedes', 'Insert', sysdate(), system_user());
end$$
delimiter ;
delimiter $$
-- El Trigger se ejecuta después de realizar un update en la tabla Sedes y realiza un insert en la tabla Bitacora con los datos solicitados. --
Create trigger TrSedesHistoricoUpdate after Update on Sedes 
for each row 
begin
     insert into Bitacora (tabla, operacion, fecha, usuario)
     values ('Sedes', 'Update', sysdate(), system_user());
end$$
delimiter ;

-- Aulas --
-- El Trigger se ejecuta después de realizar un insert en la tabla Aulas y realiza un insert en la tabla Bitacora con los datos solicitados. --
delimiter $$
Create trigger TrAulasHistoricoInsert after Insert on Aulas 
for each row 
begin
     insert into Bitacora (tabla, operacion, fecha, usuario)
     values ('Aulas', 'Insert', sysdate(), system_user());
end$$
delimiter ;
delimiter $$
-- El Trigger se ejecuta después de realizar un update en la tabla Aulas y realiza un insert en la tabla Bitacora con los datos solicitados. --
Create trigger TrAulasHistoricoUpdate after Update on Aulas
for each row 
begin
     insert into Bitacora (tabla, operacion, fecha, usuario)
     values ('Aulas', 'Update', sysdate(), system_user());
end$$
delimiter ;

-- Materias --
-- El Trigger se ejecuta después de realizar un insert en la tabla  Materias y realiza un insert en la tabla Bitacora con los datos solicitados. --
delimiter $$
Create trigger TrMateriasHistoricoInsert after Insert on Materias 
for each row 
begin
     insert into Bitacora (tabla, operacion, fecha, usuario)
     values ('Materias', 'Insert', sysdate(), system_user());
end$$
delimiter ;
delimiter $$
-- El Trigger se ejecuta después de realizar un update en la tabla  Materias y realiza un insert en la tabla Bitacora con los datos solicitados. --
Create trigger TrMateriasHistoricoUpdate after Update on Materias
for each row 
begin
     insert into Bitacora (tabla, operacion, fecha, usuario)
     values ('Materias', 'Update', sysdate(), system_user());
end$$
delimiter ;

-- Cursos --
-- El Trigger se ejecuta después de realizar un insert en la tabla Cursos y realiza un insert en la tabla Bitacora con los datos solicitados. --
delimiter $$
Create trigger TrCursosHistoricoInsert after Insert on Cursos
for each row 
begin
     insert into Bitacora (tabla, operacion, fecha, usuario)
     values ('Cursos', 'Insert', sysdate(), system_user());
end$$
delimiter ;
delimiter $$
-- El Trigger se ejecuta después de realizar un update en la tabla Cursos y realiza un insert en la tabla Bitacora con los datos solicitados. --
Create trigger TrCursosHistoricoUpdate after Update on Cursos
for each row 
begin
     insert into Bitacora (tabla, operacion, fecha, usuario)
     values ('Cursos', 'Update', sysdate(), system_user());
end$$
delimiter ;

-- Pruebas TRIGGERS --

insert into Alumnos (id, nombre, edad)
values (777, 'Gerardo', 29);
update Alumnos 
Set nombre = 'Santiago' 
where id=777;

insert into Sedes(Id, Nombre)
values('777', 'Holanda');
update Sedes 
Set nombre = 'Alajuelita' 
where id=777;

insert into Carreras(Id, Nombre, IdSede)
values('777','Carrera 777','1');
update Carreras 
Set nombre = 'Diseño Musical' 
where id=777;

insert into Aulas(Id,Nombre,Cupo)
values('777','Karaoke','777');
update Aulas 
Set nombre = 'Canto Romano' 
where id=777;

insert into Materias(Id,IdCarrera,Nombre,Credito)
values('777',100,'Afinación','777');
update Materias 
Set nombre = 'Lira III' 
where id=777;

Insert into Cursos(Id, IdMaterias, Inicio, Fin,IdAulas)
values ('777','501', '2021-01-15','2022-01-15','2');
update Cursos 
Set Fin = '2024-01-15'
where id=777;

Select * from bitacora;