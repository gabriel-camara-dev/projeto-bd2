INSERT INTO Canal (nome, nro_plataforma, tipo, data_inicio, descricao, qtd_visualizacoes, nick_streamer, qtd_videos)
SELECT
    'Canal_' || s.nick_streamer || '_' || seq,
    p.nro,
    CASE (seq % 3)
        WHEN 0 THEN 'privado'
        WHEN 1 THEN 'público'
        ELSE 'misto'
    END,
    CURRENT_DATE - (seq * INTERVAL '30 days'),
    'Descricao do canal de ' || s.nick_streamer || ' - focado em gaming e entretenimento',
    CAST(FLOOR(RANDOM() * 10000000) AS INT),
    s.nick_streamer,
    CAST(FLOOR(RANDOM() * 500) AS INT)
FROM (
    SELECT nick_streamer, ROW_NUMBER() OVER (ORDER BY nick_streamer) as rn
    FROM StreamerPais
    LIMIT 20
) s
CROSS JOIN generate_series(1, 5) as seq
CROSS JOIN LATERAL (
    SELECT nro FROM Plataforma ORDER BY RANDOM() LIMIT 1
) p
WHERE s.rn <= 20
UNION ALL
SELECT
    'Canal_' || u.nick || '_' || seq,
    p.nro,
    CASE (seq % 3)
        WHEN 0 THEN 'privado'
        WHEN 1 THEN 'público'
        ELSE 'misto'
    END,
    CURRENT_DATE - (seq * INTERVAL '45 days'),
    'Descricao do canal de ' || u.nick || ' - variedades e lifestyle',
    CAST(FLOOR(RANDOM() * 5000000) AS INT),
    u.nick,
    CAST(FLOOR(RANDOM() * 300) AS INT)
FROM (
    SELECT nick, ROW_NUMBER() OVER (ORDER BY nick) as rn
    FROM Usuario
    WHERE nick NOT IN (SELECT nick_streamer FROM StreamerPais)
    LIMIT 30
) u
CROSS JOIN generate_series(1, 3) as seq
CROSS JOIN LATERAL (
    SELECT nro FROM Plataforma ORDER BY RANDOM() LIMIT 1
) p
WHERE u.rn <= 30;