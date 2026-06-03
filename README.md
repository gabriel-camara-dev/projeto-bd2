# Projeto BD2 - Streamers Database

Projeto de banco de dados para catalogação de streamers de jogos online, implementado em PostgreSQL com Docker.

## Pré-requisitos

- Docker
- Docker Compose

## Comandos Rápidos

### Subir o banco pela primeira vez

```bash
docker compose up -d
``` 

### Recriar o banco do zero (após alterações nos scripts)

``` bash
docker compose down -v
docker compose up -d
```
