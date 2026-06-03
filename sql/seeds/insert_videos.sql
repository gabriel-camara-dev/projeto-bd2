INSERT INTO Video (id_canal, titulo, dataH, tema, duracao, visu_simul, visu_total)
SELECT
    c.id_canal,
    'Video_' || seq || '_' || LEFT(c.nome, 20),
    CURRENT_TIMESTAMP - (seq * INTERVAL '1 hour') - (CAST(FLOOR(RANDOM() * 30) AS INT) * INTERVAL '1 day'),
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
    INTERVAL '1 hour' * (CAST(FLOOR(RANDOM() * 3 + 0.5) AS INT)) + 
    INTERVAL '30 minutes' * CAST(FLOOR(RANDOM() * 2) AS INT),
    CAST(FLOOR(RANDOM() * 50000) AS INT),
    CAST(FLOOR(RANDOM() * 1000000) AS INT)
FROM Canal c
CROSS JOIN generate_series(1, 10) as seq
WHERE c.id_canal <= 100;