# Run once inside this folder to link it to your GitHub repo
Set-Location $PSScriptRoot

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "Git is not installed. Run this, then close and reopen PowerShell:" -ForegroundColor Red
    Write-Host "  winget install --id Git.Git -e --source winget" -ForegroundColor Yellow
    exit 1
}

if (-not (Test-Path .git)) { git init -b main }
if (-not (git remote 2>$null | Select-String -Quiet origin)) {
    git remote add origin https://github.com/prashantkr102004-ui/DevOps-Assignment.git
}
git config user.name  "Prashant Kumar"
git config user.email "prashantkr102004@gmail.com"
git config core.autocrlf true
git fetch origin
git reset origin/main
git branch --set-upstream-to=origin/main main
git status
Write-Host "`nFolder is linked to GitHub." -ForegroundColor Green
