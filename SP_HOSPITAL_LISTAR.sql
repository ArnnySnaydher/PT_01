CREATE OR REPLACE PROCEDURE SP_CONSULTAR_HOSPITALES
    (sp_consulta NUMBER)
IS
BEGIN
    IF sp_consulta = 1 THEN
        
        FOR i IN (
            SELECT H.idHospital, H.Nombre, H.idDistrito
            FROM Hospital H
            INNER JOIN Distrito D ON H.idDistrito = D.idDistrito
            INNER JOIN Provincia P ON D.idProvincia = P.idProvincia
            WHERE P.descProvincia = 'Callao'
        ) LOOP
            DBMS_OUTPUT.PUT_LINE('ID Hospital: ' || i.idHospital || ', Nombre: ' || i.Nombre || ', ID Distrito: ' || i.idDistrito);
        END LOOP;
    ELSIF sp_consulta = 2 THEN
        
        FOR i IN (
            SELECT *
            FROM Hospital
            WHERE Nombre LIKE '%NACIONAL%'
        ) LOOP
            DBMS_OUTPUT.PUT_LINE('ID Hospital: ' || i.idHospital || ', Nombre: ' || i.Nombre || ', ID Distrito: ' || i.idDistrito);
        END LOOP;
    ELSIF sp_consulta = 3 THEN
       
        FOR i IN (
            SELECT *
            FROM Hospital
            WHERE Nombre LIKE '%a'
        ) LOOP
            DBMS_OUTPUT.PUT_LINE('ID Hospital: ' || i.idHospital || ', Nombre: ' || i.Nombre || ', ID Distrito: ' || i.idDistrito);
        END LOOP;
    ELSIF sp_consulta = 4 THEN
        
        FOR i IN (
            SELECT UPPER(Nombre) AS Nombre_Mayuscula
            FROM Hospital
        ) LOOP
            DBMS_OUTPUT.PUT_LINE('Nombre en mayúsculas: ' || i.Nombre_Mayuscula);
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
END;