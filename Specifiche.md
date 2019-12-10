## Abstract  





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
