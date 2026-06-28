CREATE OR REPLACE PROCEDURE sp_canais_patrocinados_por_empresa(
    IN p_id_empresa INT,
    INOUT ref refcursor
)
LANGUAGE plpgsql
AS $$
BEGIN
    OPEN ref FOR
    SELECT
        e.nro AS id_empresa,
        e.nome AS nome_empresa,
        e.nome_fantasia,
        v.id_canal,
        v.canal,
        v.total_patrocinio
    FROM vw_receita_patrocinio v
    JOIN Patrocinio p
        ON v.id_canal = p.id_canal
    JOIN Empresa e
        ON p.nro_empresa = e.nro
    WHERE (p_id_empresa IS NULL OR e.nro = p_id_empresa)
    ORDER BY e.nome, v.canal;
END;
$$;
