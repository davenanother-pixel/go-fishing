# GO FISHING - Project Overview & Quick Reference

## Project Summary

**Go Fishing** is a professional, feature-rich DirectX-based fishing game with:
- Advanced graphics engine supporting DirectX 10/11/12
- Full Xbox controller support
- Robust upgrade and achievement systems
- Sophisticated anti-cheat system with VM sandboxing
- Encrypted local data persistence
- Graphics customization and performance optimization

## Quick Start

### 1. Build the Project
```bash
cd c:\Users\dchua\go.fishing
dotnet build GoFishing.sln -c Release
```

### 2. Run the Game
```bash
dotnet run --project GoFishing.Game\GoFishing.Game.csproj
```

### 3. First Launch
- Graphics settings auto-generated in `%APPDATA%\GoFishing\settings.json`
- Player data directory created at `%APPDATA%\GoFishing\Data\`
- Anti-cheat logs stored in `%APPDATA%\GoFishing\AntiCheat\`

## Solution Organization

```
GoFishing.sln (3 Projects)
│
├─ GoFishing.Game (Main Application)
│  ├─ Program.cs (Entry point)
│  ├─ GameWindow.cs (Game loop & state)
│  ├─ Graphics/
│  │  └─ DirectXRenderingEngine.cs (DX11/12 renderer)
│  └─ Systems/
│     ├─ UpgradeSystem.cs (Progression)
│     ├─ AchievementSystem.cs (Goals)
│     └─ GraphicsSettingsManager.cs (Configuration)
│
├─ GoFishing.Core (Shared Library)
│  ├─ Data/
│  │  ├─ GraphicsSettings.cs (Video config)
│  │  └─ PlayerData.cs (Player/Session/Achievement data)
│  ├─ Input/
│  │  └─ InputManager.cs (Keyboard/Mouse/Controller)
│  └─ Persistence/
│     └─ SecureDataManager.cs (AES-256 encryption)
│
└─ GoFishing.AntiCheat (Anti-Cheat Library)
   └─ Core/
      └─ AntiCheatSystem.cs (VM sandboxed detection)
```

## Key Features

### Graphics Engine
- **DirectX Support**: 10, 11, 12 (configured in settings or settings.json)
- **Resolution**: 1280x720 to 3840x2160
- **Quality Presets**: Low, Medium, High, Ultra
- **Anti-Aliasing**: None, 2x, 4x, 8x MSAA
- **Effects**: Motion blur, particles, shadow quality scaling
- **ReShade Compatible**: Standard DirectX API, fully compatible

### Input System
- **Keyboard**: Full key support + special keys
- **Mouse**: Button and movement tracking
- **Xbox Controller**: 
  - All buttons and D-Pad
  - Analog sticks with deadzone
  - Triggers with normalized values
  - Battery level monitoring
  - 4-player support

### Game Systems
- **Upgrades**: 6+ upgrade types with progressive levels
- **Achievements**: 9 achievement tracks with rewards
- **Leveling**: XP-based progression system
- **Currency**: Coin-based economy
- **Fishing Mechanics**: Catch-based gameplay with randomization

### Security
- **Data Encryption**: AES-256 with Windows DPAPI keys
- **Integrity**: SHA256 checksums on all saved files
- **Secure Deletion**: 3-pass overwrite (random, zeros, ones)
- **Session Tracking**: All actions timestamped and logged

### Anti-Cheat
- **Detection Methods**: 7 different analysis types
- **VM Sandboxing**: Isolated environment for analysis
- **Permanent Ban**: Automatic data deletion
- **No Appeals**: By design (deterrent measure)
- **Analysis Points**: Memory, timing, behavior, input patterns, state consistency

## Configuration Files

### settings.json Location
```
%APPDATA%\GoFishing\settings.json
```

### Default Settings
```json
{
  "Resolution_Width": 1920,
  "Resolution_Height": 1080,
  "RefreshRate": 60,
  "GraphicsQuality": 2,        // 0=Low, 1=Med, 2=High, 3=Ultra
  "AntiAliasingLevel": 2,       // 0=None, 1=2x, 2=4x, 3=8x
  "TextureQuality": 1.0,        // 0.5 to 2.0
  "ShadowQuality": 1.0,         // 0.5 to 2.0
  "EnableMotionBlur": true,
  "EnableParticles": true,
  "ViewDistance": 1.0,          // 0.5 to 2.0
  "VSync": true,
  "Fullscreen": false,
  "DirectXVersion": 11,         // 10, 11, or 12
  "BrightnessLevel": 1.0,
  "ContrastLevel": 1.0
}
```

## File Structure

```
c:\Users\dchua\go.fishing\
├─ GoFishing.sln
├─ README.md
├─ SETUP_GUIDE.md
├─ ANTICHEAT_SYSTEM.md
├─ build.bat
├─ .gitignore
│
├─ GoFishing.Game\
│  ├─ GoFishing.Game.csproj
│  ├─ Program.cs
│  ├─ GameWindow.cs
│  ├─ app.manifest
│  ├─ Graphics\
│  │  └─ DirectXRenderingEngine.cs
│  ├─ Systems\
│  │  ├─ UpgradeSystem.cs
│  │  ├─ AchievementSystem.cs
│  │  └─ GraphicsSettingsManager.cs
│  ├─ bin\
│  └─ obj\
│
├─ GoFishing.Core\
│  ├─ GoFishing.Core.csproj
│  ├─ Data\
│  │  ├─ GraphicsSettings.cs
│  │  └─ PlayerData.cs
│  ├─ Input\
│  │  └─ InputManager.cs
│  ├─ Persistence\
│  │  └─ SecureDataManager.cs
│  ├─ bin\
│  └─ obj\
│
├─ GoFishing.AntiCheat\
│  ├─ GoFishing.AntiCheat.csproj
│  ├─ Core\
│  │  └─ AntiCheatSystem.cs
│  ├─ bin\
│  └─ obj\
│
└─ publish\ (after build)
   └─ GoFishing\
      └─ GoFishing.Game.exe
```

## Building & Deployment

### Development Build
```bash
dotnet build GoFishing.sln
dotnet run --project GoFishing.Game\GoFishing.Game.csproj
```

### Release Build
```bash
dotnet build GoFishing.sln -c Release
dotnet publish GoFishing.Game\GoFishing.Game.csproj -c Release -o publish
```

### Automated Build
```bash
# Windows
build.bat

# Linux/Mac equivalent would be needed
```

## Gameplay Flow

```
┌────────────┐
│ Start Game │
└─────┬──────┘
      │
      ▼
┌──────────────────┐
│  Main Menu       │
│  - New Game      │
│  - Settings      │
│  - Upgrades      │
│  - Achievements  │
└─────┬────────────┘
      │
      ▼
┌──────────────────┐
│  In Gameplay     │
│  - Fish (RT)     │
│  - Earn Coins    │
│  - Gain XP       │
│  - Level Up      │
└─────┬────────────┘
      │
      ├─→ Every 5 min: Anti-Cheat Scan
      │   └─→ Score < 80: Continue
      │   └─→ Score ≥ 80: Ban & Delete Data
      │
      ▼
┌──────────────────┐
│ Session End      │
│ Final Analysis   │
└─────┬────────────┘
      │
      ▼
┌──────────────────┐
│ Return to Menu   │
│ Data Saved       │
└──────────────────┘
```

## Development Tips

### Adding New Upgrades
1. Add to `UpgradeSystem.InitializeUpgrades()`
2. Define UpgradeDefinition
3. Update UI to display option
4. Configure cost and effect value

### Adding New Achievements
1. Add to `AchievementSystem.InitializeAchievements()`
2. Define AchievementDefinition
3. Call `UpdateAchievements()` when event occurs
4. Handle unlock notifications

### Adjusting Graphics Settings
1. Edit quality presets in `GraphicsSettingsManager.ApplyQualityPreset()`
2. Modify DirectXRenderingEngine initialization
3. Update resolution support list
4. Test performance on target hardware

### Modifying Anti-Cheat Thresholds
1. Edit constants in `AntiCheatSystem.cs`
2. Adjust suspicion score multipliers
3. Modify earning rate thresholds
4. Update catch rate limits
5. Test with various gameplay patterns

## Performance Guidelines

### Target FPS
- **Low Quality**: 60 FPS @ 720p
- **Medium Quality**: 60 FPS @ 1080p
- **High Quality**: 60 FPS @ 1440p
- **Ultra Quality**: 30 FPS @ 4K

### Optimization Priorities
1. Reduce AA level (biggest impact)
2. Lower resolution
3. Disable particle effects
4. Reduce texture quality
5. Lower shadow quality
6. Reduce view distance

## Known Issues & Limitations

### Current Limitations
- No dedicated server backend (local-only)
- UI rendered to console only (future: ImGui)
- Single-threaded rendering
- No network multiplayer
- No cloud saves

### Workarounds
- Use highest quality settings for your GPU
- Disable overlays (Discord, Xbox Game Bar)
- Close background applications
- Update GPU drivers regularly
- Run as Administrator if permission issues

## Testing Checklist

- [ ] Game launches without errors
- [ ] DirectX version selected correctly
- [ ] Graphics settings persist after restart
- [ ] Controller connects and responds
- [ ] Keyboard/mouse input works
- [ ] Fishing mechanics functional
- [ ] Coins/XP earned correctly
- [ ] Player data saves/loads
- [ ] Achievements unlock properly
- [ ] Upgrades apply effects
- [ ] Anti-cheat analyzes sessions
- [ ] Performance meets target FPS

## Documentation Files

| File | Purpose |
|------|---------|
| README.md | Full documentation and features |
| SETUP_GUIDE.md | Installation and troubleshooting |
| ANTICHEAT_SYSTEM.md | Anti-cheat technical details |
| QUICK_REFERENCE.md | This file |

## Support Resources

### Online Documentation
- See README.md for comprehensive feature list
- See SETUP_GUIDE.md for installation help
- See ANTICHEAT_SYSTEM.md for anti-cheat details

### Building & Running
- Use `build.bat` for automated release build
- Or use `dotnet build` for manual build
- Requires .NET 8.0 SDK

### Troubleshooting
- Check `%APPDATA%\GoFishing\Logs\` for game logs
- Check `%APPDATA%\GoFishing\AntiCheat\` for anti-cheat logs
- Review SETUP_GUIDE.md troubleshooting section

## Version Information

- **Current Version**: 1.0.0
- **.NET Target**: .NET 8.0
- **DirectX Versions**: 10, 11, 12
- **Minimum Windows**: Windows 10 Build 19041
- **Recommended Windows**: Windows 11 22H2

## Next Steps

1. **Build the project**: `dotnet build GoFishing.sln`
2. **Run the game**: `dotnet run --project GoFishing.Game\GoFishing.Game.csproj`
3. **Test gameplay**: Fish, earn coins, unlock upgrades
4. **Check settings**: Verify graphics options save/load
5. **Monitor logs**: Check for any errors or warnings
6. **Optimize performance**: Adjust settings for your hardware

## Advanced Topics

### Custom DirectX Configurations
Edit settings before launch in settings.json to optimize for your specific GPU.

### Extending the Anti-Cheat
Add new detection methods in `AntiCheatSystem.cs`:
1. Override `RunAnalysisInVM()`
2. Add custom analysis function
3. Update suspicion score calculation
4. Document detection method

### Adding Game Modes
1. Add new GameState enum value
2. Implement Update/Render methods
3. Add state transition logic
4. Update input handling

---

**Quick Reference Complete!**

For detailed information, see the respective documentation files.
