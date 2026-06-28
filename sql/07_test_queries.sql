-- Consultas 1 a 8 do trabalho

-- Consulta 1: canais patrocinados por empresa.
BEGIN;
CALL sp_canais_patrocinados_por_empresa(NULL, 'cur_canais_patrocinados');
FETCH 10 FROM cur_canais_patrocinados;
COMMIT;

-- Consulta 2: gasto mensal dos membros com inscricoes.
BEGIN;
CALL sp_gasto_mensal_membros(NULL, 'cur_gasto_membros');
FETCH 10 FROM cur_gasto_membros;
COMMIT;

-- Consulta 3: canais com doacoes recebidas.
BEGIN;
CALL sp_canais_doacoes(NULL, 'cur_canais_doacoes');
FETCH 10 FROM cur_canais_doacoes;
COMMIT;

-- Consulta 4: doacoes lidas por video, usando procedure com cursor.
BEGIN;
CALL sp_doacoes_video(NULL, 'cur_doacoes_video');
FETCH 10 FROM cur_doacoes_video;
COMMIT;

-- Consulta 5: canais com maior receita de patrocinio.
SELECT * FROM fn_top_canais_patrocinio(10);

-- Consulta 6: canais com maior receita de membros.
SELECT * FROM fn_top_canais_membros(10);

-- Consulta 7: canais com maior receita de doacoes.
SELECT * FROM fn_top_canais_doacoes(10);

-- Consulta 8: canais com maior faturamento total.
SELECT * FROM fn_top_canais_faturamento(10);
