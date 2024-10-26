#!/bin/sh

# MUST SETUP gh auth as api style via curl only hits public repos (github-cli)
# ./backup.sh <BACKUP-LOCATION>
rm -f repos.txt ; touch repos.txt

# the only way to get private repos also is to use gh to list them
# Setup gh auth

# PUBLIC AND PRIVATE - HTTPS or SSH
# gh repo list --json url --limit 9999 | jq .[].url >> repos.txt
gh repo list --json sshUrl --limit 9999 | jq .[].sshUrl >> repos.txt

mapfile -t repos_array < <(sed 's/^"\(.*\)"$/\1/;s/^[ \t]*//;s/[ \t]*$//' repos.txt)
# sed uses regex to remove " from repos.txt as it was breaking git clone

for temp_repo_name in "${repos_array[@]}"; do
  echo -e "\n  CLONING: $temp_repo_name"
  git clone $temp_repo_name $1
done
