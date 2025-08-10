#!/usr/bin/env pwsh
# Template Initialization Script
# This script customizes the template for a new project

param(
    [Parameter(Mandatory=$true)]
    [string]$ProjectName,

    [Parameter(Mandatory=$false)]
    [string]$Description = "A full-stack application with FastAPI backend and React frontend",

    [Parameter(Mandatory=$false)]
    [string]$Author = "Your Name"
)

# Validate project name (kebab-case recommended)
if ($ProjectName -notmatch '^[a-z][a-z0-9-]*[a-z0-9]$') {
    Write-Host "❌ Project name should be in kebab-case (lowercase, hyphens only)" -ForegroundColor Red
    Write-Host "Example: my-awesome-project" -ForegroundColor Yellow
    exit 1
}

Write-Host "🚀 Initializing template for project: $ProjectName" -ForegroundColor Green

# Define files to update
$filesToUpdate = @(
    @{
        Path = "backend/app/core/config.py"
        Find = 'app_name: str = "python-react-startup"'
        Replace = "app_name: str = `"$ProjectName`""
    },
    @{
        Path = "backend/.env.example"
        Find = "APP_NAME=python-react-startup"
        Replace = "APP_NAME=$ProjectName"
    },
    @{
        Path = "backend/Makefile"
        Find = "python-react-startup-backend"
        Replace = "$ProjectName-backend"
    },
    @{
        Path = "Makefile"
        Find = "Setting up python-react-startup project..."
        Replace = "Setting up $ProjectName project..."
    },
    @{
        Path = "frontend/package.json"
        Find = '"name": "frontend"'
        Replace = "`"name`": `"$ProjectName-frontend`""
    },
    @{
        Path = "README.md"
        Find = "# Python React Startup Template"
        Replace = "# $ProjectName"
    },
    @{
        Path = "README.md"
        Find = "python-react-startup"
        Replace = "$ProjectName"
    }
)

# Function to update file content
function Update-FileContent {
    param($FilePath, $FindText, $ReplaceText)

    if (Test-Path $FilePath) {
        $content = Get-Content $FilePath -Raw
        $newContent = $content -replace [regex]::Escape($FindText), $ReplaceText
        Set-Content $FilePath $newContent -NoNewline
        Write-Host "✅ Updated $FilePath" -ForegroundColor Green
    } else {
        Write-Host "⚠️  File not found: $FilePath" -ForegroundColor Yellow
    }
}

# Update files
Write-Host "📝 Updating project files..." -ForegroundColor Blue
foreach ($update in $filesToUpdate) {
    Update-FileContent -FilePath $update.Path -FindText $update.Find -ReplaceText $update.Replace
}

# Update README with custom description
if (Test-Path "README.md") {
    $readmeContent = Get-Content "README.md" -Raw
    $readmeContent = $readmeContent -replace "Modern full-stack starter with FastAPI \+ React TypeScript", $Description
    Set-Content "README.md" $readmeContent -NoNewline
    Write-Host "✅ Updated README.md with description" -ForegroundColor Green
}

# Update package.json with description
if (Test-Path "frontend/package.json") {
    $packageJson = Get-Content "frontend/package.json" | ConvertFrom-Json
    $packageJson.name = "$ProjectName-frontend"
    $packageJson.description = $Description
    $packageJson | ConvertTo-Json -Depth 10 | Set-Content "frontend/package.json"
    Write-Host "✅ Updated frontend/package.json" -ForegroundColor Green
}

# Create initial .env files
Write-Host "📄 Setting up environment files..." -ForegroundColor Blue
if (Test-Path "backend/.env.example" -and -not (Test-Path "backend/.env")) {
    Copy-Item "backend/.env.example" "backend/.env"
    Write-Host "✅ Created backend/.env" -ForegroundColor Green
}

if (Test-Path "frontend/.env.example" -and -not (Test-Path "frontend/.env")) {
    Copy-Item "frontend/.env.example" "frontend/.env"
    Write-Host "✅ Created frontend/.env" -ForegroundColor Green
}

# Initialize git if not already initialized
if (-not (Test-Path ".git")) {
    Write-Host "🔧 Initializing git repository..." -ForegroundColor Blue
    git init
    git add .
    git commit -m "Initial commit: $ProjectName from template"
    Write-Host "✅ Git repository initialized" -ForegroundColor Green
}

Write-Host ""
Write-Host "🎉 Template initialization complete!" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Blue
Write-Host "1. Run: make setup" -ForegroundColor White
Write-Host "2. Run: make dev" -ForegroundColor White
Write-Host "3. Start coding your $ProjectName!" -ForegroundColor White
