USE ecommerce;

DROP TABLE IF EXISTS Appointments;
DROP TABLE IF EXISTS MedicalRecords;
DROP TABLE IF EXISTS Billing;
DROP TABLE IF EXISTS Patients;
DROP TABLE IF EXISTS Doctors;

CREATE TABLE Patients(
patientID INT PRIMARY KEY AUTO_INCREMENT,
patientName VARCHAR(100) NOT NULL,
age INT,
gender VARCHAR(10),
contactNumber VARCHAR (15) UNIQUE,
address TEXT,
registrationDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Doctors(
doctorID INT PRIMARY KEY AUTO_INCREMENT,
doctorName VARCHAR(100) NOT NULL,
specialization VARCHAR(100),
phoneNumber VARCHAR(15) UNIQUE,
department VARCHAR(100),
joiningDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


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


CREATE TABLE Billing(
billingID INT PRIMARY KEY AUTO_INCREMENT,
patientID INT,
Amount DECIMAL(10,2),
PaymentStatus ENUM('Pending', 'Paid') DEFAULT 'Pending',
PaymentDate DATE NULL,
insuranceProvider VARCHAR(100) NULL,
FOREIGN KEY (patientID) REFERENCES Patients(patientID) ON DELETE CASCADE
);



INSERT INTO Patients (patientName, age, gender, contactNumber, address, registrationDate) VALUES
('John Doe', 35, 'Male', '1234567890', '123 Main St, NY', NOW()),
('Jane Smith', 28, 'Female', '9876543210', '456 Oak St, CA', NOW()),
('Mike Johnson', 42, 'Male', '4567891230', '789 Pine St, TX', NOW()),
('Emily Davis', 30, 'Female', '7412589630', '101 Maple St, FL', NOW()),
('Chris Wilson', 50, 'Male', '8529637410', '202 Cedar St, WA', NOW());


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

-- List all patients who have appointments this week.

SELECT 
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
FROM Doctors;








