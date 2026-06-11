/*
Trigger 1: Incrementa a quantidade de usuários da plataforma.
*/

CREATE OR REPLACE FUNCTION inc_users_trig_func()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE Plataforma
    SET qtd_users = qtd_users + 1
    WHERE nro = NEW.nro_plataforma;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER inc_users_trig
AFTER INSERT ON PlataformaUsuario
FOR EACH ROW
EXECUTE FUNCTION inc_users_trig_func();

/*
Trigger 2: Decrementa a quantidade de usuários da plataforma.
*/

CREATE OR REPLACE FUNCTION dec_users_trig_func()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE Plataforma
    SET qtd_users = qtd_users - 1
    WHERE nro = OLD.nro_plataforma;

    RETURN OLD;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER dec_users_trig
AFTER DELETE ON PlataformaUsuario
FOR EACH ROW
EXECUTE FUNCTION dec_users_trig_func();

/*
Trigger 3: Incrementa a quantidade de vídeos do canal após um INSERT.
*/

CREATE OR REPLACE FUNCTION inc_videos_trig_func()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE Canal
    SET qtd_videos = qtd_videos + 1
    WHERE id_canal = NEW.id_canal;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER inc_videos_trig
AFTER INSERT ON Video
FOR EACH ROW
EXECUTE FUNCTION inc_videos_trig_func();


/*
Trigger 4: Decrementa a quantidade de vídeos do canal após um DELETE.
*/

CREATE OR REPLACE FUNCTION dec_videos_trig_func()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE Canal
    SET qtd_videos = qtd_videos - 1
    WHERE id_canal = OLD.id_canal;

    RETURN OLD;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER dec_videos_trig
AFTER DELETE ON Video
FOR EACH ROW
EXECUTE FUNCTION dec_videos_trig_func();

/*
Trigger 5: Adiciona as visualizações do vídeo ao total do canal após um INSERT.
*/

CREATE OR REPLACE FUNCTION inc_views_trig_func()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE Canal
    SET qtd_visualizacoes = qtd_visualizacoes + NEW.visu_total
    WHERE id_canal = NEW.id_canal;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER inc_views_trig
AFTER INSERT ON Video
FOR EACH ROW
EXECUTE FUNCTION inc_views_trig_func();


/*
Trigger 6: Subtrai as visualizações do vídeo do total do canal após um DELETE.
*/

CREATE OR REPLACE FUNCTION dec_views_trig_func()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE Canal
    SET qtd_visualizacoes = qtd_visualizacoes - OLD.visu_total
    WHERE id_canal = OLD.id_canal;

    RETURN OLD;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER dec_views_trig
AFTER DELETE ON Video
FOR EACH ROW
EXECUTE FUNCTION dec_views_trig_func();