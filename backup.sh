#!/bin/sh

# MUST SETUP gh auth as api style via curl only hits public repos (github-cli)
# the only way to get private repos also is to use gh to list them
# Setup gh auth

EXAMPLE
# ./backup.sh <BACKUP-LOCATION>
# ./backup.sh ~/Documents
# ./backup.sh "/mnt/id7/GITHUB_BACKUPS"
# ./backup.sh "/run/media/U5B/GITHUB_BACKUPS"

rm -f repos.txt ; touch repos.txt

# PUBLIC AND PRIVATE - HTTPS or SSH
# gh repo list --json url --limit 9999 | jq .[].url >> repos.txt
gh repo list --json sshUrl --limit 9999 | jq .[].sshUrl >> repos.txt

mapfile -t repos_array < <(sed 's/^"\(.*\)"$/\1/;s/^[ \t]*//;s/[ \t]*$//' repos.txt)
# sed uses regex to remove " from repos.txt lines as it was breaking the git clone command

for temp_repo_name in "${repos_array[@]}"; do
  echo -e "\n  CLONING: $temp_repo_name"
  git clone $temp_repo_name $1
done
