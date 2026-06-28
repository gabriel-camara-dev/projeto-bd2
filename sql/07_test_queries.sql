-- Consultas 1 a 8 do trabalho

-- Consulta 1: canais patrocinados por empresa.
SELECT * FROM fn_canais_patrocinados_por_empresa(NULL) LIMIT 10;

-- Consulta 2: gasto mensal dos membros com inscrições.
SELECT * FROM GastoMensalMembros(NULL) LIMIT 10;

-- Consulta 3: canais com doações recebidas.
SELECT * FROM fn_canais_doacoes(NULL) LIMIT 10;

-- Consulta 4: doações lidas por vídeo, usando procedure com cursor.
BEGIN;
CALL sp_doacoes_video(NULL, 'cur_doacoes_video');
FETCH 10 FROM cur_doacoes_video;
COMMIT;

-- Consulta 5: canais com maior receita de patrocínio.
SELECT * FROM fn_top_canais_patrocinio(10);

-- Consulta 6: canais com maior receita de membros.
SELECT * FROM fn_top_canais_membros(10);

-- Consulta 7: canais com maior receita de doações.
SELECT * FROM fn_top_canais_doacoes(10);

-- Consulta 8: canais com maior faturamento total.
SELECT * FROM fn_top_canais_faturamento(10);
