-- Table: public."pubcode_pcidTable"

-- DROP TABLE public."pubcode_pcidTable";

CREATE TABLE public."pubcode_pcidTable"
(
    "CodeTitle" character varying(20) COLLATE pg_catalog."default" NOT NULL,
    "PCID" character varying(20) COLLATE pg_catalog."default" NOT NULL,
    "PMID" character varying(20) COLLATE pg_catalog."default",
    "PMCID" character varying(20) COLLATE pg_catalog."default",
    "PaperPubDate" date,
    "CodePubDate" date,
    "Authors" character varying(500) COLLATE pg_catalog."default" NOT NULL,
    "CodeLanguage" character varying(50) COLLATE pg_catalog."default",
    "OS" character varying(20) COLLATE pg_catalog."default",
    "Dependencies" character varying(500) COLLATE pg_catalog."default",
    "Licensing" character varying(20) COLLATE pg_catalog."default",
    "Keywords" character varying(500) COLLATE pg_catalog."default",
    "Dataset_IDs" character varying(20) COLLATE pg_catalog."default",
    "GitHub_URL" character varying(50) COLLATE pg_catalog."default",
    "GH_Forks" integer,
    "GH_OpenIssues" integer,
    "GH_ClosedIssues" integer,
    "GH_DateUpdate" date,
    CONSTRAINT "pubcode_pcidTable_pkey" PRIMARY KEY ("CodeTitle", "PCID")
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public."pubcode_pcidTable"
    OWNER to postgres;
