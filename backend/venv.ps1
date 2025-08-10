#!/usr/bin/env pwsh

# Virtual Environment Activation Script
# This script ensures you're always working in a virtual environment

param(
    [Parameter(Mandatory=$false)]
    [string]$Command = "shell"
)

# Colors for output
$Green = "`e[32m"
$Red = "`e[31m"
$Yellow = "`e[33m"
$Blue = "`e[34m"
$Reset = "`e[0m"

function Write-ColorMessage {
    param($Message, $Color)
    Write-Host "$Color$Message$Reset"
}

# Check if we're in the backend directory
if (-not (Test-Path "pyproject.toml")) {
    Write-ColorMessage "❌ This script must be run from the backend directory" $Red
    exit 1
}

# Virtual environment paths
$VenvPath = ".venv"
if ($IsWindows -or $env:OS -eq "Windows_NT") {
    $VenvPython = "$VenvPath\Scripts\python.exe"
    $VenvActivate = "$VenvPath\Scripts\Activate.ps1"
    $VenvPip = "$VenvPath\Scripts\pip.exe"
} else {
    $VenvPython = "$VenvPath/bin/python"
    $VenvActivate = "$VenvPath/bin/activate"
    $VenvPip = "$VenvPath/bin/pip"
}

# Function to create virtual environment
function New-VirtualEnvironment {
    Write-ColorMessage "🔧 Creating virtual environment..." $Blue
    python -m venv $VenvPath
    if ($LASTEXITCODE -ne 0) {
        Write-ColorMessage "❌ Failed to create virtual environment" $Red
        exit 1
    }
    Write-ColorMessage "✅ Virtual environment created" $Green
}

# Function to check if virtual environment exists
function Test-VirtualEnvironment {
    return Test-Path $VenvPython
}

# Function to check if we're in a virtual environment
function Test-InVirtualEnvironment {
    return $env:VIRTUAL_ENV -ne $null
}

# Function to install dependencies
function Install-Dependencies {
    Write-ColorMessage "📦 Installing dependencies..." $Blue
    & $VenvPip install --upgrade pip
    & $VenvPip install -r requirements.txt
    & $VenvPip install pre-commit coverage
    & $VenvPython -m pre-commit install
    Write-ColorMessage "✅ Dependencies installed" $Green
}

# Main logic
if (-not (Test-VirtualEnvironment)) {
    Write-ColorMessage "⚠️  Virtual environment not found" $Yellow
    New-VirtualEnvironment
    Install-Dependencies
} elseif (-not (Test-InVirtualEnvironment)) {
    Write-ColorMessage "⚠️  Not in virtual environment, activating..." $Yellow

    if ($IsWindows -or $env:OS -eq "Windows_NT") {
        Write-ColorMessage "💡 Activating virtual environment..." $Blue
        & $VenvActivate

        # Check if dependencies are installed
        $BlackInstalled = & $VenvPython -m pip show black 2>$null
        if (-not $BlackInstalled) {
            Write-ColorMessage "📦 Installing missing dependencies..." $Yellow
            Install-Dependencies
        }
    } else {
        Write-ColorMessage "💡 Please activate the virtual environment:" $Blue
        Write-Host "source $VenvActivate"
        exit 0
    }
}

# Execute the command if specified
switch ($Command) {
    "shell" {
        Write-ColorMessage "🐍 Virtual environment is active" $Green
        Write-ColorMessage "📁 Working directory: $(Get-Location)" $Blue
        Write-ColorMessage "🔧 Available commands: dev, test, lint, format, type, verify" $Blue
    }
    "dev" {
        & $VenvPython -m uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
    }
    "test" {
        & $VenvPython -m pytest -v
    }
    "lint" {
        & $VenvPython -m flake8 --max-line-length=100 --extend-ignore=E203 app tests
    }
    "format" {
        & $VenvPython -m black app tests
        & $VenvPython -m isort app tests
    }
    "type" {
        & $VenvPython -m mypy app
    }
    "verify" {
        & $VenvPython -m black --check app tests
        & $VenvPython -m isort --check-only app tests
        & $VenvPython -m flake8 --max-line-length=100 --extend-ignore=E203 app tests
        & $VenvPython -m mypy app
        & $VenvPython -m pytest -v
    }
    default {
        Write-ColorMessage "❌ Unknown command: $Command" $Red
        Write-ColorMessage "Available commands: shell, dev, test, lint, format, type, verify" $Yellow
    }
}
