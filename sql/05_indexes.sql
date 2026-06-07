-- Índice 1: Comentario(id_video) hash para joins de comentário por vídeo (Q3, Q4, Q7, Q8)
CREATE INDEX idx_comentario_id_video
    ON Comentario USING HASH (id_video);

-- Índice 2: Doacao(status) hash para filtro de doações por status (Q4)
CREATE INDEX idx_doacao_status
    ON Doacao USING HASH (status);

-- Índice 3: Patrocinio(id_canal) para agrupamento e ordenação de patrocínios por canal (Q1, Q5, Q8)
CREATE INDEX idx_patrocinio_id_canal
    ON Patrocinio (id_canal);

-- Índice 4: Inscricao(nick_membro) hash para filtro de inscrições por membro (Q2, Q6)
CREATE INDEX idx_inscricao_nick_membro
    ON Inscricao USING HASH (nick_membro);

-- Índice 5: Video(id_canal) com visu_total para index-only scan de visualizações por canal (Q3, Q7, Q8)
CREATE INDEX idx_video_id_canal
    ON Video (id_canal) INCLUDE (visu_total);