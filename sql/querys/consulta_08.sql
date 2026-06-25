CREATE OR REPLACE FUNCTION fn_top_canais_faturamento(p_limite INT DEFAULT 10)
RETURNS TABLE (
    id_canal INT,
    canal VARCHAR,
    patrocinio NUMERIC,
    membros NUMERIC,
    doacoes NUMERIC,
    faturamento_total NUMERIC
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        mv.id_canal,
        mv.nome,
        mv.patrocinio,
        mv.membros,
        mv.doacoes,
        mv.faturamento_total
    FROM mv_faturamento_total_canal mv
    ORDER BY mv.faturamento_total DESC, mv.nome
    LIMIT p_limite;
END;
$$ LANGUAGE plpgsql;
