create or replace PROCEDURE SP_HOSPITAL_ACTUALIZAR
        --Definicion de los parametros de entrada
       (sp_idHospital IN Hospital.idHospital%TYPE,
        sp_idSede IN Hospital.idSede%TYPE,
        sp_idDistrito IN Hospital.idDistrito%TYPE,
        sp_idGerente IN Hospital.idGerente%TYPE,
        sp_idCondicion IN Hospital.idCondicion%TYPE) 
      IS
        --Declaracion de cursores
          cursor c_sede is select descSede from Sede where idSede = sp_idSede;
          cursor c_gerente is select descGerente from Gerente where idGerente = sp_idGerente;
          cursor c_distrito is select descDistrito from Distrito where idDistrito = sp_idDistrito;
          cursor c_condicion is select descCondicion from Condicion where idCondicion = sp_idCondicion;
          
          v_descSede Sede.descSede%TYPE;
          v_descGerente Gerente.descGerente%TYPE;
          v_descDistrito Distrito.descDistrito%TYPE;
          v_descCondicion Condicion.descCondicion%TYPE;
          v_count NUMBER;
          v_idGerente Hospital.idGerente%TYPE;
          v_nombreGerente Hospital.nombre%TYPE;
          
      BEGIN
      
        -- Validar si se está modificando el idGerente
        SELECT idGerente,nombre INTO v_idGerente,v_nombreGerente FROM Hospital WHERE idHospital = sp_idHospital;
        IF sp_idGerente != v_idGerente  THEN
            SELECT COUNT(*) INTO v_count FROM Hospital WHERE idGerente = sp_idGerente;
                IF v_count > 0 THEN
                    RAISE_APPLICATION_ERROR(-20001, 'El Gerente ya está siendo utilizado por otro hospital');
                END IF;
        END IF;
        
        BEGIN
        SELECT descSede INTO v_descSede FROM Sede WHERE idSede = sp_idSede;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    RAISE_APPLICATION_ERROR(-20002, 'Sede no encontrada');
        END;
    
        BEGIN
        SELECT descGerente INTO v_descGerente FROM Gerente WHERE idGerente = sp_idGerente;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    RAISE_APPLICATION_ERROR(-20002, 'Gerente no encontrado');
        END;
    
        BEGIN
        SELECT descDistrito INTO v_descDistrito FROM Distrito WHERE idDistrito = sp_idDistrito;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    RAISE_APPLICATION_ERROR(-20002, 'Distrito no encontrado');
        END;
    
        BEGIN
        SELECT descCondicion INTO v_descCondicion FROM Condicion WHERE idCondicion = sp_idCondicion;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    RAISE_APPLICATION_ERROR(-20002, 'Condición no encontrada');
        END;

          -- Actualizar el registro del hospital
        UPDATE Hospital
            SET idSede      = sp_idSede,
                idDistrito  = sp_idDistrito,
                idGerente   = sp_idGerente,
                idCondicion = sp_idCondicion
            WHERE idHospital= sp_idHospital;

        -- Verificar si se realizó la actualización
        IF SQL%ROWCOUNT = 1 THEN
            DBMS_OUTPUT.PUT_LINE( v_nombreGerente ||' actualizado exitosamente');
        ELSE
            DBMS_OUTPUT.PUT_LINE('No se encontró ningún hospital con el ID proporcionado');
        END IF;

        
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
        
        EXCEPTION
            WHEN OTHERS THEN
             RAISE_APPLICATION_ERROR(-20002, 'ID Hospital no encontrada');
             RAISE;
END ;