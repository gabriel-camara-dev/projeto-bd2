CREATE OR REPLACE FUNCTION fn_top_canais_doacoes(p_limite INT DEFAULT 10)
RETURNS TABLE (
    id_canal INT,
    canal VARCHAR,
    qtd_doacoes BIGINT,
    total_doacoes NUMERIC
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        v.id_canal,
        v.canal,
        v.qtd_doacoes,
        v.total_doacoes
    FROM vw_doacoes_canal v
    ORDER BY v.total_doacoes DESC, v.canal
    LIMIT p_limite;
END;
$$ LANGUAGE plpgsql;
