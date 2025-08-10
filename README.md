# Python React Startup Template

> Modern full-stack starter with FastAPI + React TypeScript

Opinionated development setup with comprehensive tooling for linting, formatting, testing, and CI/CD.

## ✨ Features

- 🚀 **FastAPI** backend with modular router structure
- ⚛️ **React 19** + **TypeScript** frontend with strict type checking
- 🐳 **Docker** containerization with development hot-reload
- 🔧 **Pre-commit hooks** for code quality
- 🧪 **Pytest** + **Jest** testing with coverage
- 📦 **GitHub Actions** CI/CD pipeline
- 🎨 **Black** + **Prettier** code formatting
- 🔍 **MyPy** + **ESLint** static analysis
- 🛡️ **Bandit** + **Safety** security scanning
- 📄 **Pydantic Settings** configuration management

## 🛡️ Virtual Environment Safety

This project implements **multiple layers of virtual environment protection** to ensure consistent development:

### Automatic Detection & Creation
- **Makefile Commands**: All `make` commands automatically detect and activate virtual environments
- **PowerShell Script**: Run `.\venv.ps1` in `backend/` for guided activation
- **Pre-commit Hooks**: Verify virtual environment before each commit

### Safety Layers
1. **Makefile Auto-Detection**: Commands check for virtual env and create if missing
2. **Python Checker**: `backend/venv_check.py` provides environment status
3. **Pre-commit Protection**: Git hooks prevent commits without virtual environment
4. **PowerShell Helper**: Color-coded guidance for environment activation

### Quick Commands
```bash
# Backend development (auto-activates venv)
cd backend
make dev          # Start development server
make verify       # Run all quality checks
make test         # Run tests only

# Manual virtual environment
.\venv.ps1         # PowerShell activation helper
python venv_check.py  # Check environment status
```

## 🚀 Quick Start

### One-Command Setup

```bash
make setup
```

This will:
- Install all dependencies (backend + frontend)
- Set up pre-commit hooks
- Create environment files from examples
- Prepare your development environment

### Start Development

```bash
# Start both backend and frontend
make dev

# Or individually
make dev-backend   # Backend at http://localhost:8000
make dev-frontend  # Frontend at http://localhost:3000
```

### Run Quality Checks

```bash
make verify  # Run all checks (lint, format, type, test)
```

## 📋 Prerequisites

- **Python 3.13.6+** (pinned in `.python-version`)
- **Node.js 20.18.0+** (pinned in `.nvmrc`)
- **Docker** and **Docker Compose**
- **Make** (for convenience commands)

## 🛠️ Manual Setup (Alternative)

### Backend Setup

```bash
cd backend
python -m venv .venv

# Windows PowerShell
.venv\Scripts\Activate.ps1

# Unix/macOS
source .venv/bin/activate

pip install -r requirements.txt
cp .env.example .env
make dev
```

### Frontend Setup

```bash
cd frontend
npm install
cp .env.example .env
npm run dev
```

## 📁 Project Structure

```
├── backend/                 # FastAPI application
│   ├── app/
│   │   ├── api/routes/     # API route handlers
│   │   ├── core/           # Configuration & logging
│   │   └── main.py         # FastAPI app instance
│   ├── tests/              # Backend tests
│   ├── Makefile            # Backend commands
│   └── requirements.txt    # Python dependencies
├── frontend/               # React TypeScript app
│   ├── src/               # Source code
│   ├── public/            # Static assets
│   └── package.json       # Node dependencies
├── .github/workflows/     # CI/CD pipelines
├── docker-compose.yml     # Production compose
├── docker-compose.override.yml  # Development overrides
├── Makefile              # Root project commands
└── .pre-commit-config.yaml  # Git hooks configuration
```

## 🔧 Development Commands

### Root Level (Unified)

```bash
make help           # Show all available commands
make setup          # Complete project setup
make dev            # Start both services
make verify         # Run all quality checks
make test           # Run all tests
make lint           # Lint all code
make format         # Format all code
make clean          # Clean cache files
```

### Backend Specific

```bash
cd backend
make dev            # Start with hot reload
make test           # Run pytest
make test-cov       # Run with coverage
make lint           # Flake8 linting
make format         # Black + isort formatting
make type           # MyPy type checking
make verify         # All quality checks
```

### Frontend Specific

```bash
cd frontend
npm run dev         # Start development server
npm run test        # Run Jest tests
npm run test:coverage  # Run with coverage
npm run lint        # ESLint
npm run format      # Prettier formatting
npm run type-check  # TypeScript checking
npm run verify      # All quality checks
```

## 🐳 Docker Development

```bash
# Start with hot reload (uses override file)
docker compose up --build

# Production-like build
docker compose -f docker-compose.yml up --build

# View logs
make docker-logs
```

## 🧪 Testing

### Backend Tests

```bash
cd backend
make test           # Quick test run
make test-cov       # With coverage report
pytest -v           # Verbose output
```

### Frontend Tests

```bash
cd frontend
npm test            # Interactive mode
npm run test:coverage  # Coverage report
```

## 🔍 Code Quality

### Pre-commit Hooks

Automatically run on each commit:
- Code formatting (Black, Prettier)
- Linting (Flake8, ESLint)
- Type checking (MyPy, TypeScript)
- Security scanning (Bandit)
- File checks (trailing whitespace, large files)

```bash
# Manual run
pre-commit run --all-files
```

### Manual Quality Checks

```bash
# Run everything
make verify

# Individual checks
make lint           # All linting
make format         # All formatting
make type           # All type checking
make test           # All tests
```

## 📊 CI/CD Pipeline

GitHub Actions automatically:
- ✅ Lints and type-checks all code
- ✅ Runs test suites with coverage
- ✅ Builds Docker images
- ✅ Scans for security vulnerabilities
- ✅ Reports coverage to Codecov

## 🚀 Production Deployment

### Environment Configuration

1. Copy environment examples:
   ```bash
   cp backend/.env.example backend/.env
   cp frontend/.env.example frontend/.env
   ```

2. Update environment variables for production
3. Set up secrets in CI/CD environment

### Docker Deployment

```bash
# Build production images
docker compose -f docker-compose.yml build

# Deploy (example)
docker compose -f docker-compose.yml up -d
```

## 🔧 Customization

### Adding Dependencies

**Backend:**
```bash
cd backend
pip install new-package
pip freeze > requirements.txt
```

**Frontend:**
```bash
cd frontend
npm install new-package
```

### Adding Environment Variables

1. Add to `.env.example` files
2. Update `backend/app/core/config.py` for backend vars
3. Prefix frontend vars with `REACT_APP_`

### Database Integration

Uncomment database lines in `backend/requirements.txt`:
```bash
# Uncomment these lines
sqlalchemy==2.0.23
alembic==1.12.1
psycopg2-binary==2.9.7
```

## 📚 Tech Stack

### Backend
- **FastAPI** - Modern Python web framework
- **Pydantic** - Data validation using Python type hints
- **Uvicorn** - ASGI server
- **Pytest** - Testing framework

### Frontend
- **React 19** - UI library
- **TypeScript** - Type-safe JavaScript
- **Create React App** - Build tooling
- **Jest** - Testing framework

### Development Tools
- **Black** + **Prettier** - Code formatting
- **MyPy** + **ESLint** - Static analysis
- **Pre-commit** - Git hooks
- **Docker** - Containerization

## 🎯 Using This as a Template

This repository can be used as a template for new projects. See [TEMPLATE.md](TEMPLATE.md) for detailed instructions.

### Quick Template Usage:

1. **Create from GitHub Template:**
   - Click "Use this template" on GitHub
   - Clone your new repository

2. **Initialize for your project:**
   ```powershell
   .\scripts\init-template.ps1 -ProjectName "your-project-name"
   ```

3. **Start development:**
   ```powershell
   make setup
   make dev
   ```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Make your changes
4. Run quality checks: `make verify`
5. Commit with conventional commits
6. Push and create a Pull Request

## 📝 License

MIT License - see [LICENSE](LICENSE) file for details.

---

**Happy coding! 🎉**

For questions or issues, please open a GitHub issue.
