create or replace NONEDITIONABLE PROCEDURE SP_CONSULTAR_HOSPITALES
    --Definicion de los parametros de entrada
    (sp_consulta NUMBER , sp_nombre varchar2)
IS
   v_count NUMBER := 0;
BEGIN
    IF sp_consulta = 1 THEN

        FOR i IN (
            SELECT H.idHospital, H.Nombre, H.idDistrito
            FROM Hospital H
            INNER JOIN Distrito D ON H.idDistrito = D.idDistrito
            INNER JOIN Provincia P ON D.idProvincia = P.idProvincia
            WHERE UPPER(P.descProvincia) = UPPER(sp_nombre)
        ) LOOP
            DBMS_OUTPUT.PUT_LINE('ID Hospital: ' || i.idHospital || ', Nombre: ' || i.Nombre || ', ID Distrito: ' || i.idDistrito);
            v_count := v_count + 1;
        END LOOP;
    ELSIF sp_consulta = 2 THEN

        FOR i IN (
            SELECT *
            FROM Hospital
            WHERE UPPER(Nombre) LIKE '%' || UPPER(sp_nombre) || '%'
        ) LOOP
            DBMS_OUTPUT.PUT_LINE('ID Hospital: ' || i.idHospital || ', Nombre: ' || i.Nombre || ', ID Distrito: ' || i.idDistrito);
            v_count := v_count + 1;
        END LOOP;
    ELSIF sp_consulta = 3 THEN

        FOR i IN (
            SELECT *
            FROM Hospital
            WHERE LOWER(Nombre) LIKE '%' || UPPER(sp_nombre) || '%'
        ) LOOP
            DBMS_OUTPUT.PUT_LINE('ID Hospital: ' || i.idHospital || ', Nombre: ' || i.Nombre || ', ID Distrito: ' || i.idDistrito);
            v_count := v_count + 1;
        END LOOP;
    ELSIF sp_consulta = 4 THEN

        FOR i IN (
            SELECT UPPER(Nombre) AS Nombre_Mayuscula
            FROM Hospital
        ) LOOP
            DBMS_OUTPUT.PUT_LINE('Nombre en mayúsculas: ' || i.Nombre_Mayuscula);
            v_count := v_count + 1;
        END LOOP;
    ELSIF sp_consulta = 5 THEN

        FOR i IN (
            SELECT P.descProvincia, COUNT(H.idHospital) AS Numero_Hospitales
            FROM Provincia P
            JOIN Distrito D ON P.idProvincia = D.idProvincia
            JOIN Hospital H ON D.idDistrito = H.idDistrito
            GROUP BY P.descProvincia
        ) LOOP
            DBMS_OUTPUT.PUT_LINE('Provincia: ' || i.descProvincia || ', Número de hospitales: ' || i.Numero_Hospitales);
        END LOOP;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Tipo de consulta no reconocido');
    END IF;
    
    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'No se encontraron resultados para la consulta');
    END IF;

    --Caputar exception no validado anteriormente
    EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END;