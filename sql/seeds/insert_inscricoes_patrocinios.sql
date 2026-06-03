INSERT INTO Inscricao (id_canal, nick_membro, nivel)
SELECT DISTINCT
    c.id_canal,
    u.nick,
    (floor(random() * 5) + 1)::int
FROM Canal c
CROSS JOIN LATERAL (
    SELECT nick FROM Usuario 
    WHERE nick != c.nick_streamer 
    ORDER BY random() 
    LIMIT 2
) u
LIMIT 200
ON CONFLICT (id_canal, nick_membro) DO NOTHING;

INSERT INTO Patrocinio (nro_empresa, id_canal, valor)
SELECT DISTINCT
    e.nro,
    c.id_canal,
    (floor(random() * 50000) + 1000)::int
FROM Canal c
CROSS JOIN LATERAL (
    SELECT nro FROM Empresa ORDER BY random() LIMIT 1
) e
LIMIT 150
ON CONFLICT (nro_empresa, id_canal) DO NOTHING;