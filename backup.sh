#!/bin/sh

# ./backup.sh <username>

curl "https://api.github.com/users/$1/repos?per_page=1000" | jq -r .[].clone_url | repos.txt

