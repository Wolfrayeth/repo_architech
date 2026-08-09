#!/usr/bin/env bash

if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
    echo "Usage: ./codeplan.sh <path> <repository-url> <branch>"
    exit 1
fi

PATH_TO_CHECKOUT="$1"
REPO_URL="$2"
BRANCH="$3"

if [ -d "CODEPLAN/.git" ]; then
    echo "CODEPLAN is already initialized."
    exit 1
fi

mkdir -p CODEPLAN
cd CODEPLAN || exit 1

git clone \
    --filter=blob:none \
    --sparse \
    --branch "$BRANCH" \
    "$REPO_URL" .

git sparse-checkout set "$PATH_TO_CHECKOUT"