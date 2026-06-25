-- Recalcula os totais derivados dos canais depois da carga dos videos.
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

-- Atualiza a materialized view que depende das receitas carregadas.
REFRESH MATERIALIZED VIEW mv_faturamento_total_canal;
