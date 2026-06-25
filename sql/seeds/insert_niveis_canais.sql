-- Cada canal possui os cinco niveis de membro exigidos no enunciado.
INSERT INTO NivelCanal (id_canal, nivel, valor, gif)
SELECT
    c.id_canal,
    nivel.nivel,
    CASE nivel.nivel
        WHEN 1 THEN 4.99
        WHEN 2 THEN 9.99
        WHEN 3 THEN 19.99
        WHEN 4 THEN 49.99
        WHEN 5 THEN 99.99
    END,
    'https://cdn.example.com/level_' || nivel.nivel || '_' || c.id_canal || '.gif'
FROM Canal c
CROSS JOIN generate_series(1, 5) AS nivel(nivel)
ON CONFLICT (id_canal, nivel) DO NOTHING;
