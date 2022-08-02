CREATE DATABASE "db-task";

CREATE TABLE IF NOT EXISTS public."file-entries"
(
    date date NOT NULL,
    "latin-string" character varying COLLATE pg_catalog."default" NOT NULL,
    "russian-string" character varying COLLATE pg_catalog."default" NOT NULL,
    "integer-number" integer NOT NULL,
    "double-number" double precision NOT NULL
)