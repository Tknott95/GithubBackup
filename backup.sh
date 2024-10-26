#!/bin/sh

# ./backup.sh <username>
rm -f repos.txt
curl "https://api.github.com/users/$1/repos?per_page=1000" | jq -r .[].clone_url | repos.txt
