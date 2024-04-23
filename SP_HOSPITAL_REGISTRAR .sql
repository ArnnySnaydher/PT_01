create or replace PROCEDURE SP_HOSPITAL_REGISTRAR
        --Definicion de los parametros de entrada
       (sp_idHospital IN Hospital.idHospital%TYPE,
        sp_idDistrito IN Hospital.idDistrito%TYPE,
        sp_Nombre IN Hospital.Nombre%TYPE,
        sp_Antiguedad IN Hospital.Antiguedad%TYPE,
        sp_Area IN Hospital.Area%TYPE,
        sp_idSede IN Hospital.idSede%TYPE,
        sp_idGerente IN Hospital.idGerente%TYPE,
        sp_idCondicion IN Hospital.idCondicion%TYPE) 
      IS
        --Declaracion de cursores
          cursor c_sede is select descSede from Sede where idSede = sp_idSede;
          cursor c_gerente is select descGerente from Gerente where idGerente = sp_idGerente;
          cursor c_distrito is select descDistrito from Distrito where idDistrito = sp_idDistrito;
          cursor c_condicion is select descCondicion from Condicion where idCondicion = sp_idCondicion;

      BEGIN

        for f_sede in c_sede loop
                     dbms_output.put_line('Sede : ' || f_sede.descSede);
                end loop;

        for f_gerente in c_gerente loop
            dbms_output.put_line('Gerente : ' || f_gerente.descGerente);
        end loop;

        for f_distrito in c_distrito loop
            dbms_output.put_line('Distrito: ' || f_distrito.descDistrito);
        end loop;

        for f_condicion in c_condicion loop
            dbms_output.put_line('Valor recuperado: ' || f_condicion.descCondicion);
        end loop;


        --INSERTAR DATOS
        INSERT INTO Hospital(idHospital, idDistrito, Nombre, Antiguedad, Area,idSede, idGerente, idCondicion)
        VALUES(sp_idHospital, sp_idDistrito, sp_Nombre, sp_Antiguedad, sp_Area,sp_idGerente, sp_idGerente, sp_idCondicion);

        IF SQL%ROWCOUNT = 1 THEN
            DBMS_OUTPUT.PUT_LINE('Hospital registrado exitosamente');
        END IF;

END ;