UPDATE Canal c
SET qtd_videos = (
    SELECT COUNT(*)
    FROM Video v
    WHERE v.id_canal = c.id_canal
);

UPDATE Canal c
SET qtd_visualizacoes = (
    SELECT COALESCE(SUM(v.visu_total), 0)
    FROM Video v
    WHERE v.id_canal = c.id_canal
);