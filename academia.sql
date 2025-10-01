CREATE TABLE Instrutor (
	id_instrutor INT PRIMARY KEY auto_increment,
	nome VARCHAR(150) NOT NULL,
	cpf VARCHAR(14) NOT NULL UNIQUE,
	especialidade VARCHAR(50),
	telefone VARCHAR(30),
	email VARCHAR(150) UNIQUE
);

CREATE TABLE Aluno (
	id_aluno INT PRIMARY KEY auto_increment,
	nome VARCHAR(150) NOT NULL,
	cpf VARCHAR(14) NOT NULL UNIQUE,
	data_nascimento DATE,
	telefone VARCHAR(30),
	email VARCHAR(150) UNIQUE,
	endereco TEXT,
	data_matricula DATE
);

CREATE TABLE Plano (
	id_plano INT PRIMARY KEY auto_increment,
	nome_plano VARCHAR(20) NOT NULL,
	valor DECIMAL(10,2) NOT NULL,
	descricao TEXT
);

CREATE TABLE Treino (
	id_treino INT PRIMARY KEY auto_increment,
	nome_treino VARCHAR(100) NOT NULL,
	descricao TEXT,
	id_instrutor INT,
	CONSTRAINT fk_treino_instrutor FOREIGN KEY (id_instrutor) REFERENCES Instrutor(id_instrutor) ON DELETE SET NULL
);

CREATE TABLE Exercicio (
	id_exercicio INT PRIMARY KEY auto_increment,
	nome_exercicio VARCHAR(150) NOT NULL,
	grupo_muscular VARCHAR(50),
	equipamento VARCHAR(100)
);

CREATE TABLE Treino_Exercicio (
	id_treino INT NOT NULL,
	id_exercicio INT NOT NULL,
	series INT,
	repeticoes INT,
	carga DECIMAL(8,2),
	PRIMARY KEY (id_treino, id_exercicio),
	CONSTRAINT fk_te_treino FOREIGN KEY (id_treino) REFERENCES Treino(id_treino) ON DELETE CASCADE,
	CONSTRAINT fk_te_exercicio FOREIGN KEY (id_exercicio) REFERENCES Exercicio(id_exercicio) ON DELETE CASCADE
);

CREATE TABLE Matricula (
	id_matricula INT PRIMARY KEY auto_increment,
	id_aluno INT NOT NULL,
	id_plano INT NOT NULL,
	data_inicio DATE NOT NULL,
	data_fim DATE,
	status VARCHAR(20) NOT NULL DEFAULT 'ativo',
	CONSTRAINT fk_matricula_aluno FOREIGN KEY (id_aluno) REFERENCES Aluno(id_aluno) ON DELETE CASCADE,
	CONSTRAINT fk_matricula_plano FOREIGN KEY (id_plano) REFERENCES Plano(id_plano) ON DELETE RESTRICT,
	CONSTRAINT chk_matricula_status CHECK (status IN ('ativo','suspenso','cancelado'))
);

CREATE TABLE Aluno_Treino (
	id_aluno INT NOT NULL,
	id_treino INT NOT NULL,
	data_atribuicao DATE NOT NULL DEFAULT CURRENT_DATE,
	PRIMARY KEY (id_aluno, id_treino, data_atribuicao),
	CONSTRAINT fk_at_aluno FOREIGN KEY (id_aluno) REFERENCES Aluno(id_aluno) ON DELETE CASCADE,
	CONSTRAINT fk_at_treino FOREIGN KEY (id_treino) REFERENCES Treino(id_treino) ON DELETE CASCADE
);

CREATE TABLE Presenca (
	id_presenca INT PRIMARY KEY auto_increment,
	id_aluno INT NOT NULL,
	data_entrada DATE NOT NULL,
	hora_entrada TIME,
	hora_saida TIME,
	CONSTRAINT fk_presenca_aluno FOREIGN KEY (id_aluno) REFERENCES Aluno(id_aluno) ON DELETE CASCADE
);

insert into Instrutor (nome, cpf, especialidade, telefone, email) values
('Carlos', '123.456.789-00', 'Musculação', '(11) 91234-5678', 'carlos.silva@email.com'),
('Ana', '987.654.321-00', 'Yoga', '(21) 99876-5432', 'ana.pereira@email.com');

insert into Aluno (nome, cpf, data_nascimento, telefone, email, endereco, data_matricula) values
('Mariana', '111.222.333-44', '1995-05-20', '(11) 92345-6789', 'mariana.souza@email.com', 'Rua A, 123', '2023-01-15'),
('Lucas', '555.666.777-88', '1990-10-10', '(21) 98765-4321', 'lucas.silva@email.com', 'Rua B, 456', '2023-02-20');

insert into Plano (nome_plano, valor, descricao) values
('Mensal', 80.00, 'Acesso mensal à academia'),
('Trimestral', 220.00, 'Acesso por três meses com desconto');

insert into Treino (nome_treino, descricao, id_instrutor) values
('Treino de Força', 'Focado em exercícios de musculação para ganho de força', 1),
('Treino de Flexibilidade', 'Focado em exercícios de alongamento e yoga', 2);

insert into Exercicio (nome_exercicio, grupo_muscular, equipamento) values
('Supino', 'Peito', 'Banco e barra'),
('Agachamento', 'Pernas', 'Barra'),
('Cadeira Extensora', 'Pernas', 'Máquina de cadeira extensora'),
('Flexão de Braço', 'Peito', 'Nenhum');

insert into Treino_Exercicio (id_treino, id_exercicio, series, repeticoes, carga) values
(1, 1, 4, 10, 60.00),
(1, 2, 4, 12, 80.00),
(2, 3, 3, 15, NULL),
(2, 4, 3, 20, NULL);

insert into Matricula (id_aluno, id_plano, data_inicio, data_fim, status) values
(1, 1, '2023-01-15', '2023-02-14', 'ativo'),
(2, 2, '2023-02-20', '2023-05-19', 'ativo');

insert into Aluno_Treino (id_aluno, id_treino, data_atribuicao) values
(1, 1, '2023-01-16'),
(2, 2, '2023-02-21');

insert into Presenca (id_aluno, data_entrada, hora_entrada, hora_saida) values
(1, '2023-01-16', '08:00:00', '09:30:00'),
(2, '2023-02-21', '18:00:00', '19:15:00');

SELECT * FROM Aluno;

SELECT * FROM Treino;

SELECT * FROM Matricula WHERE status = 'ativo';

SELECT * FROM Presenca
WHERE id_aluno = 1 AND data_entrada = '2023-01-16';

SELECT * FROM Presenca
WHERE id_aluno = 1 AND data_entrada = '2023-01-16';

update Matricula
set status = 'suspenso'
where id_matricula = 1;

update Presenca
set hora_saida = '10:00:00'
where id_presenca = 2;
