DROP MATERIALIZED VIEW IF EXISTS mv_faturamento_total_canal CASCADE;

DROP VIEW IF EXISTS vw_doacoes_video CASCADE;
DROP VIEW IF EXISTS vw_doacoes_canal CASCADE;
DROP VIEW IF EXISTS vw_receita_membros CASCADE;
DROP VIEW IF EXISTS vw_receita_patrocinio CASCADE;

/*
View 1: Receita de Patrocínios por Canal

Justificativa:
Esta visão pré-agrega os valores de patrocínio recebidos por cada canal.
Sem ela, consultas como canais patrocinados, que mais recebem patrocínio, e faturamento total, precisariam executar JOINs e agregações repetidamente.
A visão reduz a complexidade das consultas e melhora a legibilidade das stored procedures.
*/

CREATE VIEW vw_receita_patrocinio AS
SELECT
    c.id_canal,
    c.nome AS canal,
    SUM(p.valor) AS total_patrocinio
FROM Canal c
JOIN Patrocinio p
    ON c.id_canal = p.id_canal
GROUP BY c.id_canal, c.nome;


/*
View 2: Receita de Membros por Canal

Justificativa:
As consultas 2, 6 e 8 utilizam informações de inscrições. O cálculo do valor arrecadado exige JOIN entre Canal, Inscricao, e NivelCanal. A visão concentra esse cálculo em um único objeto reutilizável, evitando processamento repetido.
*/

CREATE VIEW vw_receita_membros AS
SELECT
    c.id_canal,
    c.nome AS canal,
    COUNT(i.nick_membro) AS qtd_membros,
    SUM(nc.valor) AS receita_mensal
FROM Canal c
JOIN Inscricao i
    ON c.id_canal = i.id_canal
JOIN NivelCanal nc
    ON i.id_canal = nc.id_canal
    AND i.nivel = nc.nivel
GROUP BY c.id_canal, c.nome;


/*
View 3: Total de Doações por Canal

Justificativa:
A obtenção das doações envolve uma cadeia longa de relacionamentos (Canal -> Video -> Comentario -> Doacao) e aparece diretamente nas consultas 3, 4, 7 e 8. A visão evita a repetição desses JOINs e melhora o desempenho de buscas relacionadas a arrecadação por doações.
*/

CREATE VIEW vw_doacoes_canal AS
SELECT
    c.id_canal,
    c.nome AS canal,
    COUNT(d.id_doacao) AS qtd_doacoes,
    SUM(d.valor) AS total_doacoes
FROM Canal c
JOIN Video v
    ON c.id_canal = v.id_canal
JOIN Comentario co
    ON v.id_video = co.id_video
JOIN Doacao d
    ON co.id_comentario = d.id_comentario
WHERE d.status IN ('recebido', 'lido')
GROUP BY c.id_canal, c.nome;


/*
View 4: Doações por Vídeo

Justificativa:
A consulta número 4 pede a soma das doações geradas pelos comentários que foram lidos em cada vídeo. Como essa informação exige JOIN entre Video, Comentario e Doacao, além da filtragem das doações com status 'lido', a visão centraliza essa agregação em um único objeto reutilizável. Dessa forma, evita-se repetir os mesmos JOINs e cálculos em consultas futuras, tornando as stored procedures mais simples e fáceis de manter.
*/

CREATE VIEW vw_doacoes_video AS
SELECT
    v.id_video,
    v.titulo,
    SUM(d.valor) AS total_doacoes,
    COUNT(d.id_doacao) AS qtd_doacoes
FROM Video v
JOIN Comentario c
    ON v.id_video = c.id_video
JOIN Doacao d
    ON c.id_comentario = d.id_comentario
WHERE d.status = 'lido'
GROUP BY v.id_video, v.titulo;


/*
View 5: Faturamento Total dos Canais

Justificativa:
A consulta número 8 pede para listar os canais que mais faturam considerando patrocínio, membros inscritos e doações. Sem essa visão seria necessário repetir três agregações diferentes e diversos JOINs. A visão centraliza todas as fontes de receita em uma única estrutura, reduzindo a complexidade e aumentando a reutilização da lógica de negócio.
*/

CREATE MATERIALIZED VIEW mv_faturamento_total_canal AS
SELECT
    c.id_canal,
    c.nome,

    COALESCE(p.total_patrocinio, 0) AS patrocinio,
    COALESCE(m.receita_mensal, 0) AS membros,
    COALESCE(d.total_doacoes, 0) AS doacoes,

    COALESCE(p.total_patrocinio, 0)
    + COALESCE(m.receita_mensal, 0)
    + COALESCE(d.total_doacoes, 0)
    AS faturamento_total

FROM Canal c
LEFT JOIN vw_receita_patrocinio p
    ON c.id_canal = p.id_canal
LEFT JOIN vw_receita_membros m
    ON c.id_canal = m.id_canal
LEFT JOIN vw_doacoes_canal d
    ON c.id_canal = d.id_canal;