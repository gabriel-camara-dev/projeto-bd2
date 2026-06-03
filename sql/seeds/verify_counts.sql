SELECT 'Conversao' as tabela, COUNT(*) as total FROM Conversao UNION ALL
SELECT 'Pais', COUNT(*) FROM Pais UNION ALL
SELECT 'Empresa', COUNT(*) FROM Empresa UNION ALL
SELECT 'Usuario', COUNT(*) FROM Usuario UNION ALL
SELECT 'Plataforma', COUNT(*) FROM Plataforma UNION ALL
SELECT 'StreamerPais', COUNT(*) FROM StreamerPais UNION ALL
SELECT 'EmpresaPais', COUNT(*) FROM EmpresaPais UNION ALL
SELECT 'PlataformaUsuario', COUNT(*) FROM PlataformaUsuario UNION ALL
SELECT 'Canal', COUNT(*) FROM Canal UNION ALL
SELECT 'NivelCanal', COUNT(*) FROM NivelCanal UNION ALL
SELECT 'Inscricao', COUNT(*) FROM Inscricao UNION ALL
SELECT 'Patrocinio', COUNT(*) FROM Patrocinio UNION ALL
SELECT 'Video', COUNT(*) FROM Video UNION ALL
SELECT 'Participa', COUNT(*) FROM Participa UNION ALL
SELECT 'Comentario', COUNT(*) FROM Comentario UNION ALL
SELECT 'Doacao', COUNT(*) FROM Doacao UNION ALL
SELECT 'BitCoin', COUNT(*) FROM BitCoin UNION ALL
SELECT 'PayPal', COUNT(*) FROM PayPal UNION ALL
SELECT 'CartaoCredito', COUNT(*) FROM CartaoCredito UNION ALL
SELECT 'MecanismoPlat', COUNT(*) FROM MecanismoPlat
ORDER BY tabela;