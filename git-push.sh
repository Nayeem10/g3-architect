#!/bin/bash

# Path to the file containing the GitHub token
TOKEN_FILE="/home/nayeemha/Documents/webdev/github_token.txt"

# Check if the token file exists
if [ ! -f "$TOKEN_FILE" ]; then
  echo "Token file not found at $TOKEN_FILE. Exiting."
  exit 1
fi

# Read the GitHub token from the file
GITHUB_TOKEN=$(cat "$TOKEN_FILE")

# Check if the token is empty
if [ -z "$GITHUB_TOKEN" ]; then
  echo "GitHub token is empty. Exiting."
  exit 1
fi

# Get the repository URL from the git config
REPO_URL=$(git config --get remote.origin.url)

# Check if the repository URL is retrieved
if [ -z "$REPO_URL" ]; then
  echo "Repository URL not found. Are you in a git repository? Exiting."
  exit 1
fi

# Replace https:// with https://<token>@ for authentication
AUTH_REPO_URL=$(echo "$REPO_URL" | sed -e "s/https:\/\//https:\/\/$GITHUB_TOKEN@/")

# Add all changes to staging
git add .

# Commit changes with a message
read -p 'Enter commit message: ' COMMIT_MESSAGE
git commit -m "$COMMIT_MESSAGE"

# Push changes to the repository
git push "$AUTH_REPO_URL"

# Clear the GitHub token from memory
unset GITHUB_TOKEN
echo "Code pushed successfully."

