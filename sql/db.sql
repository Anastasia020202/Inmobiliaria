CREATE DATABASE inmobiliaria;


USE inmobiliaria;


CREATE TABLE agents (
    id INT PRIMARY KEY IDENTITY,
    first_name NVARCHAR(50),
    last_name NVARCHAR(50),
    email NVARCHAR(100),
    phone NVARCHAR(20),
    password NVARCHAR(100)
);


CREATE TABLE customers (
    id INT PRIMARY KEY IDENTITY,
    first_name NVARCHAR(50),
    last_name NVARCHAR(50),
    email NVARCHAR(100),
    phone NVARCHAR(20)
);


CREATE TABLE properties (
    id INT PRIMARY KEY IDENTITY,
    address NVARCHAR(255),
    type NVARCHAR(50),
    price DECIMAL(18, 2),
    square_meters DECIMAL(18, 2),
    rooms INT,
    bathrooms INT,
    description NVARCHAR(MAX),
    agent_id INT,
    ImageColumn VARBINARY(MAX),
    CONSTRAINT FK_Properties_Agents FOREIGN KEY (agent_id) REFERENCES agents(id)
);


CREATE TABLE appointments (
    id INT PRIMARY KEY IDENTITY,
    property_id INT,
    customer_id INT,
    agent_id INT,
    appointment_datetime DATETIME,
    status NVARCHAR(50),
    message NVARCHAR(MAX),
    customer_first_name NVARCHAR(50),
    customer_last_name NVARCHAR(50),
    customer_email NVARCHAR(100),
    customer_phone NVARCHAR(20),
    CONSTRAINT FK_Appointments_Properties FOREIGN KEY (property_id) REFERENCES properties(id),
    CONSTRAINT FK_Appointments_Customers FOREIGN KEY (customer_id) REFERENCES customers(id),
    CONSTRAINT FK_Appointments_Agents FOREIGN KEY (agent_id) REFERENCES agents(id)
);


CREATE TABLE reviews (
    id INT PRIMARY KEY IDENTITY,
    customer_name NVARCHAR(100),
    text NVARCHAR(MAX)
);


INSERT INTO agents (first_name, last_name, email, phone, password) 
VALUES ('John', 'Doe', 'john.doe@example.com', '123456789', 'password123');