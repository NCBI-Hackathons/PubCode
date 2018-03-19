CREATE TABLE clinical_data (
    CONSTRAINT PubCode_ID PRIMARY KEY,
	PubMed_ID variable NOT NULL,
	Code_Publication_Date date NOT NULL,
	Authors "char" NOT NULL,
	Programming_Language variable,
	OS "char",
	Dependencies_and_Versions variable,
	Licensing variable,
	Keywords variable,
	Dataset_IDs variable,
	Access boolean,
	Reproducibility_Score integer,
)

ALTER TABLE gldata.patients
	OWNER to postgres;
