**Sede**  
telefono not null e unique  
indirizzo not null  
IDprimary key   
**Personale**  
IBAN not null   
CF primary key  
**Stipendio**  
tipo primary key  
imp_lordo not null  
**Macchinario**  
n_serie primary key  
**Stanza**  
chiave di stanza  
**Reparto**  
tipo unique  
codice primary key
**Paziente**  
CF primary key  
telefono not null  
indirizzo not null  
**EsameEffettuato**  
IDprimary key  
terapia not null  
diagnosi not null  
stanza not null  
medico not null  
**Prenotazione Esame**  
orario not null  
ID primary key  
data not null  
**PrenotazioneStanza**  
ID primary key  
data_p not null  
data_inizio not null  
data_fine not null  
**StanzaRi**  
prezzo_notte not null  
**TipoEsame**  
nome primary key  
prezzo not null  
