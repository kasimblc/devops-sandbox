# read.ps1

param (
    [string]$serverId
)

# Aguments dosyasını içe aktar
. "$PSScriptRoot\arguments.ps1"  # PSScriptRoot kullanarak yol belirle

# Sunucu id'sine göre doğru sunucuyu bul
$server = $null

if ($setup.servers.id -contains $serverId) {
    $server = $setup.servers | Where-Object { $_.id -eq $serverId }
}
elseif ($staging.servers.id -contains $serverId) {
    $server = $staging.servers | Where-Object { $_.id -eq $serverId }
}
elseif ($prod.servers.id -contains $serverId) {
    $server = $prod.servers | Where-Object { $_.id -eq $serverId }
}

# Sunucu bulunursa değerlerini yazdır
if ($server) {
    $server.args
} else {
    Write-Host "Sunucu bulunamadı: $serverId"
}
