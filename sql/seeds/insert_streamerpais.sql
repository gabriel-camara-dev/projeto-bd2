INSERT INTO StreamerPais (nick_streamer, ddi_pais, nro_passaporte)
SELECT 
    nick,
    pais_residencia,
    'PASSPORT_' || LEFT(nick, 10) || '_' || CAST(FLOOR(RANDOM() * 10000) AS INT)
FROM Usuario
WHERE nick IN (
    'gamer_pro_01', 'streamer_lendario', 'jogador_master', 'pro_player_x', 'elite_gamer',
    'ninja_br', 'dark_souls_br', 'fps_king', 'rpg_master', 'speedrunner',
    'john_doe_us', 'jane_smith', 'mike_wilson', 'sarah_brown', 'david_jones',
    'emily_davis', 'chris_miller', 'jessica_garcia', 'daniel_rodriguez', 'ashley_martinez',
    'james_taylor', 'laura_anderson', 'robert_thomas', 'maria_jackson', 'william_white',
    'patricia_harris', 'richard_martin', 'jennifer_thompson', 'charles_garcia', 'linda_martinez',
    'sakura_yamamoto', 'takashi_tanaka', 'yuki_nakamura', 'kenji_kobayashi', 'mai_sato',
    'hiroshi_suzuki', 'ayumi_watanabe', 'ryo_takahashi', 'miki_kimura', 'taro_saito'
)
UNION ALL
SELECT 
    nick,
    pais_residencia,
    'PASSPORT_' || LEFT(nick, 10) || '_' || CAST(FLOOR(RANDOM() * 10000) AS INT)
FROM Usuario
WHERE nick IN (
    'pierre_dupont', 'marie_lambert', 'jean_martin', 'sophie_bernard', 'lucas_dubois',
    'claire_robert', 'thomas_richard', 'emma_petit', 'nicolas_durand', 'camille_lefevre',
    'heinz_schmidt', 'muller_anna', 'weber_frank', 'wagner_lisa', 'becker_tom',
    'hoffmann_julia', 'schulz_markus', 'koch_sabrina', 'richter_tim', 'klein_nina',
    'carlos_mendez', 'lucia_ramos', 'javier_fernandez', 'elena_ortiz', 'manuel_garcia'
);