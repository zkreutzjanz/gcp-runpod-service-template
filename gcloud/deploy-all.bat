@echo off
setlocal enabledelayedexpansion

REM Check if the environment variable is provided
if "%~1"=="" (
    echo Environment variable is missing.
    exit /b 1
)

REM Loop through all secret files matching the environment
for %%f in (*-%1*.secret) do (
    echo Deploying secret file: %%f
    call deploy-secret.bat "%%f"
)

@REM REM Loop through all YAML files starting with trigger- and containing the environment
@REM for %%f in (trigger*-%1*) do (
@REM     echo Deploying trigger YAML file: %%f
@REM     call deploy-trigger.bat "%%f"
@REM )

echo Done processing files.
endlocal
