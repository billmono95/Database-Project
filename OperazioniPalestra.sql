

------------------------------  1 ---------------------------------

SELECT I.NomeCommerciale
FROM Integratore I INNER JOIN Dieta D
ON I.NomeCommerciale = D.NomeIntegratore
WHERE COUNT(*) >= ALL  
	( SELECT COUNT(*)
	  FROM Integratore I2 INNER JOIN Dieta D2
	  ON I2.NomeCommerciale = D2.NomeIntegratore
      GROUP BY I2.NomeCommerciale)
GROUP BY I.NomeCommerciale;
	  

------------------------------  2 ---------------------------------

INSERT INTO Esercizio(Tipo,Dispendio)
       VALUES("MilitaryPress",220);
	   

------------------------------  3 ---------------------------------


        SELECT C.CodCorso
		FROM Corso C
		WHERE C.NumPartecipanti < ALL
          (SELECT C2.NumPartecipanti
	       FROM Corso C2
		   WHERE C2.CodCorso <> C.CodCorso) ;


------------------------------  4 ---------------------------------

INSERT INTO Iscrizione(CodCliente,CodCorso) 
VALUES('10','15');


------------------------------  5 ---------------------------------

SELECT P.IdSfida 
FROM Partecipa P
GROUP BY P.IdSfida
HAVING COUNT(*) =
         (SELECT MAX(D.Occorrenze) FROM
              (SELECT P2.IdSfida, COUNT(*) AS Occorrenze
                  FROM Partecipa P2
                  GROUP BY P2.IdSfida) AS D);


------------------------------  6 ---------------------------------

      
INSERT INTO Contratto(CodCliente,CodDipendente,DataContratto,DataScadenza,Tipo,Tipologia,Sede,IngressiSettimanali,NumeroSaleAccessibili,AccessiPiscinaMensili,TipoPiscina,Scopo,Muscoli,Livello,CostoAnnuale,Rateizzazione,TassoInteresse) 
VALUES('13','15','2018-06-06','2019-06-06','standard','platinum','3','7','4','20''interna','potenziamento muscolare','braccia','elevato','300','no','0');

------------------------------  7 ---------------------------------

SELECT C.CodContratto
FROM Contratto C
WHERE C.Sede = 1;


------------------------------  8 ---------------------------------


CREATE OR REPLACE VIEW SommaPunteggio AS
SELECT G.CodRisposta, SUM(G.Punteggio) as SommaPunteggio
FROM Gradimento G
GROUP BY G.CodRisposta;


CREATE OR REPLACE VIEW NumeroOccorrenze AS
SELECT G.CodRisposta, COUNT(*) as NumeroOccorrenze
FROM Gradimento G
GROUP BY G.CodRisposta;

SELECT SP.CodRisposta, (SP.SommaPunteggio/NU.NumeroOccorrenze) as GradimentoMedio
FROM SommaPunteggio SP
NATURAL JOIN NumeroOccorrenze NU
GROUP BY SP.CodRisposta;
