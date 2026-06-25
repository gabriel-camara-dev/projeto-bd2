CREATE OR REPLACE FUNCTION fn_top_canais_patrocinio(p_limite INT DEFAULT 10)
RETURNS TABLE (
    id_canal INT,
    canal VARCHAR,
    total_patrocinio NUMERIC
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        v.id_canal,
        v.canal,
        v.total_patrocinio
    FROM vw_receita_patrocinio v
    ORDER BY v.total_patrocinio DESC, v.canal
    LIMIT p_limite;
END;
$$ LANGUAGE plpgsql;
