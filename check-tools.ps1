# Shows which tools are installed and how to install the missing ones
$tools = [ordered]@{
    "git"      = "winget install --id Git.Git -e"
    "docker"   = "winget install --id Docker.DockerDesktop -e"
    "minikube" = "winget install --id Kubernetes.minikube -e"
    "kubectl"  = "winget install --id Kubernetes.kubectl -e"
    "python"   = "winget install --id Python.Python.3.12 -e"
}
$missing = @()
foreach ($t in $tools.Keys) {
    if (Get-Command $t -ErrorAction SilentlyContinue) {
        Write-Host ("[OK]      " + $t) -ForegroundColor Green
    } else {
        Write-Host ("[MISSING] " + $t + "   ->  " + $tools[$t]) -ForegroundColor Red
        $missing += $tools[$t]
    }
}
if ($missing.Count) {
    Write-Host "`nInstall the missing ones with:" -ForegroundColor Yellow
    $missing | ForEach-Object { Write-Host "  $_" }
    Write-Host "Then close and reopen PowerShell and run .\check-tools.ps1 again."
} else {
    Write-Host "`nAll tools installed. Make sure Docker Desktop is open before running exercises." -ForegroundColor Green
}
