-- Criação do Banco de Dados Escola
-- No SQLite, o banco é criado automaticamente ao conectar
-- Não é necessário comando CREATE DATABASE

-- Criação da tabela de Cursos
CREATE TABLE cursos (
    id_curso INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_curso VARCHAR(100) NOT NULL,
    duracao_semestres INTEGER NOT NULL,
    turno VARCHAR(20) NOT NULL,
    coordenador VARCHAR(100),
    data_criacao DATE,
    ativo INTEGER DEFAULT 1  -- SQLite não tem BOOLEAN, usa INTEGER (0=falso, 1=verdadeiro)
);

-- Criação da tabela de Alunos
CREATE TABLE alunos (
    id_aluno INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_completo VARCHAR(150) NOT NULL,
    data_nascimento DATE NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    rg VARCHAR(20),
    email VARCHAR(100) UNIQUE,
    telefone VARCHAR(20),
    endereco VARCHAR(200),
    cidade VARCHAR(50),
    estado CHAR(2),
    cep VARCHAR(10),
    id_curso INTEGER,
    data_matricula DATE NOT NULL,
    periodo_ingresso VARCHAR(7),
    situacao VARCHAR(20) DEFAULT 'Ativo',
    FOREIGN KEY (id_curso) REFERENCES cursos(id_curso)
);

-- Criação da tabela de Professores
CREATE TABLE professores (
    id_professor INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_completo VARCHAR(150) NOT NULL,
    data_nascimento DATE NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    rg VARCHAR(20),
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(20),
    endereco VARCHAR(200),
    cidade VARCHAR(50),
    estado CHAR(2),
    cep VARCHAR(10),
    formacao VARCHAR(100) NOT NULL,
    especialidade VARCHAR(100),
    data_contratacao DATE NOT NULL,
    salario DECIMAL(10,2),
    carga_horaria INTEGER,
    ativo INTEGER DEFAULT 1
);

-- Criação da tabela de Disciplinas
CREATE TABLE disciplinas (
    id_disciplina INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_disciplina VARCHAR(100) NOT NULL,
    carga_horaria INTEGER NOT NULL,
    creditos INTEGER,
    ementa TEXT,
    id_curso INTEGER,
    semestre_ofertado INTEGER,
    ativo INTEGER DEFAULT 1,
    FOREIGN KEY (id_curso) REFERENCES cursos(id_curso)
);

-- Criação da tabela de Turmas
CREATE TABLE turmas (
    id_turma INTEGER PRIMARY KEY AUTOINCREMENT,
    codigo_turma VARCHAR(20) UNIQUE NOT NULL,
    id_disciplina INTEGER NOT NULL,
    id_professor INTEGER NOT NULL,
    semestre VARCHAR(7) NOT NULL,
    ano INTEGER NOT NULL,
    vagas INTEGER,
    horario VARCHAR(50),
    sala VARCHAR(20),
    data_inicio DATE,
    data_fim DATE,
    FOREIGN KEY (id_disciplina) REFERENCES disciplinas(id_disciplina),
    FOREIGN KEY (id_professor) REFERENCES professores(id_professor)
);

-- Criação da tabela de Matrículas em Disciplinas (alunos em turmas)
CREATE TABLE matriculas_disciplinas (
    id_matricula INTEGER PRIMARY KEY AUTOINCREMENT,
    id_aluno INTEGER NOT NULL,
    id_turma INTEGER NOT NULL,
    data_matricula DATE NOT NULL,
    status VARCHAR(20) DEFAULT 'Cursando',
    nota_final DECIMAL(4,2),
    frequencia DECIMAL(5,2),
    FOREIGN KEY (id_aluno) REFERENCES alunos(id_aluno),
    FOREIGN KEY (id_turma) REFERENCES turmas(id_turma),
    UNIQUE(id_aluno, id_turma)  -- SQLite usa UNIQUE(colunas) no lugar de UNIQUE KEY
);

-- Criação da tabela de Departamentos
CREATE TABLE departamentos (
    id_departamento INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_departamento VARCHAR(100) NOT NULL,
    sigla VARCHAR(10) UNIQUE NOT NULL,
    bloco VARCHAR(20),
    ramal VARCHAR(10),
    id_coordenador INTEGER,
    FOREIGN KEY (id_coordenador) REFERENCES professores(id_professor)
);

-- Criação da tabela de Associação Professores-Departamentos
CREATE TABLE professores_departamentos (
    id_professor INTEGER,
    id_departamento INTEGER,
    data_inicio DATE NOT NULL,
    data_fim DATE,
    PRIMARY KEY (id_professor, id_departamento),
    FOREIGN KEY (id_professor) REFERENCES professores(id_professor),
    FOREIGN KEY (id_departamento) REFERENCES departamentos(id_departamento)
);

-- Criação da tabela de Pré-requisitos entre Disciplinas
CREATE TABLE pre_requisitos (
    id_disciplina INTEGER,
    id_disciplina_requisito INTEGER,
    PRIMARY KEY (id_disciplina, id_disciplina_requisito),
    FOREIGN KEY (id_disciplina) REFERENCES disciplinas(id_disciplina),
    FOREIGN KEY (id_disciplina_requisito) REFERENCES disciplinas(id_disciplina)
);

-- Índices para melhor performance
CREATE INDEX idx_alunos_curso ON alunos(id_curso);
CREATE INDEX idx_alunos_situacao ON alunos(situacao);
CREATE INDEX idx_disciplinas_curso ON disciplinas(id_curso);
CREATE INDEX idx_turmas_semestre ON turmas(semestre);
CREATE INDEX idx_turmas_disciplina ON turmas(id_disciplina);
CREATE INDEX idx_turmas_professor ON turmas(id_professor);
CREATE INDEX idx_matriculas_aluno ON matriculas_disciplinas(id_aluno);
CREATE INDEX idx_matriculas_turma ON matriculas_disciplinas(id_turma);

-- No SQLite, para verificar as tabelas criadas:
-- .tables

-- Para ver a estrutura de uma tabela específica:
-- PRAGMA table_info(alunos);
