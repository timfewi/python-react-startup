.DEFAULT_GOAL := help
.PHONY: help install install-dev dev lint format format-check type test test-cov verify clean build docker-build docker-run setup-venv

# Variables
PYTHON := python
PIP := pip
UVICORN := uvicorn
APP_MODULE := app.main:app
VENV_PATH := .venv

help: ## Show this help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

install: ## Install dependencies
	$(PYTHON) -m pip install --upgrade pip
	$(PIP) install -r requirements.txt

install-dev: ## Install development dependencies (including pre-commit)
	$(PIP) install -r requirements.txt
	$(PIP) install pre-commit coverage
	pre-commit install

dev: ## Start development server with hot reload
	$(UVICORN) $(APP_MODULE) --reload --host 0.0.0.0 --port 8000

lint: ## Run linting (flake8)
	flake8 app tests

format: ## Format code (black + isort)
	black app tests
	isort app tests

format-check: ## Check if code is formatted correctly
	black --check app tests
	isort --check-only app tests

type: ## Run type checking (mypy)
	mypy app

test: ## Run tests
	pytest -v

test-cov: ## Run tests with coverage
	pytest --cov=app --cov-report=term-missing --cov-report=html

verify: format-check lint type test ## Run all quality checks

clean: ## Clean up cache files
	find . -type f -name "*.pyc" -delete
	find . -type d -name "__pycache__" -delete
	find . -type d -name ".pytest_cache" -exec rm -rf {} +
	find . -type d -name ".mypy_cache" -exec rm -rf {} +
	rm -rf htmlcov/
	rm -rf .coverage

build: ## Build for production
	$(PYTHON) -m pip install --upgrade pip
	$(PIP) install -r requirements.txt

docker-build: ## Build Docker image
	docker build -t python-react-startup-backend .

docker-run: ## Run Docker container
	docker run -p 8000:8000 --env-file .env.example python-react-startup-backend

setup-venv: ## Create virtual environment
	$(PYTHON) -m venv $(VENV_PATH)
	@echo "Activate with: source $(VENV_PATH)/bin/activate (Unix) or $(VENV_PATH)\Scripts\Activate.ps1 (Windows)"
