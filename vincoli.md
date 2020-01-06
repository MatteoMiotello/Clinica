**Sede**  
>telefono not null e unique  
>indirizzo not null  
>IDprimary key   

**Personale**  
>IBAN not null   
>CF primary key  

**Stipendio**  
>tipo primary key  
>imp_lordo not null

**Macchinario**  
>n_serie primary key  

**StanzaSp**  
>n_stanza primary key

**StanzaRi**  
>n_stanza primary key
>prezzo_notte not null 

**Reparto**  
>tipo unique  
>codice primary key

**Paziente**  
>CF primary key  
>telefono not null  
>indirizzo not null  

**EsameEffettuato**  
>IDprimary key  
>stanza not null  
>medico not null  

**Prenotazione Esame**  
>data_e not null  
>ID primary key  
>data_p not null 
>data_e not null 

**PrenotazioneStanza**  
>ID primary key  
>data_p not null  
>data_inizio not null  
>data_fine not null  
>pagamento default 0

**StanzaRi**  
>n_stanza primary key
>prezzo_notte not null  

**TipoEsame**  
>nome primary key  
>prezzo not null  

**Macchinario**
>casa_prod not null
>ultima_revisione not null
