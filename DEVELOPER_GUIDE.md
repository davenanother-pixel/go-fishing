# GO FISHING - Developer's Guide

## Overview

This guide helps developers extend and modify the Go Fishing game. The architecture is designed to be modular and extensible.

## Architecture Overview

### Three-Tier Architecture

```
┌─────────────────────────────┐
│  Application Layer          │
│  (GoFishing.Game)           │
│  - GameWindow               │
│  - Game Systems             │
│  - Rendering Engine         │
└────────────┬────────────────┘
             │
┌────────────▼────────────────┐
│  Core Layer                 │
│  (GoFishing.Core)           │
│  - Data Models              │
│  - Input Manager            │
│  - Persistence              │
└────────────┬────────────────┘
             │
┌────────────▼────────────────┐
│  Security Layer             │
│  (GoFishing.AntiCheat)      │
│  - Analysis Engine          │
│  - Detection Methods        │
│  - Logging                  │
└─────────────────────────────┘
```

## Adding New Features

### 1. Adding a New Game State

**Goal**: Add a new menu or game mode

**Steps**:

1. Add to `GameState` enum:
```csharp
public enum GameState
{
    MainMenu,
    Gameplay,
    Settings,
    Upgrades,
    Paused,
    NewFeature  // Add here
}
```

2. Implement in `GameWindow.cs`:
```csharp
private void Update(float deltaTime)
{
    switch (_gameState)
    {
        // ... existing cases ...
        case GameState.NewFeature:
            UpdateNewFeature(deltaTime);
            break;
    }
}

private void UpdateNewFeature(float deltaTime)
{
    // Game logic for new state
}

private void RenderNewFeature()
{
    // Rendering code for new state
}
```

3. Add UI transitions in `HandleInput()`:
```csharp
if (controller.X.JustPressed) // X button to enter new feature
{
    _gameState = GameState.NewFeature;
}
```

### 2. Adding New Upgrades

**Goal**: Add new items players can purchase

**Steps**:

1. Define upgrade in `UpgradeSystem.InitializeUpgrades()`:
```csharp
new UpgradeDefinition
{
    UpgradeId = "new_upgrade",
    Name = "New Item",
    Description = "Does something cool",
    Category = "new_category",
    MaxLevel = 10,
    BaseCost = 500,
    EffectValue = 1.2f
}
```

2. Use in gameplay:
```csharp
float effectMultiplier = _upgradeSystem.GetTotalEffectMultiplier(
    _currentPlayer, 
    "new_category"
);
```

3. Apply effects:
```csharp
float coinsEarned = 100 * effectMultiplier;
```

### 3. Adding New Achievements

**Goal**: Add new progression milestones and rewards

**Steps**:

1. Define in `AchievementSystem.InitializeAchievements()`:
```csharp
new AchievementDefinition
{
    AchievementId = "new_achievement",
    Name = "Achievement Name",
    Description = "Description",
    ProgressRequired = 50,
    RewardCoins = 1000,
    RewardXP = 500
}
```

2. Trigger in gameplay:
```csharp
var unlockedAchievements = _achievementSystem.UpdateAchievements(
    _currentPlayer,
    "EVENT_TYPE",
    amount
);

if (unlockedAchievements.Count > 0)
{
    MessageBox.Show("Achievement Unlocked!");
}
```

### 4. Adding Graphics Features

**Goal**: Add new visual effects or rendering options

**Steps**:

1. Add setting in `GraphicsSettings.cs`:
```csharp
[JsonProperty]
public bool EnableNewEffect { get; set; } = true;

[JsonProperty]
public float NewEffectQuality { get; set; } = 1.0f;
```

2. Add to quality preset manager:
```csharp
public void ApplyQualityPreset(int quality)
{
    switch (quality)
    {
        case 0: // Low
            _currentSettings.EnableNewEffect = false;
            break;
        case 3: // Ultra
            _currentSettings.EnableNewEffect = true;
            _currentSettings.NewEffectQuality = 2.0f;
            break;
    }
}
```

3. Use in rendering:
```csharp
if (_graphicsSettings.EnableNewEffect)
{
    // Render new effect
}
```

### 5. Adding Input Actions

**Goal**: Add new controller or keyboard inputs

**Steps**:

1. Check input in game loop:
```csharp
var controller = _inputManager.GetController(0);

if (controller.Y.JustPressed) // Bind to Y button
{
    // New action
}

if (_inputManager.KeyboardState.IsKeyJustPressed(65)) // 'A' key
{
    // Alternative control
}
```

2. For mouse input:
```csharp
if (_inputManager.MouseState.LeftButtonJustPressed)
{
    int x = _inputManager.MouseState.X;
    int y = _inputManager.MouseState.Y;
    // Handle click
}
```

### 6. Adding Anti-Cheat Detection

**Goal**: Add new cheat detection method

**Steps**:

1. Override in `AntiCheatSystem.cs`:
```csharp
private List<string> DetectNewCheatingMethod(SessionData sessionData)
{
    var indicators = new List<string>();
    
    // Implement detection logic
    if (isSuspicious)
    {
        indicators.Add("Suspicious pattern detected");
    }
    
    return indicators;
}
```

2. Call from VM analysis:
```csharp
private VMExecutionReport RunAnalysisInVM(
    SessionData sessionData, 
    PlayerData playerData)
{
    // ... existing analysis ...
    
    var newIndicators = DetectNewCheatingMethod(sessionData);
    if (newIndicators.Count > 0)
    {
        report.SuspicionScore += 25;
        report.AnomalousPatterns.AddRange(newIndicators);
    }
    
    return report;
}
```

## Code Organization Best Practices

### File Structure
```
GoFishing.Game/
├── Systems/          # Game logic systems
├── Graphics/         # Rendering code
├── UI/              # (Future) UI components
├── Audio/           # (Future) Sound system
└── Network/         # (Future) Multiplayer
```

### Naming Conventions
- **Classes**: PascalCase (e.g., `UpgradeSystem`)
- **Methods**: PascalCase (e.g., `PurchaseUpgrade()`)
- **Properties**: PascalCase (e.g., `CurrentLevel`)
- **Fields**: camelCase with underscore prefix (e.g., `_currentPlayer`)
- **Constants**: UPPER_SNAKE_CASE (e.g., `MAX_LEVEL = 100`)

### Code Style
```csharp
// Preferred style
public class GameSystem
{
    private readonly DependencyClass _dependency;
    private int _internalState;
    
    public int PublicProperty { get; set; }
    
    public GameSystem(DependencyClass dependency)
    {
        _dependency = dependency;
    }
    
    public void PublicMethod()
    {
        PrivateMethod();
    }
    
    private void PrivateMethod()
    {
        // Implementation
    }
}
```

## Testing

### Unit Testing Pattern

```csharp
[TestClass]
public class UpgradeSystemTests
{
    [TestMethod]
    public void PurchaseUpgrade_WithSufficientCoins_Succeeds()
    {
        // Arrange
        var system = new UpgradeSystem();
        var player = new PlayerData { TotalCoins = 1000 };
        
        // Act
        bool result = system.PurchaseUpgrade(player, "rod_basic");
        
        // Assert
        Assert.IsTrue(result);
        Assert.AreEqual(900, player.TotalCoins);
    }
}
```

### Integration Testing

```csharp
[TestMethod]
public void GameLoop_RunsWithoutCrashing()
{
    // Create game window (hidden)
    var game = new GameWindow();
    
    // Simulate 60 frames
    for (int i = 0; i < 60; i++)
    {
        game.SimulateFrame(1f / 60f);
    }
    
    // Cleanup
    game.Dispose();
}
```

## Performance Optimization

### Profiling

```csharp
var timer = Stopwatch.StartNew();

// Code to measure
SimulateFishing();

timer.Stop();
Debug.WriteLine($"Fishing simulation took {timer.ElapsedMilliseconds}ms");
```

### Common Bottlenecks
1. **Rendering**: Reduce quality settings
2. **Anti-cheat analysis**: Run less frequently
3. **File I/O**: Use async operations
4. **Encryption**: Cache keys when possible

### Optimization Techniques

```csharp
// ✓ GOOD: Cache frequently accessed values
private float _cachedMultiplier;
public void CacheMultiplier()
{
    _cachedMultiplier = CalculateMultiplier();
}

// ✗ BAD: Recalculate every frame
public void RenderFrame()
{
    var multiplier = CalculateMultiplier(); // Expensive!
}
```

## Debugging

### Logging

```csharp
using log4net;

public class MyClass
{
    private static readonly ILog Logger = LogManager.GetLogger(typeof(MyClass));
    
    public void MyMethod()
    {
        Logger.Info("Starting operation");
        try
        {
            // Code
            Logger.Info("Operation completed");
        }
        catch (Exception ex)
        {
            Logger.Error("Operation failed", ex);
        }
    }
}
```

### Console Output

```csharp
// During development
Console.WriteLine($"DEBUG: Player coins = {_currentPlayer.TotalCoins}");

// Remove in release builds
#if DEBUG
    Console.WriteLine("Debug info");
#endif
```

### Debugger Breakpoints

```csharp
[Conditional("DEBUG")]
private void DebugBreak()
{
    if (System.Diagnostics.Debugger.IsAttached)
    {
        System.Diagnostics.Debugger.Break();
    }
}
```

## Extending Data Models

### Adding Player Properties

```csharp
// In PlayerData.cs
[JsonProperty]
public bool HasPremiumAccess { get; set; } = false;

[JsonProperty]
public DateTime PremiumExpiryDate { get; set; } = DateTime.UtcNow;

// In game code
if (_currentPlayer.HasPremiumAccess && 
    _currentPlayer.PremiumExpiryDate > DateTime.UtcNow)
{
    // Premium feature
}
```

### Custom Data Classes

```csharp
[JsonObject]
public class CustomData
{
    [JsonProperty]
    public string Id { get; set; }
    
    [JsonProperty]
    public List<string> Tags { get; set; } = new();
    
    [JsonProperty]
    public Dictionary<string, object> Properties { get; set; } = new();
}

// Add to PlayerData
[JsonProperty]
public List<CustomData> CustomEntities { get; set; } = new();
```

## Common Pitfalls

### ❌ Memory Leaks
```csharp
// DON'T: Forgot to dispose
var renderer = new DirectXRenderingEngine(...);

// DO: Implement IDisposable
using (var renderer = new DirectXRenderingEngine(...))
{
    // Use renderer
} // Automatically disposed
```

### ❌ Thread Safety
```csharp
// DON'T: Unsafe cross-thread access
_gameWindow.Close(); // From another thread

// DO: Invoke on UI thread
_gameWindow.Invoke(new Action(() => _gameWindow.Close()));
```

### ❌ Exception Swallowing
```csharp
// DON'T: Ignore errors
try {
    LoadSaveFile();
} catch { }

// DO: Log and handle properly
try {
    LoadSaveFile();
} catch (Exception ex) {
    Logger.Error("Failed to load save", ex);
    ShowErrorDialog(ex.Message);
}
```

### ❌ Magic Numbers
```csharp
// DON'T: Hardcoded values
if (score > 8000) // What does 8000 mean?

// DO: Named constants
const int BanThreshold = 80;
if (score > BanThreshold)
```

## Version Control

### Commit Message Convention
```
[FEATURE/BUG/DOCS] Short description

Longer explanation of changes
- Bullet points for details
- Reference issue numbers: #123
```

### Branch Naming
```
feature/new-upgrade-system
bugfix/crash-on-startup
docs/update-readme
```

## Performance Targets

### Frame Rate
- **Target**: 60 FPS
- **Minimum**: 30 FPS
- **Frame Budget**: ~16.6ms per frame

### Memory Usage
- **Game**: <500MB RAM
- **Anti-cheat Analysis**: <100MB
- **Total**: <1GB typical

### Load Times
- **Game Start**: <3 seconds
- **Save Game**: <500ms
- **Load Game**: <500ms

## Future Extensions

### Planned Architecture
- Server-side validation
- Cloud saves
- Leaderboards
- Multiplayer
- In-game store
- Battle pass system

### Extension Points
- `IGameState` interface for custom states
- `IDetectionMethod` for new anti-cheat rules
- `IUpgradeEffect` for upgrade implementations
- `IAchievementTracker` for custom tracking

## Resources

### Documentation
- See [README.md](README.md) for feature overview
- See [ANTICHEAT_SYSTEM.md](ANTICHEAT_SYSTEM.md) for security
- See [SETUP_GUIDE.md](SETUP_GUIDE.md) for deployment

### Tools
- Visual Studio 2022 or VS Code
- .NET 8.0 SDK
- NuGet Package Manager
- Git for version control

### References
- SharpDX Documentation: http://sharpdx.org/
- DirectX Documentation: https://docs.microsoft.com/en-us/windows/win32/directx
- C# Documentation: https://docs.microsoft.com/en-us/dotnet/csharp/

---

**Happy Coding!** 🚀
