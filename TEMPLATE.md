# 🎯 Using This Template

This repository is a template for creating new full-stack projects with FastAPI + React TypeScript.

## 🚀 Quick Start (New Project)

### Method 1: GitHub Template (Recommended)

1. **Create new repository from template:**
   - Click "Use this template" button on GitHub
   - Choose repository name (use kebab-case: `my-awesome-project`)
   - Clone your new repository

2. **Initialize your project:**
   ```powershell
   cd your-new-project
   .\scripts\init-template.ps1 -ProjectName "your-project-name"
   ```

3. **Setup and start development:**
   ```powershell
   make setup
   make dev
   ```

### Method 2: Manual Clone

1. **Clone and rename:**
   ```bash
   git clone https://github.com/timfewi/python-react-startup.git my-new-project
   cd my-new-project
   rm -rf .git
   ```

2. **Initialize template:**
   ```powershell
   .\scripts\init-template.ps1 -ProjectName "my-new-project"
   ```

## 📋 What the Template Script Changes

The `init-template.ps1` script automatically updates:

### Backend:
- `backend/app/core/config.py` - App name configuration
- `backend/.env.example` - Environment variable defaults
- `backend/Makefile` - Docker image names

### Frontend:
- `frontend/package.json` - Package name and description

### Documentation:
- `README.md` - Project title and descriptions
- Root `Makefile` - Setup messages

### Environment:
- Creates `.env` files from examples
- Initializes git repository with first commit

## 🛠️ Manual Customization (Alternative)

If you prefer manual updates, change these values:

### 1. Project Name References
Replace `python-react-startup` with your project name in:
- `backend/app/core/config.py` (line 16)
- `backend/.env.example` (line 2)
- `backend/Makefile` (Docker image names)
- `frontend/package.json` (name field)
- `README.md` (title and descriptions)
- Root `Makefile` (setup messages)

### 2. Environment Files
```bash
cp backend/.env.example backend/.env
cp frontend/.env.example frontend/.env
```

### 3. Git Setup
```bash
git init
git add .
git commit -m "Initial commit"
```

## 🎨 Advanced Customization

### Adding Features to Template

1. **Database Integration:**
   - Uncomment database dependencies in `requirements.txt`
   - Add database service to `docker-compose.yml`
   - Create database models and migrations

2. **Authentication:**
   - Uncomment auth dependencies in `requirements.txt`
   - Add JWT authentication endpoints
   - Create user management frontend

3. **Styling:**
   - Add UI library (Tailwind, MUI, etc.)
   - Update frontend dependencies
   - Create component library

### Template Maintenance

Keep your template updated by:
- Regularly updating dependencies
- Adding new best practices
- Improving documentation
- Adding new optional features

## 🔄 Creating Template Variants

You can create specialized templates:

1. **Minimal Template:** Remove optional features
2. **Database Template:** Pre-configured with PostgreSQL
3. **Auth Template:** Includes authentication setup
4. **Microservices Template:** Multiple backend services

## 📚 Template Structure

```
your-new-project/
├── backend/           # FastAPI application
├── frontend/          # React TypeScript application
├── scripts/           # Setup and utility scripts
├── .github/           # CI/CD workflows
├── docker-compose.yml # Container orchestration
├── Makefile          # Development commands
└── README.md         # Project documentation
```

## 🤝 Contributing to Template

To improve this template:

1. Fork the template repository
2. Make improvements
3. Test with `init-template.ps1`
4. Submit pull request

## 🆘 Troubleshooting

### Common Issues:

**Script execution policy error:**
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

**Project name validation:**
- Use kebab-case (lowercase with hyphens)
- Start and end with letters/numbers
- No special characters except hyphens

**Dependencies not installing:**
```powershell
make clean
make setup
```

---

Happy coding with your new project! 🎉
