CREATE DATABASE TransGlobe;
USE TransGlobe;

DROP TABLE IF EXISTS Reservations;
DROP TABLE IF EXISTS Clients;
DROP TABLE IF EXISTS Trajets;


CREATE TABLE IF NOT EXISTS Clients(
Client_Id INT PRIMARY KEY AUTO_INCREMENT,
Nom VARCHAR(100)  NOT NULL,
Email VARCHAR(100) UNIQUE,
Pays VARCHAR(120),
DateInscription DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS Trajets(
Trajet_Id INT PRIMARY KEY AUTO_INCREMENT,
VilleDepart VARCHAR(255),
VilleArrivee VARCHAR(255),
Prix DECIMAL(10,2),
DistanceKm INTEGER,
Disponible BOOLEAN DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS Reservations(
Reservation_Id INT PRIMARY KEY AUTO_INCREMENT,
Client_id INTEGER NOT NULL,
Trajet_id INTEGER NOT NULL,
DateReservation DATE,
Places INT NOT NULL,
MontantTotal FLOAT,
FOREIGN KEY(Client_id) REFERENCES Clients(Client_Id) ON DELETE CASCADE,
FOREIGN KEY(Trajet_id) REFERENCES Trajets(Trajet_Id) ON DELETE CASCADE
);

INSERT INTO Clients (Nom, Email, Pays, DateInscription) VALUES
('Jean Dupont', 'jean.dupont@email.com', 'France', '2024-03-15'),
('Amina Diallo', 'amina.diallo@email.com', 'Côte d’Ivoire', '2024-04-22'),
('David Smith', 'david.smith@email.com', 'Canada', '2024-01-10'),
('Fatou Bamba', 'fatou.bamba@email.com', 'Sénégal', '2024-05-09'),
('Christian Kabeya', 'christian.kabeya@email.com', 'RDC', '2024-06-01');

UPDATE Clients SET Nom='Jean Dupont' WHERE Client_Id=11;
UPDATE Clients SET Nom='Amina Diallo' WHERE Client_Id=12;
UPDATE Clients SET Nom='David Smith' WHERE Client_Id=13;
UPDATE Clients SET Nom='Fatou Bamba' WHERE Client_Id=14;
UPDATE Clients SET Nom='Christian Kabeya' WHERE Client_Id=15;




ALTER TABLE Trajets AUTO_INCREMENT = 101;

ALTER TABLE Clients MODIFY COLUMN Email VARCHAR (100);
ALTER TABLE Clients MODIFY COLUMN Nom VARCHAR (100);
ALTER TABLE Reservations CHANGE COLUMN   Place Places INT NOT NULL;
SELECT VERSION();
SELECT *
FROM Reservations;

INSERT INTO Trajets ( VilleDepart, VilleArrivee, Prix, DistanceKm, Disponible) VALUES
('Ottawa', 'Montréal', 120.00, 200, TRUE),
('Kinshasa', 'Lubumbashi', 250.00, 1500, TRUE),
('Paris', 'Lyon', 180.00, 450, TRUE),
('Abidjan', 'Bouaké', 90.00, 350, TRUE),
('Casablanca', 'Marrakech', 140.00, 320, FALSE);

INSERT INTO Reservations(Client_id,Trajet_id,DateReservation, Places, MontantTotal)VALUES
((SELECT Client_Id FROM Clients WHERE Nom='Jean Dupont')
,(SELECT Trajet_Id FROM Trajets WHERE VilleDepart='Paris')
,'2024-06-02'
, 2
, 360.00
),
((SELECT Client_Id FROM Clients WHERE Nom='Amina Diallo')
,(SELECT Trajet_Id FROM Trajets WHERE VilleDepart='Abidjan')
,'2024-06-10'
, 1
, 90.00
),
((SELECT Client_Id FROM Clients WHERE Nom='David Smith')
,(SELECT Trajet_Id FROM Trajets WHERE VilleDepart='Ottawa')
,'2024-07-15'
, 3
, 360.00
),
((SELECT Client_Id FROM Clients WHERE Nom='Fatou Bamba')
,(SELECT Trajet_Id FROM Trajets WHERE VilleDepart='Kinshasa')
,'2024-08-05'
, 2
, 500.00
)
,
((SELECT Client_Id FROM Clients WHERE Nom='Christian Kabeya')
,(SELECT Trajet_Id FROM Trajets WHERE VilleDepart='Kinshasa')
,'2024-09-01'
, 3
, 750.00
),
((SELECT Client_Id FROM Clients WHERE Nom='Jean Dupont')
,(SELECT Trajet_Id FROM Trajets WHERE VilleDepart='Casablanca')
,'2024-09-12'
, 2
, 280.00
);




TRUNCATE TABLE Reservations;

SELECT *
FROM Reservations;

SELECT c.Nom as NomDuClient,
      t.VilleDepart as VilleDeDepart,
      t.VilleArrivee as VilleDarrivee,
      r.Places as NombreDePlace,
      r.MontantTotal as MontantReservation
FROM Reservations as r
INNER JOIN Clients as c ON c.Client_Id= r.Client_id
INNER JOIN Trajets as t ON t.Trajet_Id = r.Trajet_id
ORDER BY NomDuClient;

SELECT *
FROM Clients;

SELECT c.Nom as NomDuClient,
      t.VilleDepart as VilleDeDepart,
      t.VilleArrivee as VilleDarrivee,
      r.Places as NombreDePlace,
      r.MontantTotal as MontantReservation
FROM Reservations as r
INNER JOIN Clients as c ON c.Client_Id= r.Client_id
INNER JOIN Trajets as t ON t.Trajet_Id = r.Trajet_id
WHERE r.MontantTotal > 200 
ORDER BY NomDuClient;

SELECT 
      t.VilleDepart as VilleDeDepart,
      t.VilleArrivee as VilleDarrivee,
      r.Places as NombreDePlace,
      r.MontantTotal as MontantReservation,
      COUNT(r.Reservation_Id ) as NombreTrajet
FROM Reservations as r
INNER JOIN Clients as c ON c.Client_Id= r.Client_id
INNER JOIN Trajets as t ON t.Trajet_Id = r.Trajet_id
GROUP BY t.VilleDepart 
ORDER BY VilleDeDepart;

SELECT 
	  c.Nom as NomDuClient,
      SUM( r.MontantTotal)  as MontantTotalDepense
FROM Reservations as r
INNER JOIN Clients as c ON c.Client_Id= r.Client_id
GROUP BY c.Nom 
ORDER BY MontantTotalDepense DESC;

ALTER TABLE Clients ADD COLUMN VIP BOOLEAN DEFAULT FALSE;
UPDATE Clients
SET VIP = TRUE
WHERE Client_Id IN (
  SELECT Client_id
  FROM Reservations
  WHERE MontantTotal > 150
);





SHOW COLUMNS FROM Clients;


















