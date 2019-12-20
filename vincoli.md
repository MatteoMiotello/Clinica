**Sede**  
telefono not null e unique  
indirizzo not null  
id primary key   
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
**Paziente**  
CF primary key  
telefono not null  
indirizzo not null  
**Prenotazione**  
id primary key  
data not null  
**EsameEffettuato**  
id primary key  
terapia not null  
diagnosi not null  
stanza not null  
medico not null  
**Prenotazione Esame**  
orario not null  
**PrenotazioneStanza**  
data_inizio not null  
data_fine not null  
**StanzaRi**  
prezzo_notte not null  
