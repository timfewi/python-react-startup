.DEFAULT_GOAL := help
.PHONY: help install install-dev dev dev-backend dev-frontend lint format type test verify clean docker-build docker-up docker-down

help: ## Show this help message
	@echo "Available commands:"
	@echo "  help          Show this help message"
	@echo "  install       Install dependencies for both backend and frontend"
	@echo "  install-dev   Install development dependencies and setup pre-commit"
	@echo "  dev           Start both backend and frontend in development mode"
	@echo "  dev-backend   Start only backend development server"
	@echo "  dev-frontend  Start only frontend development server"
	@echo "  lint          Run linting for both backend and frontend"
	@echo "  format        Format code for both backend and frontend"
	@echo "  type          Run type checking for both backend and frontend"
	@echo "  test          Run tests for both backend and frontend"
	@echo "  verify        Run all quality checks (lint, format, type, test)"
	@echo "  clean         Clean up cache files and build artifacts"
	@echo "  docker-build  Build Docker images"
	@echo "  docker-up     Start services with docker-compose"
	@echo "  docker-down   Stop services with docker-compose"
	@echo "  setup         Complete project setup (install deps, setup pre-commit, copy env files)"
	@echo "  quick-start   Show quick start guide"

install: ## Install dependencies for both backend and frontend
	@echo "Installing backend dependencies..."
	cd backend && make install
	@echo "Installing frontend dependencies..."
	cd frontend && npm install

install-dev: ## Install development dependencies and setup pre-commit
	@echo "Installing backend dev dependencies..."
	cd backend && make install-dev
	@echo "Installing frontend dependencies..."
	cd frontend && npm install
	@echo "Setting up pre-commit hooks..."
ifeq ($(OS),Windows_NT)
	@if exist backend\.venv\Scripts\pre-commit.exe ( backend\.venv\Scripts\pre-commit.exe install ) else ( pre-commit install )
else
	@if [ -x backend/.venv/bin/pre-commit ]; then backend/.venv/bin/pre-commit install; else pre-commit install; fi
endif

dev: ## Start both backend and frontend in development mode
	@echo "Starting development servers..."
	@echo "Backend will be available at http://localhost:8000"
	@echo "Frontend will be available at http://localhost:3000"
	docker compose up --build

dev-backend: ## Start only backend development server
	cd backend && make dev

dev-frontend: ## Start only frontend development server
	cd frontend && npm run dev

lint: ## Run linting for both backend and frontend
	@echo "Linting backend..."
	cd backend && make lint
	@echo "Linting frontend..."
	cd frontend && npm run lint

format: ## Format code for both backend and frontend
	@echo "Formatting backend..."
	cd backend && make format
	@echo "Formatting frontend..."
	cd frontend && npm run format

type: ## Run type checking for both backend and frontend
	@echo "Type checking backend..."
	cd backend && make type
	@echo "Type checking frontend..."
	cd frontend && npm run type-check

test: ## Run tests for both backend and frontend
	@echo "Testing backend..."
	cd backend && make test
	@echo "Testing frontend..."
	cd frontend && npm run test:coverage

verify: ## Run all quality checks (lint, format, type, test)
	@echo "Running all quality checks..."
	cd backend && make verify
	cd frontend && npm run verify

clean: ## Clean up cache files and build artifacts
	@echo "Cleaning backend..."
	cd backend && make clean
	@echo "Cleaning frontend..."
	cd frontend && npm run clean

docker-build: ## Build Docker images
	docker compose build

docker-up: ## Start services with docker-compose
	docker compose up -d

docker-down: ## Stop services with docker-compose
	docker compose down

docker-logs: ## Show docker-compose logs
	docker compose logs -f

setup: ## Complete project setup (install deps, setup pre-commit, create dev env files)
	@echo "Setting up python-react-startup project..."
	@echo "Installing dependencies..."
	$(MAKE) install-dev
	@echo "Setting up development environment files (.env.development.local)..."
ifeq ($(OS),Windows_NT)
	@if not exist backend\.env.development.local ( copy backend\.env.example backend\.env.development.local >NUL && echo Created backend/.env.development.local )
	@if not exist frontend\.env.development.local ( copy frontend\.env.example frontend\.env.development.local >NUL && echo Created frontend/.env.development.local )
else
	@if [ ! -f backend/.env.development.local ]; then cp backend/.env.example backend/.env.development.local && echo "Created backend/.env.development.local"; fi
	@if [ ! -f frontend/.env.development.local ]; then cp frontend/.env.example frontend/.env.development.local && echo "Created frontend/.env.development.local"; fi
endif
	@echo "Setup complete! Run 'make dev' to start development servers."

bootstrap: setup ## Alias for setup (for convenience)

quick-start: ## Quick start guide
	@echo "Python React Startup - Quick Start Guide"
	@echo ""
	@echo "1. First time setup:"
	@echo "   make setup"
	@echo ""
	@echo "2. Start development:"
	@echo "   make dev"
	@echo ""
	@echo "3. Run quality checks:"
	@echo "   make verify"
	@echo ""
	@echo "4. Individual commands:"
	@echo "   make dev-backend    # Backend only"
	@echo "   make dev-frontend   # Frontend only"
	@echo "   make test          # Run all tests"
	@echo "   make lint          # Lint all code"
	@echo ""
	@echo "Run 'make help' for all available commands"

init-project: ## (Optional) Run after cloning template to rename things via PowerShell script (Windows)
ifeq ($(OS),Windows_NT)
	@if exist scripts\init-template.ps1 ( powershell -ExecutionPolicy Bypass -File scripts\init-template.ps1 -ProjectName "$(PROJECT_NAME)" ) else ( echo "init-template.ps1 not found" )
else
	@echo "Use the PowerShell script scripts/init-template.ps1 on Windows or manually update names."
endif
