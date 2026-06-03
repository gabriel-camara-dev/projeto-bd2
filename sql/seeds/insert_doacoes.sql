INSERT INTO Doacao (id_comentario, seq_pg, valor, status)
SELECT
    c.id_comentario,
    CAST(FLOOR(RANDOM() * 10000) AS INT),
    CAST(FLOOR(RANDOM() * 1000 + 1) AS DECIMAL(10,2)),
    CASE (CAST(FLOOR(RANDOM() * 3) AS INT))
        WHEN 0 THEN 'recusado'
        WHEN 1 THEN 'recebido'
        ELSE 'lido'
    END
FROM Comentario c
WHERE c.id_comentario <= 1000
LIMIT 500;

INSERT INTO BitCoin (id_doacao, TxID)
SELECT
    d.id_doacao,
    'tx_' || md5(d.id_doacao::text || random()::text)
FROM Doacao d
WHERE d.id_doacao % 4 = 0
LIMIT 125;

INSERT INTO PayPal (id_doacao, IdPayPal)
SELECT
    d.id_doacao,
    'PP_' || d.id_doacao || '_' || md5(random()::text)
FROM Doacao d
WHERE d.id_doacao % 4 = 1
LIMIT 125;

INSERT INTO CartaoCredito (id_doacao, nro, bandeira, dataH)
SELECT
    d.id_doacao,
    '**** **** **** ' || CAST(FLOOR(RANDOM() * 10000) AS INT),
    CASE (CAST(FLOOR(RANDOM() * 4) AS INT))
        WHEN 0 THEN 'Visa'
        WHEN 1 THEN 'Mastercard'
        WHEN 2 THEN 'American Express'
        ELSE 'Discover'
    END,
    CURRENT_TIMESTAMP - (d.id_doacao * INTERVAL '1 hour')
FROM Doacao d
WHERE d.id_doacao % 4 = 2
LIMIT 125;

INSERT INTO MecanismoPlat (id_doacao, seq_plataforma)
SELECT
    d.id_doacao,
    CAST(FLOOR(RANDOM() * 100000) AS INT)
FROM Doacao d
WHERE d.id_doacao % 4 = 3
LIMIT 125;