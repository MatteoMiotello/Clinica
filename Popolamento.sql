DROP TABLE IF EXISTS Sede;
CREATE TABLE Sede(
    ID VARCHAR (3),
    CAP CHAR (5) not null,
    via VARCHAR (25) not null,
    n_civico SMALLINT not null,
    telefono VARCHAR (13) not null,
    UNIQUE (telefono),
    PRIMARY KEY (ID)
)ENGINE=InnoDb;
DROP TABLE IF EXISTS Stipendio;
CREATE TABLE Stipendio (
    tipo VARCHAR (15),
    imp_lordo DECIMAL NOT NULL,
    imp_netto DECIMAL,
    PRIMARY KEY (tipo)
)ENGINE=InnoDb;
DROP TABLE IF EXISTS Paziente;
CREATE TABLE Paziente (
    CF VARCHAR (16),
    nome VARCHAR (20),
    cognome VARCHAR (30),
    telefono VARCHAR (13) NOT NULL, 
    via VARCHAR (25) NOT NULL,
    n_civico TINYINT NOT NULL,
    CAP CHAR (5) NOT NULL,
    PRIMARY KEY (CF)
)ENGINE=InnoDb;
DROP TABLE IF EXISTS Personale;
CREATE TABLE Personale ( 
    CF VARCHAR (16),
    nome VARCHAR (20),
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
DROP TABLE IF EXISTS Reparto;
CREATE TABLE Reparto (
    codice CHAR (4),
    tipo VARCHAR (15) UNIQUE,
    primario VARCHAR (16),
    FOREIGN KEY (primario) REFERENCES Personale (CF),
    PRIMARY KEY (codice)
)ENGINE=InnoDb;
DROP TABLE IF EXISTS StanzaSp;
CREATE TABLE StanzaSp ( 
    n_stanza TINYINT,
    sede VARCHAR (3),
    reparto CHAR (4),
    FOREIGN KEY (sede) REFERENCES Sede (ID),
    FOREIGN KEY (reparto) REFERENCES Reparto (codice),
    PRIMARY KEY (n_stanza, sede, reparto)
)ENGINE=InnoDb;
DROP TABLE IF EXISTS StanzaRi;
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
DROP TABLE IF EXISTS TipoEsame;
CREATE TABLE TipoEsame (
    nome VARCHAR(10),
    prezzo DECIMAL NOT NULL,
    PRIMARY KEY (nome)
) ENGINE=InnoDb;
DROP TABLE IF EXISTS PrenotazioneStanza;
CREATE TABLE PrenotazioneStanza (
    ID INT(11) auto_increment,
    data_inizio DATETIME NOT NULL,
    data_fine DATETIME NOT NULL,
    data_p DATETIME NOT NULL,
    pagamento BOOLEAN,
    paziente VARCHAR(16),
    stanza TINYINT,
    reparto CHAR(4),
    sede VARCHAR(2),
    PRIMARY KEY (ID),
    FOREIGN KEY (stanza) REFERENCES StanzaSP(n_stanza),
    FOREIGN KEY (reparto) REFERENCES StanzaSP(reparto),
    FOREIGN KEY (sede) REFERENCES StanzaSP(sede),
    FOREIGN KEY (paziente) REFERENCES Paziente(CF)
)ENGINE=InnoDb;
DROP TABLE IF EXISTS PrenotazioneEsame;
CREATE TABLE PrenotazioneEsame (
    ID INT(11)auto_increment,
    data_p  DATETIME NOT NULL,
    orario TIME NOT NULL,    
    pagamento BOOLEAN,
    paziente VARCHAR(16),
    stanza TINYINT,
    reparto CHAR (4),
    sede VARCHAR (3),
    tipo VARCHAR(10),
    PRIMARY KEY(ID),
    FOREIGN KEY (stanza) REFERENCES StanzaSP(n_stanza),
    FOREIGN KEY (reparto) REFERENCES StanzaSP(reparto),
    FOREIGN KEY (sede) REFERENCES StanzaSP(sede),
    FOREIGN KEY (paziente) REFERENCES Paziente(CF),
    FOREIGN KEY (tipo) REFERENCES TipoEsame(nome)
)ENGINE=InnoDb;
DROP TABLE IF EXISTS Macchinario;
CREATE TABLE Macchinario (
    n_serie INT (11),
    nome VARCHAR (15),
    casa_prod VARCHAR (15),
    ultima_revisione DATE,
    n_stanza TINYINT,
    reparto CHAR (4),
    sede VARCHAR (3),
    FOREIGN KEY (n_stanza) REFERENCES StanzaSp (n_stanza),
    FOREIGN KEY (reparto) REFERENCES StanzaSp (reparto),
    FOREIGN KEY (sede) REFERENCES StanzaSp (sede),
    PRIMARY KEY (n_serie)
)ENGINE=InnoDb;
DROP TABLE IF EXISTS Costituisce;
CREATE TABLE Costituisce ( 
    sede VARCHAR(3),
    reparto CHAR (4),
    FOREIGN KEY (sede) REFERENCES Sede (ID),
    FOREIGN KEY (reparto) REFERENCES Reparto (codice),
    PRIMARY KEY (sede, reparto)
)ENGINE=InnoDb;
DROP TABLE IF EXISTS EsameEffettuato;
CREATE TABLE EsameEffettuato (
    ID INT(11)auto_increment,
    paziente VARCHAR(16),
    tipo_esame VARCHAR(10),
    stanza TINYINT NOT NULL,
    terapia VARCHAR(100) NOT NULL, 
    diagnosi VARCHAR(100) NOT NULL,
    medico VARCHAR(20) NOT NULL,
    FOREIGN KEY(tipo_esame) REFERENCES TipoEsame(nome),
    FOREIGN KEY (paziente) REFERENCES Paziente(CF),
    PRIMARY KEY(ID)
)ENGINE=InnoDb;
DROP TABLE IF EXISTS PrenotazioneStanza;
CREATE TABLE PrenotazioneStanza (
    ID INT(11) auto_increment,
    data_inizio DATETIME NOT NULL,
    data_fine DATETIME NOT NULL,
    data_p DATETIME NOT NULL,
    pagamento BOOLEAN,
    paziente VARCHAR(16),
    stanza TINYINT,
    reparto CHAR(4),
    sede VARCHAR(2),
    PRIMARY KEY (ID),
    FOREIGN KEY (stanza) REFERENCES StanzaSP(n_stanza),
    FOREIGN KEY (reparto) REFERENCES StanzaSP(reparto),
    FOREIGN KEY (sede) REFERENCES StanzaSP(sede),
    FOREIGN KEY (paziente) REFERENCES Paziente(CF)
)ENGINE=InnoDb;