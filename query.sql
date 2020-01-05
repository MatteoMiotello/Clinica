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
7. calcolo spese totali paziente 
select sum(TipoEsame.prezzo)
from (Paziente INNER JOIN PrenotazioneEsame ON (Paziente.CF=PrenotazioneEsame.paziente))INNER JOIN TipoEsame ON (PrenotazioneEsame.tipo_esame = TipoEsame.nome)
where PrenotazioneEsame.pagamento=0
group by Paziente.CF;
8. select PrenotazioneEsame.id
from Paziente INNER JOIN PrenotazioneEsame ON (Paziente.CF=PrenotazioneEsame.paziente)
where pagamento=0;
9. verifica revisione macchinari
select Macchinario.n_serie
from (Sede INNER JOIN StanzaSp ON (Sede.id=StanzaSp.sede)) INNER JOIN Macchinario ON (StanzaSp.sede=Macchinario.sede)
where Sede LIKE " " AND DATEDIFF(CURDATE(),Macchinario.ultima_revisione)
10. report incasso giornaliero degli esami e stanze ri (calcolato in base al numero di esami previsti per quel girono e che sono stati pagati)
Select sum(TipoEsame.prezzo) 
from ((Sede INNER JOIN StanzaSp ON(Sede.id=StanzaSp.id))INNER JOIN PrenotazioneEsame ON(StanzaSp.sede=PrenotazioneEsame.sede))INNER JOIN TipoEsame ON(PrenotazioneEsame.tipo_esame=TipoEsame.nome)
where Sede.id=' ' AND DATEDIFF(CURDATE(),PrenotazioneEsame.data_e) = 0 AND PrenotazioneEsame.pagamento = 1 
group by Sede.id;
11. report incasso in un frangente di tempo scelto (mi vengon passate data inizio e data fine)
select sum(StanzaRi.prezzo_notte+TipoEsame.prezzo)
from StanzaRi,PrenotazioneStanza,PrenotazioneEsame, TipoEsame
where Sede.id=' ' AND StanzaRi.sede=Sede.id AND StanzaRi.sede=PrenotazioneStanza.sede AND PrenotazioneEsame.sede=Sede.id AND PrenotazioneEsame.tipo_esame=TipoEsame.nome
AND PrenotazioneStanza.data_fine BETWEEN " " AND " " AND PrenotazioneStanza.pagamento=1
group by Sede.id;
12. report incasso medio giornaliero (considerando anche le stanzeRi)
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
Insert into PrenotazioneStanza(data_inizio, data_fine, data_p, pagamento, paziente, stanza, reparto, sede, tipo)
values ("2020-01-16","2020-01-03","2020-01-05",0,"ROBBER31D34A106D",14, "MEFI", "PD1","suite");