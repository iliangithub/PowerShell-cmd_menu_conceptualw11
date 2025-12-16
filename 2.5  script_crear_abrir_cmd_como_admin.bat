@echo off
chcp 65001 >nul
setlocal

:: --- 1) FORZAR EJECUCIÓN COMO ADMINISTRADOR ---
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Elevando permisos...
    powershell -command "Start-Process '%~f0' -Verb runAs"
    exit /b
)

echo Ejecutando como administrador...

:: --- 2) IMPORTAR EL ARCHIVO .REG ---
set "REGFILE=%~dp0NO TOCAR\cmd_admin.reg"

if not exist "%REGFILE%" (
    echo ERROR: No se encuentra "%REGFILE%"
    pause
    exit /b
)

echo Importando claves del registro...
regedit /s "%REGFILE%"

echo.
echo ============================================
echo  Claves importadas correctamente.
echo  Ya deberías ver:
echo  "Abrir CMD aquí como administrador"
echo  en el menú contextual.
echo ============================================
echo.
pause
