IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'SERVICE_CENTER')
BEGIN
    CREATE DATABASE SERVICE_CENTER;
END;
GO

USE SERVICE_CENTER;
GO


CREATE TABLE Clients (
    Client_id INT PRIMARY KEY IDENTITY(1,1),
    First_name VARCHAR(100) NOT NULL,
    Last_name VARCHAR(100) NOT NULL,
    Phone_number VARCHAR(20) NOT NULL,
    Address VARCHAR(100) NOT NULL
);

CREATE TABLE Staff (
    Staff_id INT PRIMARY KEY IDENTITY(1,1),
    First_name VARCHAR(100) NOT NULL,
    Last_name VARCHAR(100) NOT NULL,
    Roles VARCHAR(20) NOT NULL CHECK (Roles IN ('receptionist', 'master')), 
    Specialization VARCHAR(100)
);


CREATE TABLE Services (
    Service_id INT PRIMARY KEY IDENTITY(1,1),
    Title VARCHAR(250) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE SpareParts (
    SparePart_id INT PRIMARY KEY IDENTITY(1,1),
    Title VARCHAR(250) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL
);


CREATE TABLE Repairs (
    Repair_id INT PRIMARY KEY IDENTITY(1,1),
    Repair_date DATE NOT NULL,
    Completion_date DATE,
    Description TEXT,
    Equipment_model VARCHAR(100) NOT NULL,
    Client_id INT NOT NULL,
    FOREIGN KEY (Client_id) REFERENCES Clients(Client_id),
    Staff_receptionist_id INT NOT NULL,
    FOREIGN KEY (Staff_receptionist_id) REFERENCES Staff(Staff_id),
    Staff_master_id INT NOT NULL,
    FOREIGN KEY (Staff_master_id) REFERENCES Staff(Staff_id)
);

CREATE TABLE RepairServices (
    Repair_service_id INT PRIMARY KEY IDENTITY(1,1),
    Repair_id INT NOT NULL,
    FOREIGN KEY (Repair_id) REFERENCES Repairs(Repair_id),
    Service_id INT NOT NULL,
    FOREIGN KEY (Service_id) REFERENCES Services(Service_id)
);

CREATE TABLE RepairSpareParts (
    Repair_sparepart_id INT PRIMARY KEY IDENTITY(1,1),
    Repair_id INT NOT NULL,
    FOREIGN KEY (Repair_id) REFERENCES Repairs(Repair_id),
    Sparepart_id INT NOT NULL,
    FOREIGN KEY (Sparepart_id) REFERENCES SpareParts(SparePart_id),
    Quantity INT NOT NULL DEFAULT 1 CHECK (Quantity >= 0)
);
GO

BEGIN TRANSACTION;
INSERT INTO Clients (First_name, Last_name, Phone_number, address)
VALUES
    ('Иван', 'Иванов', '+79123456789', 'ул. Ленина, д. 10, кв. 5'),
    ('Мария', 'Петрова', '+79234567890', 'пр. Гагарина, д. 25, кв. 12'),
    ('Алексей', 'Сидоров', '+79345678901', 'ул. Пушкина, д. 5, кв. 1'),
    ('Елена', 'Смирнова', '+79456789012', 'ул. Мира, д. 15, кв. 7'),
    ('Дмитрий', 'Козлов', '+79567890123', 'ул. Советская, д. 3, кв. 20'),
    ('Анна', 'Новикова', '+79678901234', 'ул. Строителей, д. 8, кв. 11'),
    ('Сергей', 'Волков', '+79789012345', 'ул. Южная, д. 1, кв. 3'),
    ('Ольга', 'Морозова', '+79890123456', 'ул. Северная, д. 22, кв. 9'),
    ('Максим', 'Соколов', '+79901234567', 'ул. Парковая, д. 17, кв. 15'),
    ('Наталья', 'Лебедева', '+79012345678', 'ул. Цветочная, д. 6, кв. 4');

SELECT * FROM Clients;
COMMIT TRANSACTION;
GO

BEGIN TRANSACTION;
INSERT INTO Staff (First_name, Last_name, Roles, Specialization) VALUES
('Иван', 'Иванов', 'receptionist', NULL),
('Мария', 'Петрова', 'master', 'ремонт компьютеров'),
('Алексей', 'Сидоров', 'master', 'ремонт ноутбуков'),
('Елена', 'Смирнова', 'receptionist', NULL);

SELECT * FROM Staff;
COMMIT TRANSACTION;
GO

BEGIN TRANSACTION;
INSERT INTO Services (Title, Price) VALUES
('Диагностика', 500.00),
('Чистка от пыли', 800.00),
('Замена термопасты', 700.00),
('Установка операционной системы', 1500.00),
('Восстановление данных', 3000.00),
('Ремонт материнской платы', 4000.00);

SELECT * FROM Services;
COMMIT TRANSACTION;
GO

BEGIN TRANSACTION;
INSERT INTO SpareParts (Title, Price) VALUES
('Термопаста', 200.00),
('Жесткий диск 1TB', 5000.00),
('Оперативная память 8GB', 3000.00),
('Блок питания 500W', 2500.00),
('Кулер процессора', 1000.00);

select * from SpareParts;
COMMIT TRANSACTION;
GO

BEGIN TRANSACTION;
INSERT INTO Repairs (Repair_date, Completion_date, Description, Equipment_model,
Client_id, Staff_receptionist_id, Staff_master_id) VALUES
('2024-03-01', '2024-03-05', 'Не включается', 'HP Pavilion', 1, 1, 2),
('2024-03-10', '2024-03-12', 'Проблемы с Wi-Fi', 'Lenovo ThinkPad', 2, 1, 3),
('2024-03-15', NULL, 'Синий экран смерти', 'Dell Inspiron', 3, 4, 2);

select * from Repairs;
COMMIT TRANSACTION;
GO

BEGIN TRANSACTION;
INSERT INTO RepairServices (Repair_id, Service_id) VALUES
(1, 1),
(1, 2),
(2, 1),
(3, 5);

select * from RepairServices;
COMMIT TRANSACTION;
GO

BEGIN TRANSACTION;
INSERT INTO RepairSpareParts (Repair_id, Sparepart_id, Quantity) VALUES
(1, 1, 1),
(3, 2, 1);

select * from RepairSpareParts;
COMMIT TRANSACTION;
GO