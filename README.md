git clone <repositorio>
cd projeto

docker compose up -d

docker exec -it streamer-db psql -U postgres -d streamer_db