# Projeto: Índices e Procedures em Banco de Dados

## 📌 Descrição
Este projeto tem como objetivo a criação e otimização de índices para melhorar o desempenho de consultas SQL no **MySQL**, além da implementação de procedures para manipulação de dados em um banco de dados relacional. O projeto é dividido em duas partes principais:

1. **📊 Criação de Índices**: Implementação de índices para otimizar consultas em tabelas relacionadas a funcionários e departamentos de uma empresa.
2. **⚙️ Procedures para Manipulação de Dados**: Desenvolvimento de uma procedure que permite a inserção, atualização e remoção de registros de funcionários, utilizando uma variável de controle para determinar a ação desejada.

## 📂 Estrutura do Projeto
O projeto está estruturado da seguinte forma:

- **📜 Script SQL**: Contém a criação dos índices e procedures.
  

## 🏗️ Parte 1: Criação de Índices

Os índices foram criados para otimizar as seguintes consultas:


### 📌 Índices Criados:
1️⃣  **🔍 idx_department_id** (Tabela: `employees`, Coluna: `department_id`)
   - 📌 Motivo: Melhora a performance da contagem de funcionários por departamento.
   - 🏎️ Exemplo de consulta otimizada:
     ```sql
     SELECT department_id, COUNT(*) AS total_employees 
     FROM employees 
     GROUP BY department_id 
     ORDER BY total_employees DESC 
     LIMIT 1;
     ```

2️⃣ **🌍 idx_department_location** (Tabela: `departments`, Coluna: `city`)
   - 📌 Motivo: Acelera a busca de departamentos por cidade.
   - 🏎️ Exemplo de consulta otimizada:
     ```sql
     SELECT city, department_name FROM departments;
     ```

3️⃣ **👥 idx_employee_department** (Tabela: `employees`, Coluna: `department_id`)
   - 📌 Motivo: Agiliza a recuperação de funcionários por departamento.
   - 🏎️ Exemplo de consulta otimizada:
     ```sql
     SELECT e.employee_id, e.employee_name, d.department_name 
     FROM employees e
     JOIN departments d ON e.department_id = d.department_id;
     ```

## 🛠️ Parte 2: Procedures para Manipulação de Dados
Uma procedure chamada `manage_employee` foi criada para permitir operações de inserção, atualização e remoção de registros na tabela `employees`.

### 🔧 Estrutura da Procedure
A procedure recebe os seguintes parâmetros:
- `action_type` (INT) - Define a ação: 1️⃣ para inserção, 2️⃣ para atualização e 3️⃣ para remoção.
- `emp_id` (INT) - Identificação do funcionário.
- `emp_name` (VARCHAR) - Nome do funcionário (opcional para remoção).
- `dept_id` (INT) - ID do departamento (opcional para atualização ou remoção).

### 📌 Exemplo de Uso:
```sql
CALL manage_employee(1, 101, 'John Doe', 2); -- ➕ Inserir
CALL manage_employee(2, 101, 'John Smith', NULL); -- ✏️ Atualizar
CALL manage_employee(3, 101, NULL, NULL); -- ❌ Remover
```

## 🎯 Conclusão
✅ Com a implementação dos índices, a performance das consultas foi otimizada, garantindo respostas mais rápidas e eficiente uso dos recursos do SGBD. 
✅ A procedure implementada permite uma manipulação mais dinâmica dos dados, facilitando operações CRUD no banco de dados de maneira estruturada e segura. 🚀

