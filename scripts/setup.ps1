#!/usr/bin/env pwsh

# Python React Startup - Setup Script for Windows PowerShell
# This script sets up the development environment

Write-Host "🚀 Setting up Python React Startup project..." -ForegroundColor Green

# Check prerequisites
Write-Host "📋 Checking prerequisites..." -ForegroundColor Blue

# Check Python
try {
    $pythonVersion = python --version 2>&1
    Write-Host "✅ Found: $pythonVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ Python not found. Please install Python 3.13+" -ForegroundColor Red
    exit 1
}

# Check Node.js
try {
    $nodeVersion = node --version 2>&1
    Write-Host "✅ Found Node.js: $nodeVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ Node.js not found. Please install Node.js 20+" -ForegroundColor Red
    exit 1
}

# Check Docker
try {
    $dockerVersion = docker --version 2>&1
    Write-Host "✅ Found: $dockerVersion" -ForegroundColor Green
} catch {
    Write-Host "⚠️  Docker not found. Docker is optional but recommended." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "📦 Installing dependencies..." -ForegroundColor Blue

# Backend setup
Write-Host "🐍 Setting up backend..." -ForegroundColor Cyan
Push-Location backend

# Create virtual environment if it doesn't exist
if (-not (Test-Path ".venv")) {
    Write-Host "Creating Python virtual environment..." -ForegroundColor Yellow
    python -m venv .venv
}

# Activate virtual environment and install dependencies
Write-Host "Installing Python dependencies..." -ForegroundColor Yellow
& .venv/Scripts/Activate.ps1
python -m pip install --upgrade pip
pip install -r requirements.txt

# Copy environment file
if (-not (Test-Path ".env")) {
    Copy-Item ".env.example" ".env"
    Write-Host "✅ Created backend/.env" -ForegroundColor Green
}

Pop-Location

# Frontend setup
Write-Host "⚛️ Setting up frontend..." -ForegroundColor Cyan
Push-Location frontend

Write-Host "Installing Node.js dependencies..." -ForegroundColor Yellow
npm install

# Copy environment file
if (-not (Test-Path ".env")) {
    Copy-Item ".env.example" ".env"
    Write-Host "✅ Created frontend/.env" -ForegroundColor Green
}

Pop-Location

# Install pre-commit if available
Write-Host "🔧 Setting up development tools..." -ForegroundColor Blue
try {
    pip install pre-commit
    pre-commit install
    Write-Host "✅ Pre-commit hooks installed" -ForegroundColor Green
} catch {
    Write-Host "⚠️  Could not install pre-commit hooks" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "✅ Setup complete!" -ForegroundColor Green
Write-Host ""
Write-Host "🚀 Quick Start Commands:" -ForegroundColor Blue
Write-Host "  make dev              # Start both backend and frontend"
Write-Host "  make dev-backend      # Start backend only"
Write-Host "  make dev-frontend     # Start frontend only"
Write-Host "  make verify           # Run all quality checks"
Write-Host ""
Write-Host "Or use Docker:" -ForegroundColor Blue
Write-Host "  docker compose up --build"
Write-Host ""
Write-Host "Happy coding! 🎉" -ForegroundColor Green
