-- Cria 5 canais para os 20 primeiros streamers.
INSERT INTO Canal (nome, nro_plataforma, tipo, data_inicio, descricao, qtd_visualizacoes, nick_streamer, qtd_videos)
SELECT
    'Canal_' || s.nick_streamer || '_' || seq,
    ((s.rn + seq - 2) % 104) + 1,
    CASE (seq % 3)
        WHEN 0 THEN 'privado'
        WHEN 1 THEN U&'p\00FAblico'
        ELSE 'misto'
    END,
    CURRENT_DATE - (seq * INTERVAL '30 days'),
    'Descricao do canal de ' || s.nick_streamer || ' - focado em gaming e entretenimento',
    0,
    s.nick_streamer,
    0
FROM (
    SELECT
        nick_streamer,
        ROW_NUMBER() OVER (ORDER BY nick_streamer) AS rn
    FROM (
        SELECT DISTINCT nick_streamer
        FROM StreamerPais
    ) streamers
    ORDER BY nick_streamer
    LIMIT 20
) s
CROSS JOIN generate_series(1, 5) AS seq;

-- Cria 3 canais para 30 usuarios que nao foram marcados como streamers.
INSERT INTO Canal (nome, nro_plataforma, tipo, data_inicio, descricao, qtd_visualizacoes, nick_streamer, qtd_videos)
SELECT
    'Canal_' || u.nick || '_' || seq,
    ((u.rn + seq + 20) % 104) + 1,
    CASE (seq % 3)
        WHEN 0 THEN 'privado'
        WHEN 1 THEN U&'p\00FAblico'
        ELSE 'misto'
    END,
    CURRENT_DATE - (seq * INTERVAL '45 days'),
    'Descricao do canal de ' || u.nick || ' - variedades e lifestyle',
    0,
    u.nick,
    0
FROM (
    SELECT
        nick,
        ROW_NUMBER() OVER (ORDER BY nick) AS rn
    FROM Usuario
    WHERE nick NOT IN (
        SELECT nick_streamer
        FROM StreamerPais
    )
    ORDER BY nick
    LIMIT 30
) u
CROSS JOIN generate_series(1, 3) AS seq;
