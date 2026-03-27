param(
    [ValidateSet("codex", "qoder", "claude")]
    [string]$Platform = "codex",
    [string]$TargetDir
)

$ErrorActionPreference = "Stop"

$SkillName = "kingscript-code-generator"
$ScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path

function Get-DefaultTargetDir {
    param([string]$SelectedPlatform)

    switch ($SelectedPlatform) {
        "codex" {
            return Join-Path $env:USERPROFILE ".agents\skills\$SkillName"
        }
        "qoder" {
            return Join-Path $env:USERPROFILE ".qoder\skills\$SkillName"
        }
        "claude" {
            return Join-Path $env:USERPROFILE ".claude\skills\$SkillName"
        }
        default {
            throw "Unsupported platform: $SelectedPlatform"
        }
    }
}

function Copy-DirectoryContent {
    param(
        [string]$Source,
        [string]$Destination
    )

    if (-not (Test-Path $Source)) {
        throw "Missing source directory: $Source"
    }

    New-Item -ItemType Directory -Path $Destination -Force | Out-Null
    Copy-Item -Path (Join-Path $Source "*") -Destination $Destination -Recurse -Force
}

function Copy-FileToRoot {
    param(
        [string]$Source,
        [string]$DestinationDir,
        [string]$DestinationName
    )

    if (-not (Test-Path $Source)) {
        throw "Missing source file: $Source"
    }

    New-Item -ItemType Directory -Path $DestinationDir -Force | Out-Null
    Copy-Item -Path $Source -Destination (Join-Path $DestinationDir $DestinationName) -Force
}

function Copy-TextFileWithReplacements {
    param(
        [string]$Source,
        [string]$Destination,
        [hashtable]$Replacements
    )

    if (-not (Test-Path $Source)) {
        throw "Missing source file: $Source"
    }

    $parent = Split-Path -Parent $Destination
    if ($parent) {
        New-Item -ItemType Directory -Path $parent -Force | Out-Null
    }

    $content = [System.IO.File]::ReadAllText($Source, [System.Text.Encoding]::UTF8)
    foreach ($key in $Replacements.Keys) {
        $content = $content.Replace($key, $Replacements[$key])
    }
    $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
    [System.IO.File]::WriteAllText($Destination, $content, $utf8NoBom)
}

function Get-ExpectedEntries {
    param([string]$SelectedPlatform)

    $entries = @("references", "SKILL.md")

    switch ($SelectedPlatform) {
        "codex" {
            $entries += @("AGENTS.md", "agents")
        }
        "claude" {
            $entries += @("CLAUDE.md", "commands")
        }
    }

    return $entries
}

function Test-InstalledBundle {
    param(
        [string]$SelectedPlatform,
        [string]$Destination
    )

    $missing = @()
    foreach ($entry in (Get-ExpectedEntries -SelectedPlatform $SelectedPlatform)) {
        $target = Join-Path $Destination $entry
        if (-not (Test-Path $target)) {
            $missing += $entry
        }
    }

    if ($missing.Count -gt 0) {
        throw "Install verification failed. Missing entries: $($missing -join ', ')"
    }
}

if (-not $TargetDir) {
    $TargetDir = Get-DefaultTargetDir -SelectedPlatform $Platform
}

Write-Host "Installing $SkillName for $Platform ..." -ForegroundColor Cyan
Write-Host "Target: $TargetDir" -ForegroundColor Cyan

if (Test-Path $TargetDir) {
    Write-Host "Existing bundle found, replacing it..." -ForegroundColor Yellow
    Remove-Item -Path $TargetDir -Recurse -Force
}

New-Item -ItemType Directory -Path $TargetDir -Force | Out-Null
Copy-DirectoryContent -Source (Join-Path $ScriptRoot "references") -Destination (Join-Path $TargetDir "references")

switch ($Platform) {
    "codex" {
        $rootReplacements = @{
            "../references/" = "./references/"
        }
        Copy-TextFileWithReplacements -Source (Join-Path $ScriptRoot "codex\SKILL.md") -Destination (Join-Path $TargetDir "SKILL.md") -Replacements $rootReplacements
        Copy-TextFileWithReplacements -Source (Join-Path $ScriptRoot "codex\AGENTS.md") -Destination (Join-Path $TargetDir "AGENTS.md") -Replacements $rootReplacements
        Copy-DirectoryContent -Source (Join-Path $ScriptRoot "codex\agents") -Destination (Join-Path $TargetDir "agents")
    }
    "qoder" {
        Copy-TextFileWithReplacements -Source (Join-Path $ScriptRoot "qoder\SKILL.md") -Destination (Join-Path $TargetDir "SKILL.md") -Replacements @{
            "../references/" = "./references/"
        }
    }
    "claude" {
        Copy-FileToRoot -Source (Join-Path $ScriptRoot "claude-code\SKILL.md") -DestinationDir $TargetDir -DestinationName "SKILL.md"
        Copy-TextFileWithReplacements -Source (Join-Path $ScriptRoot "claude-code\CLAUDE.md") -Destination (Join-Path $TargetDir "CLAUDE.md") -Replacements @{
            "../references/" = "./references/"
        }

        $commandsDir = Join-Path $TargetDir "commands"
        New-Item -ItemType Directory -Path $commandsDir -Force | Out-Null
        Get-ChildItem -Path (Join-Path $ScriptRoot "claude-code\commands") -File | ForEach-Object {
            Copy-TextFileWithReplacements -Source $_.FullName -Destination (Join-Path $commandsDir $_.Name) -Replacements @{
                "../../references/" = "../references/"
            }
        }
    }
}

Write-Host ""
Test-InstalledBundle -SelectedPlatform $Platform -Destination $TargetDir
Write-Host "Verification passed." -ForegroundColor Green
Write-Host "Install complete." -ForegroundColor Green
Write-Host "Bundle path: $TargetDir" -ForegroundColor Cyan
