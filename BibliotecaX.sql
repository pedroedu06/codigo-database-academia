CREATE TABLE Usuario (
  id_usuario INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(100),
  telefone VARCHAR(20),
  cpf VARCHAR(11)
);

drop table usuario;
drop table emprestimo;

CREATE TABLE Livro (
  id_livro INT PRIMARY KEY AUTO_INCREMENT,
  titulo VARCHAR(150),
  autor VARCHAR(100),
  ano INT
);

CREATE TABLE Emprestimo (
  id_emprestimo INT PRIMARY KEY AUTO_INCREMENT,
  data_emprestimo DATE,
  data_devolucao DATE,
  id_usuario INT,
  id_livro INT,
  FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
  FOREIGN KEY (id_livro) REFERENCES Livro(id_livro)
);

insert into usuario (nome, telefone, cpf) values ("osvaldo", "551123297148", "12345678900");
insert into usuario (nome, telefone, cpf) values ("joao", "551123297148", "12341248900");
insert into usuario (nome, telefone, cpf) values ("jose", "551123292348", "12324678900");

INSERT INTO Livro (titulo, autor, ano)
VALUES 
  ('Dom Casmurro', 'Machado de Assis', 1899),
  ('O Senhor dos Anéis', 'J.R.R. Tolkien', 1954),
  ('1984', 'George Orwell', 1949);

update usuario
set telefone = '5561882389402'
where id_usuario = '1';

update livro
set titulo =  'Diario de um banana'
where id_livro = '1';

update emprestimo
set id_usuario = '3'
where id_emprestimo = '1';


INSERT INTO Emprestimo (data_emprestimo, data_devolucao, id_usuario, id_livro)
VALUES
  ('2025-09-01', '2025-09-15', 1, 1),
  ('2025-09-05', '2025-09-20', 2, 2);