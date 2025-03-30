# Convert line endings in shell scripts from CRLF to LF
$files = Get-ChildItem -Path . -Recurse -Filter "*.sh"
foreach ($file in $files) {
    Write-Host "Converting line endings in $($file.FullName)"
    $content = Get-Content $file.FullName -Raw
    $content = $content -replace "`r`n", "`n"
    [System.IO.File]::WriteAllText($file.FullName, $content)
}
Write-Host "Line endings conversion complete!" 