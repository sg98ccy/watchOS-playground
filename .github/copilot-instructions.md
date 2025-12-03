# GitHub Copilot Instructions for watchOS Development

## CRITICAL: Xcode Project Management

### Never Modify .xcodeproj Directly
- **NEVER** directly edit files in the `.xcodeproj` directory
- **NEVER** suggest or make changes to `project.pbxproj` or other Xcode project files
- **ALWAYS** guide the user to make changes through Xcode's interface instead

When project configuration changes are needed:
1. Explain what needs to be changed (e.g., "Add a new file to the project")
2. Provide step-by-step Xcode instructions:
   - Menu navigation (e.g., "File > New > File...")
   - Specific panels to use (e.g., "Project Navigator", "Build Settings")
   - Settings to modify with exact locations
3. Let Xcode manage the project file automatically

### Examples of Changes Requiring Xcode
- Adding/removing files from the project
- Configuring build settings
- Managing targets and schemes
- Adding frameworks or packages
- Setting up capabilities and entitlements
- Configuring code signing

## IMPORTANT: Core Development Principles

### Single Source of Truth
- Maintain a single source of truth for all code
- Avoid code duplication across components, views, or services
- Extract shared logic into reusable utilities, view modifiers, or extensions
- Centralize configuration, constants, and theme definitions
- Use Swift's type system to ensure consistency (enums, structs, protocols)

### Separation of Concerns
- Separate concerns into different files and folders appropriately
- Keep business logic separate from presentation logic (Views vs Services/Models)
- Use clear folder structure: `Views/`, `Models/`, `Services/`, `Extensions/`, `Utilities/`
- Split large SwiftUI views into smaller, focused sub-views and components
- Follow MVVM pattern where appropriate: Models, Views, ViewModels

### Leverage Existing Apple Frameworks
- **Prioritize using established Apple frameworks over custom implementations**
- Use **SwiftUI** for declarative UI development
- Use **WatchKit** and **WatchConnectivity** for watchOS-specific features
- Use **HealthKit** for health and fitness data
- Use **CoreMotion** for motion and sensor data
- Use **AVFoundation** for audio and haptics
- Use **Core Haptics** for advanced haptic feedback
- Only create custom implementations when Apple's solutions don't meet requirements
- Research available Apple frameworks and APIs before implementing from scratch

## Swift & watchOS Best Practices

### Code Style & Conventions
- Follow Apple's [Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/)
- Use meaningful, descriptive names for types, properties, and methods
- Prefer `let` over `var` for immutability
- Use Swift's modern concurrency (async/await, actors) for asynchronous operations
- Leverage Swift's type safety and optionals properly
- Use guard statements for early returns and preconditions
- Prefer value types (struct, enum) over reference types (class) when appropriate

### SwiftUI Best Practices
- Keep views small and composable
- Extract reusable components into separate view files
- Use `@State` for local view state, `@Binding` for shared state
- Use `@StateObject` and `@ObservedObject` appropriately for observable objects
- Leverage view modifiers and custom view modifiers for reusability
- Use `ViewBuilder` for flexible view composition
- Prefer declarative over imperative code

### watchOS-Specific Guidelines
- Design for small screens and limited interaction time
- Optimize for glanceability and quick interactions
- Use Digital Crown, gestures, and haptics appropriately
- Be mindful of battery life and performance
- Use complications and notifications effectively
- Handle background tasks and app lifecycle correctly
- Test on actual hardware when possible (simulator has limitations)

### Performance & Optimization
- Minimize view updates and avoid unnecessary recomputation
- Use `@ViewBuilder` and conditional rendering efficiently
- Profile with Instruments to identify bottlenecks
- Be conscious of battery impact (GPS, continuous sensors, etc.)
- Implement proper background task management
- Use lazy loading and pagination for large datasets

### Testing & Quality
- Write unit tests for business logic and data models
- Use XCTest framework for testing
- Test edge cases and error handling
- Validate HealthKit permissions and data access
- Test across different watchOS versions if supporting multiple versions

### Architecture & Organization
- Follow the existing project structure:
  - `Models/` - Data models and types
  - `Services/` - Business logic and API interactions
  - `Views/` - SwiftUI views organized by feature
  - `Extensions/` - Swift extensions and utilities
- Group related files by feature, not by type
- Use protocols and extensions for code reuse
- Implement proper error handling throughout the app

### Documentation & Comments
- Use Swift documentation comments (`///`) for public APIs
- Document complex logic and non-obvious implementation decisions
- Keep README and CHANGELOG up to date
- Add inline comments sparingly, preferring self-documenting code
- Use `// MARK: -` to organize code within files

### Version Control
- Write clear, concise commit messages
- Keep commits focused and atomic
- Review changes before committing
- Never commit sensitive data (API keys, certificates, etc.)
- Follow the project's branching and PR guidelines

## When Adding New Features

1. **Research First**: Check if Apple provides native support
2. **Plan Structure**: Determine which folder/module the code belongs in
3. **Define Models**: Create or update models in `Models/`
4. **Implement Services**: Add business logic in `Services/`
5. **Build Views**: Create SwiftUI views in appropriate `Views/` subfolder
6. **Test**: Verify on simulator and device if possible
7. **Document**: Update README or documentation if needed
8. **Use Xcode**: For project configuration changes, provide Xcode instructions

## Common Patterns to Follow

### Service Layer Pattern
```swift
class ExampleService: ObservableObject {
    @Published var state: StateType = .initial
    
    func performAction() async throws {
        // Implementation
    }
}
```

### SwiftUI View Composition
```swift
struct ParentView: View {
    var body: some View {
        VStack {
            HeaderView()
            ContentView()
            FooterView()
        }
    }
}
```

### Error Handling
```swift
enum ServiceError: LocalizedError {
    case networkError
    case unauthorized
    
    var errorDescription: String? {
        switch self {
        case .networkError: return "Network connection failed"
        case .unauthorized: return "Access denied"
        }
    }
}
```

### Extensions for Reusability
```swift
extension View {
    func customStyle() -> some View {
        self
            .padding()
            .background(Color.blue)
            .cornerRadius(8)
    }
}
```

## Remember

- **Never** modify `.xcodeproj` files directly - guide users through Xcode instead
- Prioritize code reusability and maintainability
- Keep watchOS constraints in mind (screen size, battery, performance)
- Use Apple's frameworks and best practices
- Write clean, documented, and testable code
