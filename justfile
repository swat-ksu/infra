make-folders:
    docker compose config --format json | jq '.services[].volumes[]?.source' | grep -E "/(data|share)" | sort -u | xargs -p mkdir -p

backup-env:
    find . -name ".env" | tar -cf env-backup.tar.gz -T -

restore-env:
    tar -xf env-backup.tar.gz

make-compose:
    echo "include:" > docker-compose.yml
    find . -mindepth 2 -path "*/docker-compose.yml" | sort | sed 's/^/  - /' >> docker-compose.yml
