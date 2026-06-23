DROP TABLE IF EXISTS MecanismoPlat CASCADE;
DROP TABLE IF EXISTS CartaoCredito CASCADE;
DROP TABLE IF EXISTS PayPal CASCADE;
DROP TABLE IF EXISTS BitCoin CASCADE;
DROP TABLE IF EXISTS Doacao CASCADE;
DROP TABLE IF EXISTS Comentario CASCADE;
DROP TABLE IF EXISTS Participa CASCADE;
DROP TABLE IF EXISTS Video CASCADE;
DROP TABLE IF EXISTS Inscricao CASCADE;
DROP TABLE IF EXISTS NivelCanal CASCADE;
DROP TABLE IF EXISTS Patrocinio CASCADE;
DROP TABLE IF EXISTS Canal CASCADE;
DROP TABLE IF EXISTS EmpresaPais CASCADE;
DROP TABLE IF EXISTS StreamerPais CASCADE;
DROP TABLE IF EXISTS PlataformaUsuario CASCADE;
DROP TABLE IF EXISTS Usuario CASCADE;
DROP TABLE IF EXISTS Pais CASCADE;
DROP TABLE IF EXISTS Conversao CASCADE;
DROP TABLE IF EXISTS Plataforma CASCADE;
DROP TABLE IF EXISTS Empresa CASCADE;

CREATE TABLE Conversao (
    moeda VARCHAR(10) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    fator_conver DECIMAL(10, 4) NOT NULL
);

CREATE TABLE Empresa (
    nro INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    nome_fantasia VARCHAR(150) NOT NULL
);

CREATE TABLE Pais (
    DDI INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    moeda VARCHAR(10) NOT NULL,
    CONSTRAINT fk_pais_moeda FOREIGN KEY (moeda) REFERENCES Conversao(moeda) ON DELETE RESTRICT
);

CREATE TABLE Usuario (
    nick VARCHAR(50) PRIMARY KEY,
    email VARCHAR(150) NOT NULL UNIQUE,
    data_nasc DATE NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    end_postal TEXT NOT NULL,
    pais_residencia INT NOT NULL,
    CONSTRAINT fk_usuario_pais FOREIGN KEY (pais_residencia) REFERENCES Pais(DDI) ON DELETE RESTRICT
);

CREATE TABLE Plataforma (
    nro INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    qtd_users INT DEFAULT 0 NOT NULL,
    empresa_fund INT NOT NULL,
    empresa_respo INT NOT NULL,
    data_fund DATE NOT NULL,
    CONSTRAINT fk_plataforma_fundadora FOREIGN KEY (empresa_fund) REFERENCES Empresa(nro) ON DELETE RESTRICT,
    CONSTRAINT fk_plataforma_responsavel FOREIGN KEY (empresa_respo) REFERENCES Empresa(nro) ON DELETE RESTRICT
);

CREATE TABLE PlataformaUsuario (
    nro_plataforma INT NOT NULL,
    nick_usuario VARCHAR(50) NOT NULL,
    nro_usuario INT NOT NULL,
    PRIMARY KEY (nro_plataforma, nick_usuario),
    CONSTRAINT uk_plataforma_nro_user UNIQUE (nro_plataforma, nro_usuario),
    CONSTRAINT fk_plat_user_plataforma FOREIGN KEY (nro_plataforma) REFERENCES Plataforma(nro) ON DELETE CASCADE,
    CONSTRAINT fk_plat_user_usuario FOREIGN KEY (nick_usuario) REFERENCES Usuario(nick) ON DELETE CASCADE
);

CREATE TABLE StreamerPais (
    nick_streamer VARCHAR(50) NOT NULL,
    ddi_pais INT NOT NULL,
    nro_passaporte VARCHAR(50) NOT NULL,
    PRIMARY KEY (nick_streamer, ddi_pais),
    CONSTRAINT uk_passaporte_por_pais UNIQUE (ddi_pais, nro_passaporte),
    CONSTRAINT fk_streamer_pais_usuario FOREIGN KEY (nick_streamer) REFERENCES Usuario(nick) ON DELETE CASCADE,
    CONSTRAINT fk_streamer_pais_pais FOREIGN KEY (ddi_pais) REFERENCES Pais(DDI) ON DELETE RESTRICT
);

CREATE TABLE EmpresaPais (
    nro_empresa INT NOT NULL,
    ddi_pais INT NOT NULL,
    id_nacional VARCHAR(50) NOT NULL,
    PRIMARY KEY (nro_empresa, ddi_pais),
    CONSTRAINT uk_id_nacional_por_pais UNIQUE (ddi_pais, id_nacional),
    CONSTRAINT fk_empresa_pais_empresa FOREIGN KEY (nro_empresa) REFERENCES Empresa(nro) ON DELETE CASCADE,
    CONSTRAINT fk_empresa_pais_pais FOREIGN KEY (ddi_pais) REFERENCES Pais(DDI) ON DELETE RESTRICT
);

-- qtd_videos não está listada no relacional, mas está no enunciado
CREATE TABLE Canal (
    id_canal INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    nro_plataforma INT NOT NULL,
    tipo VARCHAR(10) NOT NULL CHECK (tipo IN ('privado', 'público', 'misto')),
    data_inicio DATE NOT NULL,
    descricao TEXT,
    qtd_visualizacoes INT DEFAULT 0 NOT NULL,
    nick_streamer VARCHAR(50) NOT NULL,
    qtd_videos INT DEFAULT 0 NOT NULL,
    CONSTRAINT uk_canal_plataforma UNIQUE (nome, nro_plataforma),
    CONSTRAINT fk_canal_plataforma FOREIGN KEY (nro_plataforma) REFERENCES Plataforma(nro) ON DELETE RESTRICT,
    CONSTRAINT fk_canal_streamer FOREIGN KEY (nick_streamer) REFERENCES Usuario(nick) ON DELETE RESTRICT
);

CREATE TABLE Patrocinio (
    nro_empresa INT NOT NULL,
    id_canal INT NOT NULL,
    valor DECIMAL(12, 2) NOT NULL,
    PRIMARY KEY (nro_empresa, id_canal),
    CONSTRAINT fk_patrocinio_empresa FOREIGN KEY (nro_empresa) REFERENCES Empresa(nro) ON DELETE CASCADE,
    CONSTRAINT fk_patrocinio_canal FOREIGN KEY (id_canal) REFERENCES Canal(id_canal) ON DELETE CASCADE
);

CREATE TABLE NivelCanal (
    id_canal INT NOT NULL,
    nivel INT NOT NULL CHECK (nivel BETWEEN 1 AND 5),
    valor DECIMAL(10, 2) NOT NULL,
    gif VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_canal, nivel),
    CONSTRAINT fk_nivel_canal FOREIGN KEY (id_canal) REFERENCES Canal(id_canal) ON DELETE CASCADE
);

CREATE TABLE Inscricao (
    id_canal INT NOT NULL,
    nick_membro VARCHAR(50) NOT NULL,
    nivel INT NOT NULL,
    PRIMARY KEY (id_canal, nick_membro),
    CONSTRAINT fk_inscricao_usuario FOREIGN KEY (nick_membro) REFERENCES Usuario(nick) ON DELETE CASCADE,
    CONSTRAINT fk_inscricao_nivel FOREIGN KEY (id_canal, nivel) REFERENCES NivelCanal(id_canal, nivel) ON DELETE RESTRICT
);

CREATE TABLE Video (
    id_video INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_canal INT NOT NULL,
    titulo VARCHAR(200) NOT NULL,
    dataH TIMESTAMP NOT NULL,
    tema VARCHAR(100) NOT NULL,
    duracao INTERVAL NOT NULL,
    visu_simul INT DEFAULT 0 NOT NULL,
    visu_total INT DEFAULT 0 NOT NULL,
    CONSTRAINT uk_video_canal_evento UNIQUE (id_canal, titulo, dataH),
    CONSTRAINT fk_video_canal FOREIGN KEY (id_canal) REFERENCES Canal(id_canal) ON DELETE CASCADE
);

CREATE TABLE Participa (
    id_video INT NOT NULL,
    nick_streamer VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_video, nick_streamer),
    CONSTRAINT fk_participa_video FOREIGN KEY (id_video) REFERENCES Video(id_video) ON DELETE CASCADE,
    CONSTRAINT fk_participa_streamer FOREIGN KEY (nick_streamer) REFERENCES Usuario(nick) ON DELETE CASCADE
);

CREATE TABLE Comentario (
    id_comentario INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_video INT NOT NULL,
    nick_usuario VARCHAR(50) NOT NULL,
    seq INT NOT NULL,
    texto TEXT NOT NULL,
    dataH TIMESTAMP NOT NULL,
    coment_on BOOLEAN NOT NULL,
    CONSTRAINT uk_comentario_video_seq UNIQUE (id_video, nick_usuario, seq),
    CONSTRAINT fk_comentario_video FOREIGN KEY (id_video) REFERENCES Video(id_video) ON DELETE CASCADE,
    CONSTRAINT fk_comentario_usuario FOREIGN KEY (nick_usuario) REFERENCES Usuario(nick) ON DELETE CASCADE
);

CREATE TABLE Doacao (
    id_doacao INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_comentario INT NOT NULL UNIQUE,
    seq_pg INT NOT NULL,
    valor DECIMAL(10, 2) NOT NULL,
    status VARCHAR(15) NOT NULL CHECK (status IN ('recusado', 'recebido', 'lido')),
    CONSTRAINT fk_doacao_comentario FOREIGN KEY (id_comentario) REFERENCES Comentario(id_comentario) ON DELETE CASCADE
);

CREATE TABLE BitCoin (
    id_doacao INT PRIMARY KEY,
    TxID VARCHAR(64) NOT NULL UNIQUE,
    CONSTRAINT fk_bitcoin_doacao FOREIGN KEY (id_doacao) REFERENCES Doacao(id_doacao) ON DELETE CASCADE
);

CREATE TABLE PayPal (
    id_doacao INT PRIMARY KEY,
    IdPayPal VARCHAR(100) NOT NULL UNIQUE,
    CONSTRAINT fk_paypal_doacao FOREIGN KEY (id_doacao) REFERENCES Doacao(id_doacao) ON DELETE CASCADE
);

CREATE TABLE CartaoCredito (
    id_doacao INT PRIMARY KEY,
    nro VARCHAR(19) NOT NULL,
    bandeira VARCHAR(50) NOT NULL,
    dataH TIMESTAMP NOT NULL,
    CONSTRAINT fk_cartao_doacao FOREIGN KEY (id_doacao) REFERENCES Doacao(id_doacao) ON DELETE CASCADE
);

CREATE TABLE MecanismoPlat (
    id_doacao INT PRIMARY KEY,
    seq_plataforma INT NOT NULL,
    CONSTRAINT fk_mecanismo_doacao FOREIGN KEY (id_doacao) REFERENCES Doacao(id_doacao) ON DELETE CASCADE
);