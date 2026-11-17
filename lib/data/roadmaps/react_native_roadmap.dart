import 'package:dev_path/models/roadmap_step_model.dart';

final List<RoadmapStepModel> reactNativeRoadmapSteps = [
  RoadmapStepModel(
    id: 1,
    title: 'React Native Fundamentals & Expo Setup',
    description:
        'Understand React Native architecture, Expo SDK vs Bare React Native CLI, and development environment configuration.',
    duration: '1-2 weeks',
    phase: 'Phase 1: Foundations',
    level: 'Beginner',
    learningObjectives:
        'Set up Expo Go development environment, understand JavaScript to Native bridge, and build basic cross-platform views.',
    subtopics: [
      'React Native core philosophy: "Learn once, write anywhere"',
      'React Native Architecture: JS Thread, UI Thread, Bridge vs New Architecture (Hermes engine, Fabric, TurboModules)',
      'Expo Managed Workflow vs Bare React Native CLI comparison',
      'Setting up Expo development environment (npx create-expo-app)',
      'Running apps on Expo Go app, iOS Simulator, and Android Emulator',
      'JSX syntax in mobile development: View, Text, Image, ScrollView, Pressable',
      'React Native vs Web HTML elements (<View> vs <div>, <Text> vs <p>)',
      'Handling Platform-specific code (Platform.OS, Platform.select, .ios.js / .android.js file extensions)',
      'Understanding Fast Refresh and Chrome / React Native DevTools debugging',
      'Project file structure: app.json, babel.config.js, package.json',
    ],
    exercises: [
      'Create an Expo app displaying a welcome card with cross-platform conditional styles for iOS and Android.',
      'Configure Hermes JS engine in an Expo project and run on Android Emulator.',
    ],
    resources: [
      'React Native Official Docs: https://reactnative.dev/docs/getting-started',
      'Expo Documentation: https://docs.expo.dev/',
      'React Native Express Tutorial: https://www.reactnativeexpress.com/',
    ],
  ),
  RoadmapStepModel(
    id: 2,
    title: 'Mobile Styling & Layouts with Flexbox',
    description:
        'Style mobile components using StyleSheet API, Flexbox layout defaults, dimensions, and safe area insets.',
    duration: '2 weeks',
    phase: 'Phase 1: Foundations',
    level: 'Beginner',
    learningObjectives:
        'Master React Native Flexbox defaults (column direction), design responsive layouts using StyleSheet, and manage Safe Area insets.',
    subtopics: [
      'StyleSheet API (StyleSheet.create()) and inline styling performance',
      'React Native Flexbox defaults: flexDirection defaults to "column"',
      'Main axis vs Cross axis alignment: justifyContent, alignItems, alignSelf',
      'Flex sizing: flex, flexGrow, flexShrink, flexBasis',
      'Positioning: absolute vs relative positioning and zIndex',
      'Handling screen dimensions: useWindowDimensions hook & Dimensions API',
      'Handling device notch and home indicator: react-native-safe-area-context',
      'Styling Pressable and TouchableOpacity interactive states',
      'Responsive design patterns & percentage dimensions',
      'Using Utility CSS frameworks: NativeWind (Tailwind CSS for React Native)',
    ],
    exercises: [
      'Build a responsive 2-column image gallery layout that adapts to screen orientation changes using useWindowDimensions.',
      'Design a custom button component using Pressable with pressed state style animations.',
    ],
    resources: [
      'React Native Layout with Flexbox: https://reactnative.dev/docs/flexbox',
      'NativeWind Documentation: https://www.nativewind.dev/',
    ],
  ),
  RoadmapStepModel(
    id: 3,
    title: 'Navigation with React Navigation 6',
    description:
        'Implement cross-platform mobile navigation using React Navigation: Stack, Bottom Tabs, and Drawer navigators.',
    duration: '2-3 weeks',
    phase: 'Phase 2: Navigation & Lists',
    level: 'Intermediate',
    learningObjectives:
        'Set up NavigationContainer, build Native Stack navigation, pass parameters between screens, and combine Tab + Stack navigators.',
    subtopics: [
      'React Navigation architecture & NavigationContainer wrapper',
      'Native Stack Navigator (@react-navigation/native-stack): createNativeStackNavigator',
      'Navigating between screens (navigation.navigate, navigation.push, navigation.goBack)',
      'Passing route parameters (route.params) & parameter type checking',
      'Customizing Header bar title, colors, and header buttons',
      'Bottom Tab Navigator (@react-navigation/bottom-tabs): Custom icons & badge counts',
      'Drawer Navigator (@react-navigation/drawer) for side menu navigation',
      'Combining Navigators: Nesting Stack Navigators inside Tab Navigators',
      'Deep Linking setup for opening app screens via web URLs',
      'Screen transitions & animation options',
    ],
    exercises: [
      'Build a full app navigation structure with 3 Bottom Tabs, where each tab contains its own nested Stack Navigator.',
      'Configure deep linking in React Navigation to handle opening product details via custom URI schemes.',
    ],
    resources: [
      'React Navigation Official Docs: https://reactnavigation.org/docs/getting-started',
      'React Navigation Nesting Navigators: https://reactnavigation.org/docs/nesting-navigators',
    ],
  ),
  RoadmapStepModel(
    id: 4,
    title: 'High-Performance Lists & Form Inputs',
    description:
        'Render large datasets efficiently using FlatList, SectionList, and handle mobile user input with TextInput and KeyboardAvoid.',
    duration: '2 weeks',
    phase: 'Phase 2: Navigation & Lists',
    level: 'Intermediate',
    learningObjectives:
        'Render virtualized lists with FlatList, optimize list performance (getItemLayout, keyExtractor), and prevent keyboard overlap.',
    subtopics: [
      'Why not ScrollView for large datasets? Memory issues vs VirtualizedList',
      'FlatList component: data, renderItem, keyExtractor',
      'FlatList customization: ListHeaderComponent, ListFooterComponent, ListEmptyComponent',
      'FlatList performance optimization: initialNumToRender, maxToRenderPerBatch, windowSize, getItemLayout',
      'SectionList for grouped headers (e.g. Contacts grouped by letter)',
      'Pull-to-refresh (Refreshing & onRefresh) and Infinite Scroll Pagination (onEndReached)',
      'TextInput component: placeholder, value, onChangeText, secureTextEntry, keyboardType',
      'KeyboardAvoidingView & react-native-keyboard-aware-scroll-view to prevent input overlap',
      'Form Validation with React Hook Form and Zod schema validation',
      'Handling Focus states & Dismissing keyboard (Keyboard.dismiss)',
    ],
    exercises: [
      'Build a social media feed featuring infinite scroll pagination, pull-to-refresh, and header/footer components using FlatList.',
      'Create a mobile user login form using React Hook Form with dynamic validation error messages.',
    ],
    resources: [
      'React Native FlatList Guide: https://reactnative.dev/docs/flatlist',
      'React Hook Form React Native Docs: https://react-hook-form.com/',
    ],
  ),
  RoadmapStepModel(
    id: 5,
    title: 'State Management (Zustand & Redux Toolkit)',
    description:
        'Manage global mobile application state using Context API, Zustand, or Redux Toolkit.',
    duration: '2 weeks',
    phase: 'Phase 3: State & Native APIs',
    level: 'Intermediate',
    learningObjectives:
        'Share state using React Context, implement lightweight global state with Zustand, or configure Redux Toolkit slices.',
    subtopics: [
      'Local vs Global state in mobile apps',
      'React Context API for simple global themes & user auth state',
      'Zustand for lightweight, boilerplate-free state management in React Native',
      'Defining Zustand stores: state, actions, & async actions',
      'Zustand persistence middleware (persist with Async/MMKV Storage)',
      'Redux Toolkit (RTK) architecture: configureStore, createSlice, extraReducers',
      'RTK Query for automated caching and fetching API data',
      'Connecting Redux to React Native components with useSelector and useDispatch',
      'Debugging state with Reactotron or Redux DevTools',
      'State rehydration strategies during app launch',
    ],
    exercises: [
      'Build an e-commerce cart store in Zustand with persistent local storage using MMKV or Async Storage.',
      'Set up a user authentication flow in Redux Toolkit with RTK Query API mutations.',
    ],
    resources: [
      'Zustand Official Documentation: https://zustand-demo.pmnd.rs/',
      'Redux Toolkit React Native Quick Start: https://redux-toolkit.js.org/',
    ],
  ),
  RoadmapStepModel(
    id: 6,
    title: 'Accessing Native Device Hardware APIs',
    description:
        'Integrate native mobile hardware features: Camera, Location, Push Notifications, Async Storage, and Haptics.',
    duration: '2-3 weeks',
    phase: 'Phase 3: State & Native APIs',
    level: 'Intermediate to Advanced',
    learningObjectives:
        'Request permissions, capture photos with Expo Camera, query GPS coordinates with Expo Location, and trigger haptic feedback.',
    subtopics: [
      'Requesting system permissions at runtime (Camera, Location, Photos, Notifications)',
      'Persistent Local Storage: @react-native-async-storage/async-storage vs react-native-mmkv (High speed C++ storage)',
      'Expo Camera (expo-camera): Capturing photos, video recording, & barcode scanning',
      'Expo ImagePicker (expo-image-picker): Selecting photos/videos from device gallery',
      'Expo Location (expo-location): Fetching GPS coordinates & background location tracking',
      'Haptic Feedback (expo-haptics) for tactile user responses',
      'Expo SecureStore: Encrypted key-value storage for access tokens and sensitive data',
      'Push Notifications with Expo Notifications (expo-notifications): Token registration & notification handlers',
      'Device Sensors (expo-sensors): Accelerometer, Gyroscope, Magnetometer',
      'File System access (expo-file-system) for downloading and caching files',
    ],
    exercises: [
      'Build a camera app that takes a photo, stores it locally with MMKV, and displays it in a custom gallery grid.',
      'Configure Expo Push Notifications to register device tokens and handle incoming background notification payloads.',
    ],
    resources: [
      'Expo SDK Reference: https://docs.expo.dev/versions/latest/',
      'React Native MMKV High Speed Storage: https://github.com/mrousavy/react-native-mmkv',
    ],
  ),
  RoadmapStepModel(
    id: 7,
    title: 'Animations with React Native Reanimated 3',
    description:
        'Build 60FPS fluid mobile animations and gesture interactions using React Native Reanimated 3 and Gesture Handler.',
    duration: '2-3 weeks',
    phase: 'Phase 4: Advanced Performance',
    level: 'Advanced',
    learningObjectives:
        'Construct UI thread animations with Reanimated 3 (useSharedValue, useAnimatedStyle, withSpring), and handle gestures with Gesture Handler.',
    subtopics: [
      'Animated API vs Reanimated 3 architecture (UI Thread execution via Worklets)',
      'Reanimated 3 Core primitives: useSharedValue, useAnimatedStyle',
      'Animation functions: withTiming, withSpring, withDecay, withSequence, withRepeat',
      'Interpolation: interpolate & interpolateColor for dynamic scroll animations',
      'React Native Gesture Handler 2: GestureDetector, Gesture.Pan(), Gesture.Tap(), Gesture.Pinch()',
      'Combining Gestures and Reanimated for swipeable list cards and draggable elements',
      'Layout Animations (entering, exiting, layout transitions with FadeIn, SlideIn, Layout.springify())',
      'Shared Element Transitions between navigation screens',
      'Vector Graphics & Skia Graphics (react-native-skia) for custom canvas rendering',
      'Performance profiling for 60FPS animations using Systrace & Flipper',
    ],
    exercises: [
      'Build a swipeable card deck component (Tinder-style) with pan gestures, spring physics, and rotation interpolation.',
      'Create an animated sticky scroll header that scales down as the user scrolls down a FlatList.',
    ],
    resources: [
      'React Native Reanimated 3 Docs: https://docs.swmansion.com/react-native-reanimated/',
      'React Native Gesture Handler Docs: https://docs.swmansion.com/react-native-gesture-handler/',
    ],
  ),
  RoadmapStepModel(
    id: 8,
    title: 'Offline-First Storage & Offline Sync',
    description:
        'Architect offline-first mobile applications with local SQLite databases, WatermelonDB, and background synchronization.',
    duration: '2 weeks',
    phase: 'Phase 4: Advanced Performance',
    level: 'Advanced',
    learningObjectives:
        'Implement local SQLite databases, use WatermelonDB for lazy-loaded reactive storage, and handle network offline status.',
    subtopics: [
      'Offline-First Mobile Architecture principles',
      'Network connectivity monitoring with @react-native-community/netinfo',
      'Local Relational Storage: expo-sqlite / react-native-quick-sqlite',
      'WatermelonDB: High-performance lazy-loaded reactive database for React Native',
      'TanStack Query (React Query) for API caching, automatic refetching, and optimistic UI updates',
      'Optimistic Updates: Updating UI instantly before server response completes',
      'Background Task Execution (expo-background-fetch / react-native-background-actions)',
      'Conflict Resolution Strategies during offline queue synchronization',
      'Caching remote images for offline availability',
      'Secure SQLite database encryption (SQLCipher)',
    ],
    exercises: [
      'Build an offline-first note taking app using WatermelonDB that queues changes offline and syncs with a REST backend when connection restores.',
      'Implement optimistic UI updates in a social likes feature using TanStack Query.',
    ],
    resources: [
      'WatermelonDB Official Docs: https://watermelondb.dev/',
      'TanStack Query React Native Guide: https://tanstack.com/query/latest/docs/framework/react/react-native',
    ],
  ),
  RoadmapStepModel(
    id: 9,
    title: 'Native Modules & New Architecture (C++ / Swift / Kotlin)',
    description:
        'Extend React Native using C++ TurboModules, JSI (JavaScript Interface), Fabric rendering, and Swift/Kotlin native modules.',
    duration: '3 weeks',
    phase: 'Phase 5: Production & Release',
    level: 'Advanced',
    learningObjectives:
        'Understand JSI and TurboModules, write custom Swift/Kotlin native modules, and expose native methods to JavaScript.',
    subtopics: [
      'React Native New Architecture: JSI (JavaScript Interface) replacing JSON Bridge',
      'Fabric Renderer & Concurrent React in Mobile',
      'TurboModules for synchronous, lazy-loaded native module invocations',
      'Writing custom Swift Native Modules for iOS using Expo Modules API',
      'Writing custom Kotlin Native Modules for Android using Expo Modules API',
      'Exposing Native Methods, Promises, and Events to JavaScript',
      'Writing C++ code for shared cross-platform logic via JSI',
      'Autolinking mechanics for native dependencies',
      'Creating Bare React Native CLI Native Modules',
      'Debugging native crashes in Xcode (LLDB) & Android Studio (Logcat)',
    ],
    exercises: [
      'Create a custom Expo Module in Swift and Kotlin that reads native device battery health and exposes it to React Native.',
      'Write a C++ JSI function that executes high-speed string encryption synchronously in JavaScript.',
    ],
    resources: [
      'Expo Modules API Guide: https://docs.expo.dev/modules/overview/',
      'React Native New Architecture Guide: https://reactnative.dev/docs/the-new-architecture/landing-page',
    ],
  ),
  RoadmapStepModel(
    id: 10,
    title: 'App Publishing (Expo EAS, App Store & Google Play)',
    description:
        'Build, sign, test, and publish React Native apps to Apple App Store and Google Play Store using Expo Application Services (EAS).',
    duration: '2 weeks',
    phase: 'Phase 5: Production & Release',
    level: 'Advanced',
    learningObjectives:
        'Configure app.json / eas.json, build APK/AAB and IPA binaries in cloud using EAS Build, run Over-The-Air (OTA) updates, and publish.',
    subtopics: [
      'Expo Application Services (EAS): EAS Build, EAS Submit, EAS Update',
      'Configuring app.json: bundleIdentifier, package, version, splash screen, icons',
      'Eas.json build profiles: development, preview, production',
      'Generating Android Keystores & Apple Distribution Certificates automatically with EAS',
      'Building production AAB (Android App Bundle) & IPA (iOS App Store) binaries in the cloud',
      'Over-The-Air (OTA) Updates using EAS Update (expo-updates) to fix bugs without store review',
      'Google Play Console setup: App signing, Store Listing, Internal Testing track submission',
      'App Store Connect setup: TestFlight beta distribution & app review submission',
      'Handling app crashes in production with Sentry (sentry-expo)',
      'App size reduction techniques & code splitting',
    ],
    exercises: [
      'Configure eas.json, run an EAS Build to generate a production Android AAB, and release a bug fix using EAS Update OTA.',
      'Configure Sentry error logging in an Expo app to capture JavaScript and native crashes.',
    ],
    resources: [
      'Expo EAS Build Documentation: https://docs.expo.dev/build/introduction/',
      'Expo EAS Update Guide: https://docs.expo.dev/eas-update/introduction/',
      'Sentry for React Native Docs: https://docs.sentry.io/platforms/react-native/',
    ],
  ),
];
