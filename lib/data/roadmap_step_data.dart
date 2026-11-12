import 'package:dev_path/models/roadmap_step_model.dart';

class RoadmapStepData {
  static final Map<String, List<RoadmapStepModel>> languageSteps = {
    'Flutter': [
      RoadmapStepModel(
        id: 1,
        title: 'Dart Language Basics',
        description:
            'Learn variables, data types, functions, control flow (if/else, loops) and null safety.',
        duration: '1-2 weeks',
        subtopics: [
          'Dart syntax and variables',
          'Control flow & Loops',
          'Functions & Parameters',
          'Null Safety (?, !, late)',
        ],
        resources: [
          'Dart Official Language Tour: https://dart.dev/language',
          'DartPad Interactive Code Playground: https://dartpad.dev',
          'Dart Null Safety Guide: https://dart.dev/null-safety',
        ],
      ),
      RoadmapStepModel(
        id: 2,
        title: 'Object-Oriented Dart',
        description:
            'Master classes, objects, inheritance, abstract classes, mixins and asynchronous Dart (Future, async/await).',
        duration: '1-2 weeks',
        subtopics: [
          'Classes & Constructors',
          'Inheritance & Interfaces',
          'Abstract Classes & Mixins',
          'Futures, Streams & async/await',
        ],
        resources: [
          'Dart OOP Guide: https://dart.dev/language/classes',
          'Asynchronous Programming in Dart: https://dart.dev/codelabs/async-await',
        ],
      ),
      RoadmapStepModel(
        id: 3,
        title: 'Flutter UI & Core Widgets',
        description:
            'Understand StatelessWidget, StatefulWidget, Container, Column, Row, ListView, and Stack layout widgets.',
        duration: '2-3 weeks',
        subtopics: [
          'StatelessWidget vs StatefulWidget',
          'Container, Padding & Margin',
          'Row, Column & Flex Layouts',
          'ListView, GridView & SingleChildScrollView',
        ],
        resources: [
          'Flutter Widget Catalog: https://docs.flutter.dev/ui/widgets',
          'Building Layouts in Flutter: https://docs.flutter.dev/ui/layout',
        ],
      ),
      RoadmapStepModel(
        id: 4,
        title: 'Layouts, Theming & Navigation',
        description:
            'Learn responsive layouts, MediaQuery, Material 3 theming, Navigator 2.0, and GoRouter.',
        duration: '2 weeks',
        subtopics: [
          'MediaQuery & LayoutBuilder',
          'Material 3 Custom ColorScheme & ThemeData',
          'Navigator 2.0 & Named Routes',
          'GoRouter / GetX Navigation',
        ],
        resources: [
          'Material 3 Theme Guide: https://m3.material.io/',
          'GoRouter Official Package: https://pub.dev/packages/go_router',
        ],
      ),
      RoadmapStepModel(
        id: 5,
        title: 'State Management',
        description:
            'Master reactive state management using Provider, GetX, Riverpod, or BLoC architecture.',
        duration: '3-4 weeks',
        subtopics: [
          'setState vs State Management',
          'Provider / Riverpod Pattern',
          'GetX Controllers & Obx',
          'BLoC & Cubit Architecture',
        ],
        resources: [
          'Flutter State Management Guide: https://docs.flutter.dev/data-and-backend/state-mgmt/intro',
          'BLoC Library Official Docs: https://bloclibrary.dev/',
          'GetX Package Documentation: https://pub.dev/packages/get',
        ],
      ),
      RoadmapStepModel(
        id: 6,
        title: 'REST API & Networking',
        description:
            'Connect app with backend REST APIs using Http or Dio packages, parse JSON, and handle errors.',
        duration: '2-3 weeks',
        subtopics: [
          'HTTP Requests (GET, POST, PUT, DELETE)',
          'JSON Serializing & Model Classes',
          'Dio Client, Interceptors & Error Handling',
          'Authentication Headers & Tokens',
        ],
        resources: [
          'Fetch Data From Network: https://docs.flutter.dev/cookbook/networking/fetch-data',
          'Dio Package Documentation: https://pub.dev/packages/dio',
        ],
      ),
      RoadmapStepModel(
        id: 7,
        title: 'Local Storage & Databases',
        description:
            'Store offline data locally using SharedPreferences, Hive, Isar, or SQFlite database.',
        duration: '2 weeks',
        subtopics: [
          'SharedPreferences / Secure Storage',
          'Hive NoSQL Database',
          'SQLite & SQFlite Plugin',
          'Data Caching Strategies',
        ],
        resources: [
          'Persist Data with SQLite: https://docs.flutter.dev/cookbook/persistence/sqlite',
          'Hive NoSQL Database Docs: https://docs.hivedb.dev/',
        ],
      ),
      RoadmapStepModel(
        id: 8,
        title: 'Firebase & Backend Integration',
        description:
            'Implement Firebase Auth, Cloud Firestore, Cloud Storage, and Push Notifications (FCM).',
        duration: '3 weeks',
        subtopics: [
          'Firebase Core & Authentication',
          'Cloud Firestore Real-time Queries',
          'Firebase Storage (Images/Files)',
          'Push Notifications (FCM)',
        ],
        resources: [
          'FlutterFire Official Documentation: https://firebase.flutter.dev/',
          'Firebase Cloud Messaging Setup: https://firebase.google.com/docs/cloud-messaging',
        ],
      ),
      RoadmapStepModel(
        id: 9,
        title: 'Testing & App Release',
        description:
            'Write unit/widget tests, optimize app performance, and publish to Google Play Store & Apple App Store.',
        duration: '2 weeks',
        subtopics: [
          'Unit & Widget Testing',
          'DevTools, Profiling & Optimization',
          'Play Console Upload & Signings',
          'App Store Connect & TestFlight',
        ],
        resources: [
          'Testing Flutter Apps: https://docs.flutter.dev/testing',
          'Deploying to Play Store: https://docs.flutter.dev/deployment/android',
          'Deploying to App Store: https://docs.flutter.dev/deployment/ios',
        ],
      ),
    ],
    'Web Development': [
      RoadmapStepModel(
        id: 1,
        title: 'HTML5 Fundamentals',
        description:
            'Learn semantic HTML elements, forms, inputs, media tags, and web accessibility (ARIA).',
        duration: '1-2 weeks',
        subtopics: [
          'HTML Tag Structure & Semantics',
          'Forms, Validations & Inputs',
          'Images, Audio & Video Elements',
          'SEO Basics & Meta Tags',
        ],
        resources: [
          'MDN HTML Basics: https://developer.mozilla.org/en-US/docs/Learn/HTML',
          'W3C Accessibility Checklist: https://www.w3.org/WAI/standards-guidelines/wcag/',
        ],
      ),
      RoadmapStepModel(
        id: 2,
        title: 'CSS3 & Responsive Design',
        description:
            'Master CSS Box Model, Flexbox, Grid layout, Responsive Media Queries, and Animations.',
        duration: '2-3 weeks',
        subtopics: [
          'Box Model (Margin, Border, Padding)',
          'CSS Flexbox & Grid Layouts',
          'Responsive Breakpoints & Media Queries',
          'Transitions & Keyframe Animations',
        ],
        resources: [
          'CSS Flexible Box Layout Guide: https://css-tricks.com/snippets/css/a-guide-to-flexbox/',
          'Complete Guide to CSS Grid: https://css-tricks.com/snippets/css/complete-guide-grid/',
        ],
      ),
      RoadmapStepModel(
        id: 3,
        title: 'JavaScript ES6+ Core',
        description:
            'Learn DOM manipulation, events, promises, async/await, arrow functions, and ES6 modules.',
        duration: '3-4 weeks',
        subtopics: [
          'DOM Selection & Manipulation',
          'Event Listeners & Bubbling',
          'Promises, Fetch API & Async/Await',
          'ES6 Arrow Functions & Modules',
        ],
        resources: [
          'Modern JavaScript Info Guide: https://javascript.info/',
          'MDN JavaScript Reference: https://developer.mozilla.org/en-US/docs/Web/JavaScript',
        ],
      ),
      RoadmapStepModel(
        id: 4,
        title: 'Git & Version Control',
        description:
            'Master Git commands (commit, branch, merge, pull request) and GitHub collaborative workflows.',
        duration: '1 week',
        subtopics: [
          'Git Init, Add, Commit & Push',
          'Branching, Merging & Merge Conflicts',
          'GitHub Pull Requests & Reviews',
        ],
        resources: [
          'Pro Git Book Free: https://git-scm.com/book/en/v2',
          'GitHub Skills Tutorials: https://skills.github.com/',
        ],
      ),
      RoadmapStepModel(
        id: 5,
        title: 'CSS Frameworks & Tools',
        description:
            'Learn modern CSS utility frameworks like Tailwind CSS, Bootstrap, and Sass preprocessor.',
        duration: '2 weeks',
        subtopics: [
          'Tailwind CSS Utility Classes',
          'Bootstrap Components',
          'Sass Variables & Mixins',
        ],
        resources: [
          'Tailwind CSS Docs: https://tailwindcss.com/docs',
          'Bootstrap 5 Docs: https://getbootstrap.com/docs/5.3/',
        ],
      ),
      RoadmapStepModel(
        id: 6,
        title: 'Frontend Framework (React / Vue)',
        description:
            'Build single-page web applications using React.js or Vue.js with component-based architecture.',
        duration: '4-6 weeks',
        subtopics: [
          'Component Hierarchy & JSX',
          'State & Props Management',
          'Router Navigation (SPA)',
          'API Data Fetching',
        ],
        resources: [
          'React Official Guide: https://react.dev/learn',
          'Vue 3 Guide: https://vuejs.org/guide/introduction.html',
        ],
      ),
      RoadmapStepModel(
        id: 7,
        title: 'Web Security & Deployment',
        description:
            'Understand Web Vitals, SEO best practices, HTTPS security, and host on Vercel or Netlify.',
        duration: '2 weeks',
        subtopics: [
          'Core Web Vitals & Performance',
          'HTTPS & CORS Security',
          'Deployment on Vercel / Netlify',
        ],
        resources: [
          'Google Web Vitals Guide: https://web.dev/vitals/',
          'Vercel Deployment Docs: https://vercel.com/docs',
        ],
      ),
    ],
    'Python': [
      RoadmapStepModel(
        id: 1,
        title: 'Python Syntax & Basics',
        description:
            'Learn Python installation, variables, data types, type casting, and control statements.',
        duration: '1-2 weeks',
        subtopics: [
          'Variables & Primitive Types',
          'Conditionals (if, elif, else)',
          'For & While Loops',
          'Type Casting & Input',
        ],
        resources: [
          'Python Official Tutorial: https://docs.python.org/3/tutorial/',
          'W3Schools Python Tutorial: https://www.w3schools.com/python/',
        ],
      ),
      RoadmapStepModel(
        id: 2,
        title: 'Data Structures & Collections',
        description:
            'Master Python Lists, Tuples, Dictionaries, Sets, and list/dict comprehensions.',
        duration: '2 weeks',
        subtopics: [
          'Lists & Tuples Methods',
          'Dictionaries & Sets',
          'List & Dict Comprehensions',
        ],
        resources: [
          'Python Data Structures Docs: https://docs.python.org/3/tutorial/datastructures.html',
          'Real Python Data Structures: https://realpython.com/python-data-structures/',
        ],
      ),
      RoadmapStepModel(
        id: 3,
        title: 'Functions & Modules',
        description:
            'Learn function definitions, default args, *args/**kwargs, lambda functions, and pip virtual environment.',
        duration: '1-2 weeks',
        subtopics: [
          'Functions & Return Values',
          '*args and **kwargs Params',
          'Lambda & Map/Filter Functions',
          'Pip & Virtualenv Setup',
        ],
        resources: [
          'Python Virtual Environments: https://docs.python.org/3/tutorial/venv.html',
        ],
      ),
      RoadmapStepModel(
        id: 4,
        title: 'Object-Oriented Programming',
        description:
            'Understand Classes, Instances, Inheritance, Encapsulation, Polymorphism, and Dunder methods.',
        duration: '2-3 weeks',
        subtopics: [
          'Classes & __init__ Constructor',
          'Inheritance & Super()',
          'Encapsulation & Decorators (@property)',
          'Polymorphism & Special Methods',
        ],
        resources: [
          'Real Python OOP Guide: https://realpython.com/python3-object-oriented-programming/',
        ],
      ),
      RoadmapStepModel(
        id: 5,
        title: 'File Handling & Exceptions',
        description:
            'Learn reading/writing files (txt, csv, json), try/except blocks, custom exceptions, and context managers.',
        duration: '1-2 weeks',
        subtopics: [
          'File I/O (open, read, write)',
          'JSON & CSV File Parsing',
          'Try / Except Exception Blocks',
          'With Statement Context Managers',
        ],
        resources: [
          'Python Exception Handling: https://docs.python.org/3/tutorial/errors.html',
        ],
      ),
      RoadmapStepModel(
        id: 6,
        title: 'Database Access (SQL & ORM)',
        description:
            'Connect Python to PostgreSQL/SQLite databases using SQLAlchemy ORM or psycopg2.',
        duration: '2-3 weeks',
        subtopics: [
          'SQLite & psycopg2 Database Connection',
          'SQL Querying via Python',
          'SQLAlchemy ORM Models',
        ],
        resources: [
          'SQLAlchemy Official Unified Tutorial: https://docs.sqlalchemy.org/en/20/tutorial/',
        ],
      ),
      RoadmapStepModel(
        id: 7,
        title: 'Web Framework (FastAPI / Django)',
        description:
            'Build asynchronous REST APIs with FastAPI or full-stack web applications with Django.',
        duration: '3-4 weeks',
        subtopics: [
          'FastAPI Routes & Pydantic Models',
          'Django Views, Templates & ORM',
          'RESTful API Endpoints & Auth',
        ],
        resources: [
          'FastAPI Official Tutorial: https://fastapi.tiangolo.com/tutorial/',
          'Django Getting Started Guide: https://docs.djangoproject.com/en/stable/intro/tutorial01/',
        ],
      ),
      RoadmapStepModel(
        id: 8,
        title: 'Testing & Deployment',
        description:
            'Write automated tests with pytest, containerize using Docker, and deploy to Cloud.',
        duration: '2 weeks',
        subtopics: [
          'Pytest Unit Testing',
          'Docker Containerization',
          'Cloud Server Deployment',
        ],
        resources: [
          'Pytest Documentation: https://docs.pytest.org/',
        ],
      ),
    ],
    'React': [
      RoadmapStepModel(
        id: 1,
        title: 'Modern JS Prerequisites',
        description:
            'Master ES6 destructuring, spread operator, map/filter/reduce, arrow functions, and modules.',
        duration: '1-2 weeks',
        subtopics: [
          'Destructuring Arrays & Objects',
          'Spread & Rest Operators',
          'Map, Filter, Reduce Array Methods',
          'ES6 Imports & Exports',
        ],
        resources: [
          'React Prerequisites Guide: https://react.dev/learn/javascript-in-jsx-with-curly-braces',
        ],
      ),
      RoadmapStepModel(
        id: 2,
        title: 'React Components & JSX',
        description:
            'Understand JSX syntax, Functional Components, Props, and Conditional Rendering.',
        duration: '1-2 weeks',
        subtopics: [
          'JSX Rules & Expression Embedding',
          'Functional Components',
          'Props Passing & Validation',
          'Conditional Rendering Patterns',
        ],
        resources: [
          'Your First Component - React: https://react.dev/learn/your-first-component',
        ],
      ),
      RoadmapStepModel(
        id: 3,
        title: 'React Hooks & State',
        description:
            'Master useState, useEffect, useRef, useMemo, useCallback, and custom hooks.',
        duration: '2-3 weeks',
        subtopics: [
          'useState Hook & State Updates',
          'useEffect Lifecycle & Dependencies',
          'useRef DOM Access',
          'Building Custom Hooks',
        ],
        resources: [
          'Built-in React Hooks Reference: https://react.dev/reference/react/hooks',
        ],
      ),
      RoadmapStepModel(
        id: 4,
        title: 'Routing with React Router',
        description:
            'Implement multi-page SPA navigation, dynamic URL params, nested routes, and protected routes.',
        duration: '1-2 weeks',
        subtopics: [
          'BrowserRouter, Routes & Route',
          'Dynamic Params (useParams)',
          'Protected Routes & Auth Redirects',
        ],
        resources: [
          'React Router Tutorial: https://reactrouter.com/en/main/start/tutorial',
        ],
      ),
      RoadmapStepModel(
        id: 5,
        title: 'Global State Management',
        description:
            'Manage app-wide state using Redux Toolkit, Context API, Zustand, or TanStack Query.',
        duration: '3 weeks',
        subtopics: [
          'Context API & useContext',
          'Redux Toolkit Slices & Store',
          'Zustand Lightweight State',
          'TanStack / React Query Caching',
        ],
        resources: [
          'Redux Toolkit Quick Start: https://redux-toolkit.js.org/tutorials/quick-start',
          'TanStack Query Docs: https://tanstack.com/query/latest',
        ],
      ),
      RoadmapStepModel(
        id: 6,
        title: 'API Fetching & Form Handling',
        description:
            'Fetch data using Axios/Fetch, handle forms with React Hook Form, and validate with Zod.',
        duration: '2 weeks',
        subtopics: [
          'Axios Client & Interceptors',
          'React Hook Form Integration',
          'Zod Schema Validation',
        ],
        resources: [
          'React Hook Form Docs: https://react-hook-form.com/',
          'Zod Schema Validation: https://zod.dev/',
        ],
      ),
      RoadmapStepModel(
        id: 7,
        title: 'Next.js & Server Rendering',
        description:
            'Learn Next.js App Router, Server-Side Rendering (SSR), Static Generation (SSG), and Vercel deployment.',
        duration: '3-4 weeks',
        subtopics: [
          'Next.js App Router Structure',
          'Server Components vs Client Components',
          'SSR & SSG Rendering',
          'Vercel Deployment',
        ],
        resources: [
          'Next.js Official Documentation: https://nextjs.org/docs',
        ],
      ),
    ],
    'Java': [
      RoadmapStepModel(
        id: 1,
        title: 'Java Environment & Basics',
        description:
            'Understand JVM, JRE, JDK, Java syntax, primitive data types, variables, and operators.',
        duration: '2 weeks',
        subtopics: [
          'JVM, JRE & JDK Concept',
          'Variables & Primitive Data Types',
          'Control Flow (if, switch, for, while)',
        ],
        resources: [
          'Oracle Java Documentation: https://docs.oracle.com/en/java/',
        ],
      ),
      RoadmapStepModel(
        id: 2,
        title: 'Object-Oriented Programming',
        description:
            'Master OOP principles: Classes, Objects, Inheritance, Interfaces, Abstract Classes, and Polymorphism.',
        duration: '3 weeks',
        subtopics: [
          'Classes, Objects & Constructors',
          'Inheritance & Polymorphism',
          'Interfaces & Abstract Classes',
          'Encapsulation & Access Modifiers',
        ],
        resources: [
          'Java OOP Tutorial: https://dev.java/learn/oop/',
        ],
      ),
      RoadmapStepModel(
        id: 3,
        title: 'Collections Framework',
        description:
            'Learn ArrayList, LinkedList, HashSet, HashMap, PriorityQueue, Comparators, and Generics.',
        duration: '3 weeks',
        subtopics: [
          'List, Set & Map Interfaces',
          'ArrayList vs LinkedList',
          'HashMap & HashSet Operations',
          'Generics & Comparators',
        ],
        resources: [
          'Java Collections Framework Guide: https://dev.java/learn/api/collections/',
        ],
      ),
      RoadmapStepModel(
        id: 4,
        title: 'Exception Handling & Streams',
        description:
            'Master try-catch-finally, Checked vs Unchecked exceptions, Java 8 Streams API, and Lambdas.',
        duration: '2 weeks',
        subtopics: [
          'Checked vs Unchecked Exceptions',
          'Lambda Expressions',
          'Java 8 Streams (filter, map, collect)',
        ],
        resources: [
          'Java Streams API Guide: https://dev.java/learn/api/streams/',
        ],
      ),
      RoadmapStepModel(
        id: 5,
        title: 'Multithreading & Concurrency',
        description:
            'Learn Threads, Runnable interface, ExecutorService, Synchronization, and Thread Safety.',
        duration: '2-3 weeks',
        subtopics: [
          'Thread Creation & Life Cycle',
          'Synchronized Keywords & Locks',
          'ExecutorService & ThreadPools',
        ],
        resources: [
          'Java Concurrency Tutorial: https://docs.oracle.com/javase/tutorial/essential/concurrency/',
        ],
      ),
      RoadmapStepModel(
        id: 6,
        title: 'Spring Boot Backend Framework',
        description:
            'Build enterprise REST APIs using Spring Boot, Spring Data JPA, Spring Security, and Maven.',
        duration: '4-6 weeks',
        subtopics: [
          'Spring Boot Starters & Annotations',
          'Spring Data JPA & Hibernate ORM',
          'Spring Security & JWT Auth',
          'Building REST Controllers',
        ],
        resources: [
          'Spring Boot Getting Started: https://spring.io/guides/gs/spring-boot/',
        ],
      ),
    ],
    'Android (Kotlin)': [
      RoadmapStepModel(
        id: 1,
        title: 'Kotlin Fundamentals',
        description:
            'Learn Kotlin syntax, Null Safety (?), Smart Casts, Extension Functions, and Higher-Order Functions.',
        duration: '2-3 weeks',
        subtopics: [
          'Kotlin Variables (val vs var)',
          'Null Safety & Safe Call Operator',
          'Extension Functions & Lambdas',
        ],
        resources: [
          'Kotlin Language Docs: https://kotlinlang.org/docs/home.html',
        ],
      ),
      RoadmapStepModel(
        id: 2,
        title: 'Android Basics & Lifecycle',
        description:
            'Understand Android Studio, Activity, Fragment, Intent, AndroidManifest, and App Lifecycles.',
        duration: '2-3 weeks',
        subtopics: [
          'Activity & Fragment Lifecycles',
          'Intents & Explicit/Implicit Actions',
          'AndroidManifest Configuration',
        ],
        resources: [
          'Android App Fundamentals: https://developer.android.com/guide/components/fundamentals',
        ],
      ),
      RoadmapStepModel(
        id: 3,
        title: 'Jetpack Compose UI',
        description:
            'Build modern declarative UI using Composables, Modifiers, LazyColumn, State, and Recomposition.',
        duration: '3-4 weeks',
        subtopics: [
          '@Composable Functions',
          'State & Recomposition',
          'LazyColumn & LazyRow Lists',
          'Compose Material 3 Components',
        ],
        resources: [
          'Jetpack Compose Tutorial: https://developer.android.com/develop/ui/compose/documentation',
        ],
      ),
      RoadmapStepModel(
        id: 4,
        title: 'Architecture & ViewModel',
        description:
            'Implement Android MVVM Architecture using ViewModel, LiveData, StateFlow, and Navigation Compose.',
        duration: '2-3 weeks',
        subtopics: [
          'Android MVVM Pattern',
          'ViewModel & SavedStateHandle',
          'StateFlow & SharedFlow',
          'Navigation Compose Routes',
        ],
        resources: [
          'Guide to App Architecture: https://developer.android.com/topic/architecture',
        ],
      ),
      RoadmapStepModel(
        id: 5,
        title: 'Coroutines & Room DB',
        description:
            'Master async operations with Kotlin Coroutines & Flow, and store offline data with Room DB.',
        duration: '3 weeks',
        subtopics: [
          'Kotlin Coroutines (Dispatchers, Launch, Async)',
          'Room Entities, DAO & Database',
          'Flow Data Streams',
        ],
        resources: [
          'Kotlin Coroutines on Android: https://developer.android.com/kotlin/coroutines',
          'Room Database Guide: https://developer.android.com/training/data-storage/room',
        ],
      ),
      RoadmapStepModel(
        id: 6,
        title: 'Hilt DI & Retrofit API',
        description:
            'Inject dependencies using Dagger Hilt and consume REST APIs using Retrofit and Moshi/Gson.',
        duration: '3 weeks',
        subtopics: [
          'Dagger Hilt Dependency Injection',
          'Retrofit API Client & Moshi/Gson',
          'Repository Pattern Implementation',
        ],
        resources: [
          'Dependency Injection with Hilt: https://developer.android.com/training/dependency-injection/hilt-android',
        ],
      ),
    ],
    'Node.js': [
      RoadmapStepModel(
        id: 1,
        title: 'Node.js Runtime Core',
        description:
            'Understand V8 Engine, Event Loop, Non-blocking I/O, CommonJS vs ES Modules, and npm.',
        duration: '2 weeks',
        subtopics: [
          'Event Loop & Non-blocking I/O',
          'Node Core Modules (fs, path, http)',
          'NPM Package Management',
        ],
        resources: [
          'Node.js Official Documentation: https://nodejs.org/en/docs/',
        ],
      ),
      RoadmapStepModel(
        id: 2,
        title: 'Express.js Framework',
        description:
            'Master Express routing, custom middleware, request/response lifecycle, and error handling.',
        duration: '2 weeks',
        subtopics: [
          'Express App & Route Handlers',
          'Custom Middleware Functions',
          'Global Error Handling',
        ],
        resources: [
          'Express.js Getting Started: https://expressjs.com/en/starter/installing.html',
        ],
      ),
      RoadmapStepModel(
        id: 3,
        title: 'Authentication & Security',
        description:
            'Implement JWT Authentication, Password Hashing with bcrypt, CORS, Rate Limiting, and Helmet.',
        duration: '2-3 weeks',
        subtopics: [
          'JWT Auth & Authorization Middleware',
          'Password Hashing (bcrypt)',
          'Security Best Practices (Helmet, CORS)',
        ],
        resources: [
          'JWT Authentication Docs: https://jwt.io/introduction',
        ],
      ),
      RoadmapStepModel(
        id: 4,
        title: 'Databases & ORM',
        description:
            'Connect MongoDB with Mongoose or PostgreSQL with Prisma ORM / TypeORM.',
        duration: '3 weeks',
        subtopics: [
          'MongoDB & Mongoose Schema',
          'PostgreSQL & Prisma ORM',
          'Database Migrations & Queries',
        ],
        resources: [
          'Mongoose Documentation: https://mongoosejs.com/docs/',
          'Prisma ORM Docs: https://www.prisma.io/docs',
        ],
      ),
      RoadmapStepModel(
        id: 5,
        title: 'Testing & Microservices',
        description:
            'Write API tests with Jest & Supertest, build WebSockets (Socket.io), and containerize with Docker.',
        duration: '3 weeks',
        subtopics: [
          'Jest & Supertest API Testing',
          'Socket.io Real-time WebSockets',
          'Dockerizing Node Application',
        ],
        resources: [
          'Jest Documentation: https://jestjs.io/',
          'Socket.io Documentation: https://socket.io/docs/v4/',
        ],
      ),
    ],
    'DevOps & Cloud': [
      RoadmapStepModel(
        id: 1,
        title: 'Linux Administration',
        description:
            'Master Linux terminal commands, file permissions, user management, bash scripting, and systemd services.',
        duration: '2-3 weeks',
        subtopics: [
          'Linux CLI & File Permissions',
          'Bash Shell Scripting',
          'Systemd Services & Logs',
        ],
        resources: [
          'Linux Journey Tutorial: https://linuxjourney.com/',
        ],
      ),
      RoadmapStepModel(
        id: 2,
        title: 'Networking & Security',
        description:
            'Understand OSI Model, TCP/IP, DNS, HTTP/S protocols, SSH keys, Firewalls, and SSL Certificates.',
        duration: '2 weeks',
        subtopics: [
          'TCP/IP & OSI Model',
          'DNS, HTTP/S & SSL Certificates',
          'SSH Keys & Firewall Setup',
        ],
        resources: [
          'DigitalOcean Networking Tutorials: https://www.digitalocean.com/community/tags/networking',
        ],
      ),
      RoadmapStepModel(
        id: 3,
        title: 'Containerization with Docker',
        description:
            'Build custom Dockerfiles, manage multi-container apps with Docker Compose, volumes, and networks.',
        duration: '3 weeks',
        subtopics: [
          'Dockerfile Writing & Optimization',
          'Docker Compose Multi-container Setup',
          'Docker Volumes & Networking',
        ],
        resources: [
          'Docker Official Documentation: https://docs.docker.com',
        ],
      ),
      RoadmapStepModel(
        id: 4,
        title: 'CI/CD Automation Pipelines',
        description:
            'Automate testing and deployment using GitHub Actions, Jenkins, or GitLab CI/CD.',
        duration: '2-3 weeks',
        subtopics: [
          'GitHub Actions Workflows',
          'Automated Testing Pipelines',
          'Auto Deployment Strategies',
        ],
        resources: [
          'GitHub Actions Docs: https://docs.github.com/en/actions',
        ],
      ),
      RoadmapStepModel(
        id: 5,
        title: 'Kubernetes Orchestration',
        description:
            'Deploy & scale containerized apps using Kubernetes Pods, Deployments, Services, Ingress, and Helm.',
        duration: '4 weeks',
        subtopics: [
          'Pods, Deployments & ReplicaSets',
          'Kubernetes Services & Ingress',
          'Helm Package Manager',
        ],
        resources: [
          'Kubernetes Basics Tutorial: https://kubernetes.io/docs/tutorials/kubernetes-basics/',
        ],
      ),
      RoadmapStepModel(
        id: 6,
        title: 'Infrastructure as Code & Cloud',
        description:
            'Provision AWS/Cloud infrastructure using Terraform and automate configuration with Ansible.',
        duration: '4 weeks',
        subtopics: [
          'Terraform Infrastructure Modules',
          'Ansible Playbooks & Provisioning',
          'AWS Cloud Fundamentals (EC2, S3, IAM)',
        ],
        resources: [
          'HashiCorp Terraform Learn: https://developer.hashicorp.com/terraform/tutorials',
        ],
      ),
    ],
    'Data Science & AI': [
      RoadmapStepModel(
        id: 1,
        title: 'Python for Data Analysis',
        description:
            'Master Python data science libraries: NumPy arrays, Pandas DataFrames, and Data Cleaning techniques.',
        duration: '3-4 weeks',
        subtopics: [
          'NumPy Array Operations',
          'Pandas DataFrames & Manipulation',
          'Data Cleaning & Feature Engineering',
        ],
        resources: [
          'Pandas Documentation: https://pandas.pydata.org/docs/',
        ],
      ),
      RoadmapStepModel(
        id: 2,
        title: 'Math & Statistics',
        description:
            'Learn Linear Algebra, Calculus, Descriptive & Inferential Statistics, Probability, and Hypothesis Testing.',
        duration: '3 weeks',
        subtopics: [
          'Linear Algebra & Matrices',
          'Probability & Distributions',
          'Hypothesis Testing & p-values',
        ],
        resources: [
          'Khan Academy Statistics & Probability: https://www.khanacademy.org/math/statistics-probability',
        ],
      ),
      RoadmapStepModel(
        id: 3,
        title: 'Data Visualization',
        description:
            'Create insightful visual plots and charts using Matplotlib, Seaborn, and Plotly interactive dashboards.',
        duration: '2 weeks',
        subtopics: [
          'Matplotlib & Seaborn Plots',
          'Plotly Interactive Graphics',
        ],
        resources: [
          'Seaborn Tutorial: https://seaborn.pydata.org/tutorial.html',
        ],
      ),
      RoadmapStepModel(
        id: 4,
        title: 'Machine Learning Models',
        description:
            'Build ML algorithms with Scikit-Learn: Linear/Logistic Regression, Decision Trees, Random Forests, KNN.',
        duration: '4 weeks',
        subtopics: [
          'Supervised Regression & Classification',
          'Random Forest & Decision Trees',
          'Model Evaluation Metrics (F1, ROC-AUC)',
        ],
        resources: [
          'Scikit-Learn Tutorials: https://scikit-learn.org/stable/tutorial/index.html',
        ],
      ),
      RoadmapStepModel(
        id: 5,
        title: 'Deep Learning & Neural Networks',
        description:
            'Build deep neural networks (ANN, CNN, RNN) using PyTorch or TensorFlow for AI predictions.',
        duration: '4-6 weeks',
        subtopics: [
          'Artificial Neural Networks (ANN)',
          'Convolutional Neural Networks (CNN)',
          'PyTorch / TensorFlow Frameworks',
        ],
        resources: [
          'PyTorch Deep Learning Tutorials: https://pytorch.org/tutorials/',
        ],
      ),
    ],
    'iOS (Swift)': [
      RoadmapStepModel(
        id: 1,
        title: 'Swift Language Basics',
        description:
            'Learn Swift syntax, Optionals, Closures, Structs, Enums, Protocols, and Generics.',
        duration: '2-3 weeks',
        subtopics: [
          'Swift Syntax & Optionals (?)',
          'Structs, Enums & Classes',
          'Protocols & Extensions',
        ],
        resources: [
          'Swift Language Documentation: https://developer.apple.com/swift/',
        ],
      ),
      RoadmapStepModel(
        id: 2,
        title: 'Xcode & SwiftUI Core',
        description:
            'Build iOS user interfaces using SwiftUI views, modifiers, VStacks, HStacks, and NavigationStack.',
        duration: '3 weeks',
        subtopics: [
          'SwiftUI Layout Views (VStack, HStack, ZStack)',
          'View Modifiers & State',
          'NavigationStack & Lists',
        ],
        resources: [
          'SwiftUI Official Tutorials: https://developer.apple.com/documentation/swiftui/',
        ],
      ),
      RoadmapStepModel(
        id: 3,
        title: 'State & Data Flow',
        description:
            'Understand @State, @Binding, @StateObject, @EnvironmentObject, and MVVM Architecture.',
        duration: '2-3 weeks',
        subtopics: [
          '@State & @Binding Properties',
          '@StateObject & @Observable',
          'iOS MVVM Architecture',
        ],
        resources: [
          'Data Essentials in SwiftUI: https://developer.apple.com/documentation/swiftui/managing-user-interface-state',
        ],
      ),
      RoadmapStepModel(
        id: 4,
        title: 'Networking & SwiftData',
        description:
            'Consume REST APIs with URLSession & Codable, and persist local data using SwiftData / CoreData.',
        duration: '3 weeks',
        subtopics: [
          'URLSession & Async/Await Requests',
          'Codable JSON Parsing',
          'SwiftData / CoreData Persistence',
        ],
        resources: [
          'SwiftData Documentation: https://developer.apple.com/documentation/swiftdata',
        ],
      ),
      RoadmapStepModel(
        id: 5,
        title: 'App Store Publishing',
        description:
            'Test with TestFlight, configure Provisioning Profiles, and submit iOS apps to Apple App Store.',
        duration: '2 weeks',
        subtopics: [
          'TestFlight Beta Distribution',
          'App Store Connect Submission',
        ],
        resources: [
          'App Store Connect Distribution Guide: https://developer.apple.com/distribute/',
        ],
      ),
    ],
    'C++ & DSA': [
      RoadmapStepModel(
        id: 1,
        title: 'C++ Language Basics',
        description:
            'Learn C++ syntax, Pointers, References, Dynamic Memory Allocation, and Standard Template Library (STL).',
        duration: '3 weeks',
        subtopics: [
          'Pointers & References',
          'Dynamic Memory Allocation (new/delete)',
          'C++ STL (Vector, Map, Set, Queue)',
        ],
        resources: [
          'cppreference.com Reference: https://en.cppreference.com',
        ],
      ),
      RoadmapStepModel(
        id: 2,
        title: 'Time & Space Complexity',
        description:
            'Understand Big O notation, Best/Worst case analysis, and memory consumption calculation.',
        duration: '1 week',
        subtopics: [
          'Big-O Notation Analysis',
          'Time vs Space Trade-offs',
        ],
        resources: [
          'Big-O Cheat Sheet: https://www.bigocheatsheet.com/',
        ],
      ),
      RoadmapStepModel(
        id: 3,
        title: 'Arrays, Strings & Recursion',
        description:
            'Master Two Pointers, Sliding Window, Prefix Sum, Recursion, and Backtracking algorithms.',
        duration: '3 weeks',
        subtopics: [
          'Two Pointers & Sliding Window',
          'Recursion & Call Stack',
          'Backtracking Algorithms',
        ],
        resources: [
          'LeetCode Array & String Explore Card: https://leetcode.com/explore/',
        ],
      ),
      RoadmapStepModel(
        id: 4,
        title: 'Linear Data Structures',
        description:
            'Implement Linked Lists, Stacks, Queues, and solve popular LeetCode problem patterns.',
        duration: '3 weeks',
        subtopics: [
          'Single & Doubly Linked Lists',
          'Stack & Queue Applications',
          'Monotonic Stack Pattern',
        ],
        resources: [
          'GeeksforGeeks Data Structures Guide: https://www.geeksforgeeks.org/data-structures/',
        ],
      ),
      RoadmapStepModel(
        id: 5,
        title: 'Trees & Heaps',
        description:
            'Master Binary Trees, Binary Search Trees (BST), Tree Traversals, Priority Queues, and Heaps.',
        duration: '3 weeks',
        subtopics: [
          'Binary Tree Traversals (In/Pre/Post Order)',
          'Binary Search Tree (BST) Operations',
          'Priority Queue & Max/Min Heap',
        ],
        resources: [
          'Binary Tree Algorithms Guide: https://www.geeksforgeeks.org/binary-tree-data-structure/',
        ],
      ),
      RoadmapStepModel(
        id: 6,
        title: 'Graphs & Dynamic Programming',
        description:
            'Master Graph Traversals (BFS/DFS), Shortest Path (Dijkstra), and 1D/2D Dynamic Programming.',
        duration: '4-6 weeks',
        subtopics: [
          'Graph Traversals (BFS & DFS)',
          'Dijkstra Shortest Path Algorithm',
          'Dynamic Programming (Memoization & Tabulation)',
        ],
        resources: [
          'Dynamic Programming Patterns: https://leetcode.com/discuss/general-discussion/458695/dynamic-programming-patterns',
        ],
      ),
    ],
    'Vue.js': [
      RoadmapStepModel(
        id: 1,
        title: 'Vue 3 Core Basics',
        description:
            'Learn Vue template syntax, Directives (v-bind, v-model, v-if, v-for), and Event Handling.',
        duration: '2 weeks',
        subtopics: [
          'Vue Directives & Data Binding',
          'Event Handling & Form Binding',
        ],
        resources: [
          'Vue 3 Essentials Guide: https://vuejs.org/guide/essentials/application.html',
        ],
      ),
      RoadmapStepModel(
        id: 2,
        title: 'Composition API',
        description:
            'Master Composition API, Script Setup, ref(), reactive(), computed(), and watch() hooks.',
        duration: '2 weeks',
        subtopics: [
          'ref() vs reactive() State',
          'Computed Properties & Watchers',
        ],
        resources: [
          'Composition API FAQ: https://vuejs.org/guide/extras/composition-api-faq.html',
        ],
      ),
      RoadmapStepModel(
        id: 3,
        title: 'Vue Router & Pinia',
        description:
            'Implement Single Page App routing with Vue Router and global state management with Pinia.',
        duration: '2-3 weeks',
        subtopics: [
          'Vue Router Navigation',
          'Pinia Store State Management',
        ],
        resources: [
          'Pinia Official Documentation: https://pinia.vuejs.org/',
        ],
      ),
    ],
    'Cybersecurity': [
      RoadmapStepModel(
        id: 1,
        title: 'Networking & OS Basics',
        description:
            'Master TCP/IP, OSI Layers, Subnetting, Wireshark packet capture, and Kali Linux administration.',
        duration: '3 weeks',
        subtopics: [
          'OSI Layers & Subnetting',
          'Wireshark Network Analysis',
          'Kali Linux Fundamentals',
        ],
        resources: [
          'Cybrary Ethical Hacking: https://www.cybrary.it/',
        ],
      ),
      RoadmapStepModel(
        id: 2,
        title: 'Web Security (OWASP Top 10)',
        description:
            'Learn Web Vulnerabilities: SQL Injection, XSS, CSRF, Authentication Bypasses, and Burp Suite.',
        duration: '4 weeks',
        subtopics: [
          'SQL Injection & XSS Exploitation',
          'Burp Suite Web Proxy Testing',
        ],
        resources: [
          'OWASP Top 10 Project: https://owasp.org/www-project-top-ten/',
          'PortSwigger Web Security Academy: https://portswigger.net/web-security',
        ],
      ),
      RoadmapStepModel(
        id: 3,
        title: 'Ethical Hacking & PenTesting',
        description:
            'Perform Network Reconnaissance (Nmap), Metasploit Exploitation, Privilege Escalation, and CTF challenges.',
        duration: '4-6 weeks',
        subtopics: [
          'Nmap Network Scanning',
          'Metasploit Exploitation Framework',
          'Privilege Escalation Techniques',
        ],
        resources: [
          'TryHackMe Cybersecurity Practice: https://tryhackme.com/',
        ],
      ),
    ],
    'Go (Golang)': [
      RoadmapStepModel(
        id: 1,
        title: 'Go Syntax & Basics',
        description:
            'Learn Go syntax, Pointers, Structs, Interfaces, Packages, and Error Handling.',
        duration: '2 weeks',
        subtopics: [
          'Go Primitive Types & Variables',
          'Structs, Interfaces & Methods',
          'Explicit Error Handling',
        ],
        resources: [
          'A Tour of Go: https://go.dev/tour/welcome/1',
        ],
      ),
      RoadmapStepModel(
        id: 2,
        title: 'Concurrency Model',
        description:
            'Master Goroutines, Channels, Select statement, Worker Pools, and Mutex synchronization.',
        duration: '2-3 weeks',
        subtopics: [
          'Goroutines & Channels',
          'Select Statement & Worker Pools',
          'Mutex Sync & Atomic Operations',
        ],
        resources: [
          'Go Concurrency Patterns: https://go.dev/blog/concurrency-pass-by-value',
        ],
      ),
      RoadmapStepModel(
        id: 3,
        title: 'REST API & Microservices',
        description:
            'Build high-performance web APIs with Gin / Fiber framework, GORM database layer, and Docker.',
        duration: '3 weeks',
        subtopics: [
          'Gin / Fiber Web Framework',
          'GORM Database Integration',
          'Building RESTful Microservices',
        ],
        resources: [
          'Gin Web Framework Docs: https://gin-gonic.com/docs/',
        ],
      ),
    ],
    'Angular': [
      RoadmapStepModel(
        id: 1,
        title: 'TypeScript Essentials',
        description:
            'Master TypeScript Types, Interfaces, Classes, Generics, Decorators, and Enums.',
        duration: '2 weeks',
        subtopics: [
          'TypeScript Types & Interfaces',
          'Classes, Generics & Decorators',
        ],
        resources: [
          'TypeScript Official Handbook: https://www.typescriptlang.org/docs/handbook/intro.html',
        ],
      ),
      RoadmapStepModel(
        id: 2,
        title: 'Angular Architecture',
        description:
            'Understand Modules, Standalone Components, Data Binding, Directives, and Custom Pipes.',
        duration: '3 weeks',
        subtopics: [
          'Standalone Components & Templates',
          'Property & Event Binding',
          'Custom Directives & Pipes',
        ],
        resources: [
          'Angular Essentials: https://angular.dev/overview',
        ],
      ),
      RoadmapStepModel(
        id: 3,
        title: 'Services & RxJS Observables',
        description:
            'Implement Dependency Injection, HttpClient requests, and RxJS Observables & Operators.',
        duration: '3 weeks',
        subtopics: [
          'Dependency Injection Services',
          'HttpClient API Requests',
          'RxJS Observables & Pipe Operators',
        ],
        resources: [
          'RxJS Official Documentation: https://rxjs.dev/guide/overview',
        ],
      ),
    ],
    'React Native': [
      RoadmapStepModel(
        id: 1,
        title: 'React Native Core',
        description:
            'Understand View, Text, Image, FlatList, ScrollView components, and StyleSheet layout.',
        duration: '2 weeks',
        subtopics: [
          'Core Native Components',
          'StyleSheet & Flexbox Layout',
          'FlatList & ScrollView Performance',
        ],
        resources: [
          'React Native Official Docs: https://reactnative.dev/docs/getting-started',
        ],
      ),
      RoadmapStepModel(
        id: 2,
        title: 'Navigation & State',
        description:
            'Implement React Navigation (Stack, Tabs), Context API, and Redux Toolkit state.',
        duration: '3 weeks',
        subtopics: [
          'React Navigation Stack & Tabs',
          'AsyncStorage Local Storage',
          'Redux Toolkit State Integration',
        ],
        resources: [
          'React Navigation Docs: https://reactnavigation.org/docs/getting-started/',
        ],
      ),
      RoadmapStepModel(
        id: 3,
        title: 'Native Features & Release',
        description:
            'Access Camera, Async Storage, Push Notifications, and build APK/IPA for App Stores.',
        duration: '3 weeks',
        subtopics: [
          'Camera & Geolocation Permissions',
          'Push Notifications Setup',
          'Android APK & iOS IPA Release',
        ],
        resources: [
          'Publishing to Google Play: https://reactnative.dev/docs/signed-apk-android',
        ],
      ),
    ],
    'SQL & Database Design': [
      RoadmapStepModel(
        id: 1,
        title: 'Relational Database Concepts',
        description:
            'Learn Tables, Primary Keys, Foreign Keys, ER Diagrams, and Database Normalization (1NF, 2NF, 3NF).',
        duration: '2 weeks',
        subtopics: [
          'ER Diagrams & Schema Design',
          'Primary & Foreign Keys',
          'Database Normalization Rules',
        ],
        resources: [
          'PostgreSQL Tutorial: https://www.postgresqltutorial.com/',
        ],
      ),
      RoadmapStepModel(
        id: 2,
        title: 'SQL Querying (DML & DDL)',
        description:
            'Master SELECT, WHERE, INNER/LEFT JOINs, GROUP BY, HAVING, Aggregate Functions, and Subqueries.',
        duration: '2-3 weeks',
        subtopics: [
          'SELECT, WHERE & Filtering',
          'INNER, LEFT & RIGHT JOINs',
          'GROUP BY & Aggregate Functions',
          'Subqueries & CTEs',
        ],
        resources: [
          'SQL Zoo Interactive Exercises: https://sqlzoo.net/',
        ],
      ),
      RoadmapStepModel(
        id: 3,
        title: 'Indexing & Performance Tuning',
        description:
            'Understand B-Tree Indexes, Query Execution Plans (EXPLAIN), Transactions (ACID), and Locking.',
        duration: '2 weeks',
        subtopics: [
          'B-Tree Indexes Creation',
          'EXPLAIN Query Optimization',
          'ACID Transactions & Rollbacks',
        ],
        resources: [
          'Use The Index, Luke (SQL Indexing): https://use-the-index-luke.com/',
        ],
      ),
    ],
    'GraphQL': [
      RoadmapStepModel(
        id: 1,
        title: 'GraphQL Basics & Schema',
        description:
            'Learn Schema Definition Language (SDL), Types, Queries, Mutations, and Subscriptions.',
        duration: '1-2 weeks',
        subtopics: [
          'Schema Definition Language (SDL)',
          'Queries, Mutations & Subscriptions',
        ],
        resources: [
          'GraphQL Official Learn: https://graphql.org/learn/',
        ],
      ),
      RoadmapStepModel(
        id: 2,
        title: 'GraphQL Server & Client',
        description:
            'Build GraphQL Server with Apollo Server and integrate frontend client with Apollo Client.',
        duration: '2-3 weeks',
        subtopics: [
          'Apollo Server Resolvers',
          'Apollo Client & Cache Management',
        ],
        resources: [
          'Apollo GraphQL Docs: https://www.apollographql.com/docs/',
        ],
      ),
    ],
    'Blockchain & Solidity': [
      RoadmapStepModel(
        id: 1,
        title: 'Blockchain Fundamentals',
        description:
            'Understand Decentralization, Hashing, Cryptography, Consensus (PoW/PoS), and Ethereum Virtual Machine (EVM).',
        duration: '2-3 weeks',
        subtopics: [
          'Blockchain Cryptography & Hashing',
          'Consensus Mechanisms (PoW vs PoS)',
          'Ethereum Virtual Machine (EVM)',
        ],
        resources: [
          'Ethereum Developer Docs: https://ethereum.org/en/developers/docs/',
        ],
      ),
      RoadmapStepModel(
        id: 2,
        title: 'Solidity Smart Contracts',
        description:
            'Master Solidity syntax, State Variables, Mappings, Modifiers, Events, Payable functions, and Inheritance.',
        duration: '3 weeks',
        subtopics: [
          'Solidity Syntax & Data Types',
          'Mappings, Modifiers & Events',
          'ERC-20 & ERC-721 Token Standards',
        ],
        resources: [
          'CryptoZombies Interactive Solidity Tutorial: https://cryptozombies.io/',
          'Solidity Official Docs: https://docs.soliditylang.org/',
        ],
      ),
      RoadmapStepModel(
        id: 3,
        title: 'Web3 & dApp Integration',
        description:
            'Interact with Smart Contracts using Ethers.js / Web3.js, Hardhat framework, Metamask, and OpenZeppelin.',
        duration: '4 weeks',
        subtopics: [
          'Hardhat / Foundry Testing Framework',
          'Ethers.js & Metamask Wallet Connection',
          'Deploying dApps to Testnets',
        ],
        resources: [
          'Hardhat Ethereum Development: https://hardhat.org/tutorial',
        ],
      ),
    ],
    'Machine Learning': [
      RoadmapStepModel(
        id: 1,
        title: 'Math & Data Preparation',
        description:
            'Learn Linear Algebra, Probability, Feature Scaling, Normalization, and Missing Value Handling.',
        duration: '3 weeks',
        subtopics: [
          'Linear Algebra & Matrices',
          'Feature Scaling & Normalization',
          'Handling Missing & Categorical Data',
        ],
        resources: [
          'Kaggle ML Courses: https://www.kaggle.com/learn',
        ],
      ),
      RoadmapStepModel(
        id: 2,
        title: 'Supervised Learning',
        description:
            'Master Regression, Logistic Regression, Decision Trees, Random Forests, and Support Vector Machines.',
        duration: '4 weeks',
        subtopics: [
          'Linear & Logistic Regression',
          'Decision Trees & Random Forests',
          'Model Validation & Cross-Validation',
        ],
        resources: [
          'Machine Learning Specialization - Coursera: https://www.coursera.org/specializations/machine-learning-introduction',
        ],
      ),
      RoadmapStepModel(
        id: 3,
        title: 'Unsupervised & Deep Learning',
        description:
            'Learn K-Means Clustering, PCA dimension reduction, and build Neural Networks with PyTorch/TensorFlow.',
        duration: '4-6 weeks',
        subtopics: [
          'K-Means Clustering & PCA',
          'Neural Networks (PyTorch / TensorFlow)',
          'Model Deployment with FastAPI / Docker',
        ],
        resources: [
          'PyTorch Official Tutorials: https://pytorch.org/tutorials/',
          'TensorFlow Learn: https://www.tensorflow.org/learn',
        ],
      ),
    ],
  };

  static List<RoadmapStepModel> getStepsForLanguage(String language) {
    for (var key in languageSteps.keys) {
      if (language.toLowerCase().contains(key.toLowerCase()) ||
          key.toLowerCase().contains(language.toLowerCase())) {
        return languageSteps[key]!;
      }
    }

    return [
      RoadmapStepModel(
        id: 1,
        title: '$language Language Basics',
        description:
            'Learn core syntax, variables, data types, functions, and control flow statements.',
        duration: '1-2 weeks',
        subtopics: [
          'Syntax & Key Concepts',
          'Variables & Data Types',
          'Control Flow & Functions',
        ],
        resources: [
          '$language Official Documentation: https://devdocs.io',
        ],
      ),
      RoadmapStepModel(
        id: 2,
        title: 'Core Concepts & Tooling',
        description:
            'Understand environment setup, package management, object-oriented concepts, and debugging.',
        duration: '2 weeks',
        subtopics: [
          'Environment Setup & Package Manager',
          'Object-Oriented Design',
          'Debugging & Exception Handling',
        ],
        resources: [
          '$language Package Guide: https://devdocs.io',
        ],
      ),
      RoadmapStepModel(
        id: 3,
        title: 'Frameworks & Libraries',
        description:
            'Master popular frameworks, state management, API integration, and database connectivity.',
        duration: '3-4 weeks',
        subtopics: [
          'Popular Framework Architecture',
          'State & API Integration',
          'Database Connectivity',
        ],
        resources: [
          '$language Framework Docs: https://devdocs.io',
        ],
      ),
      RoadmapStepModel(
        id: 4,
        title: 'Real-world Projects & Deployment',
        description:
            'Build full-stack applications, write automated tests, and deploy to production cloud servers.',
        duration: '2-3 weeks',
        subtopics: [
          'Building Real-world Application',
          'Automated Unit Testing',
          'Production Cloud Deployment',
        ],
        resources: [
          '$language Deployment Guide: https://devdocs.io',
        ],
      ),
    ];
  }
}
