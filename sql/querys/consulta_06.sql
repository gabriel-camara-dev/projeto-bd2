CREATE OR REPLACE FUNCTION fn_top_canais_membros(p_limite INT DEFAULT 10)
RETURNS TABLE (
    id_canal INT,
    canal VARCHAR,
    qtd_membros BIGINT,
    receita_mensal NUMERIC
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        v.id_canal,
        v.canal,
        v.qtd_membros,
        v.receita_mensal
    FROM vw_receita_membros v
    ORDER BY v.receita_mensal DESC, v.canal
    LIMIT p_limite;
END;
$$ LANGUAGE plpgsql;
