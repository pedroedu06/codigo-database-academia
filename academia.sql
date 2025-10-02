CREATE TABLE Usuario (
	id_usuario INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(150) NOT NULL,
	email VARCHAR(150) NOT NULL UNIQUE,
	senha VARCHAR(255) NOT NULL,
	tipo ENUM('aluno', 'instrutor', 'administrador') NOT NULL,
	ativo BOOLEAN DEFAULT TRUE
);

CREATE TABLE Permissao (
	id_permissao INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(50) NOT NULL UNIQUE,
	descricao TEXT
);

CREATE TABLE Usuario_Permissao (
	id_usuario INT NOT NULL,
	id_permissao INT NOT NULL,
	PRIMARY KEY (id_usuario, id_permissao),
	FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario) ON DELETE CASCADE,
	FOREIGN KEY (id_permissao) REFERENCES Permissao(id_permissao) ON DELETE CASCADE
);

-- 2. Gestão de Alunos e Professores

CREATE TABLE Aluno (
	id_aluno INT PRIMARY KEY AUTO_INCREMENT,
	id_usuario INT NOT NULL UNIQUE,
	cpf VARCHAR(14) NOT NULL UNIQUE,
	data_nascimento DATE,
	telefone VARCHAR(30),
	endereco TEXT,
	objetivos TEXT,
	FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario) ON DELETE CASCADE
);

CREATE TABLE Instrutor (
	id_instrutor INT PRIMARY KEY AUTO_INCREMENT,
	id_usuario INT NOT NULL UNIQUE,
	especialidade VARCHAR(50),
	telefone VARCHAR(30),
	horarios TEXT,
	FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario) ON DELETE CASCADE
);

CREATE TABLE Turma (
	id_turma INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(100) NOT NULL,
	id_instrutor INT NOT NULL,
	horario VARCHAR(100),
	FOREIGN KEY (id_instrutor) REFERENCES Instrutor(id_instrutor) ON DELETE CASCADE
);

CREATE TABLE Aluno_Turma (
	id_aluno INT NOT NULL,
	id_turma INT NOT NULL,
	PRIMARY KEY (id_aluno, id_turma),
	FOREIGN KEY (id_aluno) REFERENCES Aluno(id_aluno) ON DELETE CASCADE,
	FOREIGN KEY (id_turma) REFERENCES Turma(id_turma) ON DELETE CASCADE
);

CREATE TABLE Historico_Treino (
	id_historico INT PRIMARY KEY AUTO_INCREMENT,
	id_aluno INT NOT NULL,
	data DATE NOT NULL,
	descricao TEXT,
	desempenho TEXT,
	FOREIGN KEY (id_aluno) REFERENCES Aluno(id_aluno) ON DELETE CASCADE
);

-- 3. Planos e Pagamentos

CREATE TABLE Plano (
	id_plano INT PRIMARY KEY AUTO_INCREMENT,
	nome_plano VARCHAR(50) NOT NULL,
	valor DECIMAL(10,2) NOT NULL,
	descricao TEXT
);

CREATE TABLE Matricula (
	id_matricula INT PRIMARY KEY AUTO_INCREMENT,
	id_aluno INT NOT NULL,
	id_plano INT NOT NULL,
	data_inicio DATE NOT NULL,
	data_fim DATE,
	status ENUM('ativo','suspenso','cancelado') NOT NULL DEFAULT 'ativo',
	FOREIGN KEY (id_aluno) REFERENCES Aluno(id_aluno) ON DELETE CASCADE,
	FOREIGN KEY (id_plano) REFERENCES Plano(id_plano) ON DELETE RESTRICT
);

CREATE TABLE Pagamento (
	id_pagamento INT PRIMARY KEY AUTO_INCREMENT,
	id_matricula INT NOT NULL,
	data_pagamento DATE NOT NULL,
	valor_pago DECIMAL(10,2) NOT NULL,
	status ENUM('pago','pendente','atrasado') NOT NULL DEFAULT 'pendente',
	FOREIGN KEY (id_matricula) REFERENCES Matricula(id_matricula) ON DELETE CASCADE
);

-- 4. Conteúdos Educativos e Acompanhamento

CREATE TABLE Conteudo (
	id_conteudo INT PRIMARY KEY AUTO_INCREMENT,
	titulo VARCHAR(150) NOT NULL,
	tipo ENUM('video','artigo','guia') NOT NULL,
	url TEXT,
	descricao TEXT,
	data_publicacao DATE NOT NULL
);

CREATE TABLE Conteudo_Tag (
	id_conteudo INT NOT NULL,
	tag VARCHAR(50) NOT NULL,
	PRIMARY KEY (id_conteudo, tag),
	FOREIGN KEY (id_conteudo) REFERENCES Conteudo(id_conteudo) ON DELETE CASCADE
);

CREATE TABLE Aluno_Conteudo (
	id_aluno INT NOT NULL,
	id_conteudo INT NOT NULL,
	data_visualizacao DATE NOT NULL,
	PRIMARY KEY (id_aluno, id_conteudo, data_visualizacao),
	FOREIGN KEY (id_aluno) REFERENCES Aluno(id_aluno) ON DELETE CASCADE,
	FOREIGN KEY (id_conteudo) REFERENCES Conteudo(id_conteudo) ON DELETE CASCADE
);

-- 5. Registro de Treinos e Evolução

CREATE TABLE Treino (
	id_treino INT PRIMARY KEY AUTO_INCREMENT,
	nome_treino VARCHAR(100) NOT NULL,
	descricao TEXT,
	id_instrutor INT,
	FOREIGN KEY (id_instrutor) REFERENCES Instrutor(id_instrutor) ON DELETE SET NULL
);

CREATE TABLE Exercicio (
	id_exercicio INT PRIMARY KEY AUTO_INCREMENT,
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
	FOREIGN KEY (id_treino) REFERENCES Treino(id_treino) ON DELETE CASCADE,
	FOREIGN KEY (id_exercicio) REFERENCES Exercicio(id_exercicio) ON DELETE CASCADE
);

CREATE TABLE Aluno_Treino (
	id_aluno INT NOT NULL,
	id_treino INT NOT NULL,
	data_atribuicao DATE NOT NULL DEFAULT CURRENT_DATE,
	PRIMARY KEY (id_aluno, id_treino, data_atribuicao),
	FOREIGN KEY (id_aluno) REFERENCES Aluno(id_aluno) ON DELETE CASCADE,
	FOREIGN KEY (id_treino) REFERENCES Treino(id_treino) ON DELETE CASCADE
);

CREATE TABLE Evolucao (
	id_evolucao INT PRIMARY KEY AUTO_INCREMENT,
	id_aluno INT NOT NULL,
	data_registro DATE NOT NULL,
	peso DECIMAL(5,2),
	altura DECIMAL(4,2),
	percentual_gordura DECIMAL(5,2),
	observacoes TEXT,
	FOREIGN KEY (id_aluno) REFERENCES Aluno(id_aluno) ON DELETE CASCADE
);
