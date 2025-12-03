# Changelog

All notable changes to WatchOS Playground will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Repository
- **GitHub**: [sg98ccy/WatchOS-Playground](https://github.com/sg98ccy/WatchOS-Playground)
- **Author**: Jackson Chai (@sg98ccy)

## [0.4.0] - 2025-12-03

### Added - Phase 4: Health & Workout Lab

#### Models & Services
- `HealthMetric` model for health data points with timestamp and unit tracking
- `WorkoutType` enum with 6 workout types (Walking, Running, Cycling, HIIT, Yoga, Strength)
- `HealthService` with singleton pattern for HealthKit integration
- Heart rate monitoring with real-time updates
- Workout session management with duration and calorie tracking
- Health metrics history tracking (last 20 readings)
- HealthKit authorization flow

#### User Interface
- `HealthLabView` as main hub with authorization status and navigation
- `HeartRateMonitorView` with live heart rate tracking
  - Pulsing heart icon animation
  - Real-time BPM display
  - Statistics display (average, max, min, reading count)
  - Start/stop monitoring controls
- `WorkoutSessionView` with workout type selection and tracking
  - 6 workout types with color-coded cards
  - Live workout timer and stats
  - Heart rate and calorie tracking during workout
  - End workout functionality
- `HealthStatsView` displaying health metrics history
  - Heart rate history list with timestamps
  - Color-coded heart rate zones
  - Summary statistics
  - Empty state with call-to-action

#### Features
- Simulated heart rate monitoring (60-180 BPM range)
- Real-time heart rate updates every 2 seconds
- Workout session tracking with duration and calories
- Heart rate statistics (average, max, min)
- HealthKit authorization request flow
- Automatic cleanup on view disappear
- Color-coded workout types
- Calorie burn calculation based on workout type
- Heart rate history with 20-reading limit

## [0.3.0] - 2025-12-03

### Added - Phase 3: Haptics Lab

#### Models & Services
- `HapticPattern` enum with all watchOS haptic types
- `HapticsService` with singleton pattern for managing haptic feedback
- Support for individual haptic patterns (notification, success, failure, click, etc.)
- Sequence playback with customizable delays
- Rhythm generator with BPM control

#### User Interface
- `HapticsLabView` as main hub with pattern gallery, sequences, and rhythm demos
- `HapticPatternsGalleryView` displaying all 9 haptic patterns with interactive testing
- `HapticSequenceDemoView` with 5 pre-built haptic sequences
- `HapticRhythmDemoView` with customizable tempo (40-120 BPM) and beat count (2-16)
- Real-time session stats tracking (haptic count, last pattern, enabled status)
- Visual feedback with color-coded patterns and animations

#### Features
- Interactive pattern gallery with all WKHapticType patterns
- Sequence player with common haptic flows (success, error, navigation)
- Rhythm generator with metronome-style beats
- Haptic enable/disable toggle
- Session statistics and pattern history
- Visual indicators during haptic playback

## [0.2.0] - 2025-12-03

### Added - Phase 2: Gestures & Input Lab

#### Models & Services
- `GestureType` enum for categorizing gesture types
- `GestureEvent` model for tracking gesture occurrences
- `GestureService` with singleton pattern for managing gesture state
- Event history tracking (last 10 gestures)
- Digital Crown value tracking
- Tap count and drag offset management

#### User Interface
- `GesturesLabView` as main navigation hub with gesture demos
- `DigitalCrownDemoView` with live rotation tracking and visual feedback
  - Circular progress indicator
  - Value display with monospaced font
  - Animated crown icon rotation
  - Range: -10.0 to +10.0 with 0.1 increments
- `TapGesturesDemoView` with single and double tap detection
  - Interactive target with scale animations
  - Tap counter and last gesture display
  - Visual feedback on each tap
- `DragGestureDemoView` with touch movement tracking
  - Draggable element with spring-back animation
  - Real-time distance calculation
  - X/Y offset display
  - Trail effect during drag
- `LongPressDemoView` with press-and-hold detection
  - Progress ring visualization
  - 1.0 second press duration
  - Success counter
  - Cancel on early release

#### Features
- Real-time gesture event tracking
- Recent gesture history display
- Digital Crown rotation with sensitivity control
- Single and double tap differentiation
- Drag gesture with bounded movement
- Long press with progress visualization
- Spring animations for natural feedback
- Session statistics and event logging

## [0.1.0] - 2025-12-02

### Added - Phase 1: Sensors Lab

#### Project Foundation
- Initial project structure with SwiftUI and watchOS 11 support
- Complete folder organization (Models, Services, Views)
- Git repository with proper .gitignore
- README with comprehensive documentation
- MIT License

#### Core Architecture
- `SensorSample` model for motion data representation
- `MotionService` with CoreMotion integration
- Observable pattern using @Observable macro
- Clean separation of concerns

#### User Interface
- `HomeView` as main navigation hub with lab cards
- `SensorsLabView` with real-time accelerometer data display
  - Live X, Y, Z axis readings with visual progress bars
  - Magnitude calculation
  - Color-coded axis indicators (X=red, Y=green, Z=blue)
  - Tracking status indicator
- `MotionVisualizerView` with interactive motion dot
  - Smooth spring animations
  - Tilt-responsive visualization
  - Grid overlay and crosshair reference
  - Real-time data overlay
  - Glow effects and gradients

#### Features
- Real-time accelerometer tracking at 60 Hz
- Automatic lifecycle management (start/stop on view appear/disappear)
- Graceful error handling for unavailable sensors
- Smooth animations with spring physics
- Placeholder cards for future labs

### Technical Details
- Minimum watchOS version: 11.0
- Swift 5.9+ with modern concurrency
- SwiftUI lifecycle
- CoreMotion framework integration
- No external dependencies

---

## Future Releases

### [Unreleased] - Phase 5: Notifications Lab
- Scheduled notification demos
- Notification actions
- Response handling

### [Unreleased] - Phase 6: Widgets & Smart Stack
- Interactive widget implementation
- Smart Stack integration
- Shared state management

### [Unreleased] - Phase 7: Connectivity Lab
- Network request demonstrations
- Connection status monitoring
- Error handling examples

### [Unreleased] - Phase 8: About & Diagnostics
- Version information display
- Debug toggle interface
- System information dump
- Performance metrics

---

[0.4.0]: https://github.com/sg98ccy/WatchOS-Playground/releases/tag/v0.4.0
[0.3.0]: https://github.com/sg98ccy/WatchOS-Playground/releases/tag/v0.3.0
[0.2.0]: https://github.com/sg98ccy/WatchOS-Playground/releases/tag/v0.2.0
[0.1.0]: https://github.com/sg98ccy/WatchOS-Playground/releases/tag/v0.1.0
