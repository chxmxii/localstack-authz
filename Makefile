.PHONY: all
all: clean build run

.PHONY: clean
clean:
	@echo "cleaning up..."
	rm -rf .venv
	rm -rf src/__pycache__

.PHONY: build
build:
	docker build -t chxmxi/localstack-authz .

.PHONY: docker
run:
	docker run -d -p 4566:4566 --name localstack-authz

.PHONY: run
run:
	uv run main.py