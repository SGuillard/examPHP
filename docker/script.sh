
install_dev(){
    cp .env.dev .env
    docker-sync start
	docker-compose up -d
	docker-compose exec php composer self-update --no-interaction
	docker-compose exec php composer install --no-interaction
	docker-compose exec php bin/console doctrine:migration:migrate --allow-no-migration --no-interaction
	docker-compose exec php bin/console assets:install --symlink --relative
	docker-compose exec php rm -Rf var/cache
	docker-compose exec php bin/console cache:warmup
	docker-compose exec php chmod -R 777 var
    rm .env
}	

install_prod(){
    cp .env.prod .env
    docker-compose up -d
	docker-compose exec php composer self-update --no-interaction
	docker-compose exec php composer install --no-interaction
	docker-compose exec php bin/console doctrine:migration:migrate --allow-no-migration --no-interaction
	docker-compose exec php bin/console assets:install --symlink --relative
	docker-compose exec php rm -Rf var/cache
	docker-compose exec php chmod -R 777 var
    rm .env
}

purge(){
    docker-sync stop
	docker-sync-stack clean
}
	
server_start(){
    docker-sync start
	docker-compose up -d
}

server_stop(){
    docker-compose stop
	@docker-sync stop
}	

new_migration(){
    docker-compose exec php bin/console doctrine:migration:diff --no-interaction
}
	
php_cli(){
    docker-compose exec php bash
}
	
docker_clean(){
    docker stop $(docker ps -a -q) | xargs docker rm
}

"$@"
