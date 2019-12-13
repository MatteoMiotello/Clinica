# Clinica Magi  
## Abstract  
1958
Il Prof. Federico Perazzini, chirurgo ortopedico, e la moglie Imelda fondano la Clinica San Francesco. Il loro obiettivo è creare una nuova istituzione per soddisfare le crescenti necessità assistenziali dei cittadini veronesi, in campo ortopedico e traumatologico e non solo.

1959

1961
I posti letto divengono 69.

1985
La struttura si amplia fino a disporre di 72 posti letto.

Anni Novanta
Sotto la guida del Dr. Perazzini, la direzione sceglie di dare alla struttura un deciso indirizzo chirurgico con le specializzazioni di Ortopedia e Traumatologia, Chirurgia Generale, Chirurgia Plastica ed Estetica e Oculistica.
L’organico di medici e paramedici viene progressivamente ampliato e vengono avviate collaborazioni con specialisti d’eccellenza in diversi campi, che contribuiscono a consolidare l’identità della Clinica come centro di chirurgia all’avanguardia.

1991
Il Prof. Federico Perazzini e la moglie affidano al figlio Piergiuseppe il compito di continuare la tradizione famigliare. Il Dr. Perazzini ricopre da allora gli incarichi di Amministratore Delegato e Responsabile dell’Unità Funzionale di Ortopedia e Traumatologia.

1992
La Clinica arricchisce la gamma di servizi con l’apertura di una nuova ala per l’attività ambulatoriale, dando vita al Poliambulatorio San Francesco.

Anni 2000
Viene attivato il servizio di ricovero giornaliero (Day-Hospital).
Il percorso intrapreso porta, dunque, ad un pieno sviluppo dell’attività operatoria e quindi dei ricoveri, sia in regime di degenza ordinaria sia di Day Hospital. L’attività ambulatoriale è ugualmente incrementata anche grazie all’attivazione delle più sofisticate attrezzature diagnostiche, ad esempio quelle per la risonanza magnetica nucleare (RMN) e la tomografia assiale computerizzata (TAC).
A seguito dell’emanazione della Dgr. 3223/02 la Clinica amplia ulteriormente la propria dotazione ospedaliera, arrivando a 92 posti letto.
Con l’apertura degli ambulatori e l’offerta di alcuni importanti servizi diagnostici come la Cardiologia, l’Endoscopia Digestiva e la Medicina di Laboratorio, la Clinica San Francesco diviene una delle più importanti cliniche della città di Verona e del Veneto, proseguendo nel suo percorso di radicamento nel territorio nazionale e perfezionamento dei servizi assistenziali per i cittadini.

2011
La Clinica è la prima struttura in Europa ad intraprendere la strada della chirurgia robotica in ortopedia.

2012
Definitiva incorporazione del Centro Diagnostico Città di Verona nella Clinica San Francesco.

2013
La Clinica è riconosciuta come primo centro ufficiale in Europa di addestramento per l’artroplastica parziale e totale del ginocchio e dell’anca con tecnica Makoplasty.

2019
La Clinica San Francesco è stata riconosciuta dalla Regione Veneto come “Struttura di riferimento per la chirurgia robotica ortopedica”. La Giunta Regionale del Veneto con deliberazione del 14 maggio 2019 ha individuato la clinica veronese come struttura ospedaliera competente, specializzata e dedicata alla chirurgia robotica ortopedica. L’attribuzione di tale ruolo è avvenuto nell’ambito della riorganizzazione della rete ospedaliera regionale prevista dal Piano socio sanitario regionale 2019-2023.




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
Pazienti
