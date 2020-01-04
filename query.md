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
6. uguale a quella sopra per qunto riguarda l'ionserimento della nuova prnotazione, ma dobbiamo guardare piu valori
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
10. 