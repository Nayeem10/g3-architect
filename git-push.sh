#!/bin/bash

TOKEN_FILE="/home/nayeemha/Documents/webdev/github_token.txt"

if [ ! -f "$TOKEN_FILE" ]; then
  echo "Token file not found at $TOKEN_FILE. Exiting."
  exit 1
fi

GITHUB_TOKEN=$(cat "$TOKEN_FILE")

if [ -z "$GITHUB_TOKEN" ]; then
  echo "GitHub token is empty. Exiting."
  exit 1
fi

REPO_URL=$(git config --get remote.origin.url)

if [ -z "$REPO_URL" ]; then
  echo "Repository URL not found. Are you in a git repository? Exiting."
  exit 1
fi

AUTH_REPO_URL=$(echo "$REPO_URL" | sed -e "s/https:\/\//https:\/\/$GITHUB_TOKEN@/")

git add .

read -p 'Enter commit message: ' COMMIT_MESSAGE
git commit -m "$COMMIT_MESSAGE"

git push "$AUTH_REPO_URL"

unset GITHUB_TOKEN
echo "Code pushed successfully."
