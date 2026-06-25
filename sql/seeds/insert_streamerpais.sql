-- Define 64 usuarios como streamers, usando o pais de residencia como pais do passaporte.
INSERT INTO StreamerPais (nick_streamer, ddi_pais, nro_passaporte)
SELECT
    u.nick,
    u.pais_residencia,
    'PASS_' || LPAD(u.rn::TEXT, 4, '0')
FROM (
    SELECT
        nick,
        pais_residencia,
        ROW_NUMBER() OVER (ORDER BY nick) AS rn
    FROM Usuario
    ORDER BY nick
    LIMIT 64
) u;

-- Alguns streamers possuem segundo passaporte para completar 100 linhas.
INSERT INTO StreamerPais (nick_streamer, ddi_pais, nro_passaporte)
SELECT
    s.nick_streamer,
    CASE WHEN s.ddi_pais = 1 THEN 55 ELSE 1 END,
    'PASS_EXTRA_' || LPAD(s.rn::TEXT, 4, '0')
FROM (
    SELECT
        nick_streamer,
        ddi_pais,
        ROW_NUMBER() OVER (ORDER BY nick_streamer) AS rn
    FROM StreamerPais
    ORDER BY nick_streamer
    LIMIT 36
) s;
