CREATE database SERVICE_CENTER;
USE SERVICE_CENTER;

create table Clients
(
Client_id int primary key auto_increment,
First_name varchar(100) not null,
Last_name varchar(100) not null,
Phone_number varchar(20) not null,
address varchar(100) not null
);

create table Staff
(
Staff_id int primary key auto_increment,
First_name varchar(100) not null,
Last_name varchar(100) not null,
Roles enum('receptionist', 'master') not null,
Specialization varchar(100)
);

create table Services
(
Service_id int primary key auto_increment,
Title varchar(250) not null,
Price decimal(10, 2) not null
);

create table SpareParts
(
SparePart_id int primary key auto_increment,
Title varchar(250) not null,
Price decimal(10, 2) not null
);

CREATE TABLE Repairs
(
Repair_id int primary key auto_increment,
Repair_date date not null,
Completion_date date,
Description text,
Equipment_model varchar(100) not null,
Client_id int not null,
foreign key (Client_id)
references Clients (Client_id),
Staff_receptionist_id int not null,
foreign key (Staff_receptionist_id)
references Staff (Staff_id),
Staff_master_id int not null,
foreign key (Staff_master_id)
references Staff (Staff_id)
);

create table RepairServices
(
Repair_service_id int primary key auto_increment,
Repair_id int not null,
foreign key (Repair_id)
references Repairs (Repair_id),
Service_id int not null,
foreign key (Service_id)
references Services (Service_id)
);

create table RepairSpareParts
(
Repair_sparepart_id int primary key auto_increment,
Repair_id int not null,
foreign key (Repair_id)
references Repairs (Repair_id),
Sparepart_id int not null,
foreign key (Sparepart_id)
references Spareparts (Sparepart_id)
);

ALTER TABLE RepairSpareParts
ADD COLUMN quantity INT UNSIGNED NOT NULL DEFAULT 1;

INSERT INTO RepairSpareParts (Repair_id, Sparepart_id, quantity)
VALUES (1, 2, 3), (2, 3, 2);

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

INSERT INTO Staff (First_name, Last_name, Roles, Specialization) VALUES
('Иван', 'Иванов', 'receptionist', NULL),
('Мария', 'Петрова', 'master', 'ремонт компьютеров'),
('Алексей', 'Сидоров', 'master', 'ремонт ноутбуков'),
('Елена', 'Смирнова', 'receptionist', NULL);

SELECT * FROM Staff;

INSERT INTO Services (Title, Price) VALUES
('Диагностика', 500.00),
('Чистка от пыли', 800.00),
('Замена термопасты', 700.00),
('Установка операционной системы', 1500.00),
('Восстановление данных', 3000.00),
('Ремонт материнской платы', 4000.00);

SELECT * FROM Services;

INSERT INTO SpareParts (Title, Price) VALUES
('Термопаста', 200.00),
('Жесткий диск 1TB', 5000.00),
('Оперативная память 8GB', 3000.00),
('Блок питания 500W', 2500.00),
('Кулер процессора', 1000.00);

select * from SpareParts;

INSERT INTO Repairs (Repair_date, Completion_date, Description, Equipment_model, 
Client_id, Staff_receptionist_id, Staff_master_id) VALUES
('2024-03-01', '2024-03-05', 'Не включается', 'HP Pavilion', 1, 1, 2),
('2024-03-10', '2024-03-12', 'Проблемы с Wi-Fi', 'Lenovo ThinkPad', 2, 1, 3),
('2024-03-15', NULL, 'Синий экран смерти', 'Dell Inspiron', 3, 4, 2);

select * from Repairs;

INSERT INTO RepairServices (Repair_id, Service_id) VALUES
(1, 1),  
(1, 2),  
(2, 1),  
(3, 5);  

select * from RepairServices;

INSERT INTO RepairSpareParts (Repair_id, Sparepart_id) VALUES
(1, 1),  
(3, 2);  

select * from RepairSpareParts