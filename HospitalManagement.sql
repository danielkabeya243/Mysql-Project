USE ecommerce;

DROP TABLE IF EXISTS Appointments;
DROP TABLE IF EXISTS MedicalRecords;
DROP TABLE IF EXISTS Billing;
DROP TABLE IF EXISTS Patients;
DROP TABLE IF EXISTS Doctors;

-- Table Patients

CREATE TABLE Patients(
patientID INT PRIMARY KEY AUTO_INCREMENT,
patientName VARCHAR(100) NOT NULL,
age INT,
gender VARCHAR(10),
contactNumber VARCHAR (15) UNIQUE,
address TEXT,
registrationDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table Doctors

CREATE TABLE Doctors(
doctorID INT PRIMARY KEY AUTO_INCREMENT,
doctorName VARCHAR(100) NOT NULL,
specialization VARCHAR(100),
phoneNumber VARCHAR(15) UNIQUE,
department VARCHAR(100),
joiningDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table Appointments

CREATE TABLE Appointments(
appointmentsID INT PRIMARY KEY AUTO_INCREMENT,
patientID INT,
doctorID INT,
appointmentDate DATE,
appointmentTime TIME,
diagnosis TEXT,
status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
FOREIGN KEY (patientID) REFERENCES Patients(patientID) ON DELETE CASCADE,
FOREIGN KEY (doctorID) REFERENCES Doctors(doctorID) ON DELETE CASCADE
);



-- Table Medical Records

CREATE TABLE MedicalRecords(
medicalRecordsID INT PRIMARY KEY AUTO_INCREMENT,
patientID INT,
doctorID INT,
RecordDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
Diagnosis TEXT,
prescriptions TEXT,
testResults TEXT,
FOREIGN KEY (patientID) REFERENCES Patients(patientID) ON DELETE CASCADE,
FOREIGN KEY (doctorID) REFERENCES Doctors(doctorID) ON DELETE CASCADE

);


-- Table Billing

CREATE TABLE Billing(
billingID INT PRIMARY KEY AUTO_INCREMENT,
patientID INT,
Amount DECIMAL(10,2),
PaymentStatus ENUM('Pending', 'Paid') DEFAULT 'Pending',
PaymentDate DATE NULL,
insuranceProvider VARCHAR(100) NULL,
FOREIGN KEY (patientID) REFERENCES Patients(patientID) ON DELETE CASCADE
);


-- Insertion of Data

INSERT INTO Patients (patientName, age, gender, contactNumber, address, registrationDate) VALUES
('John Doe', 35, 'Male', '1234567890', '123 Main St, NY', NOW()),
('Jane Smith', 28, 'Female', '9876543210', '456 Oak St, CA', NOW()),
('Mike Johnson', 42, 'Male', '4567891230', '789 Pine St, TX', NOW()),
('Emily Davis', 30, 'Female', '7412589630', '101 Maple St, FL', NOW()),
('Chris Wilson', 50, 'Male', '8529637410', '202 Cedar St, WA', NOW()),
('Paul Adams', 45, 'Male', '1231231234', '350 Elm St, NY',NOW()),
('Sophie Martin', 33, 'Female', '3213214321', '670 Pine St, TX',NOW()),
('Leo Dupont', 29, 'Male', '7418529630', '210 Maple St, FL',NOW()),
('Emma Lambert', 40, 'Female', '9517538520', '555 Cedar St, WA',NOW()),
('Omar Hassan', 38, 'Male', '1593574862', '890 Oak St, CA',NOW());


INSERT INTO Doctors (doctorName, specialization, phoneNumber, department, joiningDate) VALUES
('Dr. Alice Brown', 'Cardiologist', '1112223333', 'Cardiology', NOW()),
('Dr. Robert White', 'Neurologist', '2223334444', 'Neurology', NOW()),
('Dr. Sarah Green', 'Orthopedic', '3334445555', 'Orthopedics', NOW()),
('Dr. Mark Black', 'Dermatologist', '4445556666', 'Dermatology', NOW()),
('Dr. Laura Grey', 'Pediatrician', '5556667777', 'Pediatrics', NOW());

INSERT INTO Appointments (patientID, doctorID, appointmentDate, appointmentTime, diagnosis, status) VALUES
((SELECT patientID FROM Patients WHERE patientName ='John Doe')
,(SELECT doctorID FROM Doctors WHERE doctorName ='Dr. Alice Brown')
,'2025-02-10'
,'10:30:00'
,'High blood pressure'
,'Completed'
);

INSERT INTO Appointments (patientID, doctorID, appointmentDate, appointmentTime, diagnosis, status) VALUES
((SELECT patientID FROM Patients WHERE patientName ='Jane Smith')
,(SELECT doctorID FROM Doctors WHERE doctorName ='Dr. Robert White')
,'2025-02-11'
,'11:00:00'
,'Migraine'
,'Scheduled'
);

INSERT INTO Appointments (patientID, doctorID, appointmentDate, appointmentTime, diagnosis, status) VALUES
((SELECT patientID FROM Patients WHERE patientName ='Mike Johnson')
,(SELECT doctorID FROM Doctors WHERE doctorName ='Dr. Sarah Green')
,'2025-02-12'
,'14:00:00'
,'Knee pain'
,'Completed'
);

INSERT INTO Appointments (patientID, doctorID, appointmentDate, appointmentTime, diagnosis, status) VALUES
((SELECT patientID FROM Patients WHERE patientName ='Emily Davis')
,(SELECT doctorID FROM Doctors WHERE doctorName ='Dr. Mark Black')
,'2025-02-13'
,'09:30:00'
,'Skin allergy'
,'Scheduled'
);

INSERT INTO Appointments (patientID, doctorID, appointmentDate, appointmentTime, diagnosis, status) VALUES
((SELECT patientID FROM Patients WHERE patientName ='Chris Wilson')
,(SELECT doctorID FROM Doctors WHERE doctorName ='Dr. Laura Grey')
,'2025-02-14'
,'13:00:00'
,'Fever'
,'Completed'
);


INSERT INTO Appointments (patientID, doctorID, appointmentDate, appointmentTime, diagnosis, status) VALUES
((SELECT patientID FROM Patients WHERE patientName ='John Doe')
,(SELECT doctorID FROM Doctors WHERE doctorName ='Dr. Sarah Green')
,'2025-02-15'
,'08:30:00'
,'Routine check-up'
,'Scheduled'
);

INSERT INTO Appointments (patientID, doctorID, appointmentDate, appointmentTime, diagnosis, status) VALUES
((SELECT patientID FROM Patients WHERE patientName ='Mike Johnson')
,(SELECT doctorID FROM Doctors WHERE doctorName ='Dr. Robert White')
,'2025-02-16'
,'10:00:00'
,'Back pain'
,'Scheduled'
);

INSERT INTO Appointments (patientID, doctorID, appointmentDate, appointmentTime, diagnosis, status) VALUES
((SELECT patientID FROM Patients WHERE patientName ='Emily Davis')
,(SELECT doctorID FROM Doctors WHERE doctorName ='Dr. Mark Black')
,'2025-02-17'
,'15:30:00'
,'Allergy symptoms'
,'Completed'
);

INSERT INTO Appointments (patientID, doctorID, appointmentDate, appointmentTime, diagnosis, status) VALUES
((SELECT patientID FROM Patients WHERE patientName ='Jane Smith')
,(SELECT doctorID FROM Doctors WHERE doctorName ='Dr. Alice Brown')
,'2025-02-18'
,'09:00:00'
,'Chest pain'
,'Scheduled'
);

INSERT INTO Appointments (patientID, doctorID, appointmentDate, appointmentTime, diagnosis, status) VALUES
((SELECT patientID FROM Patients WHERE patientName ='Chris Wilson')
,(SELECT doctorID FROM Doctors WHERE doctorName ='Dr. Mark Black')
,'2025-02-19'
,'11:15:00'
,'Skin rash'
,'Completed'
);




INSERT INTO MedicalRecords(patientID,doctorID,diagnosis,prescriptions,testResults)VALUES
((SELECT patientID FROM Patients WHERE patientName = 'John Doe')
,(SELECT doctorID FROM Doctors WHERE doctorName = 'Dr. Alice Brown')
,'Hypertension'
,'Beta-blockers, Diuretics'
,'Blood pressure test, ECG'
),
((SELECT patientID FROM Patients WHERE patientName = 'Jane Smith')
,(SELECT doctorID FROM Doctors WHERE doctorName ='Dr. Robert White')
,'Migraine'
,'Pain relievers, Anti-nausea medication'
,'MRI scan, Blood test'
),
((SELECT patientID FROM Patients WHERE patientName = 'Mike Johnson')
,(SELECT doctorID FROM Doctors WHERE doctorName ='Dr. Sarah Green')
,'Knee pain'
,'Anti-inflammatory medication'
,'X-ray, MRI scan'
),
((SELECT patientID FROM Patients WHERE patientName = 'Emily Davis')
,(SELECT doctorID FROM Doctors WHERE doctorName ='Dr. Mark Black')
,'Skin allergy'
,'Antihistamines, Topical creams'
,'Allergy test'
),
((SELECT patientID FROM Patients WHERE patientName = 'Jane Smith')
,(SELECT doctorID FROM Doctors WHERE doctorName ='Dr. Laura Grey')
,'Fever'
,'Antipyretics, Hydration'
,'Blood test, Urine test'
),

((SELECT patientID FROM Patients WHERE patientName = 'Paul Adams')
,(SELECT doctorID FROM Doctors WHERE doctorName ='Dr. Alice Brown')
,NULL
,NULL 
,NULL
),

((SELECT patientID FROM Patients WHERE patientName = 'Sophie Martin')
,(SELECT doctorID FROM Doctors WHERE doctorName ='Dr. Robert White')
,NULL
,NULL 
,NULL
),

((SELECT patientID FROM Patients WHERE patientName = 'Leo Dupont')
,(SELECT doctorID FROM Doctors WHERE doctorName ='Dr. Sarah Green')
,NULL
,NULL 
,NULL
),
((SELECT patientID FROM Patients WHERE patientName = 'Emma Lambert')
,(SELECT doctorID FROM Doctors WHERE doctorName ='Dr. Mark Black')
,NULL
,NULL 
,NULL
),
((SELECT patientID FROM Patients WHERE patientName = 'Omar Hassan')
,(SELECT doctorID FROM Doctors WHERE doctorName ='Dr. Laura Grey')
,NULL
,NULL 
,NULL
)
;




INSERT INTO Billing (patientID,amount,paymentStatus,paymentDate,insuranceProvider)VALUES
((SELECT patientID FROM Patients WHERE patientName = 'John Doe')
,150.00
,'Paid'
,'2025-02-10'
,'HealthCare Insurance Co.'
),
((SELECT patientID FROM Patients WHERE patientName = 'Jane Smith')
,120.00
,'Pending'
,NULL
,'Wellness Insurance Ltd.'
),
((SELECT patientID FROM Patients WHERE patientName = 'Mike Johnson')
,200.00
,'Paid'
,'2025-02-12'
,'Prime Health Insurance'
),
((SELECT patientID FROM Patients WHERE patientName = 'Emily Davis')
,80.00
,'Pending'
,NULL
,'CarePlus Insurance'
),
((SELECT patientID FROM Patients WHERE patientName = 'Chris Wilson')
,100.00
,'Paid'
,2025-02-14
,'Family Health Insurance'
),
((SELECT patientID FROM Patients WHERE patientName = 'Paul Adams')
,180.00
,'Pending'
,NULL
,'Secure Health Insurance'
),
((SELECT patientID FROM Patients WHERE patientName = 'Sophie Martin')
,150.00
,'Pending'
,NULL
,'Wellness Insurance Ltd.'
),
((SELECT patientID FROM Patients WHERE patientName = 'Leo Dupont')
,130.00
,'Pending'
,NULL
,'HealthCare Insurance Co.'
),
((SELECT patientID FROM Patients WHERE patientName = 'Emma Lambert')
,110.00
,'Pending'
,NULL
,'CarePlus Insurance'
),
((SELECT patientID FROM Patients WHERE patientName = 'Omar Hassan')
,140.00
,'Pending'
,NULL
,'Family Health Insurance'
)
;
SELECT *
FROM Billing;






-- List all patients who have appointments this week.

/*SELECT 
    p.patientName AS nomDuPatient,
    p.age AS ageDuPatient,
    p.gender AS genreDuPatient,
    a.appointmentDate AS DateDuRendezVous
FROM Patients AS p
INNER JOIN Appointments AS a ON a.patientID = p.patientID
WHERE a.appointmentDate BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 7 DAY)
ORDER BY p.patientName ASC;

-- Retrieve all doctors from the "Cardiology" department.

SELECT *
FROM Doctors
WHERE department = 'Cardiology'
ORDER BY doctorName;



SELECT *
FROM Doctors;*/

-- Find the total number of patients each doctor has treated.
SELECT 
    d.doctorName,
    COUNT(DISTINCT m.PatientID) AS totalPatientsTreated
FROM 
    Doctors d
JOIN 
    MedicalRecords m ON d.DoctorID = m.DoctorID
WHERE 
    m.Diagnosis IS NOT NULL  -- Only count treated patients (patients with a diagnosis)
GROUP BY 
    d.doctorID;
;
-- Show all pending payments from the Billing table.
SELECT *
FROM Billing
WHERE PaymentStatus="Pending";

--  Get the most common diagnosis among patients
SELECT Diagnosis, COUNT(*) AS CommonDiagnostic
FROM MedicalRecords
GROUP BY Diagnosis
ORDER BY CommonDiagnostic DESC;

-- Retrieve all appointments for a specific doctor on a given date.

SELECT 
     d.doctorName AS NomDuDocteur,
     p.patientName AS NomDuPatient,
     a.appointmentDate AS DateDuRendezVous,
     a.appointmentTime AS HeureDuRendezVous,
     a.status AS Statut
FROM Appointments AS a
INNER JOIN Doctors AS d ON d.doctorID = a.doctorID
INNER JOIN Patients AS p ON p.patientID = a.patientID
WHERE d.doctorName = 'Dr. Alice Brown' AND a.appointmentDate ='2025-02-10';

-- Find patients who have not visited the hospital in the last 6 months.

SELECT 
     p.patientName AS NomDuPatient
FROM Appointments AS a
INNER JOIN Patients AS p ON p.patientID = a.patientID
WHERE a.appointmentDate < DATE_SUB(CURDATE(),INTERVAL 6 MONTH)
GROUP BY NomDuPatient;

-- Find the total amounts billed for patients treated by each doctor, displaying the total amount billed for each doctor.

SELECT 
    p.patientName AS NomDuPatient,
    SUM(b.Amount) AS MontantFacture
FROM Billing AS b
INNER JOIN Patients as p ON p.patientID = b.patientID
INNER JOIN MedicalRecords AS m ON m.PatientID = p.PatientID
INNER JOIN Doctors AS d ON m.doctorID = d.doctorID
GROUP BY d.doctorID
ORDER BY MontantFacture ASC;

-- Find the number of appointments made by each patient, by displaying the number of appointments for each patient
SELECT 
    p.patientName AS NomDuPatient,
    COUNT(a.appointmentsID) AS NombreRendezVous
FROM Appointments AS a
INNER JOIN Patients AS p ON p.patientID= a.patientID
GROUP BY p.patientID
ORDER BY p.patientName ASC;
   




SELECT *
FROM Appointments;









