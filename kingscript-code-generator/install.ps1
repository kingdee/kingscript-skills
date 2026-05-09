param(
    [string]$TargetDir
)

$ErrorActionPreference = "Stop"

$SkillName = "kingscript-code-generator"
$ScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path

if (-not $TargetDir) {
    $TargetDir = Join-Path $env:USERPROFILE ".qoder\skills\$SkillName"
}

Write-Host "Installing $SkillName ..." -ForegroundColor Cyan
Write-Host "Target: $TargetDir" -ForegroundColor Cyan

if (Test-Path $TargetDir) {
    Write-Host "Existing bundle found, replacing it..." -ForegroundColor Yellow
    Remove-Item -Path $TargetDir -Recurse -Force
}

New-Item -ItemType Directory -Path $TargetDir -Force | Out-Null

# --- 复制整个仓库内容到目标目录 ---
Get-ChildItem -Path $ScriptRoot -Exclude @(".git", "install.ps1", "install.sh") |
    Copy-Item -Destination $TargetDir -Recurse -Force

# --- 验证 ---
$required = @("references", "SKILL.md", "CLAUDE.md", "AGENTS.md")
$missing = @()
foreach ($entry in $required) {
    if (-not (Test-Path (Join-Path $TargetDir $entry))) {
        $missing += $entry
    }
}

if ($missing.Count -gt 0) {
    throw "Install verification failed. Missing: $($missing -join ', ')"
}

Write-Host "Verification passed." -ForegroundColor Green
Write-Host "Install complete." -ForegroundColor Green
Write-Host "Bundle path: $TargetDir" -ForegroundColor Cyan
