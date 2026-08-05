-- Criação da tabela Clientes
CREATE TABLE Clientes (
    ID INTEGER PRIMARY KEY,
    nomeCliente TEXT NOT NULL,
    emailCliente TEXT UNIQUE
);

-- Criação da tabela Compras
CREATE TABLE Compras (
    CompraID INTEGER PRIMARY KEY,
    ClienteID INTEGER NOT NULL,
    NomeLivro TEXT NOT NULL,
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ID)
);
SELECT * FROM Clientes; 
-- Limpar a tela antes de executar
-- (No SQLite Online, basta apagar o conteúdo anterior manualmente)

-- Inserir dados na tabela Clientes
INSERT INTO Clientes (ID, nomeCliente, emailCliente) VALUES
(1, 'Carlos Silva', 'carlos@email.com'),
(2, 'Ana Souza', 'ana@gmail.com'),
(3, 'Mariana Costa', 'mariana@gmail.com');

-- Inserir dados na tabela Compras
INSERT INTO Compras (CompraID, ClienteID, NomeLivro) VALUES
(101, 1, 'O Hobbit'),
(102, 1, '1984'),
(103, 2, 'Dom Casmurro'),
(104, 3, 'O Alquimista');

-- Limpar a tela novamente e digitar:
SELECT * FROM Clientes;
SELECT * FROM Compras;
