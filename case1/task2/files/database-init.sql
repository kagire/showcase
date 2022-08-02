CREATE DATABASE "excel-task";

CREATE TABLE IF NOT EXISTS public.balance_sheet
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    bank_name character varying COLLATE pg_catalog."default" NOT NULL,
    name character varying COLLATE pg_catalog."default" NOT NULL,
    period character varying COLLATE pg_catalog."default" NOT NULL,
    count_type character varying COLLATE pg_catalog."default" NOT NULL,
    date date NOT NULL,
    currency_type character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT balance_sheet_pkey PRIMARY KEY (id)
)

CREATE TABLE IF NOT EXISTS public.balance_sheet_class
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    balance_sheet_id integer NOT NULL,
    sequence integer NOT NULL,
    name character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT balance_sheet_class_pkey PRIMARY KEY (id),
    CONSTRAINT balance_sheet_id_fk FOREIGN KEY (balance_sheet_id)
    REFERENCES public.balance_sheet (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
)

CREATE TABLE IF NOT EXISTS public.balance_sheet_account
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    type character varying COLLATE pg_catalog."default" NOT NULL,
    "number" character varying COLLATE pg_catalog."default" NOT NULL,
    incoming_balance_active numeric NOT NULL,
    incoming_balance_passive numeric NOT NULL,
    turnovers_debet numeric NOT NULL,
    turnovers_credit numeric NOT NULL,
    outgoing_balance_active numeric NOT NULL,
    outgoing_balance_passive numeric NOT NULL,
    balance_sheet_class_id integer NOT NULL,
    CONSTRAINT balance_sheet_account_pkey PRIMARY KEY (id),
    CONSTRAINT balance_sheet_class_id_fk FOREIGN KEY (balance_sheet_class_id)
    REFERENCES public.balance_sheet_class (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
)