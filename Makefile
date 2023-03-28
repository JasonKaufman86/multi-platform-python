
# -------------------------------------------------------------------------
# Make variables
# -------------------------------------------------------------------------
PLATFORM = JETSON
ENVIRONMENT = LOCAL
# -------------------------------------------------------------------------

# This makes all the recipes run in the same environment
.ONESHELL:

# Commands to run when just running make
.DEFAULT_GOAL := run

# -------------------------------------------------------------------------
install: requirements.txt # This makes intstall dependant on requirements.txt
	# Install commands
	pip install --upgrade pip &&\
	pip install -r requirements.txt

format:
	# Format code
	black *.py src/*.py tests/*.py

lint:
	# flake8 or pylint
	pylint --disable=R,C *.py src test/*.py

test:
	# Unit tests
	python -m pytest --cov=src -vv test/*.py

build:
	# build container
	docker build -t ci-cd-test .

deploy:
	# Deploy

clean:
	rm -rf __pycache__
	rm -rf .pytest_cache
	rm -rf .coverage
	rm -rf .venv

run:
	# run
	# docker run -p 127.0.0.1:8080:8080 da5524e24b12
	python3 app.py
	
	
all: install format lint test deploy