# HDD Smart Monitoring Script

* Control de monitoreo personal básico para smart en 2 HDD RAID1. Reporte de log cada 10 minutos (600 segundos).

* Modificar la ruta /dev/sda y y /dev/sdb a conveniencia.

* Requiere tener instalado smartctl.exe. Este script fué realizado con la versión smartmontools-7.5.win32-setup.exe

* En Windows ---> Ejecutar con Powershell

📌 Changelog – Script SMART Monitor v1.1

Versión: 1.1
Fecha de cierre: 2025-09-05

✅ Funcionalidades actuales

Monitoreo de discos: lista de dispositivos configurable (/dev/sda, /dev/sdb, etc.).
Extracción de atributos SMART relevantes:
Start_Stop_Count
Power_Cycle_Count
Current_Pending_Sector
Reallocated_Sector_Ct
UDMA_CRC_Error_Count
Command_Timeout
Logging persistente: guarda resultados en D:\Logs\smart_log.txt.
Salida en tiempo real: muestra en pantalla los atributos y confirmación de registro para cada disco.
Contador visual: cronómetro regresivo de 10 minutos antes de la próxima revisión, en formato MM:SS.
Bucle infinito: ejecución continua hasta interrupción manual (Ctrl+C).

📂 Estructura de ejecución

Al inicio: muestra mensaje de arranque con ruta de log y discos a monitorear.

Por cada ciclo:

Se registran todos los discos definidos.
Se imprime confirmación en consola.
Se ejecuta cuenta regresiva visible de 10 minutos.
Repite indefinidamente.
