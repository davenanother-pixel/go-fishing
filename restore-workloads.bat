@echo off
REM Fix ERR_SDK_COMPONENT_MISSING by restoring .NET workloads for the Game project.
REM Run from repo root: restore-workloads.bat
echo Restoring .NET workloads for Go Fishing...
dotnet workload restore GoFishing.Game\GoFishing.Game.csproj
if %ERRORLEVEL% neq 0 (
  echo.
  echo If workload install failed, ensure you have .NET 8.0 SDK installed:
  echo   https://dotnet.microsoft.com/download/dotnet/8.0
  echo.
  echo Then run: dotnet workload install windowsdesktop
  echo (Use the workload ID shown in your error message if different.)
  exit /b 1
)
echo.
echo Done. Try building again: dotnet build GoFishing.sln
exit /b 0
