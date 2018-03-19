-- Table: public.pubcode_table1

-- DROP TABLE public.pubcode_table1;

CREATE TABLE public.pubcode_table1
(
    "PubCode_ID" "char" NOT NULL,
    "PubMed_ID" "char" NOT NULL,
    "Code_Publication_Date" "char" NOT NULL,
    "Authors" "char" NOT NULL,
    "Programming_Language" "char",
    "OS" "char",
    "Dependencies_and_Versions" "char",
    "Licensing" "char",
    "Keywords" "char",
    "Dataset_IDs" "char",
    "Access" "char",
    "Reproducibility_Score" integer,
    CONSTRAINT pubcode_table1_pkey PRIMARY KEY ("PubCode_ID")
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.pubcode_table1
    OWNER to postgres;
