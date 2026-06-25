-- Doacoes para metade dos comentarios cadastrados.
INSERT INTO Doacao (id_comentario, seq_pg, valor, status)
SELECT
    c.id_comentario,
    c.id_comentario,
    ((c.id_comentario % 100) + 1) * 10.00,
    CASE (c.id_comentario % 3)
        WHEN 0 THEN 'recusado'
        WHEN 1 THEN 'recebido'
        ELSE 'lido'
    END
FROM Comentario c
WHERE c.id_comentario <= 500;

-- Divide as doacoes em quatro formas de pagamento.
INSERT INTO BitCoin (id_doacao, TxID)
SELECT
    d.id_doacao,
    'tx_' || md5(d.id_doacao::TEXT)
FROM Doacao d
WHERE d.id_doacao % 4 = 0;

INSERT INTO PayPal (id_doacao, IdPayPal)
SELECT
    d.id_doacao,
    'PP_' || d.id_doacao
FROM Doacao d
WHERE d.id_doacao % 4 = 1;

INSERT INTO CartaoCredito (id_doacao, nro, bandeira, dataH)
SELECT
    d.id_doacao,
    '**** **** **** ' || LPAD((d.id_doacao % 10000)::TEXT, 4, '0'),
    CASE (d.id_doacao % 4)
        WHEN 0 THEN 'Visa'
        WHEN 1 THEN 'Mastercard'
        WHEN 2 THEN 'American Express'
        ELSE 'Discover'
    END,
    TIMESTAMP '2024-06-01 12:00:00' + (d.id_doacao * INTERVAL '1 minute')
FROM Doacao d
WHERE d.id_doacao % 4 = 2;

INSERT INTO MecanismoPlat (id_doacao, seq_plataforma)
SELECT
    d.id_doacao,
    100000 + d.id_doacao
FROM Doacao d
WHERE d.id_doacao % 4 = 3;
