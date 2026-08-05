-- Comandos SQL para consulta, atualização e exclusão no BD banco_1906

SELECT nome, idade FROM Clientes; 

SELECT DISTINCT cidade FROM Clientes;

SELECT nome FROM Clientes WHERE cidade = 'Curitiba'; 

SELECT nome FROM Clientes WHERE nome LIKE 'C%'; 

SELECT DISTINCT cidade FROM Clientes;

SELECT nome FROM Clientes WHERE idade BETWEEN 30 AND 40;

SELECT nome FROM Clientes WHERE cidade = 'Maringá' AND status = 'Ativo'; 

UPDATE Clientes SET idade = idade + 1 WHERE status = 'Ativo';
SELECT * FROM Clientes;

UPDATE Clientes SET status = 'Ativo' WHERE nome = 'Carla'; 
SELECT * FROM Clientes;

UPDATE Clientes SET idade = idade * 2 WHERE nome = 'Elisa';
SELECT * FROM Clientes;

DELETE FROM Clientes WHERE cidade = 'Londrina';
SELECT * FROM Clientes;

SELECT nome, cidade FROM Clientes WHERE status = 'Ativo';
