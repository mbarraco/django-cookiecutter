.PHONY: bash build-base compile delete-all-containers logs migrate migrations restart runserver

bash:
	docker-compose run --rm -it --entrypoint "ash --login" django

bash-nginx:
	docker-compose run --rm -it --entrypoint "ash --login" nginx

build-base:
	docker build --target base -t website-base .

collectstatic:
	docker-compose run --rm django python manage.py collectstatic

compile:
	docker run --rm -v .:/build website-base pip-compile requirements.in

delete-all-containers:
	docker stop $$(docker ps -a -q) || true

logs:
	docker-compose logs -f

migrate:
	docker-compose run --rm django python manage.py migrate

migrations:
	docker-compose run --rm django python manage.py makemigrations

shell_plus:
	docker-compose run --rm django python manage.py shell_plus

restart:
	docker-compose down -v; docker-compose up -d

runserver:
	docker-compose up -d
