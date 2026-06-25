-- Dez videos para cada um dos 100 primeiros canais.
INSERT INTO Video (id_canal, titulo, dataH, tema, duracao, visu_simul, visu_total)
SELECT
    c.id_canal,
    'Video_' || seq || '_' || LEFT(c.nome, 20),
    TIMESTAMP '2024-01-01 12:00:00' + (c.id_canal * INTERVAL '1 day') + (seq * INTERVAL '1 hour'),
    CASE (seq % 10)
        WHEN 0 THEN 'Gameplay'
        WHEN 1 THEN 'Tutorial'
        WHEN 2 THEN 'Review'
        WHEN 3 THEN 'Live Gameplay'
        WHEN 4 THEN 'Speedrun'
        WHEN 5 THEN 'Walkthrough'
        WHEN 6 THEN 'Multiplayer'
        WHEN 7 THEN 'Competitive'
        WHEN 8 THEN 'Casual'
        ELSE 'Highlights'
    END,
    INTERVAL '30 minutes' + (seq * INTERVAL '10 minutes'),
    1000 + (c.id_canal * 10) + seq,
    10000 + (c.id_canal * 100) + (seq * 1000)
FROM Canal c
CROSS JOIN generate_series(1, 10) AS seq
WHERE c.id_canal <= 100;
