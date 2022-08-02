CREATE DATABASE "db-task";

CREATE TABLE IF NOT EXISTS public."file-entries"
(
    date date NOT NULL,
    "latin-string" character varying COLLATE pg_catalog."default" NOT NULL,
    "russian-string" character varying COLLATE pg_catalog."default" NOT NULL,
    "integer-number" integer NOT NULL,
    "double-number" double precision NOT NULL
)

CREATE OR REPLACE FUNCTION public.integersumanddoublemed(
    )
    RETURNS record
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
rowsCount INTEGER;
integerValue BIGINT; 
doubleValue1 "file-entries";
doubleValue2 "file-entries";
doubleValue DOUBLE PRECISION; 
recordValue RECORD;
BEGIN

    -- Getting the count of rows
    SELECT COUNT(*) from "file-entries" INTO rowsCount;
    RAISE NOTICE 'Number of rows: %', rowsCount;

    -- Module = center if number of rows is odd
    IF MOD(rowsCount, 2) = 0 THEN 

         -- Getting first value for median
        SELECT * FROM (SELECT * from "file-entries" ORDER BY "double-number" LIMIT ((rowsCount / 2) + 1)) AS innerSelect ORDER BY "double-number" DESC LIMIT 1
        INTO doubleValue1;
        RAISE NOTICE 'First value: %', doubleValue1."double-number";
        
        -- Getting second value for median
        SELECT * FROM (SELECT * from "file-entries" ORDER BY "double-number" LIMIT (rowsCount / 2)) AS innerSelect ORDER BY "double-number" DESC LIMIT 1
        INTO doubleValue2;
        RAISE NOTICE 'Second value: %', doubleValue2."double-number";
        
        -- Setting the median
        doubleValue := (doubleValue1."double-number" + doubleValue2."double-number") / 2;
    ELSE

         -- Getting median
        SELECT "double-number" FROM (SELECT * from "file-entries" ORDER BY "double-number" LIMIT (rowsCount / 2)) AS innerSelect ORDER BY "double-number" DESC LIMIT 1
        INTO doubleValue;
    END IF;
    
    RAISE NOTICE 'MEDIAN: %', doubleValue;

    -- Getting sum of integer values
    SELECT SUM("integer-number") from "file-entries"
    INTO integerValue;

    -- Setting results to return
    SELECT integerValue, doubleValue INTO recordValue;

    RETURN recordValue;

END;
$BODY$;
