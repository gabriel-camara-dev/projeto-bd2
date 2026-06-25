-- Dois membros por canal nos 100 primeiros canais, sem inscrever o dono do canal.
WITH usuarios AS (
    SELECT
        nick,
        ROW_NUMBER() OVER (ORDER BY nick) AS rn
    FROM Usuario
),
canais AS (
    SELECT id_canal, nick_streamer
    FROM Canal
    ORDER BY id_canal
    LIMIT 100
)
INSERT INTO Inscricao (id_canal, nick_membro, nivel)
SELECT
    c.id_canal,
    u.nick,
    ((c.id_canal + u.rn) % 5) + 1
FROM canais c
CROSS JOIN LATERAL (
    SELECT nick, rn
    FROM usuarios
    WHERE nick <> c.nick_streamer
    ORDER BY ((rn + c.id_canal) % 100)
    LIMIT 2
) u
ON CONFLICT (id_canal, nick_membro) DO NOTHING;

-- Um patrocinador para os 150 primeiros canais.
INSERT INTO Patrocinio (nro_empresa, id_canal, valor)
SELECT
    ((c.rn - 1) % 103) + 1,
    c.id_canal,
    1000 + (c.rn * 300)
FROM (
    SELECT
        id_canal,
        ROW_NUMBER() OVER (ORDER BY id_canal) AS rn
    FROM Canal
    ORDER BY id_canal
    LIMIT 150
) c
ON CONFLICT (nro_empresa, id_canal) DO NOTHING;
