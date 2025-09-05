# Ruta del log
$logPath = "D:\Logs\smart_log.txt"

# Discos a monitorear
$discos = @("/dev/sda","/dev/sdb")  # agregá más si necesitás

# Mensaje de ejecución
Write-Host "El script de monitoreo SMART se está ejecutando. Ctrl+C para detenerlo.
Escribiendo en D:/Logs/smart_log.txt.
Discos a monitorear: $($discos -join ', ')"

# Función para loguear el estado SMART
function Log-SMART {
    param($disco)
    $fecha = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $output = smartctl -a $disco
    # Extraer solo atributos relevantes
    $attrs = $output | Select-String -Pattern "Start_Stop_Count|Power_Cycle_Count|Current_Pending_Sector|Reallocated_Sector_Ct|UDMA_CRC_Error_Count|Command_Timeout"
    $logEntry = "$fecha - Disco: $disco`r`n$($attrs -join "`r`n")`r`n"
    Add-Content -Path $logPath -Value $logEntry
}

# Bucle infinito con espera de 10 minutos y contador visual seguro
while ($true) {
    foreach ($d in $discos) {
        Log-SMART $d
        Write-Host "Se registró el disco $d a las $(Get-Date -Format 'HH:mm:ss')"
    }

    $waitSeconds = 600  # 10 minutos
    for ($i = $waitSeconds; $i -ge 0; $i--) {
        $minutes = [int]([math]::Floor($i / 60))
        $seconds = [int]($i % 60)
        Write-Host ("`rPróxima revisión en: {0:D2}:{1:D2}" -f $minutes, $seconds) -NoNewline
        Start-Sleep -Seconds 1
    }
    Write-Host ""  # Salto de línea al terminar la cuenta
}
