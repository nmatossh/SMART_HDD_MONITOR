# Ruta del log
$logPath = "D:\Logs\smart_log.txt"

# Discos a monitorear
$discos = @("/dev/sda","/dev/sdb")  # agreg� m�s si necesit�s

# Mensaje de ejecuci�n
Write-Host "El script de monitoreo SMART se est� ejecutando.
Ctrl+C para detenerlo.
Escribiendo en D:/Logs/smart_log.txt"

# Funci�n para loguear el estado SMART
function Log-SMART {
    param($disco)
    $fecha = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $output = smartctl -a $disco
    # Extraer solo atributos relevantes
    $attrs = $output | Select-String -Pattern "Start_Stop_Count|Power_Cycle_Count|Current_Pending_Sector|Reallocated_Sector_Ct|UDMA_CRC_Error_Count|Command_Timeout"
    $logEntry = "$fecha - Disco: $disco`r`n$($attrs -join "`r`n")`r`n"
    Add-Content -Path $logPath -Value $logEntry
}

# Bucle infinito con espera de 10 minutos
while ($true) {
    foreach ($d in $discos) {
        Log-SMART $d
        Write-Host "Se registr� el disco $d a las $(Get-Date -Format 'HH:mm:ss')"
    }
    Write-Host "Esperando 10 minutos antes de la pr�xima revisi�n..."
    Start-Sleep -Seconds 600
}