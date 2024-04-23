create or replace PROCEDURE SP_HOSPITAL_ACTUALIZAR
        --Definicion de los parametros de entrada
       (sp_idHospital IN Hospital.idHospital%TYPE,
        sp_idSede IN Hospital.idSede%TYPE,
        sp_idDistrito IN Hospital.idDistrito%TYPE,
        sp_idGerente IN Hospital.idGerente%TYPE,
        sp_idCondicion IN Hospital.idCondicion%TYPE) 
      IS
        --Declaracion de cursores
          cursor c_sede is select 1 from Sede where idSede = sp_idSede;
          cursor c_gerente is select 1 from Gerente where idGerente = sp_idGerente;
          cursor c_distrito is select 1 from Distrito where idDistrito = sp_idDistrito;
          cursor c_condicion is select 1 from Condicion where idCondicion = sp_idCondicion;

      BEGIN

        for f_sede in c_sede loop
            NULL;
        end loop;

        for f_gerente in c_gerente loop
            NULL;
        end loop;

        for f_distrito in c_distrito loop
            NULL;
        end loop;

        for f_condicion in c_condicion loop
            NULL;
        end loop;

          -- Actualizar el registro del hospital
        UPDATE Hospital
            SET idSede      = sp_idSede,
                idDistrito  = sp_idDistrito,
                idGerente   = sp_idGerente,
                idCondicion = sp_idCondicion
            WHERE idHospital= sp_idHospital;

        -- Verificar si se realizó la actualización
        IF SQL%ROWCOUNT = 1 THEN
            DBMS_OUTPUT.PUT_LINE('Hospital actualizado exitosamente');
        ELSE
            DBMS_OUTPUT.PUT_LINE('No se encontró ningún hospital con el ID proporcionado');
      END IF;
END ;
