INSERT INTO Participa (id_video, nick_streamer)
SELECT DISTINCT
    v.id_video,
    s.nick_streamer
FROM Video v
CROSS JOIN LATERAL (
    SELECT nick_streamer FROM StreamerPais 
    WHERE nick_streamer != (SELECT nick_streamer FROM Canal WHERE id_canal = v.id_canal)
    ORDER BY RANDOM() 
    LIMIT 1
) s
WHERE v.id_video <= 1000
LIMIT 500
ON CONFLICT (id_video, nick_streamer) DO NOTHING;