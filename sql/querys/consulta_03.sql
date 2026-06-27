CREATE OR REPLACE FUNCTION fn_canais_doacoes(p_canal INT DEFAULT NULL)
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
    WHERE (p_canal IS NULL OR v.id_canal = p_canal)
    ORDER BY v.total_doacoes DESC, v.canal;
END;
$$ LANGUAGE plpgsql;