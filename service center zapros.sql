SELECT Title, Price FROM Services;

SELECT First_name, Last_name, Phone_number, address FROM Clients;

SELECT
    c.First_name,
    c.Last_name,
    c.Phone_number,
    r.Repair_date,
    r.Description,
    s_receptionist.Last_name AS receptionist_name,
    s_master.Last_name AS master_surname,
    r.Equipment_model
FROM Clients c
JOIN Repairs r ON c.Client_id = r.Client_id
JOIN Staff s_receptionist ON r.Staff_receptionist_id = s_receptionist.Staff_id
JOIN Staff s_master ON r.Staff_master_id = s_master.Staff_id
WHERE c.Client_id = 3;

SELECT SUM(s.Price)
FROM RepairServices rs
JOIN Services s ON rs.Service_id = s.Service_id
JOIN Repairs r ON rs.Repair_id = r.Repair_id
WHERE r.Completion_date BETWEEN '2024-03-01' AND '2024-03-12';

SELECT SUM(s.Price)
FROM RepairServices rs
JOIN Services s ON rs.Service_id = s.Service_id
JOIN Repairs r ON rs.Repair_id = r.Repair_id
WHERE r.Staff_master_id = 3;

SELECT
    r.Repair_id,
    c.Last_name AS client_surname,
    c.First_name AS client_name,
    s_receptionist.Last_name AS receptionist_surname,
    s_receptionist.First_name AS receptionist_name,
    s_master.Last_name AS master_surname,
    s_master.First_name AS master_name,
    r.Equipment_model,
    r.Repair_date,
    r.Completion_date,
    r.Description,
    SUM(DISTINCT CASE WHEN rs.Service_id IS NOT NULL THEN serv.Price ELSE 0 END) AS total_services_cost,
    SUM(DISTINCT CASE WHEN rsp.Sparepart_id IS NOT NULL THEN sp.Price * rsp.quantity ELSE 0 END) AS total_spareparts_cost
FROM Repairs r
JOIN Clients c ON r.Client_id = c.Client_id
LEFT JOIN Staff s_receptionist ON r.Staff_receptionist_id = s_receptionist.Staff_id
LEFT JOIN Staff s_master ON r.Staff_master_id = s_master.Staff_id
LEFT JOIN RepairServices rs ON r.Repair_id = rs.Repair_id
LEFT JOIN Services serv ON rs.Service_id = serv.Service_id
LEFT JOIN RepairSpareParts rsp ON r.Repair_id = rsp.Repair_id
LEFT JOIN SpareParts sp ON rsp.Sparepart_id = sp.Sparepart_id
WHERE r.Repair_id = 3
GROUP BY r.Repair_id
LIMIT 0, 1000;

SELECT sp.Title
FROM RepairSpareParts rsp
JOIN SpareParts sp ON rsp.Sparepart_id = sp.Sparepart_id
JOIN Repairs r ON rsp.Repair_id = r.Repair_id
WHERE r.Completion_date BETWEEN '2024-01-04' AND '2024-10-10';

SELECT SUM(sp.Price * rsp.quantity)
FROM RepairSpareParts rsp
JOIN SpareParts sp ON rsp.Sparepart_id = sp.Sparepart_id
WHERE rsp.Repair_id = 1;

SELECT SUM(s.Price)
FROM RepairServices rs
JOIN Services s ON rs.Service_id = s.Service_id
JOIN Repairs r ON rs.Repair_id = r.Repair_id
WHERE r.Completion_date BETWEEN '2024-0 1-10' AND '2024-10-10';

SELECT Last_name, First_name, Specialization
FROM Staff
WHERE Roles = 'master';