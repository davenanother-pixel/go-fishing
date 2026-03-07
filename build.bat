@echo off
REM Go Fishing - Build Script
REM This script builds the entire solution and creates release artifacts

setlocal enabledelayedexpansion
cd /d "%~dp0"

echo ========================================
echo Go Fishing - Build Script
echo ========================================
echo.

REM Check if .NET is installed
dotnet --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: .NET SDK not found. Please install .NET 8.0 SDK
    echo Available at: https://dotnet.microsoft.com/download/dotnet/8.0
    pause
    exit /b 1
)

echo [1/5] Cleaning previous builds...
dotnet clean GoFishing.sln --nologo --verbosity quiet
if errorlevel 1 (
    echo ERROR: Failed to clean solution
    pause
    exit /b 1
)

echo [2/5] Restoring NuGet packages...
dotnet restore GoFishing.sln --nologo --verbosity quiet
if errorlevel 1 (
    echo ERROR: Failed to restore packages
    pause
    exit /b 1
)

echo [3/5] Building solution...
dotnet build GoFishing.sln -c Release --nologo --verbosity normal
if errorlevel 1 (
    echo ERROR: Build failed
    pause
    exit /b 1
)

echo.
echo [4/5] Creating release package...
if not exist "publish" mkdir "publish"

dotnet publish GoFishing.Game\GoFishing.Game.csproj -c Release -o publish\GoFishing --nologo --self-contained -r win-x64 --no-restore
if errorlevel 1 (
    echo ERROR: Publish failed
    pause
    exit /b 1
)

if exist "publish\\GoFishing\\GoFishing.Game.exe" (
    copy /Y "publish\\GoFishing\\GoFishing.Game.exe" "publish\\GoFishing\\Go Fishing.exe" >nul
    >"publish\\GoFishing\\Go Fishing.cmd" echo @echo off
    >>"publish\\GoFishing\\Go Fishing.cmd" echo start "" "%%~dp0Go Fishing.exe"
)

echo [5/5] Creating archive...
if exist "GoFishing-Release.zip" del "GoFishing-Release.zip"

setlocal enabledelayedexpansion
for /d %%x in (publish\GoFishing\*) do set "PUBLISH_DIR=publish\GoFishing"

if exist "!PUBLISH_DIR!" (
    powershell -Command "Compress-Archive -Path 'publish\GoFishing' -DestinationPath 'GoFishing-Release.zip' -Force"
    echo.
    echo ========================================
    echo Build Complete!
    echo ========================================
    echo.
    echo Output locations:
    echo - Executable: %cd%\publish\GoFishing\Go Fishing.exe
    echo - Launcher: %cd%\publish\GoFishing\Go Fishing.cmd
    echo - Legacy name: %cd%\publish\GoFishing\GoFishing.Game.exe
    echo - Archive: %cd%\GoFishing-Release.zip
    echo.
    echo To run the game:
    echo   publish\GoFishing\Go Fishing.cmd
    echo.
) else (
    echo ERROR: Publish directory not found
    pause
    exit /b 1
)

pause
