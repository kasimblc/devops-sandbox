param (
    [string]$serverId
)

# YAML modülünü içe aktar
Import-Module -Name powershell-yaml

# YAML dosyasını oku
$yamlFilePath = "S:\livasoft\yml\config.yml"


if (-Not (Test-Path $yamlFilePath)) {
    Write-Host "YAML dosyası bulunamadı: $yamlFilePath"
    exit 1
}

$yamlData = Get-Content $yamlFilePath -Raw | ConvertFrom-Yaml

# Sunucu id'sine göre doğru sunucuyu bul
$server = $yamlData.setup.servers | Where-Object { $_.id -eq $serverId }
if (-not $server) {
    $server = $yamlData.staging.servers | Where-Object { $_.id -eq $serverId }
}
if (-not $server) {
    $server = $yamlData.prod.servers | Where-Object { $_.id -eq $serverId }
}

# Sunucu bulunursa değerlerini yazdır
if ($server) {
    $server.args | ConvertTo-Json -Depth 2
} else {
    Write-Host "Sunucu bulunamadı: $serverId"
}
