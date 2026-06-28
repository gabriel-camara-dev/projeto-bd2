CREATE OR REPLACE PROCEDURE sp_canais_doacoes(
    IN p_canal INT,
    INOUT ref refcursor
)
LANGUAGE plpgsql
AS $$
BEGIN
    OPEN ref FOR
    SELECT
        v.id_canal,
        v.canal,
        v.qtd_doacoes,
        v.total_doacoes
    FROM vw_doacoes_canal v
    WHERE (p_canal IS NULL OR v.id_canal = p_canal)
    ORDER BY v.total_doacoes DESC, v.canal;
END;
$$;
