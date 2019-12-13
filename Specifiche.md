
# Clinica Magi  
## Abstract  

<p align= "justify"> 
Siamo nel 1958, il Prof. Vitangelo Moscarda, chirurgo ortopedico, e la moglie Ada fondano Clinica Magi. Il loro obiettivo è creare una nuova istituzione per soddisfare le crescenti necessità assistenziali dei cittadini vicentini, in campo ortopedico , traumatologico e non solo. Nel 1959 la clinica viene autorizzata per la gestione di 30 posti letto nella nuovissima sede in provincia di Vicenza, a Costabissara, un paesetto fondamentalmente di contadini, ma è qui che si decide di cominciare, dalle persone bisognose. All'inizio degli anni sessanta, la clinica comincia a disporre di 69 posti letto, e con l'arrivo del nuovo decennio viene aperta una seconda sede a Padova. Sotto la guida del Dr. Panzimonio (metà anni novanta, figlio di Vitangelo e Ada, che hanno da poco cessato di lavorare), la direzione sceglie di dare alla struttura un deciso indirizzo chirurgico con le specializzazioni di Ortopedia e Traumatologia, Chirurgia Generale, Chirurgia Plastica, Estetica e Oculistica, aprendo così una nuova sede a Verona. L’organico di medici e paramedici viene progressivamente ampliato e vengono avviate collaborazioni con specialisti d’eccellenza in diversi campi, che contribuiscono a consolidare l’identità della Clinica come centro di chirurgia all’avanguardia. Il percorso intrapreso porta, dunque, ad un pieno sviluppo dell’attività operatoria e quindi dei ricoveri in regime di degenza ordinaria. Con l’offerta di alcuni importanti servizi diagnostici come la Cardiologia, l’Endoscopia Digestiva e la Medicina di Laboratorio, la Clinica Magi diviene una delle più importanti cliniche del Veneto e d'Italia, proseguendo nel suo percorso di radicamento nel territorio nazionale e perfezionamento dei servizi assistenziali per i cittadini. Nel 2006 la Clinica è la prima struttura in Europa ad intraprendere la strada della chirurgia robotica, grazie alle collaborazioni con il Prof. Pier Cristoforo Giulianotti, che facilita la messa in luce di questa struttura, portando così il nome Magi ad essere conosciuto e apprezzatto in tutto il mondo. Nel 2018 la Clinica Magi è stata riconosciuta dalla Regione Veneto come “Struttura di riferimento per la chirurgia robotica”.
</p>

## Analisi dei requisiti  
Si vuole realizzare una base di dati che contenga e gestisca una clinica con più sedi sparse per il torritorio. La clinica presenta una serie di reparti, identificati dal tipo di reparto e da un codice identificativo. La clinica presenta più sedi, ognuna di esse deve essere identificata dalla località in cui si trova (numero civico, capoluogo e via), un id univoco, e un numero di telefono, in modo tale da poter essere contattati. Ogni sede presenta uno o più reparti, ogni reparto in ogni sede presenta più stanze, identificate da un numero, dal reparto a cui appartengono e dalla sede in cui si trovano. Vengono identificate due tipi di stanze, la stanza per il ricovero, nel caso in cui un paziente debba intrattenersi più giorni nella clinica per effettuare esami o per degenza, che presenta un prezzo per notte in base al tipo di stanza che il paziente sceglie; e la stanza specializzata, in cui vengono effettuati gli esami. Ogni stanza specializzata contiene al suo interno una serie di macchinari, identificati dal nome, dalla casa produttrice, un numero di serie e una data dell'ultima revisione effettuata su tal macchinario. Un paziente, di cui si vuole memoriare il nome, il cognome, il sesso, l'indirizzo di residenza (numero civico, capoluogo e via), il numero di telefono e il codice fiscale per identificarlo univocamente, può effettuare delle prenotazioni. Ogni prenotazione e' identificata da un id univoco, dalla data in cui e' stata fatta la prenotazione e un campo pagamento usato per capire se e' gia' stato effettuato o meno il versamento dei soldi. Ogni prenotazione di un esame e' riferito ad un tipo di esame specifico, per tale tipo di prenotazione si vuole memorizzare l'ora in cui verra' effettuato, in modo da poter gestire le prenotazioni con le stanze disponibili. Ogni tipo di esame e' comune ad ogni sede che presenta quel reparto, e si vuole memorizzare il nome, che lo identifica univocamente, e il prezzo. Ogni prenotazione di una stanza riserva una stanza ricovero, di tale prenotazione vogliamo conoscere la data di inizio prenotazione e la data in cui la stanza verra' liberata. Un paziente puo' effetturare degli esami. Degli esami effettuati vogliamo memorizzare la stanza in cui e' stata effettuato, la diagnosi, la terapia, il medico che ha effettuato l'esame, il nome e il prezzo dell'esame. In ogni sede lavorano diversi dipendenti, di ogni sede vogliamo memorizzare: i dirigenti, identificati dal settore, gli infermieri, identificati dal grado , i medici con la propria specializzazione e i restanti dipendenti. Ogni dipendente in base al ruolo che ricopre percepirà uno stipendio fisso, di cui si vogliono memorizzare l'importo lordo e l'importo netto. Di ogni dipendente si vuole tener traccia del: nome, cognome, data di nascita, sesso, residenza (numero civico, capoluogo e via), telefono, IBAN per versare mensilmente lo stipendio e codice fiscale che lo identifica in modo univoco.  
## Glossario dei termini  

| Termine | Descrizione | Collegamento |
|:-------:|:-------|:-------:|
| Sede | Una sede della clinica Magi | Reparto, Stanza, Persona |
| Personale | Lavoratore della clinca, si suddivide in PersonaleNonMedico <br> Dirigenti, Infermieri e Medici. Primario è una specializzazione di Medici | Reparto, Stanza, Persona |
| Stanza | Una stanza di una Sede, si suddivide in StanzaRi e StanzaSp. | PrenotazioneStanza (StanzaRi), PrenotazioneEsame(StanzaSp), Macchinario (StanzaSp)| 
| Reparto | Reparto contiene tutti i reparti che la clinica possiede(NB: non e' detto che all'interno di una sede vi siano tutti i Reparti) | Sede, Primario, Stanze, Tipo Esame |
| Paziente | Un paziente della clinica | Esame Effettuato, Prenotazione |
| Tipo Esame | Rappresenta tutti gli esami che sono possibili fare nella clinica Magi. <br> Esame Effettuato e' una specializzazione di Tipo Esame | PrenotazioneEsame |
| Prenotazione | Rappresenta le prenotazioni che l'utente puo' fare (PrenotazioneEsame) <br> e quelle che vengono fatte dal personale interno (PrenotazioneStanze)|StanzaRi(PrenotazioneStanza), StanzaSp |
| Stipendio | Lo stipendio percepito dal personale | Personale |
| Macchinario | Macchinario usato per gli esami | StanzaSp |

## Strutturazione dei requisiti  
| Frasi relative a Sede |
| :------------------- |
| La clinica presenta più sedi, ognuna di esse deve essere identificata dalla località in cui si trova (numero civico, capoluogo e via), un id univoco, e un numero di telefono, in modo tale da poter essere contattati. Ogni sede presenta uno o più reparti.. In ogni sede lavorano diversi dipendenti, di ogni sede vogliamo memorizzare: i dirigenti, identificati dal settore, gli infermieri, identificati dal grado , i medici con la propria specializzazione e i restanti dipendenti |  

| Camadonna |
| :-------- |
| ciaone |
Operazione|Tipo|Frequenza
-----------------------------------------------------|-------------------------------|---------------------------------------------
Apertura Sede | |1 Anno
Aggiunta Reparto| |1 ogni 5 anni
Assunzione nuovo dipendente| |2 al mese
Aggiunta paziente| |5 al giorno
Prenotazioneesame| |100 al giorno
PrenotazioneStanzaRi| |30 al giorno
Verifica StanzaRi| |5000 al giorno
Verifica stanze disponibili| |100 al giorno
Calcolo busta paga dipendente| |100 al mese
Calcolo spese totali paziente| |50 al giorno
Verifica pagamento| |5 al giorno
Verifica revisione macchinari| |10 al mese
Report incasso giornaliero| |5 al giorno
Report incasso mensile| |5 al mese
Incasso medio giornaliero| |5 al mese


---

## Tabella delle entità 

Entita'|Descrizione|Attributi
---------------|-------------------------------------------------|--------------------
Sede| Si intende una delle sedi fisiche della clinica|id_sede{PK}, n_civico, CAP, Via, n.telefono
Reparto| Si intendono i reparti specialistici della clinica, differenziati per tipo e per locazione|id {PK}, Tipo
Stanza| Stanze generiche all'interno di ogni sede| n_stanza
StanzaRi| Entita' figlia di Stanze, identifica le stanze adibite al ricovero| prezzo_notte
StanzaSp| Entita' figlia di Stanze, identifica le stanze specialistiche della clinica.| *Nessun Attibuto*
Macchinari| Entita' che identifica il tipo di macchinario utilizzato per effettuare gli esami| n_serie{PK}, casa_prod, nome, ultima_rev
Personale| Entita' che indica le persone che lavorano nella clinica| CF{PK}, nome, cognome, data_nascita, sesso, telefono, CAP, via, n_civico
Personale non medico| Entita' figlia di Personale, specifica per il personale non medico| tipo
Dirigente| Entita' figlia di Personale, specifica per il dirigente della sede| settore
Infermieri| Entita' figlia di Personale, specifica per gli infermieri| grado
Medico| Entita' figlia di Personale, specifica per i medici| specializzazione
Primario| Entita' figlia di Medici, specifica il primario di un certo reparto| *Nessun Attributo*
Stipendio| Entita' che identifica lo stipendio di ogni tipo di lavoratore nella Clinica| tipo {PK}, imp_lordo, imp_netto
Pazienti| Entita' che racchiude le generalita' di un paziente| CF {PK}, nome, cognome, sesso, telefono, CAP, ind_residenza, n_civico
EsameEffettuato| Entita' che indica un esame che e' stato effettuato ad un paziente| id {PK}, stanza, diagnosi, medico, terapia
TipoEsame| Entita' che indica le varie tipologie di esame che sono disponibili nella Clinica| nome {PK}, prezzo
Prenotazione| Entita' che indica la prenotazione avvenuta| Id{PK}, tipo, data, pagamento
PrenotazioneEsame| Entita' figlia di Prenotazione, specifica per la prenotazione di un esame| *Nessun attributo*
PrenotazioneStanza| Entita' figlia di Prenotazione, specifica per la prenotazione di una stanza| *Nessun attributo*

## Progettazione concettuale

### Analisi delle entita'


Sede||||
-----------------|-------|----------------------------|----------
id_Sede|VARCHAR| identifica univocamente le sedi| **Chiave**
Indirizzo|VARCHAR| attributo composto: Citta', Via, n_civico, CAP
n_telefono|VARCHAR| numero di telefono di ogni sede

Reparto||||
-----------------|-------|----------------------------|----------
id| VARCHAR| identifica univocamente il repartodi ogni sede | **Chiave**
Tipo| VARCHAR| identifica la specialita' medica che viene trattata

Stanza|||
-----------------|-------|--------------------------------------
id_stanza|VARCHAR|chiave composta: n_stanza, id_reparto, id_sede



StanzaRi|||
-----------------|-------|--------------------------------------
prezzo_notte|SMALLINT| prezzo di ogni stanza a notte

StanzaSp|
--------------------------------------------------------------|
Nessun attributo|

Macchinari||||
-----------------|-------|----------------------------|----------
n_serie|VARCHAR |codice identificativo univoco del macchinario| **Chiave**
casa_prod| VARCHAR| nome della casa produttrice
nome| VARCHAR | nome rappresentativo del macchinario
ultima_rev| DATE| data dell'ultima revisione effettuata

Personale||||
-----------------|-------|----------------------------|----------
CF| VARCHAR| codice fiscale identificativo per ogni dipendente| **Chiave**
nome|VARCHAR| nome della persona fisica
cognome|VARCHAR| cognome della persona fisica
data_nascita|DATE | data di nascita della persona fisica
sesso |ENUM| sesso della persona fisica
telefono|VARCHAR| numero di telefono del dipendente
Indirizzo|VARCHAR| attributo composto: CAP, via, n_civico



PersonaleNonMedico|||
-----------------|-------|--------------------------------------
tipo|VARCHAR| indica la mansione di ogni dipendente che non svolge un ruolo inerente alla medicina



Dirigente|||
-----------------|-------|--------------------------------------
settore| VARCHAR| indica il settore di competenza del dirigente



Infermiere|||
-----------------|-------|--------------------------------------
grado|VARCHAR|indica il grado di anzianita' di ogni infermiere



Medico|||
-----------------|-------|--------------------------------------
specializzazione|VARCHAR|indica la specializzazione medica



Primario|
|--------------------------------------------------------------
Nessun Attributo 


Stipendio||||
-----------------|-------|---------------------------|-----------
tipo| VARCHAR| chiave identificativa univoca di ogni tipo di stipendio| **Chiave**
imp_lordo|INT| importo lordo di ogni stipendio
imp_netto|INT| importo netto di ogni stipendio|

Pazienti||||
-----------------|-------|---------------------------|-----------
CF|VARCHAR|codice fiscale univoco per ogni paziente| **Chiave**
nome| VARCHAR| nome di ogni paziente
cognome| VARCHAR| cognome di ogni paziente
sesso| ENUM| sesso di ogni paziente
telefono|VARCHAR| numero di telefono di ogni paziente
indirizzo|VARCHAR| attributo composto per l'indirizzo di residenza: CAP, via, n_civico

EsameEffettuato||||
-----------------|-------|---------------------------|-----------
id|VARCHAR| chiave identificatva univoca per indicare ogni esame effettuato| **Chiave**
stanza| VARCHAR| stanza in cui è stato effettuato l'esame
diagnosi| VARCHAR| diagnosi indicata a seguito dell'esame 
medico| VARCHAR| medico che ha effettuato l'esame
terapia| VARCHAR| terapia indicata dal medico a seguito dell'esame

TipoEsame||||
-----------------|-------|---------------------------|-----------
nome|VARCHAR| chiave che indica il nome dell'esame| **Chiave**
prezzo|INT| intero che indica il prezzo di ogni esame

|Prenotazione||||
|-----------------|-------|---------------------------:|-----------:|
Id|VARCHAR| chiave identificativa univoca di ogni prenotazione| **Chiave**
data| DATE| data in cui è stata effettuata la prenotazione
pagamento|BOOL| check che identifica l'avvenuto pagamento


PrenotazioneEsame|
|---------------|
Nessun Attributo


PrenotazioneStanza|
|---------------|
Nessun Attributo

---

## Generalizzazione  
- Personale e' generalizzazione totale non esclusiva di: PersonaleNonMedico,  Dirigente, Infermiere, Medico.  
- Prenotazione e' generalizzazione totale ed esclusiva di PrenotazioneEsame e PrenotazioneStanza.  
- TipoEsame e' generalizzazione non totatale ed esclusiva di EsameEffettuato.  
- Stanze e' generalizzazione non totale esclusiva di StanzaRi e StanzaSp.  

---

## Analisi delle relazioni e delle cardinalita'

*Sede-Personale*: Lavora
   - In una sede lavora piu personale
   - Un membro di personale lavora in una sola sede

*Personale-Stipendio*: Percepisce
   - Un membro del personale percepisce uno stipendio (1,1)
   - Uno stesso stipendio (stesso codice e quindi stesso importo) può essere percepito da più membri del personale (1,N)


*Sede-Reparto*: Possiede
- una sede può possedere più reparti (1,N)
- un reparto puo' essere posseduto da piu' sedi (1,N)

*Sede-Stanza*: Possiede
- una sede può possedere molte stane (1,N)
- una stanza fa parte di una sola sede (1,1)

*Reparto-Stanza*: Contiene
- un reparto può contere molte stanze (1,N)
- una stanza può essere contenuta in un solo reparto (1,1)

*Reparto-TipoEsame*: Effettua
- in un reparto si possono effettuare molti esami (1,n)
- un esame può essere effettuato in un solo reparto (1,1) 

*Reparto-Primario*: Presiede
- un Primario presiede un solo reparto (1,1)
- molti Reparto sono presieduti da molti Primario (1,1) 

*TipoEsame-PrenotazioneEsame*: Riferisce
- una PrenotazioneEsame può riferirsi ad un solo esame (1,1)
- un TipoEsame può essere riferito a più PrenotazioniEsami (1,N)

*PrenotazioneEsame-StanzaSp*: Riserva
- una PrenotazioneEsame può riservare una sola StanzaSp (1,1)
- una Stanzasp può essere riservata da più PrenotazioneEsame (1,N)

*StanzaSp-Macchinario*: Contiene
- una StanzaSp contiene molti Macchinario (1,N)
- un Macchinario puo' essere contenuto in una sola StanzaSp (1,1)

*Paziente-Prenotazione*: Richiede
- un Paziente può richiedere più prenotazioni (1,N)
- una Prenotazione è richiesta da un solo Paziente (1,1)

*Paziente-EsameEffettuato*: Effettua
- un Paziente effettua molti EsamiEffettuati (1,N)
- un EsameEffettuato viene effettuato da un solo Paziente (1,1)












