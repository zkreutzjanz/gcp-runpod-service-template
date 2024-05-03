@echo off
:: Check for the correct number of command line arguments
if "%~1"=="" (
    echo Usage: %0 ^<config-file^>
    exit /b 1
)

:: Extract just the filename from the provided path, without the extension, to use as the secret name
set "CONFIGFILE=%~1"
set "FILENAME=%~nx1"
for /f "delims=." %%a in ("%FILENAME%") do set "SECRETNAME=%%a"
echo Deploying %SECRETNAME% from %CONFIGFILE%

:: Create the secret
gcloud secrets create %SECRETNAME% --data-file="%CONFIGFILE%" || gcloud secrets versions add %SECRETNAME% --data-file="%CONFIGFILE%" || echo Failed to create or update secret
