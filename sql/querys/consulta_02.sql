CREATE OR REPLACE FUNCTION GastoMensalMembros (
    p_nick_membro VARCHAR(50) DEFAULT NULL
) 
RETURNS TABLE (
    nick_membro VARCHAR(50),
    total_canais BIGINT,
    valor_gasto_por_mes DECIMAL(12, 2)
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        I.nick_membro,
        COUNT(I.id_canal)::BIGINT AS total_canais,
        COALESCE(SUM(N.valor), 0)::DECIMAL(12, 2) AS valor_gasto_por_mes
    FROM Inscricao I
    INNER JOIN NivelCanal N ON I.id_canal = N.id_canal AND I.nivel = N.nivel
    WHERE (p_nick_membro IS NULL OR I.nick_membro = p_nick_membro)
    GROUP BY I.nick_membro;
END;
$$ LANGUAGE plpgsql;