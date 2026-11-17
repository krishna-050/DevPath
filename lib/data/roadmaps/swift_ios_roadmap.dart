import 'package:dev_path/models/roadmap_step_model.dart';

final List<RoadmapStepModel> swiftIosRoadmapSteps = [
  RoadmapStepModel(
    id: 1,
    title: 'Swift Language Fundamentals',
    description:
        'Master the foundational syntax, data types, type inference, constants, and variables in Apple\'s Swift language.',
    duration: '1-2 weeks',
    phase: 'Phase 1: Swift Core',
    level: 'Beginner',
    learningObjectives:
        'Understand Swift type safety, declare constants and variables, format strings, and manipulate collections.',
    subtopics: [
      'Swift design philosophy: Safety, Speed, and Expressiveness',
      'Constants (let) vs Variables (var) and Type Safety',
      'Basic data types: Int, Double, Float, String, Bool',
      'Type Inference and explicit Type Annotations',
      'String manipulation, interpolation, & Substring indexing',
      'Basic arithmetic, comparison, logical, & ternary operators',
      'Tuples: Unpacking, named elements, and tuple returns',
      'Swift Collections: Arrays, Sets, and Dictionaries',
      'Array operations: append, insert, remove, slicing, filter, map',
      'Dictionary lookup, update, key-value iteration, & Set algebra operations',
    ],
    exercises: [
      'Create a Swift Playground program to calculate compound interest using type-safe Double variables.',
      'Build a inventory tracker using Dictionaries and Sets to perform union and intersection operations.',
    ],
    resources: [
      'Swift Official Documentation: https://www.swift.org/documentation/',
      'Swift Programming Language Book (Apple): https://docs.swift.org/swift-book/',
      'Hacking with Swift (100 Days of Swift): https://www.hackingwithswift.com/100',
    ],
  ),
  RoadmapStepModel(
    id: 2,
    title: 'Control Flow, Functions & Optionals',
    description:
        'Master condition branching, Swift Optionals, optional binding, guard statements, and function closures.',
    duration: '2 weeks',
    phase: 'Phase 1: Swift Core',
    level: 'Beginner',
    learningObjectives:
        'Safely unwrap Optionals with if-let and guard-let, write functions with argument labels, and understand closures.',
    subtopics: [
      'Control flow: if, else-if, else, and switch statements with pattern matching',
      'Loops: for-in, while, and repeat-while loops',
      'Understanding Swift Optionals: Optional values (Wrapped vs nil)',
      'Safely unwrapping Optionals: if let, guard let, and nil-coalescing (??)',
      'Force unwrapping (!) & Implicitly unwrapped optionals',
      'Functions: Parameters, return values, and argument labels',
      'Default parameter values, variadic parameters, & inout parameters',
      'Closures: Syntax, trailing closure syntax, & shorthand argument names (\$0, \$1)',
      'Escaping vs Non-escaping closures (@escaping)',
      'Capturing values in closures & Capture Lists ([weak self])',
    ],
    exercises: [
      'Write a function that parses a string into an Integer safely using Optionals and guard-let statements.',
      'Create a array sorting function using custom Closures with shorthand argument syntax.',
    ],
    resources: [
      'Swift Optionals Guide: https://developer.apple.com/documentation/swift/optional',
      'Closures in Swift (Apple Docs): https://docs.swift.org/swift-book/documentation/the-swift-programming-language/closures/',
    ],
  ),
  RoadmapStepModel(
    id: 3,
    title: 'Structs, Classes & Object-Oriented Swift',
    description:
        'Understand Value Types vs Reference Types, Structs, Classes, Initializers, Properties, and Memory Management (ARC).',
    duration: '2-3 weeks',
    phase: 'Phase 1: Swift Core',
    level: 'Intermediate',
    learningObjectives:
        'Compare Value vs Reference semantics, design Structs/Classes, implement Computed Properties, and manage Automatic Reference Counting (ARC).',
    subtopics: [
      'Structs vs Classes: Value types (copy on assignment) vs Reference types (shared reference)',
      'Stored properties, Computed properties (getters/setters), and Property Observers (willSet/didSet)',
      'Type properties and static/class methods',
      'Custom Initializers: Designated initializers, Convenience initializers, Failable initializers (init?)',
      'Class Inheritance, method overriding (override), and preventing inheritance (final)',
      'Deinitialization (deinit) in Classes',
      'Memory Management: Automatic Reference Counting (ARC)',
      'Strong, Weak, and Unowned references to prevent Retain Cycles',
      'Enumerations (Enums): Raw values, Associated values, and Pattern matching',
      'Property Wrappers (@propertyWrapper syntax)',
    ],
    exercises: [
      'Design a BankAccount class with property observers that log balance changes and prevent negative balances.',
      'Construct a delegate pattern using weak references to prevent memory retain cycles.',
    ],
    resources: [
      'Swift Structures and Classes: https://docs.swift.org/swift-book/documentation/the-swift-programming-language/structuresandclasses/',
      'ARC and Memory Management in Swift: https://docs.swift.org/swift-book/documentation/the-swift-programming-language/automaticreferencecounting/',
    ],
  ),
  RoadmapStepModel(
    id: 4,
    title: 'Protocols, Extensions & Generics',
    description:
        'Master Protocol-Oriented Programming (POP), Extensions, Generics, and Swift Standard Library protocols (Codable, Identifiable).',
    duration: '2 weeks',
    phase: 'Phase 2: Advanced Swift',
    level: 'Intermediate',
    learningObjectives:
        'Design Protocols with default extensions, write type-safe Generic functions, and conform to Codable for JSON processing.',
    subtopics: [
      'Protocols: Defining requirements for methods, properties, and initializers',
      'Protocol Conformance and Protocol Composition (&)',
      'Protocol Extensions & Default Implementation (Protocol-Oriented Programming)',
      'Standard Swift Protocols: Equatable, Comparable, Hashable, CustomStringConvertible',
      'Identifiable protocol & Codable (Encodable/Decodable) for JSON parsing',
      'Extensions: Adding functionality to existing types (Int, String, Array)',
      'Generics: Type parameters (<T>), Generic functions, and Generic types',
      'Type Constraints in Generics (where T: Equatable)',
      'Opaque Return Types (some View syntax in SwiftUI)',
      'Result type (Result<Success, Failure>) for handling operational status',
    ],
    exercises: [
      'Parse a complex JSON API payload into Swift Structs using Codable protocol and custom CodingKeys.',
      'Create an extension on String that validates email addresses using Regular Expressions.',
    ],
    resources: [
      'Protocol-Oriented Programming in Swift (WWDC): https://developer.apple.com/videos/play/wwdc2015/408/',
      'Swift Codable Guide: https://developer.apple.com/documentation/swift/codable',
    ],
  ),
  RoadmapStepModel(
    id: 5,
    title: 'SwiftUI Foundations & Core Views',
    description:
        'Build modern declarative iOS user interfaces using SwiftUI views, stacks, modifiers, and previews.',
    duration: '2-3 weeks',
    phase: 'Phase 3: iOS Development',
    level: 'Intermediate',
    learningObjectives:
        'Construct SwiftUI layout hierarchies with VStack, HStack, ZStack, style views with Modifiers, and inspect live Xcode Previews.',
    subtopics: [
      'Declarative UI paradigm vs Imperative UIKit',
      'SwiftUI App lifecycle (@main, App, Scene, WindowGroup)',
      'Core Layout Stacks: VStack, HStack, ZStack, Spacer, and Divider',
      'View Modifiers: Padding, background, foregroundColor, clipShape, shadow',
      'Basic UI Controls: Text, Image, Button, TextField, Toggle, Slider',
      'Lists & ScrollViews: LazyVStack, LazyHStack, and List views',
      'List customization: Section headers/footers, swipeActions, and onDelete',
      'Grid Layouts: LazyVGrid, LazyHGrid, and GridItem configuration',
      'Xcode Canvas & Xcode Previews (#Preview syntax)',
      'SF Symbols 5 integration & vector icon styling',
    ],
    exercises: [
      'Build a modern profile view in SwiftUI with custom styled buttons, avatar images, and metadata badges.',
      'Create a scrollable news feed UI using LazyVStack and AsyncImage for remote images.',
    ],
    resources: [
      'SwiftUI Official Tutorials (Apple): https://developer.apple.com/tutorials/swiftui/',
      'SwiftUI Documentation: https://developer.apple.com/documentation/swiftui/',
      'SF Symbols App: https://developer.apple.com/sf-symbols/',
    ],
  ),
  RoadmapStepModel(
    id: 6,
    title: 'SwiftUI State Management & Data Flow',
    description:
        'Manage reactive data flow across SwiftUI views using @State, @Binding, @StateObject, @ObservedObject, and @Environment.',
    duration: '2-3 weeks',
    phase: 'Phase 3: iOS Development',
    level: 'Intermediate',
    learningObjectives:
        'Manage local view state with @State/@Binding, construct reactive ViewModels with @Observable / ObservableObject, and share global environment state.',
    subtopics: [
      'SwiftUI Data Flow Philosophy: Single Source of Truth',
      'Local View State: @State for private mutable value properties',
      'Two-way Binding: @Binding to pass mutable state to child views',
      'Observable Framework (iOS 17+ @Observable macro)',
      'Legacy State Management: ObservableObject, @Published, @StateObject, and @ObservedObject',
      'Global App State: @EnvironmentObject and @Environment values',
      '@AppStorage for user preferences in UserDefaults',
      'Passing data via NavigationStack & .navigationDestination(for:)',
      'Sheets, Alerts, Action Sheets, and Popovers (.sheet, .alert)',
      'Managing Forms, FocusState, and Keyboard avoidance',
    ],
    exercises: [
      'Build a todo app in SwiftUI using @Observable ViewModel to add, complete, and delete items with persistent @AppStorage.',
      'Implement a multi-screen checkout flow using NavigationStack and path-based navigation.',
    ],
    resources: [
      'SwiftUI Data Flow (Apple Docs): https://developer.apple.com/documentation/swiftui/managing-user-interface-state',
      'Discover Observable in SwiftUI (WWDC23): https://developer.apple.com/videos/play/wwdc2023/10149/',
    ],
  ),
  RoadmapStepModel(
    id: 7,
    title: 'Networking & Swift Concurrency (Async/Await)',
    description:
        'Fetch remote data over HTTP using URLSession, JSONDecoder, and modern Swift Async/Await concurrency primitives.',
    duration: '2-3 weeks',
    phase: 'Phase 4: Data & Architecture',
    level: 'Intermediate to Advanced',
    learningObjectives:
        'Perform asynchronous HTTP requests with URLSession, handle Swift Async/Await, write Actor isolation, and handle network errors.',
    subtopics: [
      'Swift Concurrency evolution: Completion handlers vs Async/Await',
      'Async functions (async) & Suspension points (await)',
      'Structured Concurrency: Task, TaskGroup, and async let bindings',
      'Unstructured Tasks (Task { ... }) and Task Cancellation (Task.checkCancellation)',
      'Thread Safety with Actors (actor class) & MainActor attribute (@MainActor)',
      'Networking with URLSession: data(from:), data(for: URLRequest)',
      'Configuring URLRequest: HTTP methods (GET, POST), Headers, Body data',
      'Parsing JSON responses with JSONDecoder & handling Date/Key strategies',
      'Comprehensive error handling using Swift Error enum & try-catch',
      'Downloading & caching images asynchronously with AsyncImage',
    ],
    exercises: [
      'Build a weather app fetching live data from a REST API using URLSession, Async/Await, and parsing JSON into Codable models.',
      'Write an actor-isolated image caching service to prevent race conditions during concurrent image downloads.',
    ],
    resources: [
      'Swift Concurrency Guide: https://docs.swift.org/swift-book/documentation/the-swift-programming-language/concurrency/',
      'URLSession Documentation: https://developer.apple.com/documentation/foundation/urlsession',
    ],
  ),
  RoadmapStepModel(
    id: 8,
    title: 'SwiftData & Core Data Local Persistence',
    description:
        'Persist relational application data on iOS devices using SwiftData (iOS 17+) and Core Data.',
    duration: '2-3 weeks',
    phase: 'Phase 4: Data & Architecture',
    level: 'Intermediate to Advanced',
    learningObjectives:
        'Define SwiftData models with @Model, manage ModelContainer & ModelContext, perform Query sorting/filtering, and execute relationships.',
    subtopics: [
      'Local Persistence Options: UserDefaults, Keychain, FileSystem, SwiftData, Core Data',
      'SwiftData Overview (iOS 17+ macro-based ORM architecture)',
      'Defining Schema Models with @Model macro',
      'Model attributes: @Attribute(.unique), @Transient, Relationships (@Relationship)',
      'Container setup: .modelContainer(for:) in App main entry',
      'Accessing ModelContext via @Environment(\\.modelContext)',
      'Querying Data with @Query macro: Filtering, Sorting, and Predicates (#Predicate)',
      'CRUD Operations: Inserting, Fetching, Updating, & Deleting objects',
      'Core Data Architecture: NSManagedObject, NSManagedObjectContext, NSPersistentContainer',
      'Securing sensitive user credentials using iOS Keychain Services',
    ],
    exercises: [
      'Build a personal expense tracker app using SwiftData with categories, date filtering, and total calculation.',
      'Store JWT authentication tokens securely using the iOS Keychain API.',
    ],
    resources: [
      'SwiftData Documentation (Apple): https://developer.apple.com/documentation/swiftdata',
      'Meet SwiftData (WWDC23): https://developer.apple.com/videos/play/wwdc2023/10187/',
    ],
  ),
  RoadmapStepModel(
    id: 9,
    title: 'iOS App Architecture (MVVM) & Unit Testing',
    description:
        'Architect scalable, maintainable iOS applications using MVVM pattern, XCTest framework, and dependency injection.',
    duration: '2-3 weeks',
    phase: 'Phase 4: Data & Architecture',
    level: 'Advanced',
    learningObjectives:
        'Implement Model-View-ViewModel architecture, write unit tests with XCTest / Swift Testing, and stub network dependencies.',
    subtopics: [
      'Architectural Patterns: MVC vs MVVM vs Clean Architecture',
      'MVVM in SwiftUI: View, ViewModel (@Observable), Model data separation',
      'Dependency Injection patterns: Initializer injection vs Environment injection',
      'Testing Frameworks: XCTest vs Swift Testing framework (iOS 18+ @Test)',
      'Writing Unit Tests: Assertions (#expect, XCTAssertEqual, XCTAssertTrue)',
      'Mocking Network Services using Protocol stubs',
      'Asynchronous Testing: Testing async methods & expectations',
      'UI Testing with XCUITest: Locating elements & simulating user taps',
      'Code Coverage analysis in Xcode',
      'Modularizing iOS projects with Swift Packages (SPM)',
    ],
    exercises: [
      'Refactor a monolithic SwiftUI view into clean MVVM architecture with protocol-based dependency injection.',
      'Write a suite of unit tests verifying ViewModel business logic and network error scenarios.',
    ],
    resources: [
      'Swift Testing Documentation: https://developer.apple.com/documentation/testing',
      'Xcode Testing Guide: https://developer.apple.com/documentation/xcode/testing-your-app',
    ],
  ),
  RoadmapStepModel(
    id: 10,
    title: 'App Store Distribution & TestFlight',
    description:
        'Prepare iOS apps for production release, manage Certificates & Profiles, run TestFlight beta testing, and submit to App Store Connect.',
    duration: '2 weeks',
    phase: 'Phase 5: Publishing & Production',
    level: 'Advanced',
    learningObjectives:
        'Manage Apple Developer Program assets, configure App Signing, deploy builds to TestFlight, and pass App Store Review.',
    subtopics: [
      'Apple Developer Program enrollment & App Store Connect portal overview',
      'Certificates, Identifiers & Profiles (Development vs Distribution Signing)',
      'App Configuration: App Icon sets, Launch Screen, Bundle Identifier, Version & Build numbers',
      'Privacy Permissions: Info.plist NSCameraUsageDescription, NSLocationWhenInUseUsageDescription',
      'App Capabilities: Push Notifications, In-App Purchase, Background Modes',
      'Archiving builds in Xcode & uploading to App Store Connect',
      'Setting up TestFlight internal & external beta testing groups',
      'App Store Connect metadata: Screenshots, App Description, Keywords, Privacy Policy URL',
      'App Store Review Guidelines: Avoiding common rejection causes',
      'Automating iOS builds & deployments using Fastlane (fastlane match & gym)',
    ],
    exercises: [
      'Prepare an iOS app bundle with full App Icon asset catalog, Info.plist privacy descriptions, and archive a release build.',
      'Set up a Fastlane lane to automate TestFlight build uploads on git release tags.',
    ],
    resources: [
      'App Store Connect Help: https://developer.apple.com/help/app-store-connect/',
      'App Store Review Guidelines: https://developer.apple.com/app-store/review/guidelines/',
      'Fastlane iOS Documentation: https://docs.fastlane.tools/',
    ],
  ),
];
