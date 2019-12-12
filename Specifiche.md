# Clinica Magi  
## Abstract  
<div style="text-align: justify"> 
Siamo nel 1958, il Prof. Vitangelo Moscarda, chirurgo ortopedico, e la moglie Ada fondano Clinica Magi. Il loro obiettivo è creare una nuova istituzione per soddisfare le crescenti necessità assistenziali dei cittadini vicentini, in campo ortopedico , traumatologico e non solo. Nel 1959 la clinica viene autorizzata per la gestione di 30 posti letto nella nuovissima sede in provincia di Vicenza, a Costabissara, un paesetto fondamentalmente di contadini, ma è qui che si decide di cominciare, dalle persone bisognose. All'inizio degli anni sessanta, la clinica comincia a disporre di 69 posti letto, e con l'arrivo del nuovo decennio viene aperta una seconda sede a Padova. Sotto la guida del Dr. Panzimonio (metà anni novanta, figlio di Vitangelo e Ada, che hanno da poco cessato di lavorare), la direzione sceglie di dare alla struttura un deciso indirizzo chirurgico con le specializzazioni di Ortopedia e Traumatologia, Chirurgia Generale, Chirurgia Plastica, Estetica e Oculistica, aprendo così una nuova sede a Verona. L’organico di medici e paramedici viene progressivamente ampliato e vengono avviate collaborazioni con specialisti d’eccellenza in diversi campi, che contribuiscono a consolidare l’identità della Clinica come centro di chirurgia all’avanguardia. Il percorso intrapreso porta, dunque, ad un pieno sviluppo dell’attività operatoria e quindi dei ricoveri in regime di degenza ordinaria. Con l’offerta di alcuni importanti servizi diagnostici come la Cardiologia, l’Endoscopia Digestiva e la Medicina di Laboratorio, la Clinica Magi diviene una delle più importanti cliniche del Veneto e d'Italia, proseguendo nel suo percorso di radicamento nel territorio nazionale e perfezionamento dei servizi assistenziali per i cittadini. Nel 2006 la Clinica è la prima struttura in Europa ad intraprendere la strada della chirurgia robotica, grazie alle collaborazioni con il Prof. Pier Cristoforo Giulianotti, che facilita la messa in luce di questa struttura, portando così il nome Magi ad essere conosciuto e apprezzatto in tutto il mondo. Nel 2018 la Clinica Magi è stata riconosciuta dalla Regione Veneto come “Struttura di riferimento per la chirurgia robotica”.

## Analisi dei requisiti  
Si vuole realizzare una base di dati che contenga e gestisca una clinica con più sedi sparse per il torritorio. La clinica presenta una serie di reparti, identificati da:  
- tipo  
- codice identificativo 

Ogni sede è identificata da:  
- località ( numero ivico, capoluogo e via )  
- id univoco  
- numero di telefono  

Ogni sede presenta più reparti, una serie di stanze per degenze, di cui si vuole conoscere:
- prezzo per notte  

e una serie di stanze in cui avvengono gli esami. In ogni stanza per esami ( o stanze specializzate ) sono presenti una serie di macchinari che vengono utilizzati per gli esami specifici, di ogni macchinario si vogliono memorizzare:
- dati relativi alla casa produttrice  
- il numero di serie  
- il nome del macchinario  
- la data dell'ultima revisione 

Tutte le stanze sono identificate da:  
- un numero  
- il reparto  
- la sede in cui sui trovano   

Ogni reparto offre una serie di esami, comuni ad ogni sede che presenta quel reparto, identificati da:  
- nome che lo identifica univocamente
- prezzo esame  

In ogni sede lavorano diversi dipendenti, di ogni sede vogliamo memorizzare: i dirigenti, identificati da  
- settore   

gli infermieri, identificati da:  
- grado   

i medici con  
- la propria specializzazione  

e i restanti dipendenti. Ogni dipendente in base al ruolo che ricopre percepirà uno stipendio fisso, di cui si vogliono memorizzare:  
- l'importo lordo  
- l'importo netto  

Di ogni dipendente si vuole tener traccia del:  
- nome   
- cognome  
- data di nascita  
- sesso  
- città di residenza  
- telefono  
- IBAN  
- codice fiscale, che lo identifica univocamente  

Clinica Magi tiene traccia dei pazienti che si sottopongono ai loro esami, di ogni paziene si vuole memorizzare:
- nome  
- cognome  
- sesso  
- telefono  
- indirizzo residenza  
- codice fiscale, che lo identifica univocamente

Di ogni paziente si vuole conoscere gli esami effettuati presso la clinica, ogni esame è caratterizzato da:
- stanza in cui è stato effettuato l'esame  
- diagnosi  
- terapia consigliata  
- medico che ha effettuato l'esame  
- nome (mettiamo anche se stanno nella gneraizzazione?)  
- codice esame (idem)  
- codice fiscale per identificarlo univocamente  

Un paziente può effettuare prenotazioni, sia per esami che per il ricovero. Per ogni prenotazione ci interessa conoscere:  
- data prenotazione  
- id univoco  
- se il pagamento è stato o meno effettuato  

Per la prenotazione i una stanza per il ricovero ci interessa conoscere:  
- la data inizio del ricovero  
- data fine ricovero  

Per la prenotazione dell'esame è di nostro interesse memorizzare:  
- orario in cui si effettuerà l'esame  

## Glossario dei termini  
<!-- mettiamo solo le entita' principali o anchge le generalizzazioni? -->
| Termine | Descrizione | Collegamento |
|:-------:|:-------:|:-------:|
| Sede | Una sede della clinica Magi <br> porcaccia la madonna | Reparto, Stanza, Persona |



Operazione|Tipo|Frequenza
-----------------------------------------------------|-------------------------------|---------------------------------------------
Apertura Sede | |1 Anno
Aggiunta Reparto| |1 ogni 5 anni
Assunzione nuovo dipendente| |2 al mese
Aggiunta paziente| |5 al giorno
Prenotazione esame| |100 al giorno
Prenotazione stanza ricovero| |30 al giorno
Verifica stanza ricovero| |5000 al giorno
Verifica stanze disponibili| |100 al giorno
Calcolo busta paga dipendente| |100 al mese
Calcolo spese totali paziente| |50 al giorno
Verifica pagamento| |5 al giorno
Verifica revisione macchinari| |10 al mese
Report incasso giornaliero| |5 al giorno
Report incasso mensile| |5 al mese
Incasso medio giornaliero| |5 al mese


---

Entita'|Descrizione|Attributi
---------------|-------------------------------------------------|--------------------
Sede| Si intende una delle sedi fisiche della clinica|id_sede{PK}, n_civico, CAP, Via, n.telefono
Reparto| Si intendono i reparti specialistici della clinica, differenziati per tipo e per locazione|id {PK}, Tipo
Stanze| Stanze generiche all'interno di ogni sede| n_stanza
StanzaRi| Entita' figlia di Stanze, identifica le stanze adibite al ricovero| prezzo_notte
StanzaSp| Entita' figlia di Stanze, identifica le stanze specialistiche della clinica.| *Nessun Attibuto*
Macchinari| Entita' che identifica il tipo di macchinario utilizzato per effettuare gli esami| n_serie{PK}, casa_prod, nome, ultima_rev
Personale| Entita' che indica le persone che lavorano nella clinica| CF{PK}, nome, cognome, data_nascita, sesso, telefono, CAP, via, n_civico
Personale non medico| Entita' figlia di Personale, specifica per il personale non medico| tipo
Dirigente| Entita' figlia di Personale, specifica per il dirigente della sede| settore
Infermieri| Entita' figlia di Personale, specifica per gli infermieri| grado
Medici| Entita' figlia di Personale, specifica per i medici| specializzazione
Primario| Entita' figlia di Medici, specifica il primario di un certo reparto| *Nessun Attributo*
Stipendio| Entita' che identifica lo stipendio di ogni tipo di lavoratore nella Clinica| id_tipo {PK}, imp_lordo, imp_netto
Pazienti| Entita' che racchiude le generalita' di un paziente| CF {PK}, nome, cognome, sesso, telefono, CAP, ind_residenza, n_civico
EsameEffettuato| Entita' che indica un esame che e' stato effettuato ad un paziente| id {PK}, stanza, diagnosi, medico, terapia
TipoEsame| Entita' che indica le varie tipologie di esame che sono disponibili nella Clinica| nome {PK}, prezzo
Prenotazione 
</div>
