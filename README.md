# Projeto BD2 - Streamers Database

Projeto de banco de dados relacional para catalogar informacoes sobre streamers, canais, plataformas, videos, comentarios, doacoes, membros e patrocinadores.

O banco foi implementado em PostgreSQL e pode ser executado com Docker Compose.

## Requisitos

- Docker
- Docker Compose

## Estrutura dos arquivos

- `sql/01_tables.sql`: criacao das tabelas, chaves primarias, chaves estrangeiras, `UNIQUE`, `NOT NULL` e `CHECK`.
- `sql/02_views.sql`: views virtuais e materialized view.
- `sql/03_functions.sql`: arquivo principal que carrega as procedures e functions das consultas.
- `sql/querys/consulta_01.sql`: procedure da consulta 1.
- `sql/querys/consulta_02.sql`: procedure da consulta 2.
- `sql/querys/consulta_03.sql`: procedure da consulta 3.
- `sql/querys/consulta_04.sql`: procedure da consulta 4.
- `sql/querys/consulta_05.sql`: function da consulta 5.
- `sql/querys/consulta_06.sql`: function da consulta 6.
- `sql/querys/consulta_07.sql`: function da consulta 7.
- `sql/querys/consulta_08.sql`: function da consulta 8.
- `sql/04_triggers.sql`: functions de trigger e triggers.
- `sql/05_indexes.sql`: indices de apoio as consultas.
- `sql/06_seed.sql`: arquivo principal da carga de dados.
- `sql/seeds/`: arquivos com os dados de insercao.
- `sql/07_test_queries.sql`: chamadas de teste das consultas implementadas.
- `relatorio_projeto.pdf`: relatorio curto com decisoes de projeto.

## Como executar

Na raiz do projeto, execute:

```bash
docker compose up -d
```

O PostgreSQL sera iniciado com:

- banco: `streamers_db`
- usuario: `streamer_user`
- senha: `streamer_pass`
- porta: `5432`

Na primeira criacao do volume, o Docker executa automaticamente os arquivos da pasta `sql`.

## Recriar o banco do zero

Use este comando quando mudar algum script SQL e quiser recarregar tudo:

```bash
docker compose down -v
docker compose up -d
```

## Acessar o banco

```bash
docker compose exec postgres psql -U streamer_user -d streamers_db
```

## Rodar as consultas de teste

Dentro do `psql`, execute:

```sql
\i /docker-entrypoint-initdb.d/07_test_queries.sql
```

As chamadas de teste usam procedures com cursor nas consultas 1 a 4 e functions nas consultas 5 a 8.

Exemplos de chamadas com procedure:

```sql
BEGIN;
CALL sp_canais_patrocinados_por_empresa(NULL, 'cur_canais_patrocinados');
FETCH 10 FROM cur_canais_patrocinados;
COMMIT;
```

Exemplos de chamadas com function:

```sql
SELECT * FROM fn_top_canais_patrocinio(10);
SELECT * FROM fn_top_canais_membros(10);
SELECT * FROM fn_top_canais_doacoes(10);
SELECT * FROM fn_top_canais_faturamento(10);
```

## Conferir quantidade de dados

Dentro do `psql`, execute:

```sql
\i /docker-entrypoint-initdb.d/seeds/verify_counts.sql
```

Esse arquivo mostra a quantidade de tuplas carregadas em cada tabela.

## Observacao sobre a materialized view

A materialized view `mv_faturamento_total_canal` depende dos dados de patrocinio, membros e doacoes. Por isso, o arquivo `sql/seeds/update_counts.sql` executa:

```sql
REFRESH MATERIALIZED VIEW mv_faturamento_total_canal;
```

Esse refresh garante que a consulta de faturamento total use os dados carregados.
