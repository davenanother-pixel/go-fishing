# GO FISHING - Setup Guide & Installation

## System Requirements

### Minimum Requirements
- **OS**: Windows 10 Build 19041 or Windows 11
- **Processor**: Intel Core i5-8400 or AMD Ryzen 5 2600
- **Memory**: 4 GB RAM
- **Graphics**: NVIDIA GTX 1050 or AMD RX 560 (DirectX 11 support)
- **DirectX**: Version 11
- **Storage**: 2 GB available space
- **.NET Runtime**: .NET 8.0 Runtime

### Recommended Requirements
- **OS**: Windows 11 (22H2 or later)
- **Processor**: Intel Core i7-10700 or AMD Ryzen 7 3700X
- **Memory**: 16 GB RAM
- **Graphics**: NVIDIA RTX 2080 or AMD RX 6700 (DirectX 12 support)
- **DirectX**: Version 12
- **Storage**: SSD with 2GB free space
- **.NET Runtime**: .NET 8.0 Runtime

## Installation Steps

### Step 1: Install .NET 8.0 Runtime
1. Visit https://dotnet.microsoft.com/download/dotnet/8.0
2. Download ".NET 8.0 Runtime" (not SDK, unless you're developing)
3. Run the installer and follow instructions
4. Restart your computer

### Step 2: Download Go Fishing
1. Clone or download the project repository
2. Extract to desired location (e.g., `C:\Games\GoFishing`)
3. Ensure no special characters in path

### Step 3: Build the Game
```bash
cd C:\Games\GoFishing
dotnet build GoFishing.sln -c Release
```

### Step 4: Run the Game
```bash
# Development/Debug mode
dotnet run --project GoFishing.Game\GoFishing.Game.csproj

# Release mode (recommended)
dotnet GoFishing.Game\bin\Release\net8.0-windows\GoFishing.Game.exe
```

### Step 5: Verify Installation
- Game window should open with black screen
- No DirectX errors in console
- Settings file created in `%APPDATA%\GoFishing\`

## DirectX Setup

### Checking Your DirectX Version
1. Press `Windows + R`
2. Type `dxdiag` and press Enter
3. Look at "System" tab
4. Note your DirectX version

### Updating DirectX
1. Visit https://support.microsoft.com/en-us/help/179113
2. Download "Latest DirectX End-User Runtime Web Installer"
3. Run installer even if you have DirectX 12 (it updates legacy files)

### GPU Driver Updates

#### NVIDIA
```bash
# Check current version
nvidia-smi

# Update drivers from:
https://www.nvidia.com/Download/driverDetails.aspx
```

#### AMD
```bash
# Check current version
amd-settings.exe --version

# Update drivers from:
https://www.amd.com/en/support
```

#### Intel
```bash
# Download from:
https://www.intel.com/content/www/us/en/support/detect.html
```

## First Launch Checklist

- [ ] DirectX version verified
- [ ] GPU drivers updated to latest
- [ ] .NET 8.0 runtime installed
- [ ] Repository cloned/extracted
- [ ] Solution builds successfully
- [ ] Game launches without errors
- [ ] Settings file created
- [ ] Player data directory accessible

## Configuration

### Before First Run
1. Edit `%APPDATA%\GoFishing\settings.json` (if exists)
2. Or use in-game settings menu after launch

### First Time Setup
1. Launch game
2. Game will create:
   - `%APPDATA%\GoFishing\Data\` - Player data
   - `%APPDATA%\GoFishing\AntiCheat\` - Cheat detection logs
   - `%APPDATA%\GoFishing\Logs\` - Game logs
   - `%APPDATA%\GoFishing\settings.json` - Graphics settings

## Troubleshooting

### DirectX Initialization Failed

**Error**: "Failed to initialize graphics: *HRESULT code*"

**Solutions**:
1. Update Windows to latest version
2. Update GPU drivers
3. Try DirectX 11 instead of 12:
   ```json
   // In settings.json
   "DirectXVersion": 11
   ```
4. Disable V-Sync in settings
5. Reinstall DirectX

### .NET Runtime Not Found

**Error**: "Unable to find runtime"

**Solutions**:
1. Download correct .NET 8.0 Runtime:
   - x86 version if on 32-bit Windows (rare)
   - x64 version for 64-bit Windows (recommended)
2. Install from https://dotnet.microsoft.com/download/dotnet/8.0
3. Verify with: `dotnet --version`

### Controller Not Detected

**Error**: "Controller is not connected"

**Solutions**:
1. Connect Xbox controller via USB
2. Ensure USB drivers installed (automatic in Windows 10/11)
3. Check Device Manager:
   - Expand "Human Interface Devices"
   - Look for "Xbox 360 Controller" or "Xbox One Controller"
4. Update controller firmware via Xbox Accessories app
5. Try different USB port
6. Unplug all other controllers

### Low Performance / Low FPS

**Symptoms**: Game runs at <30 FPS

**Solutions**:
1. Lower graphics quality in settings:
   ```json
   "GraphicsQuality": 0,  // 0=Low, 1=Medium, 2=High, 3=Ultra
   "AntiAliasingLevel": 0
   ```
2. Lower resolution:
   ```json
   "Resolution_Width": 1280,
   "Resolution_Height": 720
   ```
3. Disable motion blur and particles:
   ```json
   "EnableMotionBlur": false,
   "EnableParticles": false
   ```
4. Set TextureQuality and ShadowQuality to 0.5
5. Close background applications
6. Update GPU drivers
7. Check Task Manager for CPU/GPU usage

### Game Crashes on Launch

**Error**: Access Violation, Null Reference Exception

**Solutions**:
1. Delete settings file: `%APPDATA%\GoFishing\settings.json`
2. Rebuild solution: `dotnet clean && dotnet build`
3. Verify .NET installation: `dotnet --list-runtimes`
4. Check Windows Update for pending updates
5. Disable overlays (Discord, Xbox Game Bar, etc.)
6. Run as Administrator

### Data File Errors

**Error**: "Data integrity check failed"

**Solutions**:
1. Data files may be corrupted - delete and restart:
   ```bash
   del %APPDATA%\GoFishing\Data\player_*.dat
   ```
2. Check disk space
3. Verify Windows DPAPI is available: `gpresult.msc`
4. Restart Windows
5. Check antivirus isn't blocking data files

### Input Not Working

**Symptoms**: Keyboard or mouse input not recognized

**Solutions**:
1. Verify focus is on game window (click window title bar)
2. Check keyboard caps lock and num lock state
3. Disable IME (Input Method Editor) if Asian keyboard installed
4. Update keyboard/mouse drivers
5. Try different input device
6. Disable compatibility mode

## Performance Optimization Tips

### For Maximum Performance
1. Use DirectX 12 if GPU supports it
2. Set quality to "Ultra" but:
   ```json
   "AntiAliasingLevel": 1,  // 2x MSAA is good balance
   "ViewDistance": 1.0,      // Don't max out everything
   "VSync": false            // For high refresh rate monitors
   ```
3. Monitor thermals - ensure GPU/CPU temps < 85°C
4. Use separate GPU if available (disable integrated graphics in BIOS)

### For Consistent Framerate
1. Enable V-Sync:
   ```json
   "VSync": true,
   "RefreshRate": 60
   ```
2. Set GPU power limit to maximum in driver
3. Lock refresh rate to monitor refresh rate
4. Disable background streaming services

### Power Consumption
1. Lower quality settings reduce power usage
2. Enable power saver on laptop
3. DirectX 11 generally uses less power than 12
4. Disable unnecessary graphics features

## Advanced Configuration

### Command Line Arguments
```bash
# Future support for:
dotnet run --config "C:\path\to\settings.json"
dotnet run --directx 11
dotnet run --window-width 2560 --window-height 1440
dotnet run --fullscreen
```

### Environment Variables
```powershell
# Set before running
$env:GOFISHING_LOG_LEVEL="Debug"
$env:GOFISHING_DATA_PATH="C:\CustomPath\Data"
$env:GOFISHING_DIRECTX_VERSION="11"
```

### Registry Settings (Advanced)
```powershell
# Windows Registry preferences
# HKEY_CURRENT_USER\Software\GoFishing
# Not implemented yet - future feature
```

## Uninstallation

### Complete Removal
```bash
# Remove application files
# Delete installation directory

# Remove data (optional)
# Delete %APPDATA%\GoFishing\

# Clean registry (optional)
# No registry entries created by this app
```

### Keep Settings But Reinstall
```bash
# Backup settings
copy %APPDATA%\GoFishing\settings.json settings_backup.json

# Delete everything else
rmdir %APPDATA%\GoFishing /s /q

# Create new directory
mkdir %APPDATA%\GoFishing\Data

# Restore settings
copy settings_backup.json %APPDATA%\GoFishing\settings.json
```

## Getting Help

### Online Resources
- Official Discord: (link here)
- GitHub Issues: (link here)
- Technical Support: (email here)

### Logs for Support
When reporting bugs, please include:
1. Latest log file: `%APPDATA%\GoFishing\Logs\[latest].log`
2. System specs from `dxdiag` export
3. DirectX error codes
4. Steps to reproduce issue

### Before Contacting Support
1. ✓ Updated Windows to latest version
2. ✓ Updated GPU drivers
3. ✓ Verified .NET 8.0 installed
4. ✓ Tried suggested troubleshooting steps
5. ✓ Checked available disk space (>500MB)
6. ✓ Disabled antivirus temporarily

---

**Happy Fishing!**

For more information, see README.md
