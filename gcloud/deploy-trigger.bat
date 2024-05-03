@echo off
:: Check for correct number of command line arguments
if "%~1"=="" (
    echo Usage: %0 ^<filename^>
    exit /b 1
)

:: Warn about repo linking
echo Make sure you have added the repo to v1 cloud build connections

:: Get vars
set "FILENAME=%~1"
for /f "tokens=2" %%a in ('findstr /r "^name:" "%FILENAME%"') do set "TRIGGERNAME=%%a"
echo Deploying %TRIGGERNAME% from %FILENAME%

:: Create or update the trigger
gcloud builds triggers create github --trigger-config="%FILENAME%" || gcloud builds triggers update github %TRIGGERNAME% --trigger-config="%FILENAME%" || echo Failed to create or update trigger

echo Deployed %FILENAME% Trigger, Press any key to exit
pause >nul
