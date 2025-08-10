.DEFAULT_GOAL := help
.PHONY: help install install-dev dev lint format format-check type test test-cov verify clean build docker-build docker-run setup-venv

# Variables
PYTHON := python
PIP := pip
UVICORN := uvicorn
APP_MODULE := app.main:app
VENV_PATH := .venv
# Sentinel to avoid infinite recursion after creating venv
AFTER_VENV ?= 0

# Check if we're in a virtual environment or if .venv exists
ifeq ($(OS),Windows_NT)
    # Windows paths
    VENV_PYTHON := .venv\Scripts\python.exe
    VENV_PIP := .venv\Scripts\pip.exe
    VENV_ACTIVATE := .venv\Scripts\Activate.ps1
    ifeq ($(wildcard $(VENV_PYTHON)),)
        PYTHON_CMD := $(PYTHON)
        PIP_CMD := $(PIP)
        NEEDS_VENV := true
    else
        PYTHON_CMD := $(VENV_PYTHON)
        PIP_CMD := $(VENV_PIP)
        NEEDS_VENV := false
    endif
else
    # Unix paths
    VENV_PYTHON := .venv/bin/python
    VENV_PIP := .venv/bin/pip
    VENV_ACTIVATE := .venv/bin/activate
    ifeq ($(wildcard $(VENV_PYTHON)),)
        PYTHON_CMD := $(PYTHON)
        PIP_CMD := $(PIP)
        NEEDS_VENV := true
    else
        PYTHON_CMD := $(VENV_PYTHON)
        PIP_CMD := $(VENV_PIP)
        NEEDS_VENV := false
    endif
endif

# Ensure virtual environment; if created during this invocation, re-run original target(s) with refreshed vars
ensure-venv:
ifeq ($(NEEDS_VENV),true)
	@echo "Creating virtual environment..."
	$(PYTHON) -m venv $(VENV_PATH)
	@echo "Virtual environment created. Re-running target to pick up venv python."
	@if [ "$(AFTER_VENV)" = "0" ]; then \
		$(MAKE) $(MAKECMDGOALS) AFTER_VENV=1; \
		exit 0; \
	fi
endif

help: ## Show this help message
	@echo "Available backend commands:"
	@echo "  help          Show this help message"
	@echo "  check-venv    Check if virtual environment is set up"
	@echo "  setup-venv    Create virtual environment"
	@echo "  install       Install dependencies"
	@echo "  install-dev   Install development dependencies and setup pre-commit"
	@echo "  dev           Start development server with hot reload"
	@echo "  lint          Run linting (flake8)"
	@echo "  format        Format code (black + isort)"
	@echo "  format-check  Check if code is formatted correctly"
	@echo "  type          Run type checking (mypy)"
	@echo "  test          Run tests"
	@echo "  test-cov      Run tests with coverage"
	@echo "  verify        Run all quality checks"
	@echo "  clean         Clean up cache files"
	@echo "  build         Build for production"
	@echo "  docker-build  Build Docker image"
	@echo "  docker-run    Run Docker container"

install: ensure-venv ## Install dependencies
	$(PYTHON_CMD) -m pip install --upgrade pip
	$(PIP_CMD) install -r requirements.txt

install-dev: ensure-venv ## Install development dependencies (including pre-commit)
	$(PIP_CMD) install -r requirements.txt
	$(PIP_CMD) install pre-commit coverage
	@echo "Installing pre-commit hook script..."
	$(PYTHON_CMD) -m pre_commit install

dev: ensure-venv ## Start development server with hot reload
	@echo "Starting development server..."
ifeq ($(NEEDS_VENV),true)
	@echo "Please install dependencies first: make install-dev"
	@exit 1
endif
	$(PYTHON_CMD) -m uvicorn $(APP_MODULE) --reload --host 0.0.0.0 --port 8000

lint: ensure-venv ## Run linting (flake8)
ifeq ($(NEEDS_VENV),true)
	@echo "Please install dependencies first: make install-dev"
	@exit 1
endif
	$(PYTHON_CMD) -m flake8 --max-line-length=100 --extend-ignore=E203 app tests

format: ensure-venv ## Format code (black + isort)
ifeq ($(NEEDS_VENV),true)
	@echo "Please install dependencies first: make install-dev"
	@exit 1
endif
	$(PYTHON_CMD) -m black app tests
	$(PYTHON_CMD) -m isort app tests

format-check: ensure-venv ## Check if code is formatted correctly
ifeq ($(NEEDS_VENV),true)
	@echo "Please install dependencies first: make install-dev"
	@exit 1
endif
	$(PYTHON_CMD) -m black --check app tests
	$(PYTHON_CMD) -m isort --check-only app tests

type: ensure-venv ## Run type checking (mypy)
ifeq ($(NEEDS_VENV),true)
	@echo "Please install dependencies first: make install-dev"
	@exit 1
endif
	$(PYTHON_CMD) -m mypy app

test: ensure-venv ## Run tests
ifeq ($(NEEDS_VENV),true)
	@echo "Please install dependencies first: make install-dev"
	@exit 1
endif
	$(PYTHON_CMD) -m pytest -v

test-cov: ensure-venv ## Run tests with coverage
ifeq ($(NEEDS_VENV),true)
	@echo "Please install dependencies first: make install-dev"
	@exit 1
endif
	$(PYTHON_CMD) -m pytest --cov=app --cov-report=term-missing --cov-report=html

verify: format-check lint type test ## Run all quality checks

clean: ## Clean up cache files
	find . -type f -name "*.pyc" -delete
	find . -type d -name "__pycache__" -delete
	find . -type d -name ".pytest_cache" -exec rm -rf {} +
	find . -type d -name ".mypy_cache" -exec rm -rf {} +
	rm -rf htmlcov/
	rm -rf .coverage

build: ## Build for production
	$(PYTHON_CMD) -m pip install --upgrade pip
	$(PIP_CMD) install -r requirements.txt

docker-build: ## Build Docker image
	docker build -t python-react-startup-backend .

docker-run: ## Run Docker container
	docker run -p 8000:8000 --env-file .env.example python-react-startup-backend

setup-venv: ## Create virtual environment
	$(PYTHON) -m venv $(VENV_PATH)
ifeq ($(OS),Windows_NT)
	@echo "Activate with: $(VENV_ACTIVATE)"
	@echo "Or run: make install-dev"
else
	@echo "Activate with: source $(VENV_ACTIVATE)"
	@echo "Or run: make install-dev"
endif

check-venv: ## Check if virtual environment is set up
ifeq ($(wildcard $(VENV_PYTHON)),)
	@echo "Virtual environment not found. Creating one..."
	$(MAKE) setup-venv
	@echo "Now run: make install-dev"
else
	@echo "Virtual environment found at $(VENV_PATH)"
endif
