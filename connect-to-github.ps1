# Run once inside this folder to link it to your GitHub repo
git init -b main
git remote add origin https://github.com/prashantkr102004-ui/DevOps-Assignment.git
git fetch origin
git reset origin/main
git branch --set-upstream-to=origin/main main
git status
