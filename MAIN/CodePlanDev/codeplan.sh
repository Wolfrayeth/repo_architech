#!/usr/bin/env bash

if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
    echo "Usage: ./codeplan.sh <path> <repository-url> <branch>"
    exit 1
fi

PATH_TO_CHECKOUT="$1"
REPO_URL="$2"
BRANCH="$3"

if [ ! -d "CODEPLAN/.git" ]; then
    mkdir -p CODEPLAN
    cd CODEPLAN || exit 1

    git clone \
        --filter=blob:none \
        --sparse \
        --branch "$BRANCH" \
        "$REPO_URL" .

    git sparse-checkout set "$PATH_TO_CHECKOUT"

else
    cd CODEPLAN || exit 1

    git fetch origin "$BRANCH"

    WORKTREE_DIR="$BRANCH"

    mkdir -p "$WORKTREE_DIR"

    git worktree add --detach "$WORKTREE_DIR" "origin/$BRANCH"

    cd "$WORKTREE_DIR" || exit 1

    git sparse-checkout init --cone
    git sparse-checkout set "$PATH_TO_CHECKOUT"
fi