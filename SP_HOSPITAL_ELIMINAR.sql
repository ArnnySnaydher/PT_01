create or replace PROCEDURE SP_HOSPITAL_ELIMINAR 
        --Definicion de los parametros de entrada
       (sp_idHospital IN Hospital.idHospital%TYPE) 
      IS
        --Declaracion de cursores
          v_hospital_exist NUMBER := 0;
      BEGIN
         FOR f_hospital IN (SELECT 1 FROM Hospital WHERE idHospital = sp_idHospital) LOOP
            v_hospital_exist := 1;
        END LOOP;

          -- Si alguna verificación falla, mostrar mensaje y salir del procedimiento
        IF v_hospital_exist = 0 THEN
            DBMS_OUTPUT.PUT_LINE('El ID de Hospital Error');
            RETURN;
        END IF;

        DELETE FROM Hospital
        WHERE idHospital = sp_idHospital;

        -- Verificar si se realizó la actualización
        IF SQL%ROWCOUNT = 1 THEN
            DBMS_OUTPUT.PUT_LINE('Hospital eliminado  exitosamente');
        ELSE
            DBMS_OUTPUT.PUT_LINE('No se encontró ningún hospital con el ID proporcionado');
      END IF;
      
    --Caputar exception no validado anteriormente
    EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END ;