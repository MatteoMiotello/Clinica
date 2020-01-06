1. Insert into Sede (ID, CAP, via, n_civico, telefono) values(?, ?, ?, ?,?)	  
2. Insert Into Reparto (codice, tipo, primario) Values(?,?,?) 
3.  Insert into Personale( nome,cognome,datadinascita,sesso,CF,tipo,telefono,n_civico,cap,via,Sede,IBAN) values (?,?,?,?,?,?,?,?,?,?,?,?)
4. Insert into Paziente (CF,nome,cognome,telefono,via,n_civico,CAP) values (?,?,?,?,?,?,?)  
5. CREATE OR REPLACE TRIGGER controlla_disponibilita_SP 
    BEFORE INSERT ON PrenotazioneEsame 
    FOR EACH ROW
    DECLARE v INT;
    BEGIN 
    SELECT data_e
    INTO v
    FROM PrenotazioneEsame
    WHERE data_e LIKE :new.data_e
    dbms_ouput.put_line(v)
    IF v=1 then signal sqlstate '45000';
    end if;
    end;
6. uguale a quella sopra per qunto riguarda ionserimento della nuova prnotazione, ma dobbiamo guardare piu valori

7. calcolo spese totali paziente (ho messo +1 in DATEDIFF perche altrimenti mi conta 3 giorni al posto di 4, cioe mi esclude il giorno di partenza)
select sum(TOT) As totale_da_pagare from (select sum(StanzaRi.prezzo_notte)*(DATEDIFF(PrenotazioneStanza.data_fine, PrenotazioneStanza.data_inizio)+1) as TOT
from Paziente, PrenotazioneStanza, StanzaRi
where Paziente.nome="Benedetta" AND Paziente.cognome="Lo Duca" AND Paziente.CF=PrenotazioneStanza.paziente AND PrenotazioneStanza.sede=StanzaRi.sede
AND PrenotazioneStanza.reparto=StanzaRi.reparto AND PrenotazioneStanza.stanza=StanzaRi.n_stanza AND PrenotazioneStanza.pagamento=0
UNION select sum(TipoEsame.prezzo) from TipoEsame,PrenotazioneEsame, Paziente
where Paziente.nome="Benedetta" AND Paziente.cognome="Lo Duca" AND TipoEsame.nome=PrenotazioneEsame.tipo AND Paziente.CF=PrenotazioneEsame.paziente AND PrenotazioneEsame.pagamento=0) as sub1;

8. select PrenotazioneEsame.id
from Paziente INNER JOIN PrenotazioneEsame ON (Paziente.CF=PrenotazioneEsame.paziente)
where pagamento=0;

9. I macchinari che non presentano una revisione da piu di un mese 

select distinct Macchinario.n_serie, StanzaSp.n_stanza, StanzaSp.reparto
from Sede, StanzaSp, Macchinario
where Sede.ID LIKE "VI%" AND Sede.ID=StanzaSp.sede AND Macchinario.sede=StanzaSp.sede AND Macchinario.reparto=StanzaSp.reparto 
AND StanzaSp.n_stanza=Macchinario.n_stanza AND DATEDIFF(CURDATE(),Macchinario.ultima_revisione)>=30;

10. report incasso giornaliero degli esami e stanze ri (calcolato in base al numero di esami previsti per quel girono e che sono stati pagati)
Select sum(TipoEsame.prezzo) 
from ((Sede INNER JOIN StanzaSp ON(Sede.id=StanzaSp.id))INNER JOIN PrenotazioneEsame ON(StanzaSp.sede=PrenotazioneEsame.sede))INNER JOIN TipoEsame ON(PrenotazioneEsame.tipo_esame=TipoEsame.nome)
where Sede.id=' ' AND DATEDIFF(CURDATE(),PrenotazioneEsame.data_e) = 0 AND PrenotazioneEsame.pagamento = 1 
group by Sede.id;


11. report incasso in un frangente di tempo scelto (mi vengon passate data inizio e data fine)
    select sum(StanzaRi.prezzo_notte+TipoEsame.prezzo)
    from StanzaRi,PrenotazioneStanza,PrenotazioneEsame, TipoEsame
    where StanzaRi.sede="VI1" AND StanzaRi.sede=PrenotazioneStanza.sede AND PrenotazioneEsame.sede=PrenotazioneStanza.sede AND PrenotazioneEsame.tipo=TipoEsame.nome
    AND PrenotazioneStanza.data_fine BETWEEN '2019-01-10' AND '2019-02-10' AND PrenotazioneStanza.pagamento=1
    AND PrenotazioneEsame.data_e BETWEEN '2019-01-10 00:00:00' AND '2019-02-10 00:00:00'
    group by StanzaRi.sede;

select sum(TOT) AS totale from (select sum(StanzaRi.prezzo_notte) as TOT from StanzaRi, PrenotazioneStanza where StanzaRi.sede="VI1" AND StanzaRi.sede=PrenotazioneStanza.sede 
AND StanzaRi.reparto=PrenotazioneStanza.reparto AND StanzaRi.n_stanza=PrenotazioneStanza.stanza 
AND PrenotazioneStanza.data_fine BETWEEN '2019-01-04' AND '2019-01-17' AND PrenotazioneStanza.pagamento=1 group by StanzaRi.sede
UNION
select sum(TipoEsame.prezzo) AS SUM1
from PrenotazioneEsame, TipoEsame where PrenotazioneEsame.sede="VI1" AND PrenotazioneEsame.tipo=TipoEsame.nome AND
PrenotazioneEsame.data_e BETWEEN '2019-01-10' AND '2019-02-10' AND PrenotazioneEsame.pagamento=1
group by sede) AS sub1;

(da riguardare) 12. report incasso medio giornaliero (considerando anche le stanzeRi)
select sum(StanzaRi.prezzo_notte+TipoEsame.prezzo)/(DATEDIFF("inizio","fine")) AS Incasso_Giornaliero_Medio
from StanzaRi,PrenotazioneStanza,PrenotazioneEsame, TipoEsame
where Sede.id=' ' AND StanzaRi.sede=Sede.id AND StanzaRi.sede=PrenotazioneStanza.sede AND PrenotazioneEsame.sede=Sede.id AND PrenotazioneEsame.tipo_esame=TipoEsame.nome
AND PrenotazioneStanza.data_fine BETWEEN "inizio" AND "fine" AND PrenotazioneStanza.pagamento=1
group by Sede.id;
13. verifica StanzaRi=> verifichiamo dove e un paziente (all interno della sede da cui si sta cercando)
select PrenotazioneStanza.reparto, PrenotazioneStanza.n_stanza 
from Paziente, PrenotazioneStanza
where Sede.id="sede" AND Paziente.nome="nome" AND Paziente.CF=PrenotazioneStanza.persona AND (DATEDIFF(PrenotazioneStanza.data_inizio, CURDATE()) = 0 
OR DATEDIFF(PrenotazioneStanza.data_inizio, CURDATE()) > 0) AND DATEDIFF(PrenotazioneStanza.data_fine, CURDATE()) > 0
14.verifica stanze disponibili ricovero
select distinct StanzaRi.n_stanza from StanzaRi where StanzaRi.sede="PD1" AND StanzaRi.reparto="MEFI" AND StanzaRi.n_stanza NOT IN 
( select distinct PrenotazioneStanza.stanza  
from PrenotazioneStanza, StanzaRi  
where PrenotazioneStanza.sede=StanzaRi.sede  AND PrenotazioneStanza.reparto=StanzaRi.reparto AND PrenotazioneStanza.stanza=StanzaRi.n_stanza 
AND DATEDIFF(PrenotazioneStanza.data_fine, CURDATE())>0  AND DATEDIFF(PrenotazioneStanza.data_inizio, CURDATE())<0 
AND StanzaRi.reparto="MEFI" AND StanzaRi.sede="PD1" );
15. verifica stanze disponibili ricovero indipendentemente dal reparto 
select distinct StanzaRi.n_stanza from StanzaRi, PrenotazioneStanza 
where StanzaRi.sede="PD1" AND StanzaRi.n_stanza NOT IN ( select distinct PrenotazioneStanza.stanza 
from PrenotazioneStanza, StanzaRi 
where PrenotazioneStanza.sede=StanzaRi.sede  AND DATEDIFF(PrenotazioneStanza.data_fine, CURDATE())>0 
AND DATEDIFF(PrenotazioneStanza.data_inizio, CURDATE())<0 AND StanzaRi.sede="PD1" );

----------------------per prove-----------
    Insert into PrenotazioneStanza(data_inizio, data_fine, data_p, pagamento, paziente, stanza, reparto, sede, tipo) values ("2019-01-01","2019-01-04","2019-01-10",1,"ROBBER31D34A106D",14, "MEFI", "VI1","suite");