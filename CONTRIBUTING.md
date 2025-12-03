# Contributing to WatchOS Playground

Thank you for your interest in contributing to WatchOS Playground! This is a personal learning project, but suggestions and ideas are always welcome.

## Repository
- **GitHub**: [sg98ccy/WatchOS-Playground](https://github.com/sg98ccy/WatchOS-Playground)
- **Issues**: [Report bugs or suggest features](https://github.com/sg98ccy/WatchOS-Playground/issues)
- **Author**: Jackson Chai (@sg98ccy)

## Project Goals

WatchOS Playground is designed to:
- Explore and demonstrate watchOS capabilities
- Provide a clean, well-documented codebase
- Serve as a learning resource for Apple Watch development
- Follow Apple's Human Interface Guidelines
- Maintain high code quality standards

## Development Phases

The project is being developed in phases:

- **Phase 1** (Current): Sensors Lab - Motion and accelerometer ✅
- **Phase 2**: Gestures & Input Lab
- **Phase 3**: Haptics Lab
- **Phase 4**: Health & Workout Lab
- **Phase 5**: Notifications Lab
- **Phase 6**: Widgets & Smart Stack
- **Phase 7**: Connectivity Lab
- **Phase 8**: About & Diagnostics

## Code Standards

### Swift Style
- Follow Swift API Design Guidelines
- Use meaningful variable and function names
- Add documentation comments for public APIs
- Keep functions focused and single-purpose
- Prefer composition over inheritance

### SwiftUI Best Practices
- Break complex views into smaller components
- Use `@Observable` for modern state management
- Implement proper lifecycle management (onAppear/onDisappear)
- Optimize for watchOS screen sizes
- Consider battery and performance impact

### Architecture Principles
- **Models**: Pure data structures, no logic
- **Services**: Business logic, API interactions, sensor management
- **Views**: Presentation only, delegate logic to services
- Maintain clear separation of concerns

## File Organization

```
WatchOS Playground Watch App/
├── Models/              # Data structures
├── Services/            # Business logic and system interfaces
├── Views/
│   ├── Root/           # Main navigation views
│   └── Labs/           # Feature-specific lab views
│       ├── Sensors/
│       ├── Gestures/
│       └── ...
└── Assets.xcassets/    # Images and colors
```

## Suggestions Welcome

If you have ideas for:
- New labs or features
- UI/UX improvements
- Performance optimizations
- Bug fixes
- Documentation improvements

Feel free to:
1. Open an issue describing your idea
2. Provide code examples if applicable
3. Explain the benefit to the project

## Testing Guidelines

Before submitting suggestions:
- Test on both simulator and physical device if possible
- Verify battery impact during extended use
- Check performance with Instruments
- Ensure compliance with watchOS guidelines

## Questions?

For questions about the project architecture or implementation details, please open an issue with the "question" label.

---

**Note**: This is a personal project maintained by Jackson Chai. While contributions are not actively sought, quality feedback and suggestions are appreciated.
