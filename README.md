# GO FISHING - Professional Game Edition

A comprehensive DirectX-based fishing game with advanced anti-cheat system, upgrade mechanics, and professional graphics settings.

## Features

### 🎮 Game Features
- **Professional Graphics Engine**: DirectX 10/11/12 support with ReShade compatibility
- **Controller Support**: Full Xbox controller support with analog stick and trigger inputs
- **Upgrade System**: 6+ upgrades across multiple categories (Rod, Reel, Bait, Passive)
- **Achievement System**: Progressive achievement unlocking with rewards
- **Game Progression**: Level system with XP-based advancement
- **Session Tracking**: Real-time gameplay metrics and statistics

### 🛡️ Anti-Cheat System
- **VM Sandboxing**: All analysis runs in isolated virtual environment before flagging
- **Behavioral Analysis**: Detects impossible action sequences and earning rates
- **Memory Analysis**: Detects memory manipulation attempts
- **Timing Analysis**: Identifies impossible event frequencies
- **Input Validation**: Monitors input patterns for anomalies
- **Permanent Bans**: Automatic data deletion for confirmed cheaters
- **Encrypted Logs**: All anti-cheat actions logged with SHA256 verification

### ⚙️ Settings System
- **Resolution Control**: Select any resolution with fullscreen option
- **Quality Presets**: Low, Medium, High, Ultra with optimized settings
- **Graphics Options**:
  - Anti-aliasing (None, 2x, 4x, 8x MSAA)
  - Texture Quality (0.5x - 2.0x)
  - Shadow Quality (0.5x - 2.0x)
  - Motion Blur toggle
  - Particle Effects toggle
  - View Distance scaling
  - VSync toggle
- **DirectX Version**: Choose between DirectX 10, 11, or 12
- **Display Adjustments**: Brightness and Contrast controls

### 🔐 Security Features
- **AES-256 Encryption**: All player data encrypted using Windows DPAPI
- **Integrity Verification**: SHA256 checksums for all saved data
- **Secure Deletion**: Multi-pass overwrite (random, zeros, ones) before file deletion
- **Timing Attack Prevention**: Constant-time comparison functions
- **Session Validation**: Cross-verification of player stats between saves

## Project Structure

```
GoFishing/
├── GoFishing.sln                    # Solution file
├── GoFishing.Game/                  # Main game project
│   ├── GoFishing.Game.csproj
│   ├── Program.cs                   # Application entry point
│   ├── GameWindow.cs                # Main game window and loop
│   ├── Graphics/
│   │   └── DirectXRenderingEngine.cs # DirectX rendering system
│   └── Systems/
│       ├── UpgradeSystem.cs         # Upgrade management
│       ├── AchievementSystem.cs     # Achievement tracking
│       └── GraphicsSettingsManager.cs # Settings management
├── GoFishing.Core/                  # Core game logic library
│   ├── GoFishing.Core.csproj
│   ├── Data/
│   │   ├── GraphicsSettings.cs      # Graphics configuration
│   │   └── PlayerData.cs            # Player/Session data structures
│   ├── Input/
│   │   └── InputManager.cs          # Keyboard/Mouse/Controller input
│   └── Persistence/
│       └── SecureDataManager.cs     # Encrypted data persistence
└── GoFishing.AntiCheat/             # Anti-cheat system
    ├── GoFishing.AntiCheat.csproj
    └── Core/
        └── AntiCheatSystem.cs       # VM sandboxed analysis engine
```

## Dependencies

### NuGet Packages
- **SharpDX** (4.2.0) - DirectX C# wrapper with full HAL support
- **SharpDX.Direct3D11** (4.2.0) - DirectX 11 rendering
- **SharpDX.Direct3D12** (4.2.0) - DirectX 12 rendering (optional)
- **SharpDX.DXGI** (4.2.0) - Display device interface
- **SharpDX.Mathematics** (4.2.0) - Vector/Matrix math
- **SharpDX.XInput** (4.2.0) - Xbox controller input
- **ImGui.NET** (1.90.2) - UI framework (optional, for future UI)
- **Newtonsoft.Json** (13.0.3) - JSON serialization
- **log4net** (2.0.17) - Logging framework

## Building and Running

### Requirements
- .NET 8.0 SDK (use the version in `global.json`; 10.x can trigger ERR_SDK_COMPONENT_MISSING)
- Windows 10/11 (x64)
- DirectX 11 or later
- Visual Studio 2022 or VS Code with C# extension

### If you see ERR_SDK_COMPONENT_MISSING
1. From the repo root, run: **`restore-workloads.bat`**  
   Or: `dotnet workload restore GoFishing.Game\GoFishing.Game.csproj`
2. Ensure the solution uses the .NET 8 SDK: `global.json` pins `8.0.100` with `rollForward: latestFeature`.
3. If the error persists, install the Windows Desktop workload:  
   `dotnet workload install windowsdesktop`  
   (Use the exact workload ID shown in your error if different.)

### Build
```bash
cd c:\Users\dchua\go.fishing
dotnet build GoFishing.sln
```

### Run
```bash
dotnet run --project GoFishing.Game\GoFishing.Game.csproj
```

### Release Build
```bash
dotnet publish -c Release -o ./publish
```

## Game Controls

### Keyboard
- **Space** - Cast line / Fish
- **ESC** - Return to menu / Pause
- **R** - Start new game (from menu)
- **S** - Open settings (from menu)
- **U** - Open upgrades (from menu)
- **Arrow Keys** - Menu navigation

### Xbox Controller
- **Right Trigger (RT)** - Cast line / Fish
- **A Button** - Confirm selection
- **B Button** - Back/Cancel
- **X Button** - Open upgrades
- **Y Button** - Open achievements
- **Start** - Menu
- **Back** - Pause
- **Left/Right Stick** - Menu navigation
- **D-Pad** - Quick navigation

## Graphics Settings

### Resolution Modes
- 1280x720 (720p)
- 1600x900 (900p)
- 1920x1080 (1080p - Default)
- 2560x1440 (1440p) (requires high-end GPU)
- 3840x2160 (4K) (requires high-end GPU)

### Quality Presets
| Setting | Low | Medium | High | Ultra |
|---------|-----|--------|------|-------|
| AA | None | 2x | 4x | 8x |
| Texture Quality | 0.5x | 1.0x | 1.5x | 2.0x |
| Shadow Quality | 0.5x | 0.75x | 1.0x | 2.0x |
| Motion Blur | Off | On | On | On |
| Particles | Off | On | On | On |
| View Distance | 0.5x | 1.0x | 1.5x | 2.0x |

### ReShade Compatibility
- Uses standard DirectX 11/12 API
- Works with ReShade 4.8.0+ and Kaldaien's ReShade fork
- Supports all standard ReShade shaders
- Compatible with RTGI, RayTracing, and other advanced effects

## Anti-Cheat System Details

### Analysis Pipeline
1. **Session Recording**: All player actions recorded with timestamps
2. **Behavioral Analysis**: Check for impossible earning rates, catch rates
3. **VM Execution**: Analysis runs in isolated VM environment
4. **Pattern Matching**: Cross-reference against known cheat signatures
5. **Score Calculation**: Generate suspicion score (0-100)
6. **Action**: Score ≥80 triggers permanent ban

### Cheat Detection Methods
- **Memory Manipulation**: Detects direct value modifications
- **Speed Hacks**: Identifies game speed multipliers
- **Input Spoofing**: Validates input patterns
- **DLL Injection**: Detects unauthorized code injection
- **Behavior Anomalies**: Impossible action sequences

### Permanent Ban Process
1. Detection in VM sandbox
2. All player data encrypted and marked for deletion
3. Secure 3-pass file overwrite
4. Account permanently locked
5. Ban record logged with date/time/reason
6. No recovery possible

## Player Data Structure

### Player Profile
```json
{
  "playerId": "uuid",
  "playerName": "Player",
  "createdAt": "2024-01-01T00:00:00Z",
  "currentLevel": 1,
  "totalCoins": 1000,
  "totalXP": 0,
  "totalFishCaught": 0,
  "totalPlayTime": 0,
  "upgrades": {
    "rod_basic": {
      "level": 1,
      "effectValue": 1.05
    }
  },
  "achievements": [],
  "equipment": {}
}
```

### Session Data
```json
{
  "sessionId": "uuid",
  "sessionStart": "2024-01-01T12:00:00Z",
  "sessionEnd": "2024-01-01T13:00:00Z",
  "coinsEarnedThisSession": 5000,
  "fishCaughtThisSession": 50,
  "xpEarnedThisSession": 1000,
  "events": [
    {
      "eventType": "FISH_CAUGHT",
      "timestamp": 1704110400000,
      "data": {
        "coins": 100,
        "xp": 20
      }
    }
  ]
}
```

## Upgrade System

### Available Upgrades
| Upgrade ID | Max Level | Base Cost | Effect |
|------------|-----------|-----------|--------|
| rod_basic | 5 | 100 | +5% catch rate |
| rod_advanced | 3 | 500 | +50% catch rate |
| reel_speed | 5 | 150 | +10% reel speed |
| bait_premium | 10 | 200 | +25% coin reward |
| luck_charm | 5 | 300 | +20% double rewards |
| exp_boost | 3 | 400 | +50% XP gain |

Cost calculation: `BaseCost * (CurrentLevel + 1)`

## Achievement System

### Available Achievements
- **First Catch** - Catch 1 fish (100 coins, 50 XP)
- **Novice Angler** - Catch 10 fish (500 coins, 200 XP)
- **Experienced Angler** - Catch 100 fish (2000 coins, 1000 XP)
- **Master Fisher** - Catch 1000 fish (10000 coins, 5000 XP)
- **Coin Collector** - Earn 1000 coins (500 coins, 200 XP)
- **Wealthy Merchant** - Earn 10000 coins (2000 coins, 1000 XP)
- **Rising Star** - Reach level 10 (1000 coins, 500 XP)
- **Legendary Fisher** - Reach level 25 (5000 coins, 2500 XP)
- **Marathon Angler** - Play 1 hour continuously (1500 coins, 750 XP)

## Data Persistence

### Encryption
- **Algorithm**: AES-256 (GCM mode)
- **Key Derivation**: Windows DPAPI (Data Protection API)
- **Integrity**: SHA256 checksums
- **Location**: `%APPDATA%\GoFishing\Data\`

### File Structure
- `player_[GUID].dat` - Encrypted player profile
- `.keys` - DPAPI-protected encryption keys
- `.meta` - Metadata (version, timestamps)

## Logging

### Anti-Cheat Logs
- Location: `%APPDATA%\GoFishing\AntiCheat\`
- Files: `anticheat_YYYY-MM-DD_HH-MM-SS.log`
- Content: All detections, bans, analysis results
- Retention: Permanent

### Game Logs
- Location: `%APPDATA%\GoFishing\Logs\`
- Level: Info, Warning, Error
- Rolling files: Daily rotation

## Configuration Files

### Graphics Settings
- Location: `%APPDATA%\GoFishing\settings.json`
- Persists across sessions
- Can be manually edited before game startup

### Example settings.json
```json
{
  "Resolution_Width": 1920,
  "Resolution_Height": 1080,
  "RefreshRate": 60,
  "GraphicsQuality": 2,
  "AntiAliasingLevel": 2,
  "TextureQuality": 1.0,
  "ShadowQuality": 1.0,
  "EnableMotionBlur": true,
  "EnableParticles": true,
  "ViewDistance": 1.0,
  "VSync": true,
  "Fullscreen": false,
  "DirectXVersion": 11,
  "BrightnessLevel": 1.0,
  "ContrastLevel": 1.0
}
```

## Performance Optimization

### Recommended Specs
| Setting | CPU | GPU | RAM | DirectX |
|---------|-----|-----|-----|---------|
| Low (720p) | i5-8400 | GTX 1050 | 4GB | DX11 |
| Medium (1080p) | i5-9400 | RTX 2060 | 8GB | DX11 |
| High (1440p) | i7-10700 | RTX 2080 | 16GB | DX12 |
| Ultra (4K) | i9-12900 | RTX 4090 | 32GB | DX12 |

## Troubleshooting

### DirectX Initialization Failed
- Ensure Windows 10/11 is updated
- Update GPU drivers
- Check Windows Display Driver Model (WDDM) version
- Try lower DirectX version (from 12 to 11 to 10)

### Controller Not Detected
- Verify Xbox controller is connected via USB
- Check Device Manager for proper drivers
- Try using `xinput1_3.dll` from DirectX runtime
- Restart the application

### Performance Issues
- Lower graphics quality preset
- Reduce resolution
- Disable motion blur and particles
- Disable V-Sync if frame rate is unstable

### Data Corruption
- Check file integrity from anti-cheat logs
- Verify DPAPI is enabled in Windows
- Delete corrupted `.dat` files (will lose progress)
- Check disk space availability

## Advanced Features

### Modding Support
- DirectX shaders can be modified (HLSL)
- Settings JSON can be pre-configured
- Upgrade values can be customized in code
- Achievement thresholds adjustable

### Server-Side Features (Future)
- Cloud save functionality
- Leaderboards
- Multiplayer fishing contests
- Cross-device play

### Analytics
- Player session metrics tracked
- Upgrade popularity statistics
- Achievement unlock rates
- Performance benchmarking data

## License and Legal

### Usage Terms
- For personal use only
- No redistribution without explicit permission
- Anti-cheat system cannot be disabled
- Permanent bans are non-appealable once triggered

### EULA Clause
By playing this game, you agree to:
1. Accept anti-cheat analysis of your gameplay
2. Allow encrypted data storage on your device
3. Accept permanent account deletion if cheating is detected
4. Comply with game rules and terms of service

## Support and Feedback

### Bug Reports
- Check logs in `%APPDATA%\GoFishing\Logs\`
- Include error messages and system specs
- Provide reproduction steps

### Feature Requests
- Suggest at official game forums
- Vote on community-requested features
- Contribute to open-source aspects

## Version History

### v1.0.0 (Current)
- Initial release
- Core gameplay mechanics
- Advanced anti-cheat system
- Graphics settings and DirectX support
- Upgrade and achievement systems
- Controller support

### Future (v1.1.0+)
- Advanced UI with ImGui
- In-game marketplace
- Daily challenges
- Season pass system
- Social features

## Credits

- **Engine**: SharpDX
- **Graphics**: DirectX 11/12
- **Input**: XInput (Xbox)
- **Logging**: log4net
- **Serialization**: Newtonsoft.Json
- **Development**: Go Fishing Studios

---

**Go Fishing** - Where Professional Fishing Meets Advanced Gaming
