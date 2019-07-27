
				/*------------------------------------------------------*												
				 |		INDICE											|
				 |														|
				 |	1	CREAZIONE DATABASE E SCHEMA						|
				 |	2	VINCOLI DI INTEGRITA' DATABASE                  |
                 |  3   FUNZIONI                                        |
				 |	4	POPOLAMENTO										|
				 |	5   ANALYTICS  PERFORMANCE SPORTIVA                 |
                 |. 6.  ANALYTICS ROTAZIONE DEL MAGAZZINO               |
                 |  7.  ANALYTICS REPORTING.                            |
				 |                                                      |
				 |				                                        | 
				 |				                                        |
				 |		                                             	|
				 *------------------------------------------------------*/


/*-----------------------------------------------------------------------------------------------
	
	1	CREAZIONE DATABASE E SCHEMA
	
-----------------------------------------------------------------------------------------------*/


DROP DATABASE IF EXISTS AziendaPalestra;
CREATE DATABASE IF NOT EXISTS AziendaPalestra;
USE AziendaPalestra;

CREATE TABLE IF NOT EXISTS Dipendente(
    CodDipendente INT(11) PRIMARY KEY AUTO_INCREMENT,
    Nome CHAR(50) NOT NULL,
    Cognome CHAR(255) NOT NULL,
    DataNascita DATE NOT NULL,
    Indirizzo CHAR(50) NOT NULL,
    Documento CHAR(50) NOT NULL,
    Prefettura CHAR(50) NOT NULL
   
    
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS CentroFitness(
 	CodCentro INT(11) PRIMARY KEY  AUTO_INCREMENT,
	Indirizzo CHAR(50) NOT NULL,
    Cellulare INT(11) NOT NULL,
    Capienza  INT(11) NOT NULL,
    Dimensione INT(11) NOT NULL,
    Direttore INT(11) NOT NULL,
    GiornoChiusura CHAR(50) NOT NULL,
    OrarioApertura INT(11) NOT NULL,
    OrarioChiusura INT(11) NOT NULL,
    
  FOREIGN KEY (Direttore) REFERENCES Dipendente(CodDipendente) 
        ON DELETE CASCADE
        ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS Sala (
  CodSala INT(11) PRIMARY KEY  AUTO_INCREMENT,
  Nome CHAR(50) NOT NULL,
  CodCentro INT(11) NOT NULL,
  CodDipendente INT(11) NOT NULL,
  NumApparecchiature INT(11) NOT NULL,
  FOREIGN KEY (CodCentro) REFERENCES CentroFitness(CodCentro) 
		ON DELETE CASCADE
        ON UPDATE CASCADE,
          FOREIGN KEY (CodDipendente) REFERENCES Dipendente(CodDipendente) 
        ON DELETE CASCADE
        ON UPDATE CASCADE
        
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;

    
CREATE TABLE IF NOT EXISTS Attrezzatura(
    CodMacchina INT(11) PRIMARY KEY AUTO_INCREMENT,
    Nome CHAR(50) NOT NULL
    
    
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS AttrezzaturaSala (
       IdAttrezzaturaSala INT(11) PRIMARY KEY  AUTO_INCREMENT,
       CodMacchina INT(11) NOT NULL,
	   CodSala INT(11) NOT NULL,
       Consumo INT(11) NOT NULL,
       Usura INT(11) NOT NULL,
       FOREIGN KEY(CodMacchina) REFERENCES Attrezzatura(CodMacchina)
		ON DELETE CASCADE,
       FOREIGN KEY(CodSala) REFERENCES Sala(CodSala)
		ON DELETE CASCADE
        ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS Responsabile (
       Dipendente INT(11) NOT NULL,
     Responsabile INT(11) NOT NULL,
    PRIMARY KEY(Dipendente,Responsabile),
    FOREIGN KEY(Dipendente) REFERENCES Dipendente(CodDipendente)
		ON DELETE CASCADE,
    FOREIGN KEY(Responsabile) REFERENCES Dipendente(CodDipendente)
		ON DELETE CASCADE
        ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;


CREATE TABLE IF NOT EXISTS Corso(
    CodCorso INT(11) PRIMARY KEY AUTO_INCREMENT,
    CodSala INT(11) NOT NULL,
    Disciplina CHAR(50) NOT NULL,
    NumPartecipanti INT(11) NOT NULL,
    CodDipendente INT(11) NOT NULL,
    DataInizio DATE NOT NULL,
    DataFine DATE NOT NULL,
    Livello CHAR(50),
	FOREIGN KEY(CodDipendente) REFERENCES Dipendente(CodDipendente) 
        ON DELETE CASCADE
		ON UPDATE CASCADE,
	FOREIGN KEY(CodSala) REFERENCES Sala(CodSala)
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;
  

CREATE TABLE IF NOT EXISTS Esercizio (
    CodEsercizio INT(11) PRIMARY KEY AUTO_INCREMENT,
    Tipo CHAR(50) NOT NULL,
    Dispendio INT(11) NOT NULL
    
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS Calendario (
    IdCalendario INT(11) PRIMARY KEY AUTO_INCREMENT,
    CodCorso INT(11) NOT NULL,
    OraInizio INT(11) NOT NULL,
    OraFine INT(11) NOT NULL,
    Giorno CHAR(50) NOT NULL,
    FOREIGN KEY(CodCorso) REFERENCES Corso(CodCorso) 
        ON DELETE CASCADE
		ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS Cliente(
    CodCliente INT(11) PRIMARY KEY AUTO_INCREMENT,
    Nome CHAR(50) NOT NULL,
    Cognome CHAR(255) NOT NULL,
    DataNascita DATE NOT NULL,
    Indirizzo CHAR(50) NOT NULL,
    Documento CHAR(50) NOT NULL,
    Prefettura CHAR(50) NOT NULL,
    Username CHAR(50) NOT NULL,
    Password CHAR(50) NOT NULL  
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;


CREATE TABLE IF NOT EXISTS Spogliatoio (
    CodSpogliatoio INT(11) PRIMARY KEY AUTO_INCREMENT,
    Capienza INT(11) NOT NULL,
    PostiDisponibili INT(11) NOT NULL,
    Posizione CHAR(50) NOT NULL ,
    CodCentro INT(11) NOT NULL,
      FOREIGN KEY(CodCentro) REFERENCES CentroFitness(CodCentro)
		ON DELETE CASCADE
        ON UPDATE CASCADE
    
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;



CREATE TABLE IF NOT EXISTS Armadietto (
    CodArmadietto INT(11) PRIMARY KEY AUTO_INCREMENT,
    CodSpogliatoio INT(11) NOT NULL,
    CombSblocco CHAR(50) NOT NULL,
FOREIGN KEY(CodSpogliatoio) REFERENCES Spogliatoio(CodSpogliatoio)
		ON DELETE CASCADE
        ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;


CREATE TABLE IF NOT EXISTS Accesso (
    CodAccesso INT(11) PRIMARY KEY AUTO_INCREMENT,
    CodCliente INT(11) NOT NULL,
    CodCentro INT(11) NOT NULL,
    DataAccesso  CHAR(50) NOT NULL,
	OraAccesso INT(11) NOT NULL,
    OraUscita INT(11) NOT NULL,
    CodArmadietto INT(11) NOT NULL,
    Piscina CHAR(50) NOT NULL,
    FOREIGN KEY(CodCliente) REFERENCES Cliente(CodCliente)
		ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY(CodCentro) REFERENCES CentroFitness(CodCentro)
		ON DELETE CASCADE
        ON UPDATE CASCADE,
	FOREIGN KEY(CodArmadietto) REFERENCES Armadietto(CodArmadietto)
		ON DELETE CASCADE
        ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;


CREATE TABLE IF NOT EXISTS SchedaAllenamento (
    CodScheda INT(11) PRIMARY KEY AUTO_INCREMENT,
    CodCliente INT(11) NOT NULL,
    CodDipendente INT(11) NOT NULL,
    DataInizio DATE NOT NULL,
    DataFine DATE NOT NULL,
    FOREIGN KEY(CodCliente) REFERENCES Cliente(CodCliente)
		ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY(CodDipendente) REFERENCES Dipendente(CodDipendente)
		ON DELETE CASCADE
        ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS Regolazione (
    IdRegolazione INT(11) PRIMARY KEY AUTO_INCREMENT,
    CodMacchina INT(11) NOT NULL,
    Nome CHAR(50) NOT NULL,
    Minimo INT(11) NOT NULL, /*Min*/
    Massimo CHAR(50) NOT NULL, /*Max*/
    FOREIGN KEY(CodMacchina) REFERENCES Attrezzatura(CodMacchina) 
        ON DELETE CASCADE
		ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;


CREATE TABLE IF NOT EXISTS EserciziScheda (
    IdEsercizio INT(11) PRIMARY KEY AUTO_INCREMENT,
    CodScheda INT(11) NOT NULL,
    CodEsercizio INT(11) NOT NULL,
    Serie INT(11) NOT NULL,
    Ripetizioni INT(11) NOT NULL,
    Riposo INT(11) NOT NULL,
    Durata  INT(11) NOT NULL,
    CodAccesso INT(11) NOT NULL,
    FOREIGN KEY(CodEsercizio) REFERENCES Esercizio(CodEsercizio) 
        ON DELETE CASCADE
		ON UPDATE CASCADE,
        FOREIGN KEY(CodAccesso) REFERENCES Accesso(CodAccesso) 
        ON DELETE CASCADE
		ON UPDATE CASCADE,
     FOREIGN KEY(CodScheda) REFERENCES SchedaAllenamento(CodScheda)
      
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS ControlloAttrezzatura (
    IdEsercizio INT(11) NOT NULL,
    IdRegolazione INT(11) NOT NULL,
    Intensità INT(11) NOT NULL,
    PRIMARY KEY(IdEsercizio,IdRegolazione),
    FOREIGN KEY(IdEsercizio) REFERENCES EserciziScheda(IdEsercizio)
		ON DELETE CASCADE,
    FOREIGN KEY(IdRegolazione) REFERENCES Regolazione(IdRegolazione)
		ON DELETE CASCADE
        ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;



CREATE TABLE IF NOT EXISTS Composto (
    CodDipendente INT(11) NOT NULL,
    CodCentro INT(11) NOT NULL,
    Attività CHAR(50) NOT NULL,
    PRIMARY KEY(CodDipendente,CodCentro),
    FOREIGN KEY(CodDipendente) REFERENCES Dipendente(CodDipendente)
		ON DELETE CASCADE,
    FOREIGN KEY(CodCentro) REFERENCES CentroFitness(CodCentro)
		ON DELETE CASCADE
        ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS Turno (
    IdTurno INT(11) PRIMARY KEY AUTO_INCREMENT,
    CodDipendente INT(11) NOT NULL,
    OraInizio INT(11) NOT NULL,
    OraFine INT(11) NOT NULL,
    Giorno  CHAR(50) NOT NULL,
    FOREIGN KEY(CodDipendente) REFERENCES Dipendente(CodDipendente) 
        ON DELETE CASCADE
		ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS Contratto (
    CodContratto INT(11) PRIMARY KEY AUTO_INCREMENT,
    CodCliente INT(11) NOT NULL,
    CodDipendente INT(11) NOT NULL,
    DataContratto DATE NOT NULL,   
    DataScadenza DATE NOT NULL,
    Tipo CHAR(50) NOT NULL,       
    Tipologia CHAR(50) default  NULL,
    Sede INT(11) NOT NULL,
    IngressiSettimanali INT(11) NOT NULL,
    NumeroSaleAccessibili INT(11) NOT NULL,
    AccessiPiscinaMensili INT(11) NOT NULL,
    TipoPiscina CHAR(50) default NULL,
    Scopo CHAR(50) NOT NULL,
    Muscoli CHAR(50)  default NULL,
    Livello  CHAR(50) default  NULL,
    CostoAnnuale INT(11) NOT NULL,
    Rateizzazione CHAR(50) NOT NULL,
    TassoInteresse INT(11)  default 0,
    FOREIGN KEY(CodCliente) REFERENCES Cliente(CodCliente)
		ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY(CodDipendente) REFERENCES Dipendente(CodDipendente)
		ON DELETE CASCADE
        ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS Offre (
    CodContratto INT(11) NOT NULL,
    CodCentro INT(11) NOT NULL,
    PRIMARY KEY(CodContratto,CodCentro),
    FOREIGN KEY(CodContratto) REFERENCES Contratto(CodContratto)
		ON DELETE CASCADE,
    FOREIGN KEY(CodCentro) REFERENCES CentroFitness(CodCentro)
		ON DELETE CASCADE
        ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS Rata (
    CodRata INT(11) PRIMARY KEY AUTO_INCREMENT,
    CodContratto INT(11) NOT NULL,
    Importo int default 0,
    DataScadenza DATE NOT NULL,   
    StatoPagamento CHAR(50) NOT NULL,       
       FOREIGN KEY(CodContratto) REFERENCES Contratto(CodContratto)
		ON DELETE CASCADE
        ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;



CREATE TABLE IF NOT EXISTS Log (
    IdLog INT(11) PRIMARY KEY AUTO_INCREMENT,
    IdEsercizio INT(11) NOT NULL,
    Serie INT(11) NOT NULL,
    Ripetizioni INT(11) NOT NULL,
    Riposo INT(11) NOT NULL,
    TempoImpiegato  INT(11) NOT NULL,
    CodAccesso INT(11) NOT NULL,
    FOREIGN KEY(IdEsercizio) REFERENCES EserciziScheda(IdEsercizio) 
        ON DELETE CASCADE
		ON UPDATE CASCADE,
	FOREIGN KEY(CodAccesso) REFERENCES Accesso(CodAccesso)
		ON DELETE CASCADE
        ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS Integratore (
    NomeCommerciale CHAR(50) PRIMARY KEY, 
    Sostanza CHAR(50) NOT NULL,
	DataScadenza DATE NOT NULL,  
    Pezzi INT(11) NOT NULL,
    PrezzoAcquisto INT(11) NOT NULL,
    PrezzoVendita INT(11) NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;


CREATE TABLE IF NOT EXISTS Dieta (
    CodDieta INT(11) PRIMARY KEY AUTO_INCREMENT,
    PastiGiornalieri INT(11) NOT NULL,
    CalorieGiornaliere INT(11) NOT NULL,
    Composizione VARCHAR(2000) NOT NULL, 
    NomeCommerciale CHAR(50)  NOT NULL,
       FOREIGN KEY(NomeCommerciale) REFERENCES Integratore(NomeCommerciale)
		ON DELETE CASCADE
        ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;


CREATE TABLE IF NOT EXISTS SchedaAlimentazione (
    IdScheda INT(11) PRIMARY KEY AUTO_INCREMENT,
    CodCliente INT(11) NOT NULL,
    CodDipendente INT(11) NOT NULL,
    CodDieta INT(11) NOT NULL,
    DataVisita DATE NOT NULL,
    DataInizio DATE NOT NULL, 
	DataFine DATE NOT NULL,  
    Altezza INT(11) NOT NULL,
    Peso INT(11) NOT NULL,
    MassaGrassa INT(11) NOT NULL,
    MassaMagra INT(11) NOT NULL,
    AcquaTotale INT(11) NOT NULL, 
	Obbiettivo CHAR(50) NOT NULL, 
    Sesso CHAR(50) NOT NULL,
    FOREIGN KEY(CodCliente) REFERENCES Cliente(CodCliente)
		ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY(CodDipendente) REFERENCES Dipendente(CodDipendente)
		ON DELETE CASCADE
        ON UPDATE CASCADE,
	FOREIGN KEY(CodDieta) REFERENCES Dieta(CodDieta)
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;


CREATE TABLE IF NOT EXISTS Fornitore (
    NomeFornitore CHAR(50) PRIMARY KEY ,
    Società CHAR(50) NOT NULL,
    PartitaIva INT(11) NOT NULL, 
    Telefono INT(11) NOT NULL,
    Indirizzo CHAR(50) NOT NULL
    
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS Vende  (
    NomeFornitore CHAR(50) NOT NULL,
    NomeCommerciale CHAR(50) NOT NULL,
    PRIMARY KEY(NomeFornitore,NomeCommerciale),
    FOREIGN KEY(NomeFornitore) REFERENCES Fornitore(NomeFornitore)
		ON DELETE CASCADE,
    FOREIGN KEY(NomeCommerciale) REFERENCES Integratore(NomeCommerciale)
		ON DELETE CASCADE
        ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS Ordine (
    CodInterno INT(11) PRIMARY KEY AUTO_INCREMENT,
    CodCentro INT(11) NOT NULL,
    NomeFornitore CHAR(50) NOT NULL,
    CodEsterno CHAR(50) NOT NULL,
    DataEvasione DATE default NULL, 
    Stato CHAR(50) NOT NULL,
    DataConsegna DATE NOT NULL,
    FOREIGN KEY(CodCentro) REFERENCES CentroFitness(CodCentro)
		ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY(NomeFornitore) REFERENCES Fornitore(NomeFornitore)
		ON DELETE CASCADE
        ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS Magazzino (
    CodCentro INT(11) NOT NULL,
    NomeCommerciale CHAR(50) NOT NULL,
    Quantità INT(11) NOT NULL,
    PRIMARY KEY(CodCentro,NomeCommerciale),
    FOREIGN KEY(CodCentro) REFERENCES CentroFitness(CodCentro)
		ON DELETE CASCADE,
    FOREIGN KEY(NomeCommerciale) REFERENCES Integratore(NomeCommerciale)
		ON DELETE CASCADE
        ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS OrdineIntegratore  (
	CodInterno INT(11) NOT NULL,
    NomeCommerciale CHAR(50) NOT NULL,
    Confezioni INT(11) NOT NULL,
    PRIMARY KEY(CodInterno,NomeCommerciale),
    FOREIGN KEY(CodInterno) REFERENCES Ordine(CodInterno)
		ON DELETE CASCADE,
    FOREIGN KEY(NomeCommerciale) REFERENCES Integratore(NomeCommerciale)
		ON DELETE CASCADE
        ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS Acquisto (
    CodCliente INT(11) NOT NULL,
    NomeCommerciale CHAR(50) NOT NULL,
    Confezioni INT(11) NOT NULL,
    DataAcquisto DATE NOT NULL, 
    PRIMARY KEY(CodCliente,NomeCommerciale),
    FOREIGN KEY(CodCliente) REFERENCES Cliente(CodCliente)
		ON DELETE CASCADE,
    FOREIGN KEY(NomeCommerciale) REFERENCES Integratore(NomeCommerciale)
		ON DELETE CASCADE
        ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS Amicizia (
    CodCliente INT(11) NOT NULL,
    Amico INT(11) NOT NULL,
    DataRichiesta DATE NOT NULL,
    Stato CHAR(50) NOT NULL,
    DataAccettazione DATE default NULL,
    PRIMARY KEY(CodCliente,Amico),
    FOREIGN KEY(CodCliente) REFERENCES Cliente(CodCliente)
		ON DELETE CASCADE,
    FOREIGN KEY(Amico) REFERENCES Cliente(CodCliente)
		ON DELETE CASCADE
        ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS Interesse (
    CodInteresse INT(11) PRIMARY KEY AUTO_INCREMENT,
    Nome CHAR(50) NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS InteresseCliente (
    CodCliente INT(11) NOT NULL,
    CodInteresse INT(11) NOT NULL,
    PRIMARY KEY(CodCliente,CodInteresse),
    FOREIGN KEY(CodCliente) REFERENCES Cliente(CodCliente)
		ON DELETE CASCADE,
    FOREIGN KEY(CodInteresse) REFERENCES Interesse(CodInteresse)
		ON DELETE CASCADE
        ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS Cerchia (
    CodCerchia INT(11) PRIMARY KEY AUTO_INCREMENT,
    Nome CHAR(50) NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS CerchiaCliente (
    CodCliente INT(11) NOT NULL,
    CodCerchia INT(11) NOT NULL,
    PRIMARY KEY(CodCliente,CodCerchia),
    FOREIGN KEY(CodCliente) REFERENCES Cliente(CodCliente)
		ON DELETE CASCADE,
    FOREIGN KEY(CodCerchia) REFERENCES Cerchia(CodCerchia)
		ON DELETE CASCADE
        ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS CerchiaInteresse  (
    CodCerchia INT(11) NOT NULL,
    CodInteresse INT(11) NOT NULL,
    PRIMARY KEY(CodCerchia,CodInteresse),
    FOREIGN KEY(CodCerchia) REFERENCES Cerchia(CodCerchia)
		ON DELETE CASCADE,
    FOREIGN KEY(CodInteresse) REFERENCES Interesse(CodInteresse)
		ON DELETE CASCADE
        ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS Post (
    IdPost INT(11) PRIMARY KEY AUTO_INCREMENT,
    CodCliente INT(11) NOT NULL,
    Testo VARCHAR(2000) NOT NULL,
    DataPubblicazione TIMESTAMP NOT NULL, 
    Luogo CHAR(50) NOT NULL,
    Link CHAR(50) default NULL, 
    FOREIGN KEY(CodCliente) REFERENCES Cliente(CodCliente)
		ON DELETE CASCADE
        ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS Risposta (
    CodRisposta INT(11) PRIMARY KEY AUTO_INCREMENT,
    IdPost INT(11) NOT NULL,
    CodCliente INT(11) NOT NULL,
    Testo VARCHAR(2000) NOT NULL,
    FOREIGN KEY(IdPost) REFERENCES Post(IdPost)
		ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY(CodCliente) REFERENCES Cliente(CodCliente)
		ON DELETE CASCADE
        ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS Gradimento(
            CodRisposta INT(11) NOT NULL,
            CodCliente  INT(11) NOT NULL,
            Punteggio   INT(11) NOT NULL,
    PRIMARY KEY(CodRisposta,CodCliente),
    FOREIGN KEY(CodRisposta) REFERENCES Risposta(CodRisposta)
		ON DELETE CASCADE,
    FOREIGN KEY(CodCliente) REFERENCES Cliente(CodCliente)
		ON DELETE CASCADE
        ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS Sfida (
    IdSfida INT(11) PRIMARY KEY AUTO_INCREMENT,
    CodCliente INT(11) NOT NULL,
    CodScheda INT(11) NOT NULL,
    IdScheda INT(11)  default  NULL,
    DataLancio DATE NOT NULL,
    DataInizio DATE NOT NULL,
    DataFine   DATE NOT NULL,
    Obbiettivo VARCHAR(255) NOT NULL, 
    Vincitore INT(11) default NULL,
     FOREIGN KEY(Vincitore) REFERENCES Cliente(CodCliente)
		ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY(CodCliente) REFERENCES Cliente(CodCliente)
		ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY(CodScheda) REFERENCES SchedaAllenamento(CodScheda)
		ON DELETE CASCADE
        ON UPDATE CASCADE,
        FOREIGN KEY(IdScheda) REFERENCES SchedaAlimentazione(IdScheda)
		ON DELETE CASCADE
        ON UPDATE CASCADE
	
        )ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS Partecipa(
    IdSfida INT(11) NOT NULL,
    CodCliente INT(11) NOT NULL,
    PRIMARY KEY(IdSfida,CodCliente),
    FOREIGN KEY(IdSfida) REFERENCES Sfida(IdSfida)
		ON DELETE CASCADE,
    FOREIGN KEY(CodCliente) REFERENCES Cliente(CodCliente)
		ON DELETE CASCADE
        ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE IF NOT EXISTS Iscrizione (
    CodCliente INT(11) NOT NULL,
    CodCorso INT(11) NOT NULL,
    PRIMARY KEY(CodCliente,CodCorso),
    FOREIGN KEY(CodCliente) REFERENCES Cliente(CodCliente)
		ON DELETE CASCADE,
    FOREIGN KEY(CodCorso) REFERENCES Corso(CodCorso)
		ON DELETE CASCADE
        ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=UTF8;

/*----------------------------------------------------------------------------------------------
	
	2 VINCOLI DI INTEGRITA' DATABASE 
	
----------------------------------------------------------------------------------------
*/

DROP TRIGGER IF EXISTS VincoloStatoAmicizia;
DROP TRIGGER IF EXISTS VincoloUpdateAmicizia;
DROP TRIGGER IF EXISTS Multisede;
DROP TRIGGER IF EXISTS VincoloStatoRata;
DROP TRIGGER IF EXISTS VincoloUpdateRata; 
DROP TRIGGER IF EXISTS VincoloGradimento;
DROP TRIGGER IF EXISTS VincoloNuovaAttrezzatura;
DROP TRIGGER IF EXISTS AggiuntaMacchinario;
DROP TRIGGER IF EXISTS VincoloUsura;
DROP TRIGGER IF EXISTS VincoloLivelloAllenamento;
DROP TRIGGER IF EXISTS VincoloStatoOrdine;
DROP TRIGGER IF EXISTS VincoloOrdineIncompleto;
DROP TRIGGER IF EXISTS VincoloUpdateOrdine;
DROP TRIGGER IF EXISTS AggiuntaIscrizione;
DROP TRIGGER IF EXISTS EliminaIscrizione;
DROP TRIGGER IF EXISTS VincoloNuovaAmicizia;
DROP TRIGGER IF EXISTS VincoloStatoGiorno;
DROP TRIGGER IF EXISTS VincoloUpdateGiorno;
DROP TRIGGER IF EXISTS VincoloUpdateCalendario;
DROP TRIGGER IF EXISTS VincoloStatoCalendario;
DROP TRIGGER IF EXISTS VincoloTurno;
DROP TRIGGER IF EXISTS VincoloUpdateEserciziScheda;
DROP TRIGGER IF EXISTS VincoloSessoCliente;
DROP TRIGGER IF EXISTS VincoloUpdateSessoCliente;
DROP TRIGGER IF EXISTS AggiuntaSede;
DROP TRIGGER IF EXISTS VincoloIntensità;
DROP TRIGGER IF EXISTS VincoloUpdateAccesso;

DELIMITER $$
CREATE TRIGGER Multisede    /* Limite massimo di contratti legati a più centri  */
after INSERT ON Offre
FOR EACH ROW
BEGIN
	DECLARE contrattimultisede INT;

	SELECT COUNT(*) INTO contrattimultisede
	FROM Offre
	WHERE CodContratto = NEW.CodContratto
    ;

	IF( contrattimultisede>3 ) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT  = "Non sono ammessi contratti multisede legati a più di tre centri ";
	END IF;
END $$


DELIMITER ;



DELIMITER $$

CREATE TRIGGER VincoloStatoAmicizia     /* stati consentiti  */
BEFORE INSERT ON Amicizia
FOR EACH ROW
BEGIN
	IF( NEW.Stato != "accettata" 
		AND NEW.Stato != "non accettata")  THEN		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Lo stato non è accettato";
	END IF;
END $$
DELIMITER ;

DELIMITER $$

CREATE TRIGGER  VincoloUpdateAmicizia   /* stati consentiti  */
BEFORE UPDATE ON Amicizia
FOR EACH ROW
BEGIN
	IF( NEW.Stato != "accettata" 
		AND NEW.Stato != "non accettata")  THEN		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Lo stato non è accettato";
	END IF;
END $$
DELIMITER ;

DELIMITER $$

CREATE TRIGGER VincoloUpdateRata   /* stati consentiti  */
BEFORE UPDATE ON rata
FOR EACH ROW
BEGIN
	IF( NEW.StatoPagamento != "pagato" 
		AND NEW.StatoPagamento != "non ancora dovuto" AND NEW.StatoPagamento != " non pagato") THEN		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Lo stato non è accettato";
	END IF;
END $$
DELIMITER ;

DELIMITER $$

CREATE TRIGGER VincoloUpdateAccesso   /* stati consentiti  */
BEFORE UPDATE ON Accesso
FOR EACH ROW
BEGIN
	IF( NEW.DataAccesso != "lunedi" AND NEW.DataAccesso!="martedi" AND NEW.DataAccesso != "mercoledi"  AND NEW.DataAccesso != "giovedi
        " AND NEW.DataAccesso != "venerdi" AND NEW.DataAccesso != "sabato")   
        THEN		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Il giorno inserito non è corretto";
    END IF;    
END $$
DELIMITER ;


DELIMITER $$

CREATE TRIGGER VincoloStatoRata  /* stati consentiti  */
BEFORE insert ON rata
FOR EACH ROW
BEGIN
	IF( NEW.StatoPagamento != "pagato" 
		AND NEW.StatoPagamento != "non ancora dovuto" AND NEW.StatoPagamento != " non pagato") THEN		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Lo stato non è accettato";
	END IF;
END $$
DELIMITER ;


DELIMITER $$

CREATE TRIGGER  VincoloLivelloAllenamento  /*livelli in allenamento  */
BEFORE INSERT ON Contratto
FOR EACH ROW
BEGIN
	IF( NEW.Livello != "lieve" 
		AND NEW.Livello != "moderato" AND NEW.Livello != "elevato" )  THEN		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Impossibile inserire nuovo contratto ";
	END IF;
END $$
DELIMITER ;


DELIMITER $$

CREATE TRIGGER VincoloUsura   /*se il macchinario ha un usura maggiore del 80% viene sostituito con uno nuovo  */
before update ON attrezzaturasala
FOR EACH ROW
BEGIN
		IF(  NEW.Usura >= 80 )  then
      
         set NEW.Usura = 0;
        
        
       END IF ;
END $$
DELIMITER ;

DELIMITER $$

CREATE TRIGGER VincoloStatoOrdine  /*stati consentiti  */
BEFORE INSERT ON Ordine
FOR EACH ROW
BEGIN
	IF( NEW.Stato != "completo" 
		AND NEW.Stato != "incompleto")  THEN		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Lo stato non è accettato";
  
     END IF;
      END $$
DELIMITER ;



DELIMITER $$

CREATE TRIGGER VincoloOrdineIncompleto      /* se lo stato è incompleto l'ordine non viene inviato al fornitore */
before INSERT ON Ordine
FOR EACH ROW
BEGIN
	
        IF(  NEW.Stato = "incompleto" )  THEN		
        SET NEW.DataEvasione= NULL ;
        

	END IF;
END $$
DELIMITER ;


DELIMITER $$

CREATE TRIGGER VincoloUpdateOrdine  /*se l'ordine è incompleto viene modificato in evaso e la data di evasione viene messa ad oggi,
                                    controllo che la data di evasione sia minore della data di consegna in caso contrario fallisce l'aggiornamento    */
BEFORE UPDATE ON Ordine
FOR EACH ROW
BEGIN
	
        IF(  NEW.Stato = "incompleto" )  THEN
		SET NEW.Stato= "evaso";
		SET NEW.DataEvasione= CURRENT_DATE;
        
        END IF;
   IF( NEW.DataEvasione > OLD.DataConsegna) THEN		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Aggiornamento fallito,la data di consegna è già passata";
  END IF;
    
END $$
DELIMITER ;

DELIMITER $$

CREATE TRIGGER VincoloStatoGiorno    /* giorni e orari consentiti  */
BEFORE INSERT ON centrofitness
FOR EACH ROW
BEGIN
	IF( NEW.GiornoChiusura != "domenica" 
		AND NEW.GiornoChiusura != "lunedi" AND NEW.GiornoChiusura!="martedi" AND NEW.GiornoChiusura != "mercoledi"  AND NEW.GiornoChiusura != "giovedi
        " AND NEW.GiornoChiusura != "venerdi" AND NEW.GiornoChiusura != "sabato")   
        THEN		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Il giorno inserito non è corretto";
        ELSEIF
        (NEW.OrarioChiusura > 24 OR NEW.OrarioChiusura < 1
        )  THEN		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "L'ora inserita non è corretta";
        
         ELSEIF
        (NEW.OrarioApertura > 24 OR NEW.OrarioApertura < 1
        )  THEN		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "L'ora inserita non è corretta";
        
	END IF;
END $$
DELIMITER ;

DELIMITER $$

CREATE TRIGGER VincoloUpdateGiorno    /* giorni e orari consentiti  */
BEFORE UPDATE ON centrofitness
FOR EACH ROW
BEGIN
	IF( NEW.GiornoChiusura != "domenica" 
		AND NEW.GiornoChiusura != "lunedi" AND NEW.GiornoChiusura!="martedi" AND NEW.GiornoChiusura != "mercoledi"  AND NEW.GiornoChiusura != "giovedi
        " AND NEW.GiornoChiusura != "venerdi" AND NEW.GiornoChiusura != "sabato")   
        THEN		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Il giorno inserito non è corretto";
        ELSEIF
        (NEW.OrarioChiusura > 24 OR NEW.OrarioChiusura < 1
        )  THEN		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "L'ora inserita non è corretta";
        
         ELSEIF
        (NEW.OrarioApertura > 24 OR NEW.OrarioApertura < 1
        )  THEN		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "L'ora inserita non è corretta";
        
	END IF;
END $$
DELIMITER ;

DELIMITER $$

CREATE TRIGGER VincoloUpdateCalendario    /* giorni e orari consentiti  */
BEFORE UPDATE ON calendario
FOR EACH ROW
BEGIN
	IF( NEW.Giorno != "lunedi" AND NEW.Giorno!="martedi" AND NEW.Giorno != "mercoledi"  AND NEW.Giorno != "giovedi
        " AND NEW.Giorno != "venerdi" AND NEW.Giorno != "sabato")   
        THEN		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Il giorno inserito non è corretto";
        ELSEIF
        (NEW.OraFine > 24 OR NEW.OraFine < 1
        )  THEN		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "L'ora inserita non è corretta";
        
         ELSEIF
        (NEW.OraInizio > 24 OR NEW.OraInizio < 1
        )  THEN		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "L'ora inserita non è corretta";
        
	END IF;
END $$
DELIMITER ;

DELIMITER $$

CREATE TRIGGER VincoloSessoCliente /*Sesso  riconusciuto */
before INSERT ON schedaalimentazione
FOR EACH ROW
BEGIN
		IF( NEW.Sesso !='U' AND NEW.Sesso !='D') THEN		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "spiacente Il sesso del cliente non è riconusciuto";
       END IF; 
END $$
DELIMITER ;

DELIMITER $$

CREATE TRIGGER VincoloUpdateSessoCliente /*Sesso  riconusciuto */
before update ON schedaalimentazione
FOR EACH ROW
BEGIN
		IF( NEW.Sesso !='U' AND NEW.Sesso !='D') THEN		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "spiacente Il sesso del cliente non è riconusciuto";
       END IF; 
END $$
DELIMITER ;







/*----------------------------------------------------------------------------------------------
	
	3 FUNZIONE CHE MOSTRA LO STATO DI CONDIZIONE FISICA DEL CLIENTE DOPO OGNI VISITA
	
----------------------------------------------------------------------------------------
*/

drop procedure if exists ResocontoVisita;
delimiter $$
create procedure  ResocontoVisita( in _idscheda int,out _statoforma char(50))  /*attraverso idscheda il medico può 
controllare ad ogni visita lo stato di salute del suo paziente  */

BEGIN

declare _massagrassa int default 0; 
declare _sesso char default '';

set _massagrassa = (select A.MassaGrassa
from schedaalimentazione A
where A.IdScheda = _idscheda
);

set _sesso = (select A.Sesso
from schedaalimentazione A
where A.IdScheda = _idscheda
);


IF _sesso = "D" THEN
if (_massagrassa>=10 and _massagrassa<=12 ) THEN
SET _statoforma = 'Peso minimo, pericolo per la salute';

elseif (_massagrassa>=13 AND _massagrassa<=18)  THEN
SET _statoforma = 'Forma atletica';

elseif (_massagrassa>=19 AND _massagrassa<=22)  THEN
SET _statoforma = 'Buono stato di fitness';

elseif (_massagrassa>=23 AND _massagrassa<=29)  THEN
SET _statoforma = 'Al di sopra della media';


elseif (_massagrassa >=30)  THEN
SET _statoforma = 'Obeso';
END IF;
ELSEIF  _sesso = "U" THEN

if (_massagrassa>=2 and _massagrassa<=4 ) THEN
SET _statoforma = 'Peso minimo, pericolo per la salute';

elseif (_massagrassa>=6 AND _massagrassa<=14)  THEN
SET _statoforma = 'Forma atletica';

elseif (_massagrassa>=15 AND _massagrassa<=17)  THEN
SET _statoforma = 'Buono stato di fitness';

elseif (_massagrassa>=18 AND _massagrassa<=25)  THEN
SET _statoforma = 'Al di sopra della media';

elseif (_massagrassa >=26)  THEN
SET _statoforma = 'Obeso';

END IF;
end if;
END $$
DELIMITER ;


/*----------------------------------------------------------------------------------------------
	
	3 FUNZIONE CHE MOSTRA LO STATO DI CREDIBILITA DEL CLIENTE NELL'AREA SOCIAL
	
----------------------------------------------------------------------------------------
*/


drop procedure if exists Social;
delimiter $$
create procedure Social(in _cliente int,out _credibilità int,out _messaggio char(50),out gradimento int,out _testo char(50) )

begin


declare _numerototale  int default 0;
declare _numerorisp  int default 0;
declare _sommatotale int default 0;
declare _risposte int default 0;

create or replace view SommaPunteggi  as
SELECT R.CodCliente,sum(Punteggio) as Somma,count(distinct G.CodCliente) as Quanticlienti/*La somma dei punteggi ricevuti e il numero complessivo dei clienti che ti hanno dato il punteggio  */
FROM gradimento G
inner join risposta R on R.CodRisposta = G.CodRisposta
group by R.CodCliente;

create or replace view NumeroPosttotali  as   /* ci siamo calcolati il numero dei post totali */
SELECT V.CodCliente,count(distinct V.idpost) as Numeropost
from post V  
group by V.CodCliente;

create or replace view NumeroPostRisposte as /* ci siamo calcolati il numero delle risposte   al cliente  */
SELECT V.CodCliente,count(distinct CodRisposta) as Numerorisposte 
from post V inner join risposta R on V.idpost = R.idpost 
group by V.CodCliente;


set _numerorisp = (select Numerorisposte
from NumeroPostRisposte
where CodCliente = _cliente
);



set _numerototale = (select Numeropost
from NumeroPosttotali
where CodCliente = _cliente
);

set _sommatotale = (select Somma
from SommaPunteggi 
where CodCliente = _cliente
);

set _risposte = (select Quanticlienti
from SommaPunteggi 
where CodCliente = _cliente
);

set gradimento = _sommatotale/_risposte;   /* media del gradimento a cliente */
set _credibilità = _numerorisp/_numerototale; /* media di quanto ti rispondono a post */
if(_credibilità<1)then
set _messaggio ='i tuoi post non sono  interessanti';
elseif (_credibilità=1)then
set _messaggio ='non male dai';
elseif (_credibilità>1)then
set _messaggio ='stai andando bene';
elseif (_credibilità>2)then
set _messaggio ='ormai sei popolare ';

end if;

if(gradimento=1  )then
set _testo =' cosi non va';
elseif (gradimento=2)then
set _testo ='qualcuno è interessato a te';
elseif (gradimento=3)then
set _testo =' vai alla grande';
elseif (gradimento=4)then
set _testo =' sei famoso';
elseif (gradimento=5)then
set _testo ='tutti ti amano';
end if;

end $$
delimiter ;

/*----------------------------------------------------------------------------------------------
	
	3 FUNZIONE CHE TI CALCOLA IL COSTO DI UNA RATA
	
----------------------------------------------------------------------------------------
*/


drop procedure if exists Calcolodiunarata;
delimiter $$
create procedure Calcolodiunarata(in _c int,out _rata int )

begin

declare costo int default 0;
declare pagamento char(50) default '';
declare _tassointeresse int default 0;
declare numerocontratto int default 0;

set numerocontratto = (select count(CodContratto)
from Rata
where CodContratto = _c
);


set _tassointeresse = (select TassoInteresse
from Contratto
where CodContratto = _c
);

set costo = (select CostoAnnuale
from Contratto
where CodContratto = _c
);

set pagamento = (select Rateizzazione
from Contratto
where CodContratto = _c
);

if (pagamento = 'si') then

set  _rata=(costo/numerocontratto)+((costo)*_tassoInteresse/100) ;


end if;



update  rata
set Importo = _rata
where  CodContratto = _c;

end $$
delimiter ;


/*----------------------------------------------------------------------------------------------
	
	4 POPOLAMENTO DEL DATABASE
	
----------------------------------------------------------------------------------------
*/


INSERT INTO cliente(Nome,Cognome,DataNascita,Indirizzo,Documento,Prefettura,Username,Password)VALUES
	('Luca', 'Mazzanti', '1989-04-09', 'Via Ceppi  18 Firenze(FI)', 'RF88897OL', 'Firenze', 'LuMazza', 'gok67'),
	('Angela','Berti','1993-02-17','Via Bracciano 58 Milano(MI)','CA00000AA','Padova','AngeBe93','Sbirulo'),
    ('Nicola','Corradini','1991-01-27','Via Bocaccio 23 Roma(RM)','SZ44466FG','Roma','Nicooo50','Ciccio'),
    ('Sofia','Conti','1997-04-10','Via Umbria 11 Roma(RM)','RV25698BN','Roma','SofiStar','Bang'),
    ('Alberto','Tacconi','1992-08-15','Via Montevideo 5 Milano(MI)','AD92029CB','Milano','Tacco91','Obamayes'), 
    ('Eugenio','Cataldi','1995-09-13','Via dei Condotti 9 Roma(RM)','NM99987OL','Frosinone','EuCata45','Blackops'),
    ('Francesco','Gralli','1995-11-09','Via Tulipani 13 Milano(MI)','GV33890TS','Milano','Gralloso16','Duccii'),
	('Mattia','Sentoni','1994-08-24','Via Maddaloni 4 Napoli(NA)','ER31312DC','Napoli','Sento32','Ercole'),
    ('Mario','Danili','1996-05-27','Via F. De Mura 15 Napoli(NA)','NM38842AL','Napoli','Danilino96','Capitone'),
	('Alberto','Bracci','1995-12-23','Via Solari 6(MI)','BR88686ER','Milano','Albe95','VivaLaFisica'),
	('Elia','Ottacini','1988-09-02','Via Navigli 9 Milano(MI)','ET44451GS','Milano','Otta88','TheKing'),
     ('Susanna','Moretti','1993-08-08','Via del Tevere Roma(RM)','VB24696YY','Roma','Susi93','Petaloso');



SET @dataacquisto = CURRENT_DATE - INTERVAL 4 DAY;
SET @dataacquisto6 = CURRENT_DATE - INTERVAL  2 WEEK;
SET @dataacquisto8 = CURRENT_DATE - INTERVAL  6 WEEK;     
    
SET @datascadenza = @dataacquisto + INTERVAL 90 DAY;
SET @datascadenza2 = @dataacquisto6 + INTERVAL 90 DAY;
SET @datascadenza3 = @dataacquisto8 + INTERVAL 90 DAY;

INSERT INTO integratore(NomeCommerciale,Sostanza,DataScadenza,Pezzi,PrezzoAcquisto,PrezzoVendita)VALUES
('Anabolic Mass Pro','Proteine',@datascadenza,'80','10','50'),
('Impact whey','Amminoacidi ramificati',@datascadenza3,'40','30','70'),
('Prolong','Amminoacidi ramificati',@datascadenza2,'70','25','65'),
('Creatine Powder','Proteine',@datascadenza2,'100','40','80'),
('HydraTech','Magnesio',@datascadenza,'140','15','55'),
('Protein Isolate','Amminoacidi ramificati',@datascadenza2,'150','35','75'),
('MultiSat','Ferro',@datascadenza3,'70','20','60');


INSERT INTO acquisto(CodCliente,NomeCommerciale,Confezioni,DataAcquisto) VALUES
(1,'Anabolic Mass Pro',1,@dataacquisto),
(3,'HydraTech',1,@dataacquisto6),
(8,'Protein Isolate',1,@dataacquisto6),
(1,'Prolong',1,@dataacquisto6),
(1,'Impact whey',1,@dataacquisto8),
(3,'Anabolic Mass Pro',1,@dataacquisto8),
(6,'HydraTech',1,@dataacquisto),
(7,'Prolong',1,@dataacquisto8),
(5,'Creatine Powder',1,@dataacquisto8),
(3,'Creatine Powder',1,@dataacquisto8),
(1,'HydraTech',1,@dataacquisto),
(5,'Protein Isolate',1,@dataacquisto),
(2,'Impact whey',1,@dataacquisto),
(6,'Impact whey',1,@dataacquisto),
(1,'Protein Isolate',1,@dataacquisto6),
(6,'Anabolic Mass Pro',1,@dataacquisto6),
(2,'HydraTech',1,@dataacquisto),
(8,'HydraTech',1,@dataacquisto),
(2,'Protein Isolate',1,@dataacquisto),
(4,'MultiSat',2,@dataacquisto6),
(7,'Protein Isolate',2,@dataacquisto),
(4,'Protein Isolate',2,@dataacquisto),
(1,'MultiSat',1,@dataacquisto8),
(2,'Creatine Powder',1,@dataacquisto6),
(5,'Prolong',1,@dataacquisto),
(3,'Impact whey',1,@dataacquisto),
(3,'MultiSat',1,@dataacquisto6),
(4,'HydraTech',1,@dataacquisto),
(10,'MultiSat',1,@dataacquisto8),
(11,'MultiSat',2,@dataacquisto8),
(12,'MultiSat',1,@dataacquisto8),
(11,'HydraTech',1,@dataacquisto),
(9,'HydraTech',1,@dataacquisto),
(12,'HydraTech',1,@dataacquisto),
(9,'Protein Isolate',2,@dataacquisto),
(11,'Anabolic Mass Pro',1,@dataacquisto8);


INSERT INTO  Dipendente(Nome,Cognome,DataNascita,Indirizzo,Documento,Prefettura) VALUES 
('Lorenzo','Bellini','1987-06-10','Via Olmetto Milano(MI)','FD79790BI','Milano'),
('Simona','Gulli','1964-02-18','Via Verdi Firenze(FI)','ED18974TE','Firenze'),
('Joel','Asmen','1990-03-05','Viale Zara Milano(MI)','SB35759MO','Brescia'),
('Vanessa','Rigoli','1974-06-30','Via Sordi Firenze(FI)','VA11806LI','Pisa'),
('Leonardo','Pigi','1982-11-16','Via Romeo Roma(RM)','NO34940RC','Viterbo'),
('Riccardo','Cappello','1969-12-04','Via Gioberti Milano(MI)','LE17077DA','Milano'),
('Alessandro','Sbanti','1992-08-17','Via dei Caduti Roma(RM)','AB89660CN','Roma'),
('Fabio','Biondo','1991-06-14','Viale Fulvio Testi Milano(MI)','PT36061AR','Milano'),
('Maria','Stasi','1987-01-20','Via Vecchio Firenze(FI)','ZE93305LO','Firenze'),
('Mara','Dini','1971-01-10','Via Martiri Roma(RM)','MI27292CE','Roma'),
('Filippo','Baschi','1977-06-10','Via Pomicino Napoli(NA)','BI27291RC','Napoli'),
('Andrea','Celloni','1973-07-15','Via Lotti Napoli(NA)','PU98088OS','Napoli'),
('Marco','Muti','1984-04-10','Via Olmetto Milano(MI)','ZV11771DR','Como'),
('Giorgia','Fessari','1986-10-26','Via Pascoli Roma(RM)','FU34440XD','Roma'),
('Marco','DelSarto','1987-06-19','Via Dante Roma(RM)','AQ12690IL','Roma');


INSERT INTO  CentroFitness(Indirizzo,Cellulare,Capienza,Dimensione,Direttore,GiornoChiusura,OrarioApertura,OrarioChiusura)VALUES 
('Via  Torino 8 Milano(MI)','334859701','60','6000','6','domenica',8,23),
('Via Conca Del Naviglio 18 Milano(MI)','346882173','30','2000 ','13','domenica',8,23),
(' Via del Pigneto 108 Roma(RM)','342229608','40','3000 ','10','domenica',8,23),
(' Via Tarsia 57 Napoli(NA)','333667780','20','1350 ','12','domenica',8,23),
(' Via de Pepi 28 Firenze(FI)','352468230','30','2000 ','2','domenica',8,23);


INSERT INTO Spogliatoio(Capienza,PostiDisponibili,Posizione,CodCentro)  VALUES
('10','10','lato sud',1),
('15','15',' lato ovest',5),
('15','15',' lato est',2),
('16','16','lato nord',2),
('18','18','lato est',4),
('20','20','lato sudest',1),
('15','15','lato est',1),
('20','20','lato est',3),
('25','25','lato nordest',3),
('25','25','lato nord',4);


INSERT INTO Armadietto(CodSpogliatoio,CombSblocco)  VALUES

('2','ANG5'),
('10','90NC'),
('2','9M0D'),         
('6','29NG'),
('8','CR98'),
('9','C00G'),
('2','F04N'),
('9','4TIH'),
('3','CEGL'),
('8','9G8V'),
('2','Y4Y8'),
('7','C98R'),
('2','OVDC'),
('9','13RY'),
('9','HI5U'),
('4','VULJ'),
('8','5UN7'),
('8','TU65'),
('2','3D5F'),
('9','1W4D'),
('1','Y68I'),
('6','R3TG'),
('8','2D2E'),
('9','6IJ6'),
('7','3DYF'),
('3','F4RF'),
('1','UUT2'),
('10','1FO3'),
('5','3LO9'),
('5','TRRD'),
('10','KKMI'),
('5','VGTG'),
('1','XX2E'),
('1','WEF6'),
('7','HBBF'),
('3','FFFF'),
('4','UFH2'),
('3','45O3');


INSERT INTO Accesso(CodCentro,CodCliente,DataAccesso,OraAccesso,OraUscita,CodArmadietto,Piscina)  VALUES
('5','1','lunedi','9','11','1','si'),
('5','1','martedi','8','10', '11','no'),
('5','1','mercoledi','9','10', '11','si'),
('5','1','giovedi','8','10', '7','si'),
('5','1','venerdi','8','10', '19','no'),
('5','1','sabato','15','16','7','no' ),
('1','2','lunedi','9','10', '21','no'),
('1','2','mercoledi','9','11','12','si' ),
('1','2','martedi','8','10', '21','no'),
('3','3','giovedi','17','19', '5','si'),
('3','3','lunedi','15','16', '10','no'),
('3','3','martedi','12','14', '20','no'),
('3','3','mercoledi','8','10', '18','si'),
('3','4','martedi','9','10','17','no'),
('3','4','giovedi','11','13', '10','si'),
('2','5','lunedi','9','11','37','no'),
('1','5','martedi','9','11', '35','no'),
('2','5','mercoledi','17','18','26','no'),
('1','5','venerdi','9','11','21','si' ),
('3','6','martedi','14','16','14','no' ),
('3','6','giovedi','15','16', '8','si'),
('3','6','venerdi','12','14', '6','no'),
('2','7','mercoledi','13','15', '9','si'),
('2','7','venerdi','13','15', '9','no'),
('4','8','lunedi','14','16','2','no' ),
('4','8','venerdi','10','12', '2','si'),
('4','9','sabato','15','16', '29','no'),
('4','9','mercoledi','8','10','31','no'),
('4','9','martedi','17','18','30','si'),
('4','9','giovedi','9','11','31','si' ),
('1','10','lunedi','9','10', '33','si'),
('1','10','mercoledi','12','14','4','si'),
('1','10','martedi','8','10','25','no'),
('2','10','venerdi','9','11', '38','no'),
('2','10','sabato','10','12', '26','no'),
('1','11','martedi','17','18','35','no'),
('1','11','venerdi','9','11','22','si'),
('3','12','lunedi','9','11', '23','si'),
('3','12','venerdi','9','10', '23','no');	



INSERT INTO Responsabile(Dipendente,Responsabile) VALUES
('1','6'),
('2','6'),
('3','6'),
('4','2'),
('5','10'),
('6','10'),
('7','10'),
('8','6'),
('9','2'),
('10','6'),
('11','12'),
('12','10'),
('13','6'),
('14','10'),
('15','10');

INSERT INTO Composto(CodDipendente,CodCentro,Attività) VALUES
('1','1','medico nutrizionista'),
('2','5','medico nutrizionista'),
('3','2','istruttore'),
('4','5','tutor'),
('5','3','tutor'),
('6','2','medico nutrizionista'),
('7','3','tutor'),
('8','1','tutor'),
('9','5','istruttore'),
('10','3','tutor'),
('11','4','istruttore'),
('12','4','medico nutrizionista'),
('13','1','tutor'),
('14','3','tutor '),
('15','3','istruttore'),
('13','2','tutor'),
('5','4','tutor'),     /* tutor che arriva da Roma */
('12','3','medico nutrizionista'),  /* medico che arriva da napoli  */
('3','1','istruttore'), /* istruttore  che arriva da Milano B  */
('7','4','tutor'),  /* tutor che arriva da Roma */
('9','3','istruttore'), /* istruttore  che arriva da Firenze */
('2','3','medico nutrizionista'),/* medico che arriva da Firenze  */
('6','1','medico nutrizionista'),
('8','2','tutor'),
('9','1','istruttore') /* istruttore  che arriva da Firenze */;

INSERT INTO Sala(Nome,CodCentro,CodDipendente,NumApparecchiature) VALUES
('sala fitness','1','6','6'),
('sala macchine','1','6','3'),
('sala macchine','1','6','2'),
('sala pesi','1','13','2'),
('sala pesi','1','6','4'),
('sala pesi','1','6','2'),
('piscina interna','1','13','0'),
('piscina esterna','1','13','0'),
('piscina interna','1','13','0'),
('sala macchine','2','6','3'),
('piscina interna','2','13','0'),
('sala fitness','2','6','5'),
('sala pesi','2','8','2'),
('sala fitness','3','14','6'),
('sala macchine','3','14','3'),
('sala fitness','3','14','8'),
('sala pesi','3','5','7'),
('sala pesi','3','5','3'),
('piscina interna','3','10','0'),
('piscina esterna','3','10','0'),
('piscina interna','4','12','0'),
('sala macchine','4','11','4'),
('sala fitness','4','11','4'),
('sala pesi','4','7','3'),
('sala pesi','4','7','3'),
('piscina interna','5','9','0'),
('piscina interna','5','9','0'),
('sala fitness','5','4','4'),
('sala pesi','5','4','5');

INSERT INTO Magazzino(CodCentro,NomeCommerciale,Quantità) VALUES
('1','Anabolic Mass Pro','10'),
('2','Anabolic Mass Pro','10'),
('3','Anabolic Mass Pro','10'),
('5','Anabolic Mass Pro','10'),
('1','Impact whey','15'),
('4','Impact whey','15'),
('3','Impact whey','10'),
('1','Prolong','10'),
('2','Prolong','10'),
('3','Prolong','10'),
('1','Creatine Powder','20'),
('2','Creatine Powder','20'),
('4','Creatine Powder','20'),
('3','Creatine Powder','20'),
('5','Creatine Powder','20'),
('2','HydraTech','10'),
('3','HydraTech','15'),
('5','HydraTech','10'),
('1','HydraTech','20'),
('1','Protein Isolate','5'),
('4','Protein Isolate','5'),
('1','MultiSat','10'),
('2','MultiSat','10'),
('3','MultiSat','10'),
('4','MultiSat','10'),
('5','MultiSat','10');



INSERT INTO Contratto(CodCliente,CodDipendente,DataContratto, DataScadenza,Tipo,Tipologia,Sede,IngressiSettimanali,NumeroSaleAccessibili,AccessiPiscinaMensili,TipoPiscina,Scopo,Muscoli,Livello,CostoAnnuale,Rateizzazione) VALUES
('1','2','2018-02-23','2019-02-23','standard','platinum','1','7','4','20','interna','potenziamento muscolare','spalle','elevato','300','no');
INSERT INTO Contratto(CodCliente,CodDipendente,DataContratto, DataScadenza,Tipo,Tipologia,Sede,IngressiSettimanali,NumeroSaleAccessibili,AccessiPiscinaMensili,Scopo,CostoAnnuale,Rateizzazione) VALUES
('2','3','2018-02-23','2019-02-23','standard','silver','1','3','2','0','dimagrimento','100','no');
INSERT INTO Contratto(CodCliente,CodDipendente,DataContratto, DataScadenza,Tipo,Tipologia,Sede,IngressiSettimanali,NumeroSaleAccessibili,AccessiPiscinaMensili,TipoPiscina,Scopo,Muscoli,Livello,CostoAnnuale,Rateizzazione,TassoInteresse) VALUES
('3','10','2018-02-23','2019-02-23','standard','gold','1','5','4','15','interna','potenziamento muscolare','gambe','moderato','200','si',5);
INSERT INTO Contratto(CodCliente,CodDipendente,DataContratto, DataScadenza,Tipo,Tipologia,Sede,IngressiSettimanali,NumeroSaleAccessibili,AccessiPiscinaMensili,Scopo,Muscoli,Livello,CostoAnnuale,Rateizzazione) VALUES
('4','14','2018-02-23','2019-02-23','standard','silver','1','3','2','0','potenziamento muscolare','glutei','lieve','100','no');
INSERT INTO Contratto(CodCliente,CodDipendente,DataContratto, DataScadenza,Tipo,Tipologia,Sede,IngressiSettimanali,NumeroSaleAccessibili,AccessiPiscinaMensili,TipoPiscina,Scopo,Muscoli,Livello,CostoAnnuale,Rateizzazione) VALUES
('5','8','2018-02-23','2019-02-23','standard','gold','2','5','4','15','esterna','potenziamento muscolare','braccia','moderato','200','no');
INSERT INTO Contratto(CodCliente,CodDipendente,DataContratto, DataScadenza,Tipo,Sede,IngressiSettimanali,NumeroSaleAccessibili,AccessiPiscinaMensili,TipoPiscina,Scopo,Muscoli,Livello,CostoAnnuale,Rateizzazione,TassoInteresse) VALUES
('6','10','2018-02-23','2019-02-23','personalizzato','1','7','7','30','entrambe','potenziamento muscolare','pettorali','moderato','400','si',10);
INSERT INTO Contratto(CodCliente,CodDipendente,DataContratto, DataScadenza,Tipo,Tipologia,Sede,IngressiSettimanali,NumeroSaleAccessibili,AccessiPiscinaMensili,Scopo,CostoAnnuale,Rateizzazione) VALUES
('7','1','2018-02-23','2019-02-23','standard','silver','1','3','2','0','scopo ricreativo','100','no');
INSERT INTO Contratto(CodCliente,CodDipendente,DataContratto, DataScadenza,Tipo,Tipologia,Sede,IngressiSettimanali,NumeroSaleAccessibili,AccessiPiscinaMensili,Scopo,CostoAnnuale,Rateizzazione) VALUES
('8','12','2018-02-23','2019-02-23','standard','silver','1','3','2','0','dimagrimento','100','no');
INSERT INTO Contratto(CodCliente,CodDipendente,DataContratto, DataScadenza,Tipo,Sede,IngressiSettimanali,NumeroSaleAccessibili,AccessiPiscinaMensili,TipoPiscina,Scopo,Muscoli,Livello,CostoAnnuale,Rateizzazione,TassoInteresse) VALUES
('9','11','2018-02-23','2019-02-23','personalizzato','1','7','5','30','interna','potenziamento muscolare','spalle','elevato','400','si',10);
INSERT INTO Contratto(CodCliente,CodDipendente,DataContratto, DataScadenza,Tipo,Tipologia,Sede,IngressiSettimanali,NumeroSaleAccessibili,AccessiPiscinaMensili,TipoPiscina,Scopo,Muscoli,Livello,CostoAnnuale,Rateizzazione) VALUES
('10','6','2018-02-23','2019-02-23','standard','platinum','2','7','4','20','interna','potenziamento muscolare','braccia','elevato','300','no');
INSERT INTO Contratto(CodCliente,CodDipendente,DataContratto, DataScadenza,Tipo,Tipologia,Sede,IngressiSettimanali,NumeroSaleAccessibili,AccessiPiscinaMensili,Scopo,CostoAnnuale,Rateizzazione) VALUES
('11','3','2018-02-23','2019-02-23','standard','silver','1','3','2','0','dimagrimento','300','no');
INSERT INTO Contratto(CodCliente,CodDipendente,DataContratto, DataScadenza,Tipo,Tipologia,Sede,IngressiSettimanali,NumeroSaleAccessibili,AccessiPiscinaMensili,Scopo,Muscoli,Livello,CostoAnnuale,Rateizzazione) VALUES
('12','10','2018-02-23','2019-02-23','standard','silver','1','3','2','0','potenziamento muscolare','glutei','lieve','100','no');

INSERT INTO Offre(CodContratto,CodCentro) VALUES
('1','5'),
('2','1'),
('3','3'),
('4','3'),
('5','2'),
('5','1'),
('6','3'),
('7','2'),
('8','4'),
('9','4'),
('10','1'),
('10','2'),
('11','1'),
('12','3');

INSERT INTO Interesse(Nome) VALUES
('Fitboxe'),
('Yoga'),
('Body Building'),
('Karate'),
('Zumba'),
('Aereobica'),
('Tennis'),
('Calcio'),
('Basket'),
('Nuoto'),
('Running'),
('Walking'),
('Pilates Toys'),
('Super Jump');

INSERT INTO InteresseCliente(CodCliente,CodInteresse) VALUES
('1','1'),
('1','3'),
('1','4'),
('2','13'),
('2','5'),
('3','8'),
('3','9'),
('3','1'),
('3','10'),
('4','5'),
('4','13'),
('5','3'),
('5','4'),
('5','1'),
('5','8'),
('6','12'),
('6','1'),
('6','14'),
('7','2'),
('7','7'),
('7','8'),
('7','9'),
('8','1'),
('8','7'),
('8','2'),
('8','11'),
('8','12'),
('8','6'),
('8','10'),
('9','1'),
('9','5'),
('9','8'),
('10','1'),
('10','3'),
('10','11'),
('11','2'),
('11','9'),
('11','14'),
('12','13'),
('12','2'),
('12','5'),
('1','11'),
('5','11'),
('9','7'),
('2','2'),
('4','2'),
('4','12');

INSERT INTO Cerchia(Nome) VALUES
('calciobasket'),
('sportconpalla'),
('relaxedivertimento'),
('lottaesudore'),
('camminareeriposo');
INSERT INTO CerchiaInteresse (CodCerchia,CodInteresse) VALUES
('1','8'),
('1','9'),
('2','8'),
('2','9'),
('2','7'),
('3','5'),
('3','2'),
('3','13'),
('4','1'),
('4','3'),
('4','4'),
('4','11'),
('5','2'),
('5','12');

INSERT INTO CerchiaCliente(CodCliente,CodCerchia) VALUES
('3','1'),
('7','1'),
('9','2'),
('3','2'),
('7','2'),
('2','3'),
('12','3'),
('4','3'),
('8','4'),
('1','4'),
('5','4'),
('10','4'),
('8','5'),
('4','5');




INSERT INTO Rata(CodContratto,DataScadenza,StatoPagamento)  VALUES
('3' ,'2018-02-24','pagato'),
('3' ,'2018-06-23','non ancora dovuto'),
('3','2018-10-23','non ancora dovuto'),
('6','2018-02-23','pagato'),
('6','2018-06-23','non ancora dovuto'),
('6','2018-10-23','non ancora dovuto'),
('9','2018-02-24',' non pagato'),
('9','2018-06-23','non ancora dovuto'),
('9','2018-10-23','non ancora dovuto');

INSERT INTO Dieta(PastiGiornalieri,CalorieGiornaliere,Composizione,NomeCommerciale)  VALUES
('4','2500','COLAZIONE: Latte gr 200,zucchero gr 10,fette biscottate gr 30,marmellata gr 30
,caffè gr 5 (o spremuta di arancia)
PRANZO: Pasta (o Riso) al pomodoro(pasta (Riso) gr 80,pelati gr 100,olio gr 5,parmigiano gr 5)
Petto di pollo (o Prosciutto di maiale) al forno(Petto di pollo (Prosciutto) gr 150)
Patate al forno(o Piselli)(Patate gr 200,olio gr 5),pane gr 100
MERENDA: Frutta 100 gr 
CENA: Minestrone con riso(o di verdure)(riso gr 30,patate gr 30,fagioli gr 20,olio gr 5,carote gr 30,pelati gr 30,parmigiano gr 5)
Merluzzo (qualsiasi pesce) (merluzzo gr 200),pane gr 100','Anabolic Mass Pro'
),
('4','1500','COLAZIONE: Latte o(yogurt magro) gr 200,zucchero (o senza zucchero) gr 10,fette biscottate gr 30,marmellata gr 30
,caffè gr 5 (o spremuta di arancia)
PRANZO: Pasta (o Riso) al pomodoro(pasta (Riso) gr 60,pelati gr 100,olio gr 5,parmigiano gr 5)
Tonno senza olio(qualsiasi pesce) (tonno gr 100)
insalata(pomodoro gr 40,insalata gr 40,caroti gr 30)
MERENDA: Frutta 100 gr 
CENA: Minestrone con riso(o di verdure)(riso gr 30,patate gr 30,fagioli gr 20,olio gr 5,carote gr 30,pelati gr 30,parmigiano gr 5)
','Impact whey'
),
('4','3000','COLAZIONE: Latte gr 200,zucchero gr 10,fette biscottate gr 50,marmellata (o crema alla nocciola) gr 30
,caffè gr 5 (o spremuta di arancia)
PRANZO: Pasta (o Riso) al pomodoro(pasta (Riso) gr 130,pelati gr 100,olio gr 5,parmigiano gr 5)
Petto di pollo (o Prosciutto di maiale) al forno(Petto di pollo (Prosciutto) gr 200)
Patate al forno(o Piselli)(Patate gr 200,olio gr 5),pane gr 100
MERENDA: Frutta 100 gr 
CENA: Pasta (o Riso a secoda di cosa hai mangiato a pranzo)al sugo(funghi,pesto,bolognese)(pasta (Riso) gr 100,sugo gr 100)
Merluzzo (qualsiasi pesce) (merluzzo gr 200),pane gr 100','Creatine Powder'
),
('4','2000','COLAZIONE: Latte  gr 200,zucchero  gr 10,cereali gr 30,marmellata gr 30
,caffè gr 5 (o spremuta di arancia)
PRANZO: Pasta  in binco(pasta  gr 100,olio gr 5,parmigiano gr 5)
Lonza di Maiale(o Vitello,o Agnello)gr 150
insalata(pomodoro gr 40,insalata gr 40,caroti gr 30)
MERENDA: Frutta 100 gr 
CENA: Riso in bianco(riso  gr 100,olio gr 5,parmigiano gr 5)
Polpette al sugo gr 100(o Verdura Cotta(fagiolini,spinaci,asparagi) gr 200 o Affettati gr 200)
','Prolong');


SET @iniziocorso = CURRENT_DATE- INTERVAL 1 month;
SET @finecorso = CURRENT_DATE+ INTERVAL 3 month;


/*Nel popolamento della tabella corso,abbiamo messo in conto che ogni corso potesse essere svolto in ogni sala anche quelle con i pesi,
 eccezion fatta per la sala piscina nella quale è possibile effettuare solo il corso di nuoto  */
INSERT INTO Corso(CodSala,Disciplina,CodDipendente,NumPartecipanti,DataInizio,DataFine,Livello) VALUES
('1','Fitboxe','3','2',@iniziocorso,@finecorso,'principiante'),/*stesso istruttore ma lo insegna in giorni diversi  */
('10','Fitboxe','3','2',@iniziocorso,@finecorso,'medio'),
('14','Fitboxe','15','2',@iniziocorso,@finecorso,'avanzato'),
('22','Fitboxe','11','2',@iniziocorso,@finecorso,'avanzato'),/* istruttore di Napoli  */
('6','Yoga','9','2',@iniziocorso,@finecorso,'principiante'),/* istruttore di Milano1 e Roma insegna una volta anche a Firenze  */
('15','Yoga','9','2',@iniziocorso,@finecorso,'medio'),
('16','Zumba','15','2',@iniziocorso,@finecorso,'medio'),
('12','Running','3','2',@iniziocorso,@finecorso,'principiante'),
('2','Running','3','2',@iniziocorso,@finecorso,'medio'),
('18','Walking','15','2',@iniziocorso,@finecorso,'medio'),
('17','Pilates Toys','9','2',@iniziocorso,@finecorso,'medio'),
('5','Body Building','3','2',@iniziocorso,@finecorso,'avanzato'),
('13','Body Building','3','2',@iniziocorso,@finecorso,'principiante'),
('28','Running','9','1',@iniziocorso,@finecorso,'principiante'),
('23','Zumba','11','1',@iniziocorso,@finecorso,'avanzato'),
('24','Aerobica','11','1',@iniziocorso,@finecorso,'principiante');

INSERT INTO Iscrizione(CodCliente,CodCorso) VALUES
('5','1'),
('10','1'),
('5','2'),
('10','2'),
('3','3'),
('6','3'),
('8','4'),
('9','4'),
('2','5'),
('11','5'),
('12','6'),
('4','6'),
('4','7'),
('12','7'),
('5','8'),
('10','8'),
('5','9'),
('10','9'),
('6','10'),
('4','10'),
('4','11'),
('12','11'),
('5','12'),
('10','12'),
('5','13'),
('10','13'),
('1','14'),
('9','15'),
('8','16');

INSERT INTO Fornitore(NomeFornitore,Società,PartitaIva,Telefono,Indirizzo)  VALUES
('SINTEL','S.r.l.','279892702','050678947','Via Vincenzo Monti 32 Milano(MI)'),
('T.e.s.','spa','398706146','050745616','Via Vincenzo Monti 41 Milano(MI)'),
('Rodorigo','S.r.l','426007968','050183456','Via Poggio Moiano Roma(RM)'),
('Mavi','srl','136095709','050897613','Via Centro Direzionale Isola Napoli (NA)'),
('VAR GROUP','SPA','570673271','050743562','VIA LEOPOLDO GIUNTINI Empoli(FI)');

INSERT INTO Vende(NomeFornitore,NomeCommerciale) VALUES
('SINTEL','Anabolic Mass Pro'),
('Rodorigo','Anabolic Mass Pro'),
('T.e.s.','Anabolic Mass Pro'),
('VAR GROUP','HydraTech'),
('SINTEL','HydraTech'),
('Rodorigo','HydraTech'),
('Mavi','MultiSat'),
('SINTEL','MultiSat'),
('T.e.s.','Prolong'),
('SINTEL','Prolong'),
('Rodorigo','Prolong'),
('SINTEL','Impact whey'),
('T.e.s.','Impact whey'),
('Mavi','Impact whey'),
('SINTEL','Creatine Powder'),
('T.e.s.','Creatine Powder'),
('Rodorigo','Creatine Powder'),
('Mavi','Creatine Powder'),
('VAR GROUP','Impact whey'),
('VAR GROUP','Creatine Powder'),
('VAR GROUP','Protein Isolate'),
('SINTEL','Protein Isolate'),
('Mavi','Protein Isolate'),
('T.e.s.','Protein Isolate');

INSERT INTO Attrezzatura(Nome) VALUES
('PECTORAL MACHINE'),
('VOGATORE'),
('PULLEY'),
('BARRA TRAZIONI'),
('LAT MACHINE'),
('CHEST PRESS'),
('SHOULDER PRESS'),
('LEG EXTENSION'),
('LEG CURL'),
('CYCLETTE'),
('TAPIS ROULANT'),
('ELLITTICA'),
('MANUBRI'),
('BILANCIERE');


INSERT INTO Regolazione(CodMacchina,Nome,Minimo,Massimo) VALUES
('1','Peso','5','130'),
('2','Peso','10','150'),
('3','Peso','10','150'),
('4','Peso','0','80'),
('5','Peso','10','150'),
('6','Peso','10','100'),
('7','Peso','5','100'),
('8','Peso','0','100'),
('9','Peso','0','50'),
('10','Velocità','0','40'),
('11','Velocità','0','40'),
('11','Inclinazione ','0','5'),
('12','Velocità','0','40'),
('10','Altezza Manubrio','0','5'),
('13','Peso','1','60'),
('14','Peso','1','150');



INSERT INTO SchedaAllenamento(CodCliente,CodDipendente,DataInizio,DataFine) VALUES
('1','4','2018-02-23','2018-04-27'),
('2','8','2018-02-23','2018-04-27'),
('3','10','2018-02-23','2018-04-27'),
('4','14','2018-02-23','2018-04-27'),
('5','13','2018-02-23','2018-04-27'),
('6','7','2018-02-23','2018-04-27'),
('7','13','2018-02-23','2018-04-27'),
('8','5','2018-02-23','2018-04-27'),
('9','7','2018-02-23','2018-04-27'),
('10','13','2018-02-23','2018-04-27'),
('11','8','2018-02-23','2018-04-27'),
('12','5','2018-02-23','2018-04-27');

INSERT INTO Esercizio(Tipo,Dispendio)  VALUES
('Bicipiti con Bilanciere',240),
('Bicipiti con Manubri',200),
('Rematore Bilanciere',370),
('Lat Machine Avanti ',320),
('Trazione alla sbarra avanti',260),
('Trapezi in piedi Bilanciere  ',170),
('Flessioni',220),
('Addominali',160),
('Alzate Frontali con Bilanciere',350),
('Alzate Frontali con Manubri',200),
('Alzate Laterali con Manubri',260),
('Leg Press',250),
('Trazioni Pulley ',230),
('Rematore con Manubri',220),
('Lat Machine Larga Dorsali',300),
('Vogatore',250),
('Trazioni alla sbarra',400),
('Ellitica',220),
('Cyclette',220),
('Leg Extension',200),
('Leg Curl sdraiato',260),
('Leg Curl in piedi',240),
('Alzate polpacci',120),
('Squat con manubri',220),
('Lat Machine Stretta',300),
('French Press con Bilanciere',240),
('Tricipiti con Manubri',350),
('Shoulder press',260),
('Cardio',180),
('Plank',240);

 INSERT INTO EserciziScheda (CodScheda ,CodEsercizio ,Serie ,Ripetizioni ,Riposo,Durata,CodAccesso) VALUES
(1,11,4,8,2,10,1),
(1,10,4,8,2,10,1),
(1,26,3,5,2,20,1),
(1,28,4,8,2,15,1),
(1,29,0,0,0,30,1),
(1,11,4,8,2,10,2),
(1,10,5,7,2,10,2),
(1,26,3,5,2,20,2),
(1,28,4,8,2,15,2),
(1,29,0,0,0,30,2),
(1,11,4,7,2,10,3),
(1,10,4,8,2,10,3),
(1,26,3,5,2,20,3),
(1,28,5,7,2,15,3),
(1,29,0,0,0,30,3),
(1,11,4,8,2,10,4),
(1,10,4,8,2,10,4),
(1,26,3,5,2,20,4),
(1,28,4,8,2,15,4),
(1,29,0,0,0,30,4),
(1,11,4,7,2,10,5),
(1,10,5,8,2,10,5),
(1,26,3,5,2,20,5),
(1,28,4,8,2,15,5),
(1,29,0,0,0,30,5),
(1,11,5,8,2,10,6),
(1,10,4,7,2,10,6),
(1,26,3,5,2,20,6),
(1,28,4,7,2,15,6),
(1,29,0,0,0,30,6),
(2,29,0,0,0,15,7),
(2,8,3,20,2,15,7),
(2,18,0,0,0,15,7),
(2,19,0,0,0,15,7),
(2,29,0,0,0,15,8),
(2,8,3,20,2,15,8),
(2,18,0,0,0,15,8),
(2,19,0,0,0,15,8),
(2,29,0,0,0,15,9),
(2,8,3,20,2,15,9),
(2,18,0,0,0,15,9),
(2,19,0,0,0,15,9),
(3,12,3,8,2,15,10),
(3,23,3,25,2,20,10),
(3,21,3,8,2,20,10),
(3,20,3,5,2,20,10),
(3,22,3,5,2,15,10),
(3,12,3,8,2,15,11),
(3,23,3,25,2,20,11),
(3,21,3,8,2,20,11),
(3,20,3,5,2,20,11),
(3,22,3,5,2,15,11),
(3,12,3,8,2,15,12),
(3,23,3,25,2,20,12),
(3,21,3,8,2,20,12),
(3,20,3,5,2,20,12),
(3,22,3,5,2,15,12),
(3,12,3,8,2,15,13),
(3,23,3,25,2,20,13),
(3,21,3,8,2,20,13),
(3,20,3,5,2,20,13),
(3,22,3,5,2,15,13),
(4,24,3,25,2,15,14),
(4,18,0,0,0,10,14),
(4,29,0,0,0,10,14),
(4,21,3,5,2,15,14),
(4,24,3,25,2,15,15),
(4,18,0,0,0,10,15),
(4,29,0,0,0,10,15),
(4,21,3,5,2,15,15),
(5,27,4,10,2,15,16),
(5,7,3,25,2,20,16),
(5,1,4,8,2,20,16),
(5,17,2,8,2,10,16),
(5,27,4,10,2,15,17),
(5,7,3,25,2,20,17),
(5,1,4,8,2,20,17),
(5,17,2,8,2,10,17),
(5,27,4,10,2,15,18),
(5,7,3,25,2,20,18),
(5,1,4,8,2,20,18),
(5,17,2,8,2,10,18),
(5,27,4,10,2,15,19),
(5,7,3,25,2,20,19),
(5,1,4,8,2,20,19),
(5,17,2,8,2,10,19),
(6,4,3,10,2,15,20),
(6,13,3,7,2,15,20),
(6,7,3,15,2,15,20),
(6,25,2,8,2,15,20),
(6,26,2,5,2,10,20),
(6,4,3,10,2,15,21),
(6,13,3,7,2,15,21),
(6,7,3,15,2,15,21),
(6,25,2,8,2,15,21),
(6,26,2,5,2,10,21),
(6,4,3,10,2,15,22),
(6,13,3,7,2,15,22),
(6,7,3,15,2,15,22),
(6,25,2,8,2,15,22),
(6,26,2,5,2,10,22),
(7,16,1,10,2,5,23),
(7,29,0,0,0,10,23),
(7,2,2,8,2,10,23),
(7,9,2,5,2,10,23),
(7,16,1,10,2,5,24),
(7,29,0,0,0,10,24),
(7,2,2,8,2,10,24),
(7,9,2,5,2,10,24),
(8,19,0,0,0,20,25),
(8,12,3,8,2,15,25),
(8,3,2,8,2,10,25),
(8,21,3,8,2,15,25),
(8,19,0,0,0,20,26),
(8,12,3,8,2,15,26),
(8,3,2,8,2,10,26),
(8,21,3,8,2,15,26),
(9,10,4,8,2,15,27),
(9,26,3,6,2,15,27),
(9,15,3,15,2,15,27),
(9,9,3,8,2,15,27),
(9,17,3,5,2,15,27),
(9,10,4,8,2,15,28),
(9,26,3,6,2,15,28),
(9,15,3,15,2,15,28),
(9,9,3,8,2,15,28),
(9,17,3,5,2,15,28),
(9,10,4,8,2,15,29),
(9,26,3,6,2,15,29),
(9,15,3,15,2,15,29),
(9,9,3,8,2,15,29),
(9,17,3,5,2,15,29),
(9,10,4,8,2,15,30),
(9,26,3,6,2,15,30),
(9,15,3,15,2,15,30),
(9,9,3,8,2,15,30),
(9,17,3,5,2,15,30),
(10,1,3,8,2,15,31),
(10,27,4,8,2,15,31),
(10,2,3,10,2,15,31),
(10,17,3,5,2,15,31),
(10,1,3,8,2,15,32),
(10,27,4,8,2,15,32),
(10,2,3,10,2,15,32),
(10,17,3,5,2,15,32),
(10,1,3,8,2,15,33),
(10,27,4,8,2,15,33),
(10,2,3,10,2,15,33),
(10,17,3,5,2,15,33),
(10,1,3,8,2,15,34),
(10,27,4,8,2,15,34),
(10,2,3,10,2,15,34),
(10,17,3,5,2,15,34),
(10,1,3,8,2,15,35),
(10,27,4,8,2,15,35),
(10,2,3,10,2,15,35),
(10,17,3,5,2,15,35),
(11,29,0,0,0,25,36),
(11,19,0,0,0,25,36),
(11,29,0,0,0,25,37),
(11,19,0,0,0,25,37),
(12,18,0,0,0,15,38),
(12,24,3,8,2,15,38),
(12,21,2,5,2,10,38),
(12,12,2,5,2,10,38),
(12,18,0,0,0,15,39),
(12,24,3,8,2,15,39),
(12,21,2,5,2,10,39),
(12,12,2,5,2,10,39);




INSERT INTO  Log (IdEsercizio,Serie,Ripetizioni,Riposo,TempoImpiegato,CodAccesso) VALUES

(1,4,7,1,14,1),
(2,3,7,3,12,1),
(3,3,5,2,22,1),
(4,4,8,3,15,1),
(5,0,0,0,30,1),
(6,4,8,5,13,2),
(7,4,7,3,14,2),
(8,3,5,2,20,2),
(9,5,6,1,15,2),
(10,0,0,0,26,2),
(11,4,6,3,10,3),
(12,4,8,1,10,3),
(13,3,5,3,20,3),
(14,5,8,2,15,3),
(15,0,0,0,30,3),
(16,4,6,2,13,4),
(17,4,7,2,16,4),
(18,4,5,2,24,4),
(19,3,8,2,17,4),
(20,0,0,0,34,4),
(21,4,7,2,15,5),
(22,5,6,1,13,5),
(23,3,5,2,20,5),
(24,5,8,2,18,5),
(25,0,0,0,23,5),
(26,5,8,1,10,6),
(27,3,7,2,16,6),
(28,4,5,1,23,6),
(29,5,5,2,17,6),
(30,0,0,0,23,6),
(31,0,0,0,17,7),
(32,3,23,1,15,7),
(33,0,0,0,16,7),
(34,0,0,0,18,7),
(35,0,0,0,16,8),
(36,0,0,2,15,8),
(37,0,0,0,14,8),
(38,0,0,0,15,8),
(39,0,0,0,17,9),
(40,3,33,2,15,9),
(41,0,0,0,15,9),
(42,0,0,0,19,9),
(43,4,6,3,15,10),
(44,4,28,2,16,10),
(45,4,8,2,27,10),
(46,3,5,4,20,10),
(47,3,5,2,15,10),
(48,3,6,1,15,11),
(49,3,25,4,21,11),
(50,4,7,1,23,11),
(51,3,5,3,20,11),
(52,4,5,2,18,11),
(53,4,8,3,15,12),
(54,3,25,2,22,12),
(55,3,8,2,20,12),
(56,3,5,1,24,12),
(57,3,5,2,15,12),
(58,6,7,1,18,13),
(59,3,27,2,20,13),
(60,4,2,1,24,13),
(61,3,5,2,20,13),
(62,3,5,5,15,13),
(63,3,25,2,15,14),
(64,0,0,0,14,14),
(65,0,0,0,17,14),
(66,3,3,2,17,14),
(67,3,25,1,15,15),
(68,0,0,0,10,15),
(69,0,0,0,16,15),
(70,2,5,2,15,15),
(71,3,14,4,18,16),
(72,4,25,4,28,16),
(73,3,7,4,24,16),
(74,2,8,2,10,16),
(75,4,14,3,17,17),
(76,3,25,2,24,17),
(77,3,8,4,20,17),
(78,2,6,2,15,17),
(79,7,10,3,15,18),
(80,4,25,2,23,18),
(81,4,6,3,25,18),
(82,2,6,4,10,18),
(83,4,10,4,15,19),
(84,4,25,4,24,19),
(85,3,8,4,20,19),
(86,2,8,2,17,19),
(87,3,10,4,18,20),
(88,4,7,2,17,20),
(89,3,15,5,15,20),
(90,4,7,4,18,20),
(91,2,5,3,10,20),
(92,3,10,4,17,21),
(93,3,7,2,15,21),
(94,4,15,2,18,21),
(95,2,8,2,15,21),
(96,4,5,2,10,21),
(97,3,13,4,17,22),
(98,1,7,2,15,22),
(99,4,13,5,18,22),
(100,1,6,4,15,22),
(101,2,5,2,14,22),
(102,1,16,5,9,23),
(103,0,0,0,14,23),
(104,2,8,2,10,23),
(105,3,5,2,13,23),
(106,1,13,4,7,24),
(107,0,0,0,14,24),
(108,3,8,2,10,24),
(109,2,6,2,14,24),
(110,0,0,0,22,25),
(111,3,6,2,15,25),
(112,4,8,4,10,25),
(113,3,6,2,18,25),
(114,0,0,0,24,26),
(115,3,6,2,15,26),
(116,2,6,2,15,26),
(117,4,8,3,13,26),
(118,3,6,1,13,27),
(119,4,6,2,15,27),
(120,3,15,2,15,27),
(121,3,8,4,15,27),
(122,3,5,4,18,27),
(123,3,7,3,18,28),
(124,4,6,2,17,28),
(125,3,15,2,15,28),
(126,4,6,4,15,28),
(127,3,5,5,17,28),
(128,4,8,1,15,29),
(129,5,6,2,15,29),
(130,3,15,2,14,29),
(131,4,9,5,15,29),
(132,3,5,2,18,29),
(133,4,8,3,15,30),
(134,4,6,1,16,30),
(135,4,15,2,15,30),
(136,4,5,2,18,30),
(137,3,5,3,17,30),
(138,3,5,3,15,31),
(139,4,8,2,17,31),
(140,3,10,2,15,31),
(141,4,5,4,18,31),
(142,3,9,2,15,32),
(143,4,9,2,18,32),
(144,3,10,4,15,32),
(145,4,5,1,17,32),
(146,3,8,4,11,33),
(147,4,8,2,16,33),
(148,3,11,2,15,33),
(149,4,6,2,15,33),
(150,4,8,4,18,34),
(151,4,6,5,17,34),
(152,3,10,3,15,34),
(153,3,5,4,15,34),
(154,3,8,1,18,35),
(155,4,8,1,15,35),
(156,3,13,2,15,35),
(157,2,5,4,18,35),
(158,0,0,0,26,36),
(159,0,0,0,26,36),
(160,0,0,0,24,37),
(161,0,0,0,22,37),
(162,0,0,0,13,38),
(163,4,7,2,17,38),
(164,2,5,2,10,38),
(165,2,5,2,10,38),
(166,0,0,0,18,39),
(167,3,8,2,16,39),
(168,4,5,2,14,39),
(169,2,5,2,10,39);



 INSERT INTO  ControlloAttrezzatura (IdEsercizio,IdRegolazione,Intensità) VALUES
(1,15,10),
(2,15,20),
(3,16,60),
(4,7,60),
(5,11,15),
(5,12,3),
(6,15,10),
(7,15,20),
(8,16,60),
(9,7,60),
(10,11,15),
(10,12,3),
(11,15,10),
(12,15,20),
(13,16,60),
(14,7,60),
(15,11,15),
(15,12,3),
(16,15,10),
(17,15,20),
(18,16,60),
(19,7,60),
(20,11,15),
(20,12,3),
(21,15,10),
(22,15,20),
(23,16,60),
(24,7,60),
(25,11,15),
(25,12,3),
(26,15,10),
(27,15,20),
(28,16,60),
(29,7,60),
(30,11,15),
(30,12,3),
(31,11,10),
(31,12,0),
(33,13,10),
(34,10,10),
(35,11,10),
(35,12,0),
(37,13,10),
(38,10,10),
(39,11,10),
(39,12,0),
(41,13,10),
(42,10,10),
(43,8,20),
(44,15,5),
(45,9,15),
(46,8,20),
(47,9,15),
(48,8,20),
(49,15,5),
(50,9,15),
(51,8,20),
(52,9,15),
(53,8,20),
(54,15,5),
(55,9,15),
(56,8,20),
(57,9,15),
(58,8,20),
(59,15,5),
(60,9,15),
(61,8,20),
(62,9,15),
(63,15,5),
(64,13,10),
(65,11,10),
(65,12,0),
(66,9,10),
(67,15,5),
(68,13,10),
(69,11,10),
(69,12,0),
(70,9,10),
(71,15,10),
(73,16,25),
(74,4,15),
(75,15,10),
(77,16,25),
(78,4,15),
(79,15,10),
(81,16,25),
(82,4,15),
(83,15,10),
(85,16,25),
(86,4,15),
(87,5,20),
(88,3,20),
(90,5,20),
(91,16,40),
(92,5,20),
(93,3,20),
(95,5,20),
(96,16,40),
(97,5,20),
(98,3,20),
(100,5,20),
(101,16,40),
(102,3,10),
(103,11,10),
(103,12,0),
(104,15,5),
(105,16,10),
(106,3,10),
(107,11,10),
(107,12,0),
(108,15,5),
(109,16,10),
(110,10,15),  /* altezza  e velocità cyclette */
(110,14,2),
(111,8,20),
(112,16,10),
(113,9,10),
(114,10,15),
(114,14,2),
(115,8,20),
(116,16,10),
(117,9,10),
(118,15,10),
(119,16,60),
(120,5,40),
(121,16,20),
(122,4,10),
(123,15,10),
(124,16,60),
(125,5,40),
(126,16,20),
(127,4,10),
(128,15,10),
(129,16,60),
(130,5,40),
(131,16,20),
(132,4,10),
(133,15,10),
(134,16,60),
(135,5,40),
(136,16,20),
(137,4,10),
(138,16,35),
(139,15,15),
(140,15,15),
(141,4,10),
(142,16,35),
(143,15,15),
(144,15,15),
(145,4,10),
(146,16,35),
(147,15,15),
(148,15,15),
(149,4,10),
(150,16,35),
(151,15,15),
(152,15,15),
(153,4,10),
(154,16,35),
(155,15,15),
(156,15,15),
(157,4,10),
(158,11,15),
(158,12,2),
(159,10,10),
(159,14,1),
(160,11,15),
(160,12,2),
(161,10,10),
(161,14,1),
(162,13,15),
(163,15,10),
(164,9,15),
(165,8,20),
(166,13,15),
(167,15,10),
(168,9,15),
(169,8,20); 




INSERT INTO AttrezzaturaSala (CodMacchina,CodSala,Consumo,Usura)VALUES
(1,2,10,20),
(1,14,10,15),
(1,2,10,15),
(2,10,10,25),
(2,10,10,15),
(3,14,10,30),
(3,15,10,40),
(3,12,10,40),
(4,3,0,15),
(4,12,0,10),
(4,5,0,15),
(4,16,0,5),
(5,22,20,30),
(5,22,20,40),
(5,17,20,40),
(5,17,20,40),
(5,15,20,20),
(5,16,20,40),
(5,29,10,20),
(6,2,10,20),
(6,3,20,10),
(6,10,10,10),
(6,16,10,20),
(6,29,20,30),
(7,28,10,50),
(7,29,10,40),
(7,22,10,5),
(7,22,10,0),
(8,18,20,20),
(8,24,20,20),
(8,25,20,10),
(8,17,20,15),
(8,17,20,10),
(8,5,10,0),
(9,14,10,20),
(9,23,10,40),
(9,15,10,20),
(9,17,10,20),
(10,1,10,30),
(10,1,10,40),
(10,16,10,30),
(10,14,10,40),
(10,28,10,40),
(10,23,10,40),
(10,12,10,0),
(11,1,10,30),
(11,1,10,40),
(11,16,10,30),
(11,14,10,40),
(11,28,10,40),
(11,23,10,40),
(11,12,10,0),
(12,1,10,30),
(12,1,10,20),
(12,16,10,30),
(12,14,10,20),
(12,28,10,20),
(12,23,10,20),
(12,12,10,0),
(13,4,0,0),
(13,5,0,0),
(13,6,0,0),
(13,13,0,0),
(13,16,0,0),
(13,17,0,0),
(13,18,0,0),
(13,24,0,0),
(13,25,0,0),
(13,29,0,0),
(14,4,0,0),
(14,5,0,0),
(14,6,0,0),
(14,13,0,0),
(14,16,0,0),
(14,17,0,0),
(14,18,0,0),
(14,24,0,0),
(14,25,0,0),
(14,29,0,0);



INSERT INTO Amicizia(CodCliente,Amico,DataRichiesta,Stato,DataAccettazione) VALUES
(1,5,'2018-02-26','accettata','2018-02-26'),
(1,8,'2018-02-26','accettata','2018-02-26'),
(1,9,'2018-02-26','accettata','2018-02-26'),
(1,10,'2018-03-06','accettata','2018-03-06'),
(2,4,'2018-02-25','accettata','2018-02-25'),
(2,12,'2018-02-25','accettata','2018-02-25'),
(2,11,'2018-02-25','accettata','2018-02-25'),
(3,7,'2018-02-26','accettata','2018-02-26'),
(3,9,'2018-02-26','accettata','2018-02-26'),
(4,8,'2018-02-25','accettata','2018-02-25'),
(4,2,'2018-02-25','accettata','2018-02-25'),
(4,12,'2018-04-06','accettata','2018-04-06'),
(4,6,'2018-04-06','accettata','2018-04-06'),
(5,1,'2018-02-26','accettata','2018-02-26'),
(5,8,'2018-02-28','accettata','2018-02-28'),
(5,10,'2018-04-06','accettata','2018-04-06'),
(6,1,'2018-04-06','accettata','2018-04-06'),
(6,4,'2018-04-06','accettata','2018-04-06'),
(6,11,'2018-02-25','accettata','2018-02-25'),
(7,3,'2018-04-06','accettata','2018-04-06'),
(7,9,'2018-04-06','accettata','2018-04-06'),
(8,4,'2018-02-25','accettata','2018-02-25'),
(8,1,'2018-02-26','accettata','2018-02-26'),
(8,10,'2018-04-05','accettata','2018-04-05'),
(8,5,'2018-02-28','accettata','2018-02-28'),
(9,7,'2018-04-05','accettata','2018-04-05'),
(9,1,'2018-02-26','accettata','2018-02-26'),
(10,1,'2018-02-26','accettata','2018-02-26'),
(10,8,'2018-04-05','accettata','2018-04-05'),
(10,5,'2018-04-06','accettata','2018-04-06'),
(11,6,'2018-02-25','accettata','2018-02-25'),
(11,2,'2018-02-25','accettata','2018-02-25'),
(12,2,'2018-02-25','accettata','2018-02-25'),
(12,4,'2018-02-25','accettata','2018-02-25');
INSERT INTO Amicizia(CodCliente,Amico,DataRichiesta,Stato) VALUES
(1,7,'2018-02-25','non accettata'),
(6,8,'2018-04-06','non accettata'),
(7,1,'2018-02-25','non accettata'),
(8,6,'2018-04-05','non accettata'),
(9,11,'2018-02-26','non accettata'),
(11,9,'2018-04-06','non accettata');



INSERT INTO Post(CodCliente,Testo,DataPubblicazione,Luogo) VALUES

(11,'Per perdere peso quanta cyclette dovrei fare a sessione di allenamento?', '2018-02-26 20:38:17', 'Palestra'),
(11,'Oggi  sono propio contento di come sia andata la giornata','2018-03-06 09:38:56', 'Palestra'),
(1,'Sono stanchissimo ', '2018-04-06 22:38:13', 'Palestra'),
(1,'Esercizi utili per le spalle?','2018-04-06 20:38:35', 'Palestra'),
(4,'Ma quanto si sta bene dopo aver fatto un po di yoga', '2018-04-14 20:38:12', 'Palestra'),
(1,'Quante volte bisognerebbe andare in palestra a settimana?', '2018-03-16 10:06:48', 'Palestra'),
(2,'Voi come condite l insalata?', '2018-02-26 20:18:33', 'Cibo'),
(5,'Per i bicipiti meglio utilizzare i manubri o il bilanciere?', '2018-03-06 14:35:22', 'Palestra'),
(1,'Come mai le carni rosse fanno male?', '2018-03-16 08:32:33', 'Cibo'),
(11,'Qualcuno a voglia di venire a correre con me?', '2018-02-26 18:38:33', 'Palestra');

INSERT INTO Post(CodCliente,Testo,DataPubblicazione,Luogo,Link) VALUES

(7,'Spero vinca la Lazio stasera','2018-04-06 11:24:45','Sport', 'www.laziochannel.com'),
(3,'Ma quanto è forte Bellinelli!!','2018-02-27 15:08:09','Sport', 'www.lagazzettadellosport.com');

INSERT INTO Risposta(IdPost,CodCliente,Testo) VALUES

('1','2','Dipende dagli obbiettivi che intendi raggiungere,io ad esempio ne faccio 15 di minuti'),
('1','9','Non saprei'),
('1','6','Credo che 10 minuti dovrebbero bastare'),
('4','9','Alzate frontali con bilanciere,alzate Laterali con manubri,shoulder press,trazioni alla sbarra questi sono quelli principali'),
('4','5','Anche le flessioni sono utili :)'),
('7','11','Di solito io preferisco non aggiungerci nulla,il sale e l olio non fanno bene'),
('6','9','Non è utile andarci tutti i giorni,perchè i muscoli devono avere il tempo di recuperare'),
('6','10','Dipende da quanta voglia hai e da quanto tempo puoi dedicarci'),
('6','5','3 volte a settimana'),
('10','2','no mi dispiace sono stanca'),
('10','10','Ho un esame devo studiare'),
('9','4','Mangia solo petto di pollo'),
('9','7','Senti il tuo medico nutrizionista'),
('9','5','Perchè ci stanno i grassi che fanno male');

INSERT INTO Gradimento(CodRisposta,CodCliente,Punteggio) VALUES
('1','11','3'),
('1','8','3'),
('1','6','3'),
('2','11','1'),
('3','11','1'),
('3','2','3'),
('4','1','5'),
('4','5','5'),
('4','3','3'),
('6','2','3'),
('7','1','5'),
('7','10','4'),
('7','3','3'),
('9','1','3'),
('12','1','2'),
('14','1','5'),
('14','7','1'),
('12','6','5'),
('9','9','3'),
('8','1','1');

INSERT INTO Sfida(CodCliente,CodScheda,DataLancio,DataInizio,DataFine,Obbiettivo,Vincitore) VALUES
('1','1','2018-03-01','2018-03-08','2018-04-08','Aumentare circonferenza delle braccia di 2 centimetri','5'),
('11','11','2018-02-27','2018-03-04','2018-03-11','Dimagrire 2 chili in una settimana','2'),
('5','5','2018-04-03','2018-04-06','2002-04-22','Aumentare circonferenza delle braccia di 2 centimetri','5');

INSERT INTO Partecipa(IdSfida,CodCliente) VALUES
('1','5'),
('1','10'),
('2','2'),
('3','1'),
('3','10');



INSERT INTO SchedaAlimentazione (CodCliente,CodDipendente,CodDieta,DataVisita,DataInizio, DataFine,Altezza,Peso,MassaGrassa,MassaMagra,AcquaTotale,Obbiettivo,Sesso) VALUES
(1,2,3,'2018-02-23','2018-02-23','2018-05-04',183,78,15,62,60,'acquisire massa muscolare','U'),
(1,2,3,'2018-03-09','2018-02-23','2018-05-04',183,78,16,62,60,'acquisire massa muscolare','U'),
(1,2,3,'2018-03-24','2018-02-23','2018-05-04',183,78,17,62,60,'acquisire massa muscolare','U'),
(2,1,2,'2018-02-23','2018-02-23','2018-05-04',165,58,18,47,50,'diminuire massa grassa','D'),
(2,1,2,'2018-03-09','2018-02-23','2018-05-04',165,58,18,47,50,'diminuire massa grassa','D'),
(2,1,2,'2018-03-24','2018-02-23','2018-05-04',165,58,17,47,50,'diminuire massa grassa','D'),
(3,2,4,'2018-02-23','2018-02-23','2018-05-04',178,81,14,62,55,'perdere peso','U'),
(3,2,4,'2018-03-09','2018-02-23','2018-05-04',178,81,14,62,55,'perdere peso','U'),
(3,2,4,'2018-03-24','2018-02-23','2018-05-04',178,81,14,62,55,'perdere peso','U'),
(4,12,1,'2018-02-23','2018-02-23','2018-05-04',167,54,16,46,45,'perdere peso','D'),
(4,12,1,'2018-03-09','2018-02-23','2018-05-04',167,54,16,46,45,'perdere peso','D'),
(4,12,1,'2018-03-24','2018-02-23','2018-05-04',167,54,16,46,45,'perdere peso','D'),
(5,6,1,'2018-02-23','2018-02-23','2018-05-04',186,74,17,60,65,'acquisire massa muscolare','U'),
(5,6,1,'2018-03-09','2018-02-23','2018-05-04',186,74,16,60,65,'acquisire massa muscolare','U'),
(5,6,1,'2018-03-24','2018-02-23','2018-05-04',186,74,17,60,65,'acquisire massa muscolare','U'),
(6,2,1,'2018-02-23','2018-02-23','2018-05-04',172,64,15,52,65,'acquisire massa muscolare','U'),
(6,2,1,'2018-03-09','2018-02-23','2018-05-04',172,64,16,52,65,'acquisire massa muscolare','U'),
(6,2,1,'2018-03-24','2018-02-23','2018-05-04',172,64,14,52,65,'acquisire massa muscolare','U'),
(7,6,1,'2018-02-23','2018-02-23','2018-05-04',181,80,19,63,55,'perdere peso','U'),
(7,6,1,'2018-03-09','2018-02-23','2018-05-04',181,80,19,63,55,'perdere peso','U'),
(7,6,1,'2018-03-24','2018-02-23','2018-05-04',181,80,18,63,55,'perdere peso','U'),
(8,12,2,'2018-02-23','2018-02-23','2018-05-04',176,83,18,63,55,'perdere peso','U'),
(8,12,2,'2018-03-09','2018-02-23','2018-05-04',176,83,19,63,55,'perdere peso','U'),
(8,12,2,'2018-03-24','2018-02-23','2018-05-04',176,83,18,63,55,'perdere peso','U'),
(9,12,3,'2018-02-23','2018-02-23','2018-05-04',171,73,13,57,60,'acquisire massa muscolare','U'),
(9,12,3,'2018-03-09','2018-02-23','2018-05-04',171,73,13,57,60,'acquisire massa muscolare','U'),
(9,12,3,'2018-03-24','2018-02-23','2018-05-04',171,73,13,57,60,'acquisire massa muscolare','U'),
(10,1,3,'2018-02-23','2018-02-23','2018-05-04',183,74,15,60,60,'acquisire massa muscolare','U'),
(10,1,3,'2018-03-09','2018-02-23','2018-05-04',183,74,15,60,60,'acquisire massa muscolare','U'),
(10,1,3,'2018-03-24','2018-02-23','2018-05-04',183,74,15,60,60,'acquisire massa muscolare','U'),
(11,6,2,'2018-02-23','2018-02-23','2018-05-04',177,80,21,62,55,'diminuire massa grassa','U'),
(11,6,2,'2018-03-09','2018-02-23','2018-05-04',177,80,21,62,55,'diminuire massa grassa','U'),
(11,6,2,'2018-03-24','2018-02-23','2018-05-04',177,80,21,62,55,'diminuire massa grassa','U'),
(12,2,4,'2018-02-23','2018-02-23','2018-05-04',162,58,19,47,45,'diminuire massa grassa','D'),
(12,2,4,'2018-03-09','2018-02-23','2018-05-04',162,58,19,47,45,'diminuire massa grassa','D'),
(12,2,4,'2018-03-24','2018-02-23','2018-05-04',162,58,19,47,45,'diminuire massa grassa','D');

INSERT INTO Ordine(CodCentro,NomeFornitore,CodEsterno,DataEvasione,Stato,DataConsegna) VALUES
(1,'SINTEL','d787','2018-03-04','completo','2018-04-04'),
(2,'SINTEL','u547','2018-04-11','completo','2018-04-24'),
(3,'Rodorigo','b430','2018-02-24','completo','2018-03-04'),
(3,'Mavi','l705','2018-02-27','completo','2018-03-14'),
(4,'Mavi','t989','2018-03-14','completo','2018-04-18'),
(5,'VAR GROUP','m483','2018-02-24','completo','2018-05-04'),
(5,'SINTEL','be80','2018-03-04','completo','2018-04-04'),
(2,'T.e.s.','e265','2018-03-10','completo','2018-04-10'); 
 
INSERT INTO Ordine(CodCentro,NomeFornitore,CodEsterno,Stato,DataConsegna) VALUES
(1,'T.e.s.','z168','incompleto','2018-06-07'),
(3,'Rodorigo','g724','incompleto','2018-06-04');        


INSERT INTO OrdineIntegratore(CodInterno,NomeCommerciale,Confezioni) VALUES
('1','Anabolic Mass Pro','10'),
('1','Impact whey','10'),
('1','Prolong','10'),
('1','Creatine Powder','10'),
('1','HydraTech','10'),
('1','Protein Isolate','10'),
('1','MultiSat','10'),
('2','Anabolic Mass Pro','10'),
('2','Impact whey','15'),
('2','Prolong','10'),
('2','Creatine Powder','15'),
('2','HydraTech','10'),
('3','Anabolic Mass Pro','10'),
('3','Prolong','10'),
('3','Creatine Powder','10'),
('3','HydraTech','10'),
('4','MultiSat','10'),
('4','Impact whey','10'),
('5','Creatine Powder','15'),
('5','Impact whey','10'),
('5','Protein Isolate','10'),
('5','MultiSat','10'),
('6','HydraTech','15'),
('6','Creatine Powder','10'),
('7','Anabolic Mass Pro','10'),
('7','MultiSat','10'),
('8','Impact whey','10'),
('8','Protein Isolate','10'),
('9','Impact whey','10'),
('9','Protein Isolate','10'),
('9','Anabolic Mass Pro','10'),
('10','Anabolic Mass Pro','10'),
('10','Prolong','10'),
('10','Creatine Powder','10');


INSERT INTO Calendario (CodCorso,OraInizio,OraFine,Giorno) VALUES
('1','9','11','lunedi'),
('2','15','17','lunedi'),
('3','16','18','lunedi'),
('4','9','11','lunedi'),
('5','15','17','lunedi'),
('6','10','12','martedi'),
('7','9','11','martedi'),
('8','15','17','martedi'),
('9','9','11','martedi'),
('10','9','11','mercoledi'),
('11','14','16','mercoledi'),
('12','9','11','mercoledi'),
('13','15','17','mercoledi'),
('14','9','11','giovedi'),
('15','10','12','giovedi'),
('16','14','16','giovedi');

INSERT INTO Turno(CodDipendente,OraInizio,OraFine,Giorno) VALUES
(1,9,11,'lunedi'),
(2,14,16,'lunedi'),
(2,14,16,'martedi'),
(3,9,11,'lunedi'),
(3,15,17,'lunedi'),
(3,9,11,'martedi'),
(3,15,17,'martedi'),
(3,9,11,'mercoledi'),
(3,15,17,'mercoledi'),
(4,10,12,'martedi'),
(4,14,16,'giovedi'),
(5,10,12,'martedi'),
(5,14,16,'martedi'),
(5,15,17,'giovedi'),
(6,9,11,'venerdi'),
(6,14,16,'venerdi'),
(6,9,11,'mercoledi'),
(7,9,11,'lunedi'),
(7,9,11,'giovedi'),
(7,9,11,'venerdi'),
(8,14,16,'martedi'),
(8,14,16,'mercoledi'),
(8,14,16,'giovedi'),
(9,15,17,'lunedi'),
(9,10,12,'martedi'),
(9,14,16,'mercoledi'),
(9,9,11,'giovedi'),
(10,16,18,'lunedi'),
(10,16,18,'venerdi'),
(11,9,11,'lunedi'),
(11,10,12,'giovedi'),
(11,14,16,'giovedi'),
(12,9,11,'sabato'),
(12,9,11,'venerdi'),
(13,10,12,'mercoledi'),
(13,14,16,'mercoledi'),
(13,15,17,'giovedi'),
(14,12,14,'lunedi'),
(14,12,14,'mercoledi'),
(15,16,18,'lunedi'),
(15,9,11,'martedi'),
(15,9,11,'mercoledi');


/*----------------------------------------------------------------------------------------------
	
	2 VINCOLI DI INTEGRITA' DATABASE SECONDA PARTE  
	
----------------------------------------------------------------------------------------
*/



DELIMITER $$
CREATE TRIGGER AggiuntaIscrizione   /*aumenta il  numero di apparecchiature,dopo aver aggiunto una nuova iscrizione ad un corso  */
AFTER INSERT ON Iscrizione
FOR EACH ROW
BEGIN
	UPDATE Corso
	SET NumPartecipanti = NumPartecipanti +1
		
	WHERE CodCorso = NEW.CodCorso;
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER EliminaIscrizione   /*diminuisce il  numero di apparecchiature,dopo aver eliminato un iscrizione da un corso  */
AFTER delete ON Iscrizione
FOR EACH ROW
BEGIN
	UPDATE Corso
	SET NumPartecipanti = NumPartecipanti-1
		
	WHERE CodCorso = OLD.CodCorso;
END $$
DELIMITER ;



DELIMITER $$

CREATE TRIGGER VincoloNuovaAttrezzatura  /*Un nuovo macchinario deve avere Usura uguale a 0  */
before INSERT ON attrezzaturasala
FOR EACH ROW
BEGIN
		IF( NEW.Usura <> 0) THEN		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Il macchinario non è nuovo";
       END IF; 
END $$
DELIMITER ;



DELIMITER $$

CREATE TRIGGER  VincoloNuovaAmicizia   /* stati consentiti  */
BEFORE UPDATE ON Amicizia
FOR EACH ROW
BEGIN
	
   
        IF( NEW.Stato = "accettata" )  THEN	
			SET NEW.Stato= "accettata";
		SET NEW.DataAccettazione=CURRENT_DATE; 
        
        ElSEIF( NEW.Stato = "non accettata" )  THEN	
			SET NEW.Stato= "accettata";
		SET NEW.DataAccettazione=CURRENT_DATE; 
        
        
    END IF;
END $$
DELIMITER ;


DELIMITER $$

CREATE TRIGGER  VincoloTurno  /* VALIDITA TURNO DI LAVORO NON DEVE LAVORARE PIU DI 8 ORE AL GIORNO,E MAI IN DUE CENTRI DIVERSI CONTEMPORANEAMENTE  */
after insert ON Turno
FOR EACH ROW
BEGIN
	
    declare ore integer default 0;
    declare c integer default 0;
    set ore = ( select F.OraFine-F.OraInizio
    from Turno F
    where F.IdTurno = NEW.IdTurno
    );
   
        IF(ore >8) THEN 
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "orario di lavoro non compatibile";
        
        END IF;
        
        set c = (select count(*)
        from Turno C
        where C.IdTurno = NEW.IdTurno
        and  exists( select *
          from Turno C2
        where C2.CodDipendente = C.CodDipendente
        and C2.giorno = C.giorno
        and C2.IdTurno <> C.IdTurno 
        and C2.OraInizio = C.OraInizio  /*da migliorare la parte sulle ore ma funziona    */
        and C2.OraFine = C.OraFine 
        )
        );
        
        IF(c >=1) THEN 
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = " lavoro non compatibile";
        END IF;
        
END $$
DELIMITER ;



DELIMITER $$

CREATE TRIGGER VincoloUpdateEserciziScheda  
BEFORE UPDATE ON esercizischeda
FOR EACH ROW
BEGIN
	
        IF(  OLD.Serie = 0 )  THEN
		SET NEW.Serie= 0 ;
		END IF;
         IF(  OLD.Ripetizioni = 0 )  THEN
		SET NEW.Ripetizioni= 0 ;
		END IF;
         IF(  OLD.Riposo = 0 )  THEN
		SET NEW.Riposo= 0 ;
		END IF;

END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER AggiuntaSede   /*aumento numero di centri legati ad un contratto */
AFTER INSERT ON Offre
FOR EACH ROW
BEGIN
	UPDATE Contratto 
	SET Sede = Sede+1
		WHERE CodContratto = NEW.CodContratto;
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER AggiuntaMacchinario   /*aumento numero di apparecchiature,dopo aver aggiunto un nuovo macchinario alla sala  */
AFTER INSERT ON attrezzaturasala
FOR EACH ROW
BEGIN
	UPDATE Sala 
	SET NumApparecchiature = NumApparecchiature+1
		
	WHERE CodSala = NEW.CodSala;
END $$
DELIMITER ;


DELIMITER $$

CREATE TRIGGER VincoloGradimento  /*il punteggio massimo consentito non deve superare 5 e non deve essere minore di 0 */
BEFORE insert ON gradimento
FOR EACH ROW
BEGIN
	IF( NEW.punteggio > 5 ) THEN		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Il punteggio non è corretto";
    ELSEIF ( NEW.punteggio < 1 ) THEN		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Il punteggio non è corretto";   
        
	END IF;
    
    
    
END $$
DELIMITER ;

DELIMITER $$

CREATE TRIGGER VincoloIntensità /* Intensità MASSIMA E MINIMA*/
before insert ON controlloattrezzatura
FOR EACH ROW
BEGIN

set @m = (select Massimo
from regolazione
where IdRegolazione=new.IdRegolazione
);

set @r = (select Minimo
from regolazione
where IdRegolazione=new.IdRegolazione
);


		IF( NEW.Intensità >= @m ) THEN		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "hai raggiunto il limite che il macchinario può supportare";
        elseIF( NEW.Intensità <= @r ) THEN		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Sei sotto il limite che il macchinario può supportare";
       end if;
END $$
DELIMITER ;




/*----------------------------------------------------------------------------------------------
	
	5 ANALYTICS PERFORMANCE SPORTIVA PRIMA PARTE
	
----------------------------------------------------------------------------------------
*/


drop procedure if exists efficienzaesercizio;
delimiter $$
create procedure efficienzaesercizio(in _esercizio int,out _serie char(50),out _ripetizioni char(50),out _riposo char(50),out _tempoimpiegato varchar(255))

begin

declare seriecliente int default 0;
declare serienellascheda int default 0;
declare ripetizionicliente int default 0;
declare ripetizionischeda int default 0;
declare riposocliente int default 0;
declare ripososcheda int default 0;
declare tempoimpiegatocliente int default 0;
declare tempoimpiegatoscheda int default 0;


set seriecliente = (select Serie
from log G
where G.IdEsercizio = _esercizio
);

set serienellascheda = (select Serie
from esercizischeda S
where S.IdEsercizio = _esercizio
);

set ripetizionicliente = (select Ripetizioni
from log G
where G.IdEsercizio = _esercizio
);

set ripetizionischeda = (select Ripetizioni
from esercizischeda S
where S.IdEsercizio = _esercizio
);

set riposocliente = (select Riposo
from log G
where G.IdEsercizio = _esercizio
);

set ripososcheda = (select Riposo
from esercizischeda S
where S.IdEsercizio = _esercizio
);

set tempoimpiegatocliente = (select TempoImpiegato
from log G
where G.IdEsercizio = _esercizio
);

set tempoimpiegatoscheda = (select Durata
from esercizischeda S
where S.IdEsercizio = _esercizio
);


if (tempoimpiegatocliente-tempoimpiegatoscheda>0) then
set _tempoimpiegato = 'hai impiegato un tempo maggiore rispetto a quanto veniva richiesto';
 
elseif (tempoimpiegatocliente-tempoimpiegatoscheda<0) then
set _tempoimpiegato = 'Complimenti hai impiegato un tempo minore rispetto a quanto veniva richiesto';

elseif (tempoimpiegatocliente-tempoimpiegatoscheda=0) then
set _tempoimpiegato = 'lo stesso che richiedeva l esercizio';

end if;




if (ripetizionicliente-ripetizionischeda>0) then
set _ripetizioni = 'hai eseguito un numero maggiore  di  ripetizioni';
 
elseif (ripetizionicliente-ripetizionischeda<0) then
set _ripetizioni = 'hai eseguito un numero minore di  ripetizioni';

elseif (ripetizionicliente-ripetizionischeda=0) then
set _ripetizioni = 'stesso numero di ripetizioni richiesto';

end if;

if (seriecliente-serienellascheda>0) then
set _serie = 'hai eseguito un numero maggiore di serie';
elseif (seriecliente-serienellascheda<0) then
set _serie = 'hai eseguito un numero minore di serie';

elseif (seriecliente-serienellascheda=0) then
set _serie = 'stesso numero di serie richiesto';

end if;

if (riposocliente-ripososcheda>0) then
set _riposo = ' ti stai riposando troppo ';
elseif (riposocliente-ripososcheda<0) then
set _riposo = 'puoi recuperare ancora';

elseif (riposocliente-ripososcheda=0) then
set _riposo = 'riposo giusto';

end if;
if (riposocliente = 0 and seriecliente = 0 and ripetizionicliente = 0 and tempoimpiegatocliente-tempoimpiegatoscheda>=0) then
set _tempoimpiegato = 'COMPLIMENTI HAI SVOLTO con successo  l esercizio di aerobica'
;
set _riposo = 'nessun riposo ';
set _serie = 'nessuna serie';
set _ripetizioni = 'nessuna ripetizione ';


end if ;

if (riposocliente = 0 and seriecliente = 0 and ripetizionicliente = 0 and tempoimpiegatocliente-tempoimpiegatoscheda<0) then
set _tempoimpiegato = 'NON HAI SVOLTO con successo  l esercizio di aerobica'
;
set _riposo = 'nessun riposo ';
set _serie = 'nessuna serie';
set _ripetizioni = 'nessuna ripetizione ';


end if ;



end $$
delimiter ;




/*----------------------------------------------------------------------------------------------
	
	5 ANALYTICS PERFORMANCE SPORTIVA SECONDA PARTE
	
----------------------------------------------------------------------------------------
*/

drop procedure if exists Valutazione;
delimiter $$
create procedure Valutazione(in _scheda int ,in _accesso int,out _serie char(50),out _differenzaserie int,out _ripetizioni char(50),
out _differenzaripetizioni int,out _riposo char(50),out _differenzariposo int,out _tempoimpiegato varchar(255),out _differenzatempoimpiegato int)

begin

declare serietotalicliente int default 0;
declare serietotalinellascheda int default 0;
declare ripetizionitotalicliente int default 0;
declare ripetizionitotalischeda int default 0;
declare riposototalecliente int default 0;
declare riposototalescheda int default 0;
declare tempoimpiegatototalecliente int default 0;
declare tempoimpiegatototalescheda int default 0;
declare numeroaccesso int default 0;


set numeroaccesso = (select count(CodScheda)
from esercizischeda
where CodAccesso = _accesso
and CodScheda =_scheda 
);



set serietotalicliente = (select sum(G.Serie)
from log G
inner join EserciziScheda S on S.IdEsercizio = G.IdEsercizio
where G.CodAccesso = _accesso
and S.CodScheda =_scheda
);

set serietotalinellascheda = (select sum(S.Serie)
from esercizischeda S
where S.CodAccesso = _accesso
and S.CodScheda =_scheda);

set ripetizionitotalicliente = (select sum(G.Ripetizioni)
from log G
inner join EserciziScheda S on S.IdEsercizio = G.IdEsercizio
where G.CodAccesso = _accesso
and S.CodScheda =_scheda
);

set ripetizionitotalischeda = (select sum(S.Ripetizioni)
from esercizischeda S
where S.CodAccesso = _accesso
and S.CodScheda =_scheda);

set riposototalecliente = (select sum(G.Riposo)
from log G
inner join EserciziScheda S on S.IdEsercizio = G.IdEsercizio
where G.CodAccesso = _accesso
and S.CodScheda =_scheda);

set riposototalescheda = (select sum(S.Riposo)
from esercizischeda S
where S.CodAccesso = _accesso
and S.CodScheda =_scheda);

set tempoimpiegatototalecliente = (select sum(G.TempoImpiegato)
from log G
inner join EserciziScheda S on S.IdEsercizio = G.IdEsercizio
where G.CodAccesso = _accesso
and S.CodScheda =_scheda
);

set tempoimpiegatototalescheda = (select sum(S.Durata)
from esercizischeda S
where S.CodAccesso = _accesso
and S.CodScheda =_scheda
);



if (serietotalicliente-serietotalinellascheda>0) then
set _serie = 'hai eseguito un numero maggiore di serie';
set _differenzaserie = serietotalicliente-serietotalinellascheda;
elseif (serietotalicliente-serietotalinellascheda<0) then
set _serie = 'hai eseguito un numero minore di serie';
set _differenzaserie = serietotalicliente-serietotalinellascheda;

elseif (serietotalicliente-serietotalinellascheda=0) then
set _serie = 'stesso numero di serie richiesto';
set _differenzaserie = serietotalicliente-serietotalinellascheda;
end if;


if (ripetizionitotalicliente-ripetizionitotalischeda>0) then
set _ripetizioni = 'hai eseguito un numero maggiore  di  ripetizioni';
set _differenzaripetizioni = ripetizionitotalicliente-ripetizionitotalischeda;

elseif (ripetizionitotalicliente-ripetizionitotalischeda<0) then
set _ripetizioni = 'hai eseguito un numero minore di  ripetizioni';
set _differenzaripetizioni = ripetizionitotalicliente-ripetizionitotalischeda;

elseif (ripetizionitotalicliente-ripetizionitotalischeda=0) then
set _ripetizioni = 'stesso numero di ripetizioni richiesto';
set _differenzaripetizioni = ripetizionitotalicliente-ripetizionitotalischeda;

end if;

if (riposototalecliente-riposototalescheda>0) then
set _riposo = ' ti stai riposando troppo ';
set _differenzariposo = riposototalecliente-riposototalescheda;

elseif (riposototalecliente-riposototalescheda<0) then
set _riposo = 'puoi recuperare ancora';
set _differenzariposo = riposototalecliente-riposototalescheda;

elseif (riposototalecliente-riposototalescheda=0) then
set _riposo = 'riposo giusto';
set _differenzariposo = riposototalecliente-riposototalescheda;
end if;


if (tempoimpiegatototalecliente-tempoimpiegatototalescheda>0) then
set _tempoimpiegato = 'hai impiegato un tempo maggiore rispetto a quanto veniva richiesto';
set  _differenzatempoimpiegato = tempoimpiegatototalecliente-tempoimpiegatototalescheda;
 
elseif (tempoimpiegatototalecliente-tempoimpiegatototalescheda<0) then
set _tempoimpiegato = 'Complimenti hai impiegato un tempo minore rispetto a quanto veniva richiesto';
set  _differenzatempoimpiegato = tempoimpiegatototalecliente-tempoimpiegatototalescheda;

elseif (tempoimpiegatototalecliente-tempoimpiegatototalescheda=0) then
set _tempoimpiegato = 'lo stesso che richiedeva l esercizio';
set  _differenzatempoimpiegato = tempoimpiegatototalecliente-tempoimpiegatototalescheda;

end if;




UPDATE esercizischeda 
SET 
    serie = serie + _differenzaserie / numeroaccesso
WHERE
    CodAccesso = _accesso
    and CodScheda =_scheda;

UPDATE esercizischeda 
SET 
    ripetizioni = ripetizioni + _differenzaripetizioni / numeroaccesso
WHERE
    CodAccesso = _accesso
and CodScheda =_scheda
;

UPDATE esercizischeda 
SET 
    riposo = riposo + _differenzariposo / numeroaccesso
WHERE
    CodAccesso = _accesso
    and CodScheda =_scheda;

UPDATE esercizischeda 
SET 
    Durata = Durata + _differenzatempoimpiegato / numeroaccesso
WHERE
    CodAccesso = _accesso
    and CodScheda =_scheda;



end $$
delimiter ;


/*----------------------------------------------------------------------------------------------
	
	6	FUNZIONE ANALYTICS "ROTAZIONE DEL MAGAZZINO"
	
-----------------------------------------------------------------------------------------------*/

DROP EVENT IF EXISTS ResocontoScadenze;
DELIMITER $$
CREATE EVENT ResocontoScadenze
ON SCHEDULE EVERY 1 MONTH
DO BEGIN
		
SELECT M.CodCentro,M.NomeCommerciale, DATEDIFF(I.DataScadenza,current_date()) as GiorniScadenza
FROM Magazzino M INNER JOIN Integratore I 
ON M.NomeCommerciale = I.NomeCommerciale;             
             
END $$
DELIMITER ;


DROP EVENT IF EXISTS ResocontoAcquisti;
DELIMITER $$
CREATE EVENT ResocontoAcquisti
ON SCHEDULE EVERY 1 MONTH
DO BEGIN

SELECT A.NomeCommerciale, COUNT(*) as ConfezioniVendute
FROM Acquisto A
GROUP BY A.NomeCommerciale
ORDER BY ConfezioniVendute ASC
;

END $$
DELIMITER ;


DROP PROCEDURE IF EXISTS NuovoPrezzoVendita;
DELIMITER $$
CREATE PROCEDURE NuovoPrezzoVendita(IN NomeCommerciale CHAR(100),IN PrezzoAcquisto INT, IN PrezzoVendita INT,
OUT ScontoTotale INT, OUT NuovoPrezzoVendita INT)
BEGIN


DECLARE ScontoVendite INT DEFAULT 0;
DECLARE ScontoScadenza INT DEFAULT 0;
DECLARE ConfezioniVendute INT DEFAULT 0;
DECLARE ConfezioniTotali INT DEFAULT 0;
DECLARE GiorniScadenza INT DEFAULT 0;

SELECT SUM(M.Quantità) INTO ConfezioniTotali
FROM Magazzino M
WHERE M.NomeCommerciale = NomeCommerciale;

SELECT SUM(A.Confezioni) INTO ConfezioniVendute
FROM Acquisto A
WHERE A.NomeCommerciale = NomeCommerciale;

IF ConfezioniVendute <= (10*ConfezioniTotali)/100 THEN
SET ScontoVendite = 20;
END IF;


SELECT DATEDIFF(I.DataScadenza,current_date()) INTO GiorniScadenza
FROM Integratore I
WHERE I.NomeCommerciale = NomeCommerciale;


IF GiorniScadenza <= 45 THEN

CASE 
WHEN GiorniScadenza BETWEEN 41 AND 45 THEN
SET ScontoScadenza = 10;
WHEN GiorniScadenza BETWEEN 31 AND 40 THEN
SET ScontoScadenza = 20;
WHEN GiorniScadenza BETWEEN 21 AND 30 THEN
SET ScontoScadenza = 40;
WHEN GiorniScadenza BETWEEN 11 AND 20 THEN
SET ScontoScadenza = 60;
WHEN GiorniScadenza BETWEEN 1 AND 10 THEN
SET ScontoScadenza = 80;
END CASE;

END IF;

SET ScontoTotale = ScontoVendite + ScontoScadenza;
SET NuovoPrezzoVendita = PrezzoAcquisto + ((PrezzoVendita-PrezzoAcquisto)*((100-ScontoTotale)/100)) ;

END $$
DELIMITER ;


DROP FUNCTION IF EXISTS Sconto;
DELIMITER $$
CREATE FUNCTION Sconto(NomeCommerciale CHAR(100))
RETURNS INT DETERMINISTIC
BEGIN


DECLARE ScontoVendite INT DEFAULT 0;
DECLARE ScontoScadenza INT DEFAULT 0;
DECLARE ConfezioniVendute INT DEFAULT 0;
DECLARE ConfezioniTotali INT DEFAULT 0;
DECLARE GiorniScadenza INT DEFAULT 0;
DECLARE ScontoTotale INT DEFAULT 0;

SELECT SUM(M.Quantità) INTO ConfezioniTotali
FROM Magazzino M
WHERE M.NomeCommerciale = NomeCommerciale;

SELECT SUM(A.Confezioni) INTO ConfezioniVendute
FROM Acquisto A
WHERE A.NomeCommerciale = NomeCommerciale;

IF ConfezioniVendute <= (10*ConfezioniTotali)/100 THEN
SET ScontoVendite = 20;
END IF;


SELECT DATEDIFF(I.DataScadenza,current_date()) INTO GiorniScadenza
FROM Integratore I
WHERE I.NomeCommerciale = NomeCommerciale;


IF GiorniScadenza <= 45 THEN

CASE 
WHEN GiorniScadenza BETWEEN 41 AND 45 THEN
SET ScontoScadenza = 10;
WHEN GiorniScadenza BETWEEN 31 AND 40 THEN
SET ScontoScadenza = 20;
WHEN GiorniScadenza BETWEEN 21 AND 30 THEN
SET ScontoScadenza = 40;
WHEN GiorniScadenza BETWEEN 11 AND 20 THEN
SET ScontoScadenza = 60;
WHEN GiorniScadenza BETWEEN 1 AND 10 THEN
SET ScontoScadenza = 80;
END CASE;

END IF;

SET ScontoTotale = ScontoVendite + ScontoScadenza;

RETURN(ScontoTotale);

END $$
DELIMITER ;


CREATE OR REPLACE VIEW ConfezioniTotali AS
SELECT M.NomeCommerciale, SUM(M.Quantità) AS ConfezioniTotali
FROM Magazzino M
GROUP BY M.NomeCommerciale;

CREATE OR REPLACE VIEW ConfezioniVendute AS
SELECT A.NomeCommerciale, SUM(A.Confezioni) AS ConfezioniVendute
FROM Acquisto A
GROUP BY A.NomeCommerciale;
                                                          
                             
CREATE OR REPLACE VIEW NuovoPrezzoVendita AS
SELECT I.NomeCommerciale, (I.PrezzoAcquisto + ((I.PrezzoVendita-I.PrezzoAcquisto)*((100-Sconto(I.NomeCommerciale))/100))) AS NuovoPrezzoVendita
FROM  Integratore I
GROUP BY I.NomeCommerciale;  

CREATE OR REPLACE VIEW MargineTemporale AS
SELECT I.Nomecommerciale, DATEDIFF(I.DataScadenza,current_date) as MargineTemporale
FROM Integratore I;                                                       

DROP PROCEDURE IF EXISTS IntegratoriTarget;
DELIMITER $$
CREATE PROCEDURE IntegratoriTarget()
BEGIN

CREATE TEMPORARY TABLE IF NOT EXISTS _IntegratoriTarget(
NomeCommerciale VARCHAR(100) NOT NULL,
PRIMARY KEY(NomeCommerciale)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

TRUNCATE TABLE _IntegratoriTarget;


INSERT INTO _IntegratoriTarget                              
SELECT CT.Nomecommerciale
FROM ConfezioniTotali CT
NATURAL JOIN ConfezioniVendute CV
WHERE CV.ConfezioniVendute <= (10*CT.ConfezioniTotali)/100
UNION
SELECT I.Nomecommerciale
FROM Integratore I
WHERE DATEDIFF(I.DataScadenza,current_date) <= 45; 

END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS RankingIntegratori;
DELIMITER $$
CREATE PROCEDURE RankingIntegratori()
BEGIN

CREATE TEMPORARY TABLE IF NOT EXISTS _RankingIntegratori(
NomeCommerciale VARCHAR(100) NOT NULL,
MargineTemporale INT NOT NULL,
Sconto INT NOT NULL,
NuovoPrezzoVendita INT NOT NULL,
PRIMARY KEY(NomeCommerciale)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

TRUNCATE TABLE _RankingIntegratori;


INSERT INTO _RankingIntegratori                             
SELECT MT.NomeCommerciale, MT.MargineTemporale, Sconto(MT.NomeCommerciale) AS Sconto, NPV.NuovoPrezzoVendita
FROM MargineTemporale MT 
NATURAL JOIN NuovoprezzoVendita NPV
ORDER BY MT.MargineTemporale ASC;

END $$
DELIMITER ;


/*----------------------------------------------------------------------------------------------
	
	7	FUNZIONE ANALYTICS "REPORTING"
	
-----------------------------------------------------------------------------------------------*/


DROP PROCEDURE IF EXISTS MonitoraggioCorsiPocoFrequentati;
DELIMITER $$
CREATE PROCEDURE MonitoraggioCorsiPocoFrequentati()
BEGIN

CREATE TEMPORARY TABLE IF NOT EXISTS _MonitoraggioCorsiPocoFrequentati(
CodCorso INT NOT NULL,
NumPartecipanti INT NOT NULL,
OraInizio INT NOT NULL,
OraFine INT NOT NULL,
Giorno VARCHAR(100) NOT NULL,
PRIMARY KEY(CodCorso)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

TRUNCATE TABLE _MonitoraggioCorsiPocoFrequentati;

INSERT INTO _MonitoraggioCorsiPocoFrequentati
SELECT C.CodCorso, C.NumPartecipanti, CA.OraInizio, CA.OraFine, CA.Giorno
FROM Corso C 
NATURAL JOIN Calendario CA
ORDER BY C.NumPartecipanti ASC;



END $$
DELIMITER ;


DROP PROCEDURE IF EXISTS PacchettiIntegrativi;
DELIMITER $$
CREATE PROCEDURE PacchettiIntegrativi(IN CodContratto INT,IN CodCliente INT, OUT CodPromozione INT,
OUT CodClientePromozione INT, OUT NumAccessiPiscinaPromozione INT, OUT PrezzoPromozione INT )
BEGIN

DECLARE NumAccessiPiscina INT DEFAULT 0;
DECLARE TipoContratto VARCHAR(100) DEFAULT "";
DECLARE TipologiaContratto VARCHAR(100) DEFAULT "";

SELECT COUNT(*) INTO NumAccessiPiscina
FROM Accesso A
WHERE A.CodCliente = CodCliente
AND A.Piscina = 'si';

SELECT C.Tipo INTO TipoContratto
FROM Contratto C
WHERE C.CodContratto = CodContratto
AND C.CodCliente = CodCliente;

SELECT C.Tipologia INTO TipologiaContratto
FROM Contratto C
WHERE C.CodContratto = CodContratto
AND C.CodCliente = CodCliente;

IF (TipoContratto = 'standard' AND TipologiaContratto = 'silver' AND NumAccessiPiscina != 0)  THEN
SET CodPromozione = CodContratto;
SET CodClientePromozione = CodCliente;
SET NumAccessiPiscinaPromozione = NumAccessiPiscina + 10;


CASE
WHEN NumAccessiPiscina BETWEEN 1 AND 5 THEN
SET PrezzoPromozione = 80;
WHEN NumAccessiPiscina BETWEEN 6 AND 10 THEN
SET PrezzoPromozione = 170;
WHEN NumAccessiPiscina BETWEEN 11 AND 20 THEN
SET PrezzoPromozione = 260;
END CASE;
END IF;

END $$
DELIMITER ;




CREATE OR REPLACE VIEW CentroSala AS
SELECT S.CodCentro,S.CodSala
FROM Sala S;


CREATE OR REPLACE VIEW CentroSalaAttrezzatura AS
SELECT CS.CodCentro,CS.CodSala,ATS.CodMacchina
FROM CentroSala CS 
NATURAL JOIN AttrezzaturaSala ATS;

CREATE OR REPLACE VIEW CentroSalaAttrezzatura2 AS
SELECT CSA.CodCentro,CSA.CodSala,CSA.CodMacchina
FROM CentroSalaAttrezzatura CSA
NATURAL JOIN Attrezzatura A;

CREATE OR REPLACE VIEW CentroSalaAttrezzaturaRegolazione AS
SELECT CSA2.CodCentro,CSA2.CodSala,CSA2.CodMacchina,R.IdRegolazione
FROM CentroSalaAttrezzatura2 CSA2
NATURAL JOIN Regolazione R;


CREATE OR REPLACE VIEW CentroSalaAttrezzaturaRegolazione2 AS
SELECT CSAR.CodCentro,CSAR.CodSala,CSAR.CodMacchina,CSAR.IdRegolazione,CA.IdEsercizio	
FROM CentroSalaAttrezzaturaRegolazione CSAR
NATURAL JOIN ControlloAttrezzatura CA;			


DROP PROCEDURE IF EXISTS MonitoraggioAttrezzaure;
DELIMITER $$
CREATE PROCEDURE MonitoraggioAttrezzaure()
BEGIN

CREATE TEMPORARY TABLE IF NOT EXISTS _MonitoraggioAttrezzaure(
CodCentro INT NOT NULL,
CodSala INT NOT NULL,
CodMacchina INT NOT NULL,
TempoAttesaMedio INT NOT NULL,
PRIMARY KEY(CodCentro,CodSala,CodMacchina)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

TRUNCATE TABLE _MonitoraggioAttrezzaure;

INSERT INTO _MonitoraggioAttrezzaure
SELECT CSAR2.CodCentro,CSAR2.CodSala,CSAR2.CodMacchina,AVG(L.TempoImpiegato) as TempoAttesaMedio	
FROM CentroSalaAttrezzaturaRegolazione2 CSAR2
NATURAL JOIN Log L
GROUP BY CSAR2.CodCentro,CSAR2.CodSala,CSAR2.CodMacchina;


END $$
DELIMITER ;

CREATE OR REPLACE VIEW TempoAttesaMedio AS
SELECT CSAR2.CodCentro,CSAR2.CodSala,CSAR2.CodMacchina,AVG(L.TempoImpiegato) as TempoAttesaMedio	
FROM CentroSalaAttrezzaturaRegolazione2 CSAR2
NATURAL JOIN Log L
GROUP BY CSAR2.CodCentro,CSAR2.CodSala,CSAR2.CodMacchina;

DROP PROCEDURE IF EXISTS Dimensionamento;
DELIMITER $$
CREATE PROCEDURE Dimensionamento(IN CodCentro INT,IN CodSala INT, 
IN CodMacchina INT, OUT Dimensionamento VARCHAR(100))
BEGIN

DECLARE TempoAttesaMedio INT DEFAULT 0;
DECLARE Occorrenze INT DEFAULT 0;

SELECT COUNT(*) INTO Occorrenze
FROM TempoAttesaMedio TAM
WHERE TAM.CodCentro = Codcentro
AND TAM.CodSala = CodSala
AND TAM.CodMacchina = CodMacchina;

IF Occorrenze = 0 THEN
SET Dimensionamento = 'Dimensionamento non Pervenuto';
END IF;


SELECT TAM.TempoAttesamedio INTO TempoAttesaMedio
FROM TempoAttesaMedio TAM
WHERE TAM.CodCentro = Codcentro
AND TAM.CodSala = CodSala
AND TAM.CodMacchina = CodMacchina;

IF Occorrenze != 0 THEN
CASE
WHEN TempoAttesaMedio < 15 THEN
SET Dimensionamento = 'Buon Dimensionamento';
WHEN TempoAttesaMedio  BETWEEN 15 AND 20 THEN
SET Dimensionamento = 'Dimensionamento Sufficiente';
WHEN TempoAttesaMedio > 20 THEN
SET Dimensionamento = 'Pessimo Dimensionamento';
END CASE;
END IF;

END $$
DELIMITER ;



