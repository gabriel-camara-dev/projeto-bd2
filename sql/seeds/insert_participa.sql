-- Adiciona um streamer convidado aos 500 primeiros videos.
INSERT INTO Participa (id_video, nick_streamer)
SELECT
    v.id_video,
    s.nick_streamer
FROM Video v
JOIN Canal c
    ON c.id_canal = v.id_canal
CROSS JOIN LATERAL (
    SELECT nick_streamer
    FROM (
        SELECT DISTINCT nick_streamer
        FROM StreamerPais
    ) streamers
    WHERE nick_streamer <> c.nick_streamer
    ORDER BY nick_streamer
    LIMIT 1
) s
WHERE v.id_video <= 500
ON CONFLICT (id_video, nick_streamer) DO NOTHING;
