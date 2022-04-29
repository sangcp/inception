all: 
	@docker-compose -f ./srcs/docker-compose.yml up

down:
	@docker-compose -f ./srcs/docker-compose.yml down

re:
	@docker-compose -f srcs/docker-compose.yml up --build

clean:
	@docker stop $$(docker ps -qa);\
	docker rm $$(docker ps -qa);\
	docker rmi -f $$(docker images -qa);\
	docker volume rm $$(docker volume ls -q);\
	docker network rm $$(docker network ls -q);\

volume_dir:
	@if [ ! -d /home/sangcpar/data/wordpress ] ; then \
		sudo mkdir -p /home/sangcpar/data/wordpress; \
	fi
	@if [ ! -d /home/sangcpar/data/mariadb ] ; then \
		sudo mkdir -p /home/sangcpar/data/mariadb; \
	fi

setup_domain:
	@if ! grep -q -E '^127\.0\.0\.1\s+jtanaka.42.fr' /etc/hosts ; then \
		echo "Add 127.0.0.1 to jtanaka.42.fr in /etc/hosts!"; \
		sudo sh -c 'echo "127.0.0.1\tjtanaka.42.fr" >> /etc/hosts'; \
	fi

.PHONY: all re down clean setup_domain volume_dir
