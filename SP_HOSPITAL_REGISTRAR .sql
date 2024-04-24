create or replace NONEDITIONABLE PROCEDURE SP_HOSPITAL_REGISTRAR
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

        v_descSede Sede.descSede%TYPE;
        v_descGerente Gerente.descGerente%TYPE;
        v_descDistrito Distrito.descDistrito%TYPE;
        v_descCondicion Condicion.descCondicion%TYPE;
        v_count NUMBER;

BEGIN

    -- Comprobaciones de existencia

    SELECT COUNT(*) INTO v_count FROM Hospital WHERE idGerente = sp_idGerente;
    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'El Gerente ya está siendo utilizado por otro hospital');
    END IF;

    SELECT COUNT(*) INTO v_count FROM Hospital WHERE idHospital = sp_idHospital;
    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'El idHospital ya está siendo utilizado por otro hospital');
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

    -- Insertar datos
    INSERT INTO Hospital(idHospital, idDistrito, Nombre, Antiguedad, Area, idSede, idGerente, idCondicion)
    VALUES(sp_idHospital, sp_idDistrito, sp_Nombre, sp_Antiguedad, sp_Area, sp_idSede, sp_idGerente, sp_idCondicion);

    IF SQL%ROWCOUNT = 1 THEN
        DBMS_OUTPUT.PUT_LINE( sp_Nombre ||' registrado exitosamente');
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
        RAISE;
END;