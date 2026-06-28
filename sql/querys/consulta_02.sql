CREATE OR REPLACE PROCEDURE sp_gasto_mensal_membros(
    IN p_nick_membro VARCHAR(50),
    INOUT ref refcursor
)
LANGUAGE plpgsql
AS $$
BEGIN
    OPEN ref FOR
    SELECT
        i.nick_membro,
        COUNT(i.id_canal)::BIGINT AS total_canais,
        COALESCE(SUM(n.valor), 0)::DECIMAL(12, 2) AS valor_gasto_por_mes
    FROM Inscricao i
    INNER JOIN NivelCanal n
        ON i.id_canal = n.id_canal
        AND i.nivel = n.nivel
    WHERE (p_nick_membro IS NULL OR i.nick_membro = p_nick_membro)
    GROUP BY i.nick_membro;
END;
$$;
