CREATE OR REPLACE PROCEDURE sp_doacoes_video(
    IN p_video INT,
    INOUT ref refcursor
)
LANGUAGE plpgsql
AS $$
BEGIN
    OPEN ref FOR
    SELECT
        v.id_video,
        v.titulo,
        v.qtd_doacoes,
        v.total_doacoes
    FROM vw_doacoes_video v
    WHERE (p_video IS NULL OR v.id_video = p_video)
    ORDER BY v.total_doacoes DESC NULLS LAST, v.titulo;
END;
$$;