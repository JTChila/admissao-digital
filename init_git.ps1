$GitExe = "C:\Users\Usuario\.gemini\antigravity\brain\5e78d2d8-2d22-4a1c-8479-c288ab5dd5bc\scratch\mingit\cmd\git.exe"
$Dir = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $Dir

Write-Host "Inicializando repositorio Git em $Dir..." -ForegroundColor Cyan
& $GitExe init
& $GitExe config user.name "Juliano Chila"
& $GitExe config user.email "julianotchila@hotmail.com"
& $GitExe add .
& $GitExe commit -m "feat: initial release of AdmissaoFlow - portal e validador inteligente de documentos admissionais"
& $GitExe branch -M main

$remotes = & $GitExe remote
if ($remotes -contains "origin") {
    & $GitExe remote set-url origin "https://github.com/JTChila/admissao-digital.git"
} else {
    & $GitExe remote add origin "https://github.com/JTChila/admissao-digital.git"
}

Write-Host "Fazendo push para o GitHub..." -ForegroundColor Cyan
& $GitExe push -u origin main -f

Write-Host "Tudo pronto!" -ForegroundColor Green
