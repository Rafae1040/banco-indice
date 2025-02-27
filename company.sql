-- Criando Banco de Dados
CREATE DATABASE company;
USE company;

-- Criando a Tabela de Departamentos
CREATE TABLE Departamentos (
    idDepartamento INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    cidade VARCHAR(100)
);

-- Criando a Tabela de Empregados
CREATE TABLE Empregados (
    idEmpregado INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    idDepartamento INT,
    FOREIGN KEY (idDepartamento) REFERENCES Departamentos(idDepartamento)
);

-- Criando Índices para Otimização
-- Índice para otimizar a busca do maior número de pessoas por departamento
CREATE INDEX idx_departamento ON Empregados(idDepartamento);

-- Índice para otimizar a consulta de departamentos por cidade
CREATE INDEX idx_cidade ON Departamentos(cidade);

-- Consultas Otimizadas
-- Qual o departamento com maior número de pessoas?
SELECT d.nome, COUNT(e.idEmpregado) AS total_empregados
FROM Departamentos d
JOIN Empregados e ON d.idDepartamento = e.idDepartamento
GROUP BY d.nome
ORDER BY total_empregados DESC
LIMIT 1;

-- Quais são os departamentos por cidade?
SELECT cidade, GROUP_CONCAT(nome) AS departamentos
FROM Departamentos
GROUP BY cidade;

-- Relação de empregados por departamento
SELECT d.nome AS departamento, e.nome AS empregado
FROM Departamentos d
JOIN Empregados e ON d.idDepartamento = e.idDepartamento
ORDER BY d.nome;

-- Criando a Procedure para Manipulação de Dados
DELIMITER //
CREATE PROCEDURE ManipularEmpregados(
    IN acao INT,
    IN p_idEmpregado INT,
    IN p_nome VARCHAR(100),
    IN p_idDepartamento INT
)
BEGIN
    CASE acao
        WHEN 1 THEN -- Inserir
            INSERT INTO Empregados (nome, idDepartamento) VALUES (p_nome, p_idDepartamento);
        WHEN 2 THEN -- Atualizar
            UPDATE Empregados SET nome = p_nome, idDepartamento = p_idDepartamento WHERE idEmpregado = p_idEmpregado;
        WHEN 3 THEN -- Remover
            DELETE FROM Empregados WHERE idEmpregado = p_idEmpregado;
        WHEN 4 THEN -- Selecionar
            IF p_idEmpregado IS NOT NULL THEN
                SELECT * FROM Empregados WHERE idEmpregado = p_idEmpregado;
            ELSE
                SELECT * FROM Empregados;
            END IF;
    END CASE;
END //
DELIMITER ;

-- Chamando a Procedure
CALL ManipularEmpregados(1, NULL, 'João Silva', 1); -- Inserção
CALL ManipularEmpregados(2, 1, 'João Pedro', 2); -- Atualização
CALL ManipularEmpregados(3, 1, NULL, NULL); -- Remoção
CALL ManipularEmpregados(4, 1, NULL, NULL); -- Seleção de um empregado específico
CALL ManipularEmpregados(4, NULL, NULL, NULL); -- Seleção de todos os empregados
