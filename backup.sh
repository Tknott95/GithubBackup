#!/bin/sh

# PAGE=1

# source .env



# Iif wanting to optmize from length (works on public only)
# curl -H "Authorization: token $GITHUB_API_KEY" -s "https://api.github.com/users/$1" | jq '.public_repos'

# Only saves public - assumes less than 900
# for PAGE in {1..9}; do
#   curl -H "Authorization: token $GITHUB_API_KEY" -s "https://api.github.com/users/$1/repos?per_page=1000&page=$PAGE" | jq -r .[].clone_url >> repos.txt
# done


# MUST SETUP gh auth  (github-cli)
# ./backup.sh
rm -f repos.txt ; touch repos.txt

# the only way to get private repos also is to use gh to list them
# Setup gh auth

# PUBLIC AND PRIVATE
gh repo list --json url --limit 9999 | jq .[].url >> repos.txt
