-- Um comentario para cada video, alternando usuario e tipo online/offline.
WITH usuarios AS (
    SELECT
        nick,
        ROW_NUMBER() OVER (ORDER BY nick) AS rn
    FROM Usuario
)
INSERT INTO Comentario (id_video, nick_usuario, seq, texto, dataH, coment_on)
SELECT
    v.id_video,
    u.nick,
    1,
    'Comentario do video ' || v.id_video || ' - ' ||
    CASE (v.id_video % 5)
        WHEN 0 THEN 'Excelente video!'
        WHEN 1 THEN 'Muito bom, obrigado pelo conteudo!'
        WHEN 2 THEN 'Poderia fazer mais videos assim?'
        WHEN 3 THEN 'Compartilhei com meus amigos!'
        ELSE 'Primeira vez aqui, gostei muito!'
    END,
    v.dataH + INTERVAL '1 minute',
    (v.id_video % 2 = 0)
FROM Video v
JOIN usuarios u
    ON u.rn = ((v.id_video - 1) % 100) + 1
WHERE v.id_video <= 1000;
