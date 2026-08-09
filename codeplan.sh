#!/usr/bin/env bash

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: ./codeplan.sh <project-directory> <repository-url>"
    exit 1
fi

PROJECT="$1"
REPO_URL="$2"

if [ -d "CODEPLAN/.git" ]; then
    echo "CODEPLAN is already initialized."
    exit 1
fi

mkdir -p CODEPLAN
cd CODEPLAN || exit 1

git clone --filter=blob:none --sparse "$REPO_URL" .

git sparse-checkout set "$PROJECT"