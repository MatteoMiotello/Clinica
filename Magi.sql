--CREAZIONE TABELLE--
DROP TABLE IF EXISTS Sede;
CREATE TABLE Sede (
    ID VARCHAR (3),
    CAP VARCHAR (5) NOT NULL,
    via VARCHAR (25) NOT NULL,
    n_civico SMALLINT NOT NULL,
    telefono VARCHAR (13) NOT NULL,
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
    nome VARCHAR (30),
    cognome VARCHAR (30),
    sesso ENUM ('M','F'),
    telefono VARCHAR (13),
    via VARCHAR (35) NOT NULL,
    n_civico TINYINT NOT NULL,
    CAP VARCHAR (5) NOT NULL,
    PRIMARY KEY (CF)
)ENGINE=InnoDb;
DROP TABLE IF EXISTS Personale;
CREATE TABLE Personale ( 
    CF VARCHAR (16),
    nome VARCHAR (30),
    cognome VARCHAR (30),
    datadinascita DATE,
    sesso ENUM ('M','F'),
    telefono VARCHAR (13),
    tipo VARCHAR (30),
    grado VARCHAR (30) default null,
    CAP VARCHAR (5),
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
    codice VARCHAR (4),
    tipo VARCHAR (25) UNIQUE,
    primario VARCHAR (16),
    FOREIGN KEY (primario) REFERENCES Personale (CF),
    PRIMARY KEY (codice)
)ENGINE=InnoDb;
DROP TABLE IF EXISTS Costituisce;
CREATE TABLE Costituisce ( 
    sede VARCHAR(3),
    reparto VARCHAR (4),
    FOREIGN KEY (sede) REFERENCES Sede (ID),
    FOREIGN KEY (reparto) REFERENCES Reparto (codice),
    PRIMARY KEY (sede, reparto)
)ENGINE=InnoDb;
DROP TABLE IF EXISTS StanzaSp;
CREATE TABLE StanzaSp ( 
    n_stanza TINYINT,
    sede VARCHAR (3),
    reparto VARCHAR (4),
    FOREIGN KEY (sede, reparto) REFERENCES Costituisce (sede, reparto),
    PRIMARY KEY (n_stanza, sede, reparto)
)ENGINE=InnoDb;
DROP TABLE IF EXISTS StanzaRi;
CREATE TABLE StanzaRi ( 
    n_stanza TINYINT,
    sede VARCHAR (3),
    reparto VARCHAR (4),
    prezzo_notte DECIMAL (6,2) NOT NULL,
    FOREIGN KEY (sede, reparto) REFERENCES Costituisce (sede,reparto),
    PRIMARY KEY (n_stanza, sede, reparto)
)ENGINE=InnoDb;
DROP TABLE IF EXISTS TipoEsame;
CREATE TABLE TipoEsame (
    nome VARCHAR(25),
    prezzo DECIMAL (6,2) NOT NULL,
    PRIMARY KEY (nome)
) ENGINE=InnoDb;
DROP TABLE IF EXISTS PrenotazioneStanza;
CREATE TABLE PrenotazioneStanza (
    ID INT(11) auto_increment,
    data_inizio DATETIME NOT NULL,
    data_fine DATETIME NOT NULL,
    data_p DATETIME NOT NULL,
    pagamento BOOLEAN default 0,
    paziente VARCHAR (16),
    n_stanza TINYINT,
    reparto VARCHAR (4),
    sede VARCHAR (3),
    FOREIGN KEY (n_stanza, sede, reparto) REFERENCES StanzaRi (n_stanza, sede, reparto),
    FOREIGN KEY (paziente) REFERENCES Paziente (CF),
    PRIMARY KEY (ID),
    constraint check_data CHECK((DATEDIFF(data_inizio,data_fine)<=0) AND (DATEDIFF(data_inizio,data_p)>=0))
)ENGINE=InnoDb;
DROP TABLE IF EXISTS PrenotazioneEsame;
CREATE TABLE PrenotazioneEsame (
    ID INT (11) auto_increment,
    data_p DATETIME NOT NULL,
    data_e DATETIME NOT NULL,    
    pagamento BOOLEAN,
    paziente VARCHAR(16),
    n_stanza TINYINT,
    reparto VARCHAR (4),
    sede VARCHAR (3),
    tipo VARCHAR(25),
    PRIMARY KEY (ID),
    FOREIGN KEY (n_stanza, sede, reparto) REFERENCES StanzaSp (n_stanza, sede, reparto),
    FOREIGN KEY (paziente) REFERENCES Paziente(CF),
    FOREIGN KEY (tipo) REFERENCES TipoEsame(nome),
    constraint check_data CHECK((DATEDIFF(data_e,data_p)>=0))
)ENGINE=InnoDb;
DROP TABLE IF EXISTS Macchinario;
CREATE TABLE Macchinario (
    n_serie VARCHAR (11),
    nome VARCHAR (30),
    casa_prod VARCHAR (30),
    ultima_revisione DATE NOT NULL,
    n_stanza TINYINT,
    reparto VARCHAR (4),
    sede VARCHAR (3),
    FOREIGN KEY (n_stanza, sede, reparto) REFERENCES StanzaSp (n_stanza, sede, reparto),
    PRIMARY KEY (n_serie)
)ENGINE=InnoDb;
DROP TABLE IF EXISTS EsameEffettuato;
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


CREATE INDEX idx_PrenotazioneEsame ON PrenotazioneEsame (data_e);

CREATE INDEX idx_PrenotazioneStanza ON PrenotazioneStanza (data_inizio, data_fine);

--POPOLAMENTO TABELLE

INSERT INTO Sede VALUES
("VI1","36100","Via roma", 2,"0444977328"),
("VI2","36040","Via dellindustria", 24 ,"0444354022"),
("PD1","35100","Via IV novembre", 39,"0492314458"),
("TR1","38014","Via Venezia",3 ,"0461556321"),
("BL1","32100","Via Col di Lana", 102,"0437823145");


INSERT INTO Stipendio VALUES 
("medico",2833, 3060),
("primario",3180, 3816),
("infermiere",2125, 2520),
("c.infermiere",2310,2772),
("segreteria",1750,2100),
("ata",1820,2184),
("tecnico",1960,2352);


INSERT INTO Personale VALUES
("MHMNCN37C42A001Z","INNOCENZA","MOHAMMADIAN","1937-03-02","F","3937815668","ata",NULL,"36033","Brioli",51,"IT60X0542811101000000123456","VI1"),
("MHDNCN37C42A001Z","CRISTIAN","GASTALDON","2006-06-05","M","3737815668","medico",NULL,"36032","Roma",50,"IT60X0542811101000000123455","VI2"),
("ANDDND68E05F399E","SARA","FORALOSSO","1999-12-01","F","3537815668","primario",NULL,"36031","Firenze",8,"IT60X0542811101000000123457","PD1"),
("DNDSVT65T22L477D","GIANNI","HU","2000-07-12","M","3337815668","infermiere",NULL,"36030","Pino",98,"IT60X0542811101000000123456","TR1"),
("CRRSVT56B27F399B","SALVATORE","CARRINO","1956-02-27","M","3137815668","ata",NULL,"36029","Ragazzi del 99",32,"IT60X0542811101000000123458","BL1"),
("DNDMRS64P60F399G","MAURA ROSARIA","DONADIO","1964-09-20","F","2937815668","segreteria",NULL,"36028","All'acqua",37,"IT60X0542811101000000123457","PD1"),
("DNDNCL76L24G786K","NICOLA","DONADIO","1976-07-24","M","2737815668","segreteria",NULL,"36027","Chiodo",21,"IT60X0542811101000000123459","TR1"),
("TCCDNC73D25F052A","DOMENICO SANTO","TUCCI","1973-04-25","M","2537815668","ata",NULL,"36026","Napoleone",94,"IT60X0542811101000000123458","PD1"),
("MNTNNR66M15F052I","ANTONIO ROCCO","MONTESANO","1966-08-15","M","2337815668","c.infermiere",NULL,"36025","Mazzini",47,"IT60X0542811101000000123460","PD1"),
("DNDSVT65W22L477D","SALVATORE","DONADIO","1965-12-22","M","2137815668","medico",NULL,"36024","Parigini",70,"IT60X0542811101000000123459","VI1"),
("FNCGLG68R05F399E","GIANLUIGI","FINOCCHIARO","2008-05-05","M","1937815668","primario",NULL,"36023","Sassolini",98,"IT60X0542811101000000123461","PD1"),
("BNDNDR90E15G712A","ANDREA","BENEDETTO","1990-05-15","F","1737815668","medico",NULL,"36022","Pisa",35,"IT60X0542811101000000123460","TR1"),
("BLLVCN72L22F052W","VINCENZO","BELLINO","1972-07-22","M","1537815668","tecnico",NULL,"36021","Milano",83,"IT60X0542811101000000123462","BL1"),
("PZZGPP79H15G786W","GIUSEPPE","PIZZOLLA","1979-06-15","M","1337815668","c.infermiere",NULL,"36020","Torino",39,"IT60X0542811101000000123461","TR1"),
("TCCVMR66P20F052Q","VITO MAURIZIO ANTONIO","TUCCI","1966-09-20","M","1137815668","infermiere",NULL,"36019","Giotto",15,"IT60X0542811101000000123463","VI2"),
("SCRRCC66H16F052M","ROCCO","SIFREDI","1966-06-16","M","6937815668","ata",NULL,"36018","Leopardi",69,"IT60X0542811101000000123462","BL1"),
("NNZMHL73M28L477R","MICHELE","IANNUZZI","1973-08-28","M","8737815668","ata",NULL,"36017","Navon",19,"IT60X0542811101000000123464","BL1"),
("SNTSFN61H24A942B","STEFANO GIOVANNI","SANTARCANGELO","1961-06-24","M","5378156689","ata",NULL,"36016","4 novembre",56,"IT60X0542811101000000123463","VI1"),
("CNTRFL58S08F399L","RAFFAELE","CONTE","1958-11-08","M","3378156689","tecnico",NULL,"36015","Gesù   Cristo",11,"IT60X0542811101000000123465","BL1"),
("STGGPP61A28A801X","GIUSEPPE","STIGLIANO","1961-01-28","M","1378156688","segreteria",NULL,"36014","Dei santi",89,"IT60X0542811101000000123464","BL1"),
("LMBNCL67L09I954F","NICOLA","LOMBARDI","1967-07-09","M","4621843326","infermiere",NULL,"36013","Giuseppe Maria",26,"IT60X0542811101000000123466","TR1"),
("DNDMRC78E20F839E","MARCO IGINO NICOLA","D'ANDREA","1978-05-20","M","4621843326","ata",NULL,"36012","Firenze",84,"IT60X0542811101000000123465","VI2"),
("MTRRCC76L16I954B","ROCCO","MATARRESE","1978-07-16","M","4621843326","segreteria",NULL,"36011","Ologna",12,"IT60X0542811101000000123467","BL1"),
("MTRGNN50T17I954Q","GIOVANNI","MATARRESE","1950-12-17","M","4621843326","medico",NULL,"36010","Bologna",91,"IT60X0542811101000000123466","VI1"),
("TRCGPR64P01F907M","GINO PROSPERO","TRUNCELLITO","1964-09-01","M","4621843326","medico",NULL,"36009","Lucrezia",51,"IT60X0542811101000000123468","TR1"),
("NTZVCN54M13F052E","VINCENZO","ANTEZZA","1954-08-13","M","4621843326","c.infermiere",NULL,"36008","Miotello",70,"IT60X0542811101000000123467","BL1"),
("RSSVCN63D28G712W","VINCENZO FABIO","RUSSO","1963-04-24","M","4621843326","tecnico",NULL,"36007","Vicenza",99,"IT60X0542811101000000123469","VI2"),
("QNTSVT69P09G712B","SALVATORE GAETANO","QUINTO","1969-09-09","M","4621843326","primario",NULL,"36006","Francesco Guardi",61,"IT60X0542811101000000123468","BL1"),
("VGGNCL76P13I954H","NICOLA","VIGGIANO","1976-09-13","M","4621843326","infermiere",NULL,"36005","Fornaci",96,"IT60X0542811101000000123470","PD1"),
("PZZDNC53D17F201X","DOMENICO","PIZZOLLA","1953-04-17","M","4621843326","segreteria",NULL,"36004","Murano",28,"IT60X0542811101000000123469","TR1"),
("BRTGPP69H27E093G","GIUSEPPE","BARTOLOMEO","1969-06-27","M","4621843326","ata",NULL,"36003","Bologna",17,"IT60X0542811101000000123471","VI1"),
("LZZMSL69B17I954Q","MARIO SALVATORE","LIUZZI","1969-02-17","M","4621843326","tecnico",NULL,"36002","Cristo Re",56,"IT60X0542811101000000123470","VI1"),
("DRANTN61M23F052U","ANTONIO","DARAIA","1961-08-23","M","4621843326","infermiere",NULL,"36001","4 novembre",91,"IT60X0542811101000000123472","PD1"),
("PCLNCL63A31D128G","NICOLA","PACILIO","1963-01-31","M","4621843326","primario",NULL,"36000","Ologna",84,"IT60X0542811101000000123471","PD1"),
("MRNFNC51B01G786M","FRANCESCO","MARINO","1951-02-01","M","4621843326","tecnico",NULL,"35999","Ragazzi del 99",46,"IT60X0542811101000000123473","VI1"),
("MRNNCL56B27H591V","NICOLA","MARINO","1956-02-27","M","4621843326","primario",NULL,"35998","Vicenza",76,"IT60X0542811101000000123472","BL1"),
("MRNTRN80P28L049T","ETTORE ANTONIO","MARINO","1980-09-28","M","4621843326","primario",NULL,"35997","Leopardi",50,"IT60X0542811101000000123474","VI1"),
("MRNDNC86E09G786Z","DOMENICO","MARINO","1986-05-09","M","4621843326","ata",NULL,"35996","Giuseppe Maria",80,"IT60X0542811101000000123473","VI1"),
("MGNVTI48A30F839B","VITO","MAGNANTE","1948-01-30","M","4621843326","medico",NULL,"35995","Miotello",65,"IT60X0542811101000000123475","VI1"),
("MNLGNN87M18I954Z","GIOVANNI","MANOLIO","1987-08-18","M","4621843326","c.infermiere",NULL,"35994","Firenze",17,"IT60X0542811101000000123474","VI1"),
("QNTFBA84M23F052A","FABIO","QUINTO","1984-08-23","M","4621843326","infermiere",NULL,"35993","Napoleone",27,"IT60X0542811101000000123476","PD1");


INSERT INTO Paziente VALUES
("FRGLLI43H50H807Q","Lilia","Fragomena","F","27929575179","Via Monte Amiata",88,"00013"),
("BRRMTA62T13C849G","Amato","Oberarzbacher","M","94811348628","Via Gino Cervi",61,"40133"),
("DNCNZR40B03H524V","Nazzareno","Dinicuta","M","53274431222","Via Enzo Ferrari",32,"40138"),
("VRTGLL30H56F782L","Gisella","Vertua","F","21812930663","Via Salita Ai Montesei",28,"38057"),
("GRSDMN53H08C025S","Damiano","Geroso","M","83359546844","Via Crocetta",41,"41122"),
("JNNPRM52C18B921X","Priamo","Janner","M","11255851796","Via Gorizia",65,"10028"),
("TRNGTN93M02A861A","Gastone","Troncia","M","39086145540","Corso Lamarmora",20,"15121"),
("NLZGNR50T67B808E","Gennara","Naluzzo","F","10036621415","Via Madre Teresa Di Calcutta",43,"27020"),
("VRCMRM58M50C473E","Miriam","Avarucci","F","67445358461","Via Emilia",9,"27058"),
("SCHLVN58R61G128E","Livia","Floreal","F","45012959842","Via Della Pace",83,"40010"),
("LAVSCH31D34A106D","Lavinia","Schepici","F","70553488357","Via Pio La Torre",29,"56025"),
("CLACAM31D34A106D","Claudia","Camolese","F","11211625374","Via Quiete",48,"91100"),
("BRUFIO31D34A106D","Bruto","Fiorentino","M","43354955876","VIA DELL'ABBONDANZA",70,"81044"),
("DANROM31D34A106D","Danilo","Romani","M","56180804718","VIA BARLETE",52,"10050"),
("ANNTRE31D34A106D","Annunziata","Trentino","F","8496239368","VICOLO BISSI",62,"87070"),
("CHRMON31D34A106D","Christian","Monaldo","M","72007013597","VIA BENELLI BRUNO",49,"73040"),
("ANTDAV31D34A106D","Antonio","Davide","M","98991630959","VIALE LOMBARDO MARCO",28,"66030"),
("BRUMIL31D34A106D","Brunilde","Milani","F","49349778045","VIA MISSIROLI ICILIO",8,"56126"),
("GABRUS31D34A106D","Gabriella","Russo","F","90121337261","VIA TOBAGI WALTER",75,"51020"),
("BIBFIO31D34A106D","Bibiana","Fiorentino","F","82556884279","VIA FIUMICELLO",77,"66010"),
("RENCOS31D34A106D","Renato","Costa","M","82950429426","VIA ALDINI ALDO",74,"10090"),
("ANGDEL31D34A106D","Angelico","Dellucci","M","41215828933","VIA RE FILIPPO",65,"60010"),
("BENLOD31D34A106D","Benedetta","Lo Duca","F","12171545341","VIA PIZZETTI ILDEBRANDO",40,"14037"),
("PIEGAL31D34A106D","Piera","Gallo","F","11392634501","VIA SEGURINI TERZO",31,"33029"),
("PIEBAR31D34A106D","Pietro","Barese","M","92705903959","VIA SAMARITANI AGIDE",34,"81057"),
("NAZBON31D34A106D","Nazzareno","Boni","M","24639678758","VIA ARGINE DESTRO SAVIO",25,"27020"),
("LIBONI31D34A106D","Liberata","Onio","F","42509345032","VIA DEL LAVORO",50,"2047"),
("ROBBER31D34A106D","Roberta","Bergamaschi","F","20263810109","VIA DE GASPERI ALCIDE",9,"89865"),
("CARGRE31D34A106D","Carmela","Greece","F","65998554520","VIA LA PALISSE JACQUES",81,"63030"),
("VALMON31D34A106D","Valter","Monaldo","M","57292251417","VIA HOLBEIN HANS",57,"56020"),
("VITGRE31D34A106D","Vitale","Greece","M","53925719081","VIA CHIESA DAMIANO",44,"31055"),
("RINNAP31D34A106D","Rina","Napolitani","F","8325776533","VIA CALLEGATI ARRIGO",62,"41013"),
("SARBEL31D34A106D","Sara","Bellucci","F","34688185637","VIA PRATO",64,"12040"),
("OMEBEN31D34A106D","Omero","Beneventi","M","24608590733","VIA MESINI DON GIOVANNI",41,"25014"),
("ADOFOL31D34A106D","Adolfa","Folliero","F","90076818265","VIA LAMA LUCIANO",34,"8020"),
("GERRIZ31D34A106D","Gerardo","Rizzo","M","77066837291","VIA BALDINI SANTI",62,"18100"),
("LIAMAZ31D34A106D","Lia","Mazzanti","F","49268155666","VIA TREDICI MARZO 1987",43,"44000"),
("IGODAV31D34A106D","Igor","Davide","M","13979579207","VIA FELISATTI GIROLAMO",0,"36063"),
("ORTPAL31D34A106D","Ortensia","Palerma","F","80189694064","VIA SILVAGNI DON NICOLA",13,"36050"),
("ALFIAD31D34A106D","Alfreda","Iadanza","F","64867015141","VIA TURCI DON MARIO",13,"12030"),
("NICCAS31D34A106D","Nicodemo","Castiglione","M","71785226750","VIA SALIETTI ALBERTO",22,"89861"),
("ABETOS31D34A106D","Abele","Toscano","F","89942846912","VIA GRANDI ACHILLE",38,"89812"),
("MARRIC31D34A106D","Maria Teresa","Ricci","F","16541655801","VIA MINGUZZI",86,"10095"),
("PATDEL31D34A106D","Patrizio","Dellucci","M","73225248338","VIA MATTEOTTI GIACOMO",96,"10144"),
("PIOMAN31D34A106D","Pio","Manfrin","M","65085605900","PIAZZALE SOPRANI WILMA",53,"9040"),
("MELMIL31D34A106D","Melania","Milanesi","F","78591194605","VIALE VIRGILIO PUBLIO MARONE",41,"86084"),
("EMICAL31D34A106D","Emiliano","Calabresi","M","96706036006","VIALE LUCANO ANNEO MARCO",85,"66030"),
("VIRGEN31D34A106D","Virgilio","Genovese","M","95461304010","PIAZZA COSTA ANDREA",97,"27010"),
("CARBRU31D34A106D","Carmela","Bruno","F","77108430623","VIA BARBONI ORAZIO",76,"60020"),
("ANTLON31D34A106D","Antonietta","Longo","F","53499013309","PIAZZALE ROSSI GIOVANNI BATTISTA",47,"46040"),
("DOLBRU31D34A106D","Dolcelino","Bruno","M","11170430739","VIA BUSMANTI DARIO",34,"56026"),
("SAVCAL31D34A106D","Saverio","Calabresi","M","63093145482","VIA ORIOLI LUIGI",6,"64010"),
("VIOSCH31D34A106D","Viola","Schiavone","F","30373846995","VIA CAPPI ALESSANDRO",30,"34075"),
("CORLOR31D34A106D","Corinna","Lorenzo","F","65174092664","VIA BAGNOLO",50,"16012"),
("ADATRE31D34A106D","Adalgisa","Trevisan","F","26171795661","VIA BIANCOLI FRATELLI",64,"26040"),
("SIMCAT31D34A106D","Simonetta","Cattaneo","F","45110162162","VIA MARIGNOLLI GIOVANNI",14,"12070"),
("MICBIA31D34A106D","Michelino","Bianchi","M","78863520241","VIA GARAVINI BRUNO",42,"44042"),
("FEDNAP31D34A106D","Fedra","Napolitani","F","71374319402","PIAZZA MAMELI GOFFREDO",69,"6070"),
("BEAFAL31D34A106D","Beatrice","Fallaci","F","71456025176","VIA LA TORRE PIO",36,"45010"),
("LEALON31D34A106D","Leardo","Longo","M","71007087661","VIA ABBA CESARE",30,"73030"),
("FABFER31D34A106D","Fabrizia","Ferrari","F","87167244621","VIA ACQUARA SUPERIORE",34,"74010"),
("ADAEND31D34A106D","Adalfredo","Endrizzi","M","6585778797","VIA COSTANTINI MARIO",44,"15020"),
("PLAFER31D34A106D","Placido","Ferri","M","93157946414","VIA DEI TRE LATI",55,"47824"),
("TIMMIL31D34A106D","Timotea","Milani","F","99713015776","VIA FABBRI",20,"81012"),
("WALCAS31D34A106D","Walter","Castiglione","M","20070103348","VIA SAVINIO ALBERTO",75,"61030"),
("CIRBIA31D34A106D","Ciriaco","Bianchi","F","75540787225","VICOLO CHIESA",73,"24060"),
("CESDEL31D34A106D","Cesare","Dellucci","M","73110928113","CARRAIA VANGATICCIO",19,"55010"),
("OLIFAN31D34A106D","Olinto","Fanucci","M","23444458830","CARRAIA CANOVA",62,"17026"),
("SANTRE31D34A106D","Santina","Trevisan","F","4680385287","VICOLO DEL SALE",88,"25041"),
("AMBTOS31D34A106D","Ambrosino","Toscano","M","67861435758","CARRARONE CHIESA",88,"28070"),
("ELIMAN31D34A106D","Elisa","Manfrin","F","47633584350","VICOLO CHIESA",12,"36070"),
("GIOFER31D34A106D","Gioele","Ferrari","M","78030878573","VIA SINISTRA CANALE MOLINETTO",58,"30035"),
("SANROM31D34A106D","Sandro","Romano","M","41749252965","CARRAIA GRAZIANI",1,"27020"),
("VINMIL31D34A106D","Vincenza","Milanesi","F","68746234151","CARRAIA SORBOLI",59,"61020"),
("EMAMAZ31D34A106D","Emanuela","Mazzi","F","81204350543","VIALE CABOTO",20,"36012"),
("DIOPIC31D34A106D","Dionisio","Piccio","M","29405724822","VIA MONTAGNOLA",59,"59100"),
("REBMAR31D34A106D","Rebecca","Marcelo","M","98008971365","PIAZZA MAZZINI GIUSEPPE",12,"46041"),
("BONFER31D34A106D","Bonacata","Ferrari","M","84074514355","VIA DEL DOTTORE",12,"45100"),
("DEMLOM31D34A106D","Demetrio","Lombardo","F","63422973486","VIA DEL BORGO",3,"52030"),
("MAUMIL31D34A106D","Maura","Milano","F","19725462627","VIA DORSO GUIDO",6,"41010"),
("NARFIO31D34A106D","Narciso","Fiorentino","M","7157228550","VIA NOCE TERESA",62,"16121"),
("CASLOR31D34A106D","Cassandra","Lori","F","7385227915","VIA FORLIVESE",74,"23035"),
("FACBER31D34A106D","Facino","Bergamaschi","M","1271243558","VIA BAGNOLO",74,"47018"),
("BERPIA31D34A106D","Berenice","Piazza","F","85973682713","VIA DISMANO",84,"95030"),
("GIOPIS31D34A106D","Giovanni","Pisani","M","43540909857","VIA STANDIANA",4,"61024"),
("BERSAG31D34A106D","Berengario","Sagese","M","30893851940","VIA DISMANINO",3,"6057"),
("IOLROS31D34A106D","Iolanda","Rossi","F","72923583276","VIA SANT'ALBERTO",95,"74020"),
("MACNAP31D34A106D","Macaria","Napolitani","F","8926850572","VIA FARINI EPAMINONDA",38,"12060"),
("FILBEL31D34A106D","Filomena","Bellucci","F","9643461949","VIA SAN VITALE STRADA STATALE",62,"41021"),
("ARTARC31D34A106D","Arturo","Arcuri","M","43043141320","VIA CASTELLO",95,"28040"),
("ANGCAL31D34A106D","Angelico","Calabrese","M","94221380204","VIA TORRES CAMILLO",19,"27020"),
("GINDER31D34A106D","Gina","DeRose","F","11002842795","VIA BUOZZI BRUNO",18,"55030"),
("NORLIE31D34A106D","Norberto","Li Fonti","M","96155725154","VIA PIERO DELLA FRANCESCA",10,"59011"),
("GAEMON31D34A106D","Gaetana","Monaldo","F","61040443954","VIA BALLARDINI GIUSEPPE",47,"17037"),
("ALVNAP31D34A106D","Alvisa","Napolitano","F","24413236084","VIA DEL TEATRO SOCJALE",86,"31059"),
("MELARC31D34A106D","Melissa","Arcuri","F","97782875431","VIA DALLA CHIESA CARLO ALBERTO",20,"24040"),
("OREBEL31D34A106D","Orestilla","Bellucci","F","31710947504","PARCO DEL SOLE",42,"88837"),
("MARPIC31D34A106D","Maria","Piccio","F","18416432099","PARCO PASSO DI SAN GERVASIO",34,"15021"),
("AMAMIL31D34A106D","Amaranto","Milanesi","M","3876602572","PARCO DELLA PACE",37,"38050"),
("ILDSAL31D34A106D","Ilda","Sal","F","29892064242","PARCO DEGLI ALBERI FATATI",39,"90121"),
("LINDEL31D34A106D","Lina","De Luca","F","38290444307","VIA CHIESA",82,"21052"),
("VIVNAP31D34A106D","Vivaldo","Napolitano","M","64847003137","VIA DELLA CILLA",41,"39056"),
("QUIPAD31D34A106D","Quirino","Padovesi","M","73274497608","VIA RICCI CORRADO",64,"165"),
("ISAGAL31D34A106D","Isaia","Gallo","M","19443278703","VIA SCHIAPPARELLI GIOVANNI VIRGILIO",65,"31020"),
("LODPIC31D34A106D","Lodovica","Piccio","F","47857141834","VIA FRISI PAOLO",17,"11020"),
("GERPIS31D34A106D","Gerardino","Pisani","M","38312261861","VIA BOZZI ALDO",41,"10010"),
("ERMLUC31D34A106D","Ermes","Lucchesi","F","70964376213","VIA BACCARINI ALFREDO",18,"73012"),
("ALISCH31D34A106D","Alighiero","Schiavone","M","68393558487","VIA QUASIMODO SALVATORE",51,"23865"),
("STACAL31D34A106D","Stanislao","Calabrese","M","15950054543","VIA PACIOLI LUCA",12,"87060"),
("ADRBRU31D34A106D","Adriana","Bruno","F","38123426466","LUNGOMARE COLOMBO CRISTOFORO",99,"19010"),
("ORAUDI31D34A106D","Orazio","Udinesi","M","43464406331","VICOLO CHIESA",65,"10068"),
("OFERIC31D34A106D","Ofelia","Ricci","F","4931853274","VIALE ALBERTI LEON BATTISTA",21,"12010");

INSERT INTO Reparto VALUES
("CHMA","Maxillo","ANDDND68E05F399E"),
("CHVA","Chirurgia vascolare","FNCGLG68R05F399E"),
("MEDE","Dermatologia","QNTSVT69P09G712B"),
("MEFI","Fisioterapia","PCLNCL63A31D128G"),
("CHGE","Chirurgia Generale","MRNTRN80P28L049T");

Insert Into Costituisce VALUES
("VI1","CHMA"),
("VI1","CHVA"),
("VI1","MEDE"),
("VI1","MEFI"),
("VI1","CHGE"),
("VI2","CHMA"),
("VI2","CHVA"),
("VI2","MEDE"),
("VI2","MEFI"),
("VI2","CHGE"),
("PD1","CHMA"),
("PD1","CHVA"),
("PD1","MEDE"),
("PD1","MEFI"),
("PD1","CHGE"),
("TR1","CHMA"),
("TR1","CHVA"),
("TR1","MEDE"),
("TR1","MEFI"),
("TR1","CHGE"),
("BL1","CHMA"),
("BL1","CHVA"),
("BL1","MEDE"),
("BL1","MEFI"),
("BL1","CHGE");

INSERT INTO StanzaRi VALUES 
(1,"VI1","CHMA",20),
(2,"VI1","CHVA",20),
(3,"VI1","MEDE",20),
(4,"VI1","MEFI",20),
(5,"VI1","CHGE",30),
(6,"VI1","CHMA",30),
(7,"VI1","CHVA",30),
(8,"VI1","MEDE",30),
(9,"VI1","MEFI",30),
(10,"VI1","CHGE",50),
(11,"VI1","CHMA",50),
(12,"VI1","CHVA",50),
(13,"VI1","MEDE",50),
(14,"VI1","MEFI",50),
(15,"VI1","CHGE",50),
(1,"VI2","CHMA",20),
(2,"VI2","CHVA",20),
(3,"VI2","MEDE",20),
(4,"VI2","MEFI",20),
(5,"VI2","CHGE",30),
(6,"VI2","CHMA",30),
(7,"VI2","CHVA",30),
(8,"VI2","MEDE",30),
(9,"VI2","MEFI",30),
(10,"VI2","CHGE",50),
(11,"VI2","CHMA",50),
(12,"VI2","CHVA",50),
(13,"VI2","MEDE",50),
(14,"VI2","MEFI",50),
(15,"VI2","CHGE",50),
(1,"PD1","CHMA",20),
(2,"PD1","CHVA",20),
(3,"PD1","MEDE",20),
(4,"PD1","MEFI",20),
(5,"PD1","CHGE",30),
(6,"PD1","CHMA",30),
(7,"PD1","CHVA",30),
(8,"PD1","MEDE",30),
(9,"PD1","MEFI",30),
(10,"PD1","CHGE",50),
(11,"PD1","CHMA",50),
(12,"PD1","CHVA",50),
(13,"PD1","MEDE",50),
(14,"PD1","MEFI",50),
(15,"PD1","CHGE",50),
(1,"TR1","CHMA",20),
(2,"TR1","CHVA",20),
(3,"TR1","MEDE",20),
(4,"TR1","MEFI",20),
(5,"TR1","CHGE",30),
(6,"TR1","CHMA",30),
(7,"TR1","CHVA",30),
(8,"TR1","MEDE",30),
(9,"TR1","MEFI",30),
(10,"TR1","CHGE",50),
(11,"TR1","CHMA",50),
(12,"TR1","CHVA",50),
(13,"TR1","MEDE",50),
(14,"TR1","MEFI",50),
(15,"TR1","CHGE",50),
(1,"BL1","CHMA",20),
(2,"BL1","CHVA",20),
(3,"BL1","MEDE",20),
(4,"BL1","MEFI",20),
(5,"BL1","CHGE",30),
(6,"BL1","CHMA",30),
(7,"BL1","CHVA",30),
(8,"BL1","MEDE",30),
(9,"BL1","MEFI",30),
(10,"BL1","CHGE",50),
(11,"BL1","CHMA",50),
(12,"BL1","CHVA",50),
(13,"BL1","MEDE",50),
(14,"BL1","MEFI",50),
(15,"BL1","CHGE",50);

INSERT INTO StanzaSp VALUES 
(100,"VI1","CHMA"),
(102,"VI1","CHVA"),
(103,"VI1","MEDE"),
(104,"VI1","MEFI"),
(105,"VI1","CHGE"),
(101,"VI2","CHMA"),
(102,"VI2","CHVA"),
(103,"PD1","MEDE"),
(104,"PD1","MEFI"),
(105,"PD1","CHGE"),
(101,"TR1","CHVA"),
(102,"TR1","MEDE"),
(103,"TR1","MEFI"),
(104,"TR1","CHGE"),
(101,"BL1","MEDE"),
(102,"BL1","MEFI"),
(103,"BL1","CHGE");

Insert Into TipoEsame (nome, prezzo) values
("TAC",100),
("Ecografia",70),
("Visita medica",75),
("Visita chirurgica",85),
("Prelievo",45);

Insert Into PrenotazioneStanza (data_inizio, data_fine, data_p, pagamento, paziente, n_stanza, reparto, sede) VALUES
("2020-01-10","2020-01-15","2020-01-04",1,"FRGLLI43H50H807Q",1,"CHMA","VI1"),
("2020-02-11","2020-02-16","2020-01-03",0,"BRRMTA62T13C849G",3,"MEDE","PD1"),
("2020-02-12","2020-02-17","2020-01-02",0,"DNCNZR40B03H524V",10,"CHGE","BL1"),
("2020-02-05","2020-02-13","2020-01-01",1,"VRTGLL30H56F782L",12,"CHVA","TR1"),
("2020-02-14","2020-02-19","2019-12-31",0,"BENLOD31D34A106D",2,"CHVA","VI1"),
("2020-02-15","2020-02-20","2019-12-30",0,"JNNPRM52C18B921X",5,"CHGE","VI2"),
("2020-02-16","2020-02-21","2019-12-29",0,"TRNGTN93M02A861A",7,"CHVA","VI2"),
("2020-01-01","2020-01-30","2019-01-10",1,"NLZGNR50T67B808E",14, "MEFI", "VI1"),
("2020-01-01","2020-01-04","2019-01-01",1,"SCHLVN58R61G128E",8, "MEDE", "PD1");

INSERT INTO PrenotazioneEsame (data_p, data_e, pagamento, paziente, n_stanza, reparto, sede, tipo) values
("2020-01-01 08:07:22","2020-01-10 08:07:22",1,"ANNTRE31D34A106D",100,"CHMA","VI1","TAC"),
("2019-02-02 09:07:22","2019-02-08 09:07:22",0,"CHRMON31D34A106D",102,"MEFI","BL1","Ecografia"),
("2019-03-03 10:07:22","2020-03-03 10:07:22",0,"ANTDAV31D34A106D",102,"MEDE","TR1","Visita medica"),
("2019-01-01 08:07:23","2019-08-09 08:07:23",0,"BRUMIL31D34A106D",104,"MEFI","VI1","Visita chirurgica"),
("2020-01-02 09:07:23","2020-01-02 09:07:23",1,"GABRUS31D34A106D",105,"CHGE","VI1","Prelievo"),
("2019-03-03 10:07:23","2020-01-10 08:07:23",1,"BIBFIO31D34A106D",102,"MEFI","BL1","TAC"),
("2019-01-01 08:07:24","2019-02-08 09:07:23",1,"RENCOS31D34A106D",103,"MEDE","VI1","Ecografia"),
("2019-02-02 09:07:24","2019-03-03 10:07:23",1,"ANGDEL31D34A106D",104,"MEFI","PD1","Visita medica"),
("2019-03-03 10:07:24","2019-08-09 08:07:24",1,"PIEGAL31D34A106D",101,"CHVA","TR1","Visita chirurgica"),
("2019-01-01 08:07:25","2019-02-02 09:07:24",1,"PIEBAR31D34A106D",103,"MEFI","TR1","Prelievo"),
("2019-02-02 09:07:25","2020-01-10 08:07:24",1,"NAZBON31D34A106D",102,"MEDE","TR1","TAC"),
("2019-03-03 10:07:25","2020-02-08 09:07:24",1,"LIBONI31D34A106D",104,"MEFI","VI1","Ecografia"),
("2019-01-01 08:07:26","2019-03-03 10:07:24",0,"ROBBER31D34A106D",105,"CHGE","VI1","Visita medica"),
("2019-02-02 09:07:26","2019-08-09 08:07:25",0,"CARGRE31D34A106D",102,"CHVA","VI1","Visita chirurgica"),
("2019-03-03 10:07:26","2020-02-02 09:07:25",0,"VALMON31D34A106D",103,"CHGE","BL1","Prelievo"),
("2019-01-01 08:07:27","2019-01-10 08:07:25",0,"VITGRE31D34A106D",104,"CHGE","TR1","TAC"),
("2019-02-02 09:07:27","2019-02-08 09:07:25",0,"RINNAP31D34A106D",101,"MEDE","BL1","Ecografia"),
("2019-03-03 10:07:27","2020-03-03 10:07:25",0,"SARBEL31D34A106D",103,"MEFI","TR1","Visita medica"),
("2019-01-01 08:07:28","2020-08-09 08:07:26",0,"OMEBEN31D34A106D",102,"MEDE","TR1","Visita chirurgica"),
("2019-02-02 09:07:28","2020-02-02 09:07:26",0,"ADOFOL31D34A106D",104,"CHGE","TR1","Prelievo"),
("2019-03-03 10:07:28","2020-01-10 08:07:26",0,"GERRIZ31D34A106D",105,"CHGE","PD1","TAC"),
("2019-01-01 08:07:29","2019-02-08 09:07:26",0,"LIAMAZ31D34A106D",102,"MEFI","BL1","Ecografia"),
("2019-02-02 09:07:29","2019-03-03 10:07:26",0,"IGODAV31D34A106D",103,"MEDE","VI1","Visita medica"),
("2019-03-03 10:07:29","2019-08-09 08:07:27",1,"DEMLOM31D34A106D",104,"MEFI","VI1","Visita chirurgica"),
("2019-01-01 08:07:30","2019-02-02 09:07:27",1,"ALFIAD31D34A106D",101,"MEDE","BL1","Prelievo");

Insert Into Macchinario VALUES
(23927102734,"Armadio porta farmaci","quirumed","2019-10-10",101,"CHMA","VI2"),
(23927102740,"Aspiratore","quirumed","2019-10-11",102,"CHVA","VI2"),
(23927102746,"ECG","quirumed","2019-10-12",102,"CHVA","VI1"),
(23927102752,"Autoclave","quirumed","2019-10-13",104,"CHGE","TR1"),
(23927102758,"Armadio porta farmaci","quirumed","2019-10-14",101,"MEDE","BL1"),
(23927102764,"Aspiratore","quirumed","2019-10-15",103,"MEFI","TR1"),
(23927102770,"ECG","quirumed","2019-10-16",103,"MEDE","PD1"),
(23927102776,"Autoclave","quirumed","2019-10-17",104,"MEFI","PD1");

Insert Into EsameEffettuato (paziente, tipo_esame, stanza, terapia, diagnosi, medico) Values
("VINMIL31D34A106D","TAC","1VI1CHMA",Null,Null,"MHMNCN37C42A001Z"),
("VIOSCH31D34A106D","Ecografia","2VI1CHVA",Null,Null,"DNDSVT65T22L477D"),
("VIRGEN31D34A106D","Visita medica","3VI1MEDE",Null,Null,"BNDNDR90E15G712A"),
("PIOMAN31D34A106D","Visita chirurgica","4VI1MEFI",Null,Null,"MTRGNN50T17I954Q"),
("QUIPAD31D34A106D","TAC","5VI1CHGE",Null,Null,"TRCGPR64P01F907M"),
("MELARC31D34A106D","Visita chirurgica","1VI2CHMA",Null,Null,"MGNVTI48A30F839B"),
("GIOFER31D34A106D","TAC","2VI2CHVA",Null,Null,"MGNVTI48A30F839B"),
("JNNPRM52C18B921X","Ecografia","3VI2MEDE",Null,Null,"TRCGPR64P01F907M");

--QUERY

--1
SELECT DISTINCT StanzaRi.n_stanza as Numero_stanza FROM StanzaRi
WHERE StanzaRi.sede="PD1" AND StanzaRi.reparto="MEFI" AND StanzaRi.n_stanza NOT IN  
(SELECT DISTINCT PrenotazioneStanza.n_stanza    
FROM PrenotazioneStanza, StanzaRi   
WHERE PrenotazioneStanza.sede=StanzaRi.sede  AND PrenotazioneStanza.reparto=StanzaRi.reparto AND PrenotazioneStanza.n_stanza=StanzaRi.n_stanza   
AND DATEDIFF(PrenotazioneStanza.data_fine, CURDATE())>0  AND DATEDIFF(PrenotazioneStanza.data_inizio, CURDATE())<0   
AND StanzaRi.reparto="MEFI" AND StanzaRi.sede="PD1" );

--2
SELECT PrenotazioneStanza.reparto AS Reparto, PrenotazioneStanza.n_stanza As Stanza  
FROM Paziente, PrenotazioneStanza  
WHERE PrenotazioneStanza.sede="VI1" AND Paziente.nome="Demetrio" AND Paziente.cognome="Lombardo" AND Paziente.CF=PrenotazioneStanza.paziente AND (DATEDIFF(PrenotazioneStanza.data_inizio, CURDATE()) = 0 OR DATEDIFF(PrenotazioneStanza.data_inizio, CURDATE()) < 0) AND DATEDIFF(PrenotazioneStanza.data_fine, CURDATE()) > 0;

--3
SELECT sum(TOT) AS totale FROM (SELECT sum(StanzaRi.prezzo_notte) as TOT FROM StanzaRi, PrenotazioneStanza WHERE StanzaRi.sede="VI1" AND   StanzaRi.sede=PrenotazioneStanza.sede   
AND StanzaRi.reparto=PrenotazioneStanza.reparto AND StanzaRi.n_stanza=PrenotazioneStanza.n_stanza   
AND PrenotazioneStanza.data_fine BETWEEN '2019-01-04' AND '2019-01-17' AND PrenotazioneStanza.pagamento=1 group by StanzaRi.sede  
UNION  
SELECT sum(TipoEsame.prezzo) AS SUM1  
FROM PrenotazioneEsame, TipoEsame WHERE PrenotazioneEsame.sede="VI1" AND PrenotazioneEsame.tipo=TipoEsame.nome AND  
PrenotazioneEsame.data_e BETWEEN '2020-01-01 ' AND '2020-02-01' AND PrenotazioneEsame.pagamento=1  
group by sede) AS sub1;  

--4
SELECT sum(TOT) As totale_da_pagare FROM (SELECT sum(StanzaRi.prezzo_notte)*(DATEDIFF(PrenotazioneStanza.data_fine, PrenotazioneStanza.data_inizio)+1) as TOT  
FROM Paziente, PrenotazioneStanza, StanzaRi  
WHERE Paziente.nome="Benedetta" AND Paziente.cognome="Lo Duca" AND Paziente.CF=PrenotazioneStanza.paziente AND PrenotazioneStanza.sede=StanzaRi.sede  
AND PrenotazioneStanza.reparto=StanzaRi.reparto AND PrenotazioneStanza.n_stanza=StanzaRi.n_stanza AND PrenotazioneStanza.pagamento=0 
UNION SELECT sum(TipoEsame.prezzo) FROM TipoEsame,PrenotazioneEsame, Paziente  
WHERE Paziente.nome="Benedetta" AND Paziente.cognome="Lo Duca" AND TipoEsame.nome=PrenotazioneEsame.tipo AND Paziente.CF=PrenotazioneEsame.paziente AND PrenotazioneEsame.pagamento=0) as sub1; 

--5
SELECT StanzaSp.sede, StanzaSp.n_stanza, StanzaSp.reparto,Macchinario.n_serie 
FROM StanzaSp, Macchinario  
WHERE Macchinario.sede=StanzaSp.sede AND Macchinario.reparto=StanzaSp.reparto   
AND StanzaSp.n_stanza=Macchinario.n_stanza AND DATEDIFF(CURDATE(),Macchinario.ultima_revisione)>=30;

--6
SELECT ROUND((sum(TOT)/(DATEDIFF("2020-02-01","2020-01-01")+1)),2) AS Guadagno_giornaliero_medio FROM (SELECT sum(StanzaRi.prezzo_notte) as TOT FROM StanzaRi, PrenotazioneStanza WHERE StanzaRi.sede="VI1" AND   StanzaRi.sede=PrenotazioneStanza.sede   
AND StanzaRi.reparto=PrenotazioneStanza.reparto AND StanzaRi.n_stanza=PrenotazioneStanza.n_stanza   
AND PrenotazioneStanza.data_fine BETWEEN '2020-01-01' AND '2020-02-01' AND PrenotazioneStanza.pagamento=1 group by StanzaRi.sede  
UNION  
SELECT sum(TipoEsame.prezzo) AS SUM1  
FROM PrenotazioneEsame, TipoEsame WHERE PrenotazioneEsame.sede="VI1" AND PrenotazioneEsame.tipo=TipoEsame.nome AND  
PrenotazioneEsame.data_e BETWEEN '2020-01-01 ' AND '2020-02-01' AND PrenotazioneEsame.pagamento=1  
group by sede) AS sub1;

--7
SELECT ROUND(AVG(Stipendio.imp_netto), 0) AS Stipendio_medio_personale  
FROM Personale inner join Stipendio on(Personale.tipo=Stipendio.tipo);

--8
SELECT ROUND((SELECT count(*) FROM EsameEffettuato)/(SELECT count(*) FROM Paziente),0) AS Media_esami_paziente;

--9
SELECT Personale.nome, Personale.cognome, Personale.tipo FROM Personale, Sede WHERE Personale.sede=Sede.ID AND Sede.ID="VI1" GROUP BY Personale.nome, Personale.cognome, Personale.tipo order by Personale.tipo;

--10
SELECT COUNT(Personale.sede), Sede.ID FROM Personale, Sede WHERE Personale.sede=Sede.ID GROUP BY Sede.ID;