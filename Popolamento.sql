CREATE TABLE Sede (
    ID VARCHAR (3),
    CAP CHAR (5) NOT NULL,
    via VARCHAR (25) NOT NULL,
    n_civico SMALLINT NOT NULL,
    telefono VARCHAR (13) NOT NULL,
    UNIQUE (telefono),
    PRIMARY KEY (ID)
)ENGINE=InnoDb;
CREATE TABLE Stipendio (
    tipo VARCHAR (15),
    imp_lordo DECIMAL NOT NULL,
    imp_netto DECIMAL,
    PRIMARY KEY (tipo)
)ENGINE=InnoDb;
CREATE TABLE Paziente (
    CF VARCHAR (16),
    nome VARCHAR (30),
    cognome VARCHAR (30),
    telefono VARCHAR (13),
    via VARCHAR (35) NOT NULL,
    n_civico TINYINT NOT NULL,
    CAP CHAR (5) NOT NULL,
    PRIMARY KEY (CF)
)ENGINE=InnoDb;
CREATE TABLE Personale ( 
    CF VARCHAR (16),
    nome VARCHAR (30),
    cognome VARCHAR (30),
    datadinascita DATE,
    sesso ENUM ('M','F'),
    telefono VARCHAR (13),
    tipo VARCHAR (30),
    grado VARCHAR (30) default null,
    CAP CHAR (5),
    via VARCHAR (25),
    n_civico SMALLINT,
    IBAN VARCHAR (27) NOT NULL,
    sede VARCHAR (3),
    PRIMARY KEY (CF),
    FOREIGN KEY (sede) REFERENCES Sede (ID),
    FOREIGN KEY (tipo) REFERENCES Stipendio (tipo)
)ENGINE=InnoDb;
CREATE TABLE Reparto (
    codice CHAR (4),
    tipo VARCHAR (25) UNIQUE,
    primario VARCHAR (16),
    FOREIGN KEY (primario) REFERENCES Personale (CF),
    PRIMARY KEY (codice)
)ENGINE=InnoDb;
CREATE TABLE StanzaSp ( 
    n_stanza TINYINT,
    sede VARCHAR (3),
    reparto CHAR (4),
    FOREIGN KEY (sede) REFERENCES Sede (ID),
    FOREIGN KEY (reparto) REFERENCES Reparto (codice),
    PRIMARY KEY (n_stanza, sede, reparto)
)ENGINE=InnoDb;
CREATE TABLE StanzaRi ( 
    n_stanza TINYINT,
    sede VARCHAR (3),
    reparto CHAR (4),
    prezzo_notte DECIMAL (6,2) NOT NULL,
    tipo VARCHAR (15),
    FOREIGN KEY (sede) REFERENCES Sede (ID),
    FOREIGN KEY (reparto) REFERENCES Reparto (codice),
    PRIMARY KEY (n_stanza, sede, reparto)
)ENGINE=InnoDb;
CREATE TABLE TipoEsame (
    nome VARCHAR(25),
    prezzo DECIMAL NOT NULL,
    PRIMARY KEY (nome)
) ENGINE=InnoDb;
CREATE TABLE PrenotazioneStanza (
    ID INT(11) auto_increment,
    data_inizio DATETIME NOT NULL,
    data_fine DATETIME NOT NULL,
    data_p DATETIME NOT NULL,
    pagamento BOOLEAN,
    paziente VARCHAR(16),
    stanza TINYINT,
    reparto CHAR(4),
    sede VARCHAR(3),
    PRIMARY KEY (ID),
    FOREIGN KEY (stanza) REFERENCES StanzaSp (n_stanza),
    FOREIGN KEY (reparto) REFERENCES StanzaSp (reparto),
    FOREIGN KEY (sede) REFERENCES StanzaSp (sede),
    FOREIGN KEY (paziente) REFERENCES Paziente (CF)
)ENGINE=InnoDb;
CREATE TABLE PrenotazioneEsame (
    ID INT(11) auto_increment,
    data_p DATETIME NOT NULL,
    data_e DATETIME NOT NULL,    
    pagamento BOOLEAN,
    paziente VARCHAR(16),
    stanza TINYINT,
    reparto CHAR (4),
    sede VARCHAR (3),
    tipo VARCHAR(25),
    PRIMARY KEY(ID),
    FOREIGN KEY (stanza) REFERENCES StanzaSp(n_stanza),
    FOREIGN KEY (reparto) REFERENCES StanzaSp(reparto),
    FOREIGN KEY (sede) REFERENCES StanzaSp(sede),
    FOREIGN KEY (paziente) REFERENCES Paziente(CF),
    FOREIGN KEY (tipo) REFERENCES TipoEsame(nome)
)ENGINE=InnoDb;
CREATE TABLE Macchinario (
    n_serie VARCHAR (11),
    nome VARCHAR (30),
    casa_prod VARCHAR (30),
    ultima_revisione DATE,
    n_stanza TINYINT,
    reparto CHAR (4),
    sede VARCHAR (3),
    FOREIGN KEY (n_stanza) REFERENCES StanzaSp (n_stanza),
    FOREIGN KEY (reparto) REFERENCES StanzaSp (reparto),
    FOREIGN KEY (sede) REFERENCES StanzaSp (sede),
    PRIMARY KEY (n_serie)
)ENGINE=InnoDb;
CREATE TABLE Costituisce ( 
    sede VARCHAR(3),
    reparto CHAR (4),
    FOREIGN KEY (sede) REFERENCES Sede (ID),
    FOREIGN KEY (reparto) REFERENCES Reparto (codice),
    PRIMARY KEY (sede, reparto)
)ENGINE=InnoDb;
CREATE TABLE EsameEffettuato (
    ID INT(11) auto_increment,
    paziente VARCHAR(16),
    tipo_esame VARCHAR(25),
    stanza VARCHAR (8) NOT NULL,
    terapia VARCHAR(100), 
    diagnosi VARCHAR(100),
    medico VARCHAR(20) NOT NULL,
    FOREIGN KEY(tipo_esame) REFERENCES TipoEsame(nome),
    FOREIGN KEY (paziente) REFERENCES Paziente(CF),
    PRIMARY KEY(ID)
)ENGINE=InnoDb;
