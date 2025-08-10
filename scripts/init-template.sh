#!/usr/bin/env bash
# Template Initialization Script (Unix/macOS)
# Mirrors functionality of init-template.ps1 for non-Windows users
set -euo pipefail

PROJECT_NAME=""
DESCRIPTION="A full-stack application with FastAPI backend and React frontend"
AUTHOR="Your Name"

usage() {
  cat <<EOF
Usage: ./scripts/init-template.sh -n project-name [-d description] [-a author]

Options:
  -n  Project name (kebab-case, required)
  -d  Description (optional)
  -a  Author (optional)
  -h  Help
EOF
}

while getopts ":n:d:a:h" opt; do
  case ${opt} in
    n) PROJECT_NAME=$OPTARG ;;
    d) DESCRIPTION=$OPTARG ;;
    a) AUTHOR=$OPTARG ;;
    h) usage; exit 0 ;;
    :) echo "Missing argument for -$OPTARG" >&2; usage; exit 1 ;;
    \?) echo "Invalid option -$OPTARG" >&2; usage; exit 1 ;;
  esac
done

if [[ -z "${PROJECT_NAME}" ]]; then
  echo "Error: project name required" >&2
  usage
  exit 1
fi

if [[ ! ${PROJECT_NAME} =~ ^[a-z][a-z0-9-]*[a-z0-9]$ ]]; then
  echo "Project name should be kebab-case (lowercase letters, digits, hyphens)" >&2
  echo "Example: my-awesome-project" >&2
  exit 1
fi

echo -e "🚀 Initializing template for project: ${PROJECT_NAME}\n"
update_file() {
  local path=$1
  local find=$2
  local replace=$3
  if [[ -f "$path" ]]; then
    # Use perl for inplace replace to keep formatting
    perl -0777 -pe "s/\Q${find}\E/${replace}/g" "$path" >"$path.tmp" && mv "$path.tmp" "$path"
    echo "✅ Updated $path"
  else
    echo "⚠️  File not found: $path"
  fi
}

# Replacements
update_file backend/app/core/config.py 'app_name: str = "python-react-startup"' "app_name: str = \"${PROJECT_NAME}\""
update_file backend/.env.example 'APP_NAME=python-react-startup' "APP_NAME=${PROJECT_NAME}"
update_file backend/Makefile 'python-react-startup-backend' "${PROJECT_NAME}-backend"
update_file Makefile 'Setting up python-react-startup project...' "Setting up ${PROJECT_NAME} project..."
update_file frontend/package.json '"name": "frontend"' "\"name\": \"${PROJECT_NAME}-frontend\""
# README project heading and slug occurrences
if [[ -f README.md ]]; then
  perl -0777 -pe "s/^# Python React Startup Template/# ${PROJECT_NAME}/" README.md > README.md.tmp && mv README.md.tmp README.md
  perl -0777 -pe "s/python-react-startup/${PROJECT_NAME}/g" README.md > README.md.tmp && mv README.md.tmp README.md
fi

# README description replacement
if [[ -f README.md ]]; then
  perl -0777 -pe "s/Modern full-stack starter with FastAPI \+ React TypeScript/${DESCRIPTION}/" README.md > README.md.tmp && mv README.md.tmp README.md
fi

# Update package.json description (frontend)
if [[ -f frontend/package.json ]]; then
  # Use jq if available, fallback to regex replace
  if command -v jq >/dev/null 2>&1; then
    tmp=$(mktemp)
    jq --arg name "${PROJECT_NAME}-frontend" --arg desc "${DESCRIPTION}" '.name=$name | .description=$desc' frontend/package.json > "$tmp" && mv "$tmp" frontend/package.json
  else
    perl -0777 -pe 's/"name":\s*"[^"]+"/"name": "'${PROJECT_NAME}'-frontend"/' frontend/package.json > frontend/package.json.tmp && mv frontend/package.json.tmp frontend/package.json
  fi
  echo "✅ Updated frontend/package.json"
fi

# Create env files if missing
echo "📄 Setting up environment files..."
[[ -f backend/.env ]] || (cp backend/.env.example backend/.env && echo "✅ Created backend/.env")
[[ -f frontend/.env ]] || (cp frontend/.env.example frontend/.env && echo "✅ Created frontend/.env")

# Initialize git if missing
if [[ ! -d .git ]]; then
  echo "🔧 Initializing git repository..."
  git init
  git add .
  git commit -m "Initial commit: ${PROJECT_NAME} from template"
  echo "✅ Git repository initialized"
fi

echo
echo "🎉 Template initialization complete!"
echo
echo "Next steps:"
echo "1. make setup"
echo "2. make dev"
echo "3. Start coding your ${PROJECT_NAME}!"
