INSERT INTO Comentario (id_video, nick_usuario, seq, texto, dataH, coment_on)
SELECT
    v.id_video,
    u.nick,
    seq,
    'Comentário #' || seq || ' - ' || 
    CASE (seq % 5)
        WHEN 0 THEN 'Excelente vídeo! Parabéns!'
        WHEN 1 THEN 'Muito bom, obrigado pelo conteúdo!'
        WHEN 2 THEN 'Poderia fazer mais vídeos assim?'
        WHEN 3 THEN 'Compartilhei com meus amigos!'
        ELSE 'Primeira vez aqui, gostei muito!'
    END,
    v.dataH + (seq * INTERVAL '1 minute'),
    CASE WHEN seq % 2 = 0 THEN TRUE ELSE FALSE END
FROM Video v
CROSS JOIN LATERAL (
    SELECT nick FROM Usuario ORDER BY RANDOM() LIMIT 1
) u
CROSS JOIN generate_series(1, 1) as seq
WHERE v.id_video <= 1000
LIMIT 1000;