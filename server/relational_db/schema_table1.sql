-- Table: public.pubcode_table1

-- DROP TABLE public.pubcode_table1;

CREATE TABLE public.pubcode_table1
(
    "PubCode_ID" character varying COLLATE pg_catalog."default" NOT NULL,
    "PubMed_ID" character varying COLLATE pg_catalog."default" NOT NULL,
    "Code_Publication_Date" character varying COLLATE pg_catalog."default" NOT NULL,
    "Authors" character varying COLLATE pg_catalog."default" NOT NULL,
    "Programming_Language" character varying COLLATE pg_catalog."default" NOT NULL,
    "OS" character varying COLLATE pg_catalog."default" NOT NULL,
    "Dependencies_and_Versions" character varying COLLATE pg_catalog."default",
    "Licensing" character varying COLLATE pg_catalog."default",
    "Keywords" character varying COLLATE pg_catalog."default",
    "Dataset_IDs" character varying COLLATE pg_catalog."default",
    "Access" character varying COLLATE pg_catalog."default",
    "Reproducibility_Score" character varying COLLATE pg_catalog."default",
    CONSTRAINT pubcode_table1_pkey PRIMARY KEY ("PubCode_ID")
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.pubcode_table1
    OWNER to postgres;
