import 'package:dev_path/models/roadmap_step_model.dart';

final List<RoadmapStepModel> angularRoadmapSteps = [
  RoadmapStepModel(
    id: 1,
    title: 'Angular Foundations & Standalone Components',
    description:
        'Master Angular Architecture, Angular CLI, TypeScript integration, and modern Standalone Components.',
    duration: '2 weeks',
    phase: 'Phase 1: Angular Core',
    level: 'Beginner to Intermediate',
    learningObjectives:
        'Scaffold Angular apps using Angular CLI, understand project layout, and write modern Standalone Components.',
    subtopics: [
      'Angular framework philosophy: Batteries-included enterprise web framework',
      'Angular CLI installation & essential commands (ng new, ng serve, ng generate, ng build)',
      'Anatomy of an Angular project: angular.json, main.ts, index.html, src/app/',
      'Standalone Components architecture (imports: [...] property in @Component decorator)',
      'Legacy NgModules (@NgModule) vs Modern Standalone Components',
      'TypeScript Integration: Interfaces, Types, Decorators (@Component, @Injectable)',
      'Template syntax: Interpolation ({{ value }}), Property Binding ([property]="value")',
      'Event Binding ((event)="handler()"), Two-Way Binding ([(ngModel)] with FormsModule)',
      'Control Flow Syntax (Angular 17+ @if, @else, @for, @switch)',
      'Component Styling: Encapsulation modes (Emulated, ShadowDom, None) & SCSS integration',
    ],
    exercises: [
      'Scaffold an Angular project using Angular CLI and build a Standalone Component featuring dynamic control flow syntax (@if, @for).',
      'Build a two-way data bound interactive user profile editor using [(ngModel)].',
    ],
    resources: [
      'Angular Official Documentation: https://angular.dev/',
      'Angular CLI Overview: https://angular.dev/tools/cli',
      'Angular Control Flow Guide (@if / @for): https://angular.dev/guide/templates/control-flow',
    ],
  ),
  RoadmapStepModel(
    id: 2,
    title: 'Component Interaction & Lifecycle Hooks',
    description:
        'Pass data between parent and child components using @Input, @Output, ViewChild, and lifecycle hooks.',
    duration: '2 weeks',
    phase: 'Phase 1: Angular Core',
    level: 'Intermediate',
    learningObjectives:
        'Communicate between components using input() / output() signals and decorators, and hook into component lifecycle phases.',
    subtopics: [
      'Parent-to-Child Communication: @Input() decorator & input() signals',
      'Child-to-Parent Communication: @Output() with EventEmitter & output() signals',
      'Component Lifecycle Hooks: ngOnInit, ngOnChanges, ngDoCheck, ngAfterViewInit, ngOnDestroy',
      'Accessing Child elements & components with @ViewChild / @ViewChildren',
      'Content Projection with <ng-content> (Single-slot & Multi-slot with select)',
      'Template Reference Variables (#varName)',
      'Container elements: <ng-container> & <ng-template>',
      'Dynamic Component Loading with ViewContainerRef',
      'Component OnPush Change Detection strategy basics',
      'Host bindings (@HostBinding) & Host listeners (@HostListener)',
    ],
    exercises: [
      'Build a reusable Card component utilizing multi-slot content projection (<ng-content select="[header]">).',
      'Implement custom event emission from a child Filter Component updating a parent list component.',
    ],
    resources: [
      'Angular Component Lifecycle: https://angular.dev/guide/components/lifecycle',
      'Angular Component Interaction Guide: https://angular.dev/guide/components/inputs-outputs',
    ],
  ),
  RoadmapStepModel(
    id: 3,
    title: 'Directives & Pipes',
    description:
        'Master Angular Built-in Attributes & Structural Directives, Custom Directives, and Data Transformation Pipes.',
    duration: '1-2 weeks',
    phase: 'Phase 2: UI Features',
    level: 'Intermediate',
    learningObjectives:
        'Create Custom Attribute Directives with ElementRef & Renderer2, and transform data in templates using Pipes.',
    subtopics: [
      'Types of Directives: Components, Attribute Directives, Structural Directives',
      'Built-in Attribute Directives: ngClass, ngStyle',
      'Built-in Structural Directives: *ngIf, *ngFor, *ngSwitch (Legacy syntax)',
      'Creating Custom Attribute Directives (@Directive decorator)',
      'ElementRef & Renderer2 for safe DOM manipulation',
      'Creating Custom Structural Directives with TemplateRef & ViewContainerRef',
      'Built-in Pipes: DatePipe, CurrencyPipe, DecimalPipe, JsonPipe, AsyncPipe',
      'Custom Pipes: Implementing PipeTransform interface (transform() method)',
      'Pure Pipes (cached evaluation) vs Impure Pipes',
      'Chaining multiple Pipes in template expressions',
    ],
    exercises: [
      'Build a custom tooltip directive (v-tooltip / appTooltip) that dynamically creates and positions a floating element on hover.',
      'Create a custom Pipe that transforms raw number bytes into human-readable strings (KB, MB, GB).',
    ],
    resources: [
      'Angular Directives Guide: https://angular.dev/guide/directives',
      'Angular Pipes Documentation: https://angular.dev/guide/pipes',
    ],
  ),
  RoadmapStepModel(
    id: 4,
    title: 'Dependency Injection & Services',
    description:
        'Master Angular\'s Hierarchical Dependency Injection (DI) system, injectable services, and singleton providers.',
    duration: '2 weeks',
    phase: 'Phase 2: UI Features',
    level: 'Intermediate',
    learningObjectives:
        'Write Angular Services with @Injectable, configure DI Providers (providedIn: "root"), and inject dependencies with inject() function.',
    subtopics: [
      'Angular Dependency Injection Architecture & Provider Trees',
      'Creating Services with @Injectable({ providedIn: "root" })',
      'Injecting Services: Constructor Injection vs modern inject() function',
      'Hierarchical Injector Tree: Root Injector, Component Injector, Module Injector',
      'Provider Configurations: useClass, useExisting, useValue, useFactory',
      'Injection Tokens (InjectionToken<T>) for non-class dependencies and configuration objects',
      'Multi-providers (multi: true) for extending framework hooks (HTTP_INTERCEPTORS, APP_INITIALIZER)',
      'Singleton Services vs Component-scoped Services',
      'APP_INITIALIZER for executing code during Angular application bootstrap',
      'Tree-shakable providers & performance implications',
    ],
    exercises: [
      'Build an Authentication Service that manages user sessions and inject it into multiple components using inject().',
      'Configure an InjectionToken for environment API base URLs and inject it into an HTTP service using useFactory.',
    ],
    resources: [
      'Angular Dependency Injection Guide: https://angular.dev/guide/di',
      'Angular Injectable Decorator: https://angular.dev/api/core/Injectable',
    ],
  ),
  RoadmapStepModel(
    id: 5,
    title: 'Reactive Programming with RxJS in Angular',
    description:
        'Master RxJS Observables, Subjects, BehaviorSubjects, Operators, and AsyncPipe for reactive data streams.',
    duration: '2-3 weeks',
    phase: 'Phase 3: State & Concurrency',
    level: 'Intermediate to Advanced',
    learningObjectives:
        'Understand Observables vs Promises, use RxJS operators (map, filter, switchMap, catchError), and handle AsyncPipe in templates.',
    subtopics: [
      'Reactive Programming Paradigm & RxJS in Angular',
      'Observables, Observers, & Subscriptions lifecycle',
      'Creating Observables: of(), from(), interval(), fromEvent()',
      'Hot vs Cold Observables',
      'RxJS Subjects: Subject, BehaviorSubject, ReplaySubject, AsyncSubject',
      'RxJS Transformation Operators: map, scan, switchMap, mergeMap, concatMap, exhaustMap',
      'RxJS Filtering Operators: filter, debounceTime, distinctUntilChanged, take, takeUntil',
      'RxJS Combination Operators: combineLatest, zip, forkJoin, merge',
      'Unsubscribing strategies: takeUntilDestroyed(), AsyncPipe, & managing memory leaks',
      'RxJS Error Handling: catchError, retry, and EMPTY fallback streams',
    ],
    exercises: [
      'Build a real-time typeahead search input in Angular using RxJS debounceTime, distinctUntilChanged, and switchMap.',
      'Manage global state in a service using BehaviorSubject and expose read-only Observables.',
    ],
    resources: [
      'RxJS Official Documentation: https://rxjs.dev/',
      'Learn RxJS Interactive Guide: https://www.learnrxjs.io/',
    ],
  ),
  RoadmapStepModel(
    id: 6,
    title: 'Angular Reactive Forms & Custom Validation',
    description:
        'Build complex, dynamic enterprise forms using Angular Reactive Forms (FormGroup, FormControl, FormArray).',
    duration: '2 weeks',
    phase: 'Phase 3: State & Concurrency',
    level: 'Intermediate',
    learningObjectives:
        'Construct FormGroups with FormBuilder, implement custom sync/async Validators, and manage dynamic arrays with FormArray.',
    subtopics: [
      'Reactive Forms vs Template-Driven Forms comparison',
      'Core Reactive Form Primitives: FormControl, FormGroup, FormArray',
      'Constructing forms using FormBuilder / NonNullableFormBuilder',
      'Built-in Validators: Validators.required, minLength, maxLength, pattern, email',
      'Displaying validation errors in templates & CSS states (ng-touched, ng-dirty, ng-invalid)',
      'Creating Custom Synchronous Validators (ValidatorFn)',
      'Creating Custom Asynchronous Validators (AsyncValidatorFn) with RxJS',
      'Dynamic Form Fields with FormArray (push, removeAt, clear)',
      'Cross-field validation (e.g. Password matching validation on FormGroup)',
      'Subscribing to valueChanges and statusChanges Observables',
    ],
    exercises: [
      'Build an registration form in Angular with custom password match validator and an Async Validator checking username availability.',
      'Create a dynamic survey builder form using FormArray allowing users to add/remove custom question inputs.',
    ],
    resources: [
      'Angular Reactive Forms Guide: https://angular.dev/guide/forms/reactive-forms',
      'Angular Form Validation: https://angular.dev/guide/forms/form-validation',
    ],
  ),
  RoadmapStepModel(
    id: 7,
    title: 'Angular Routing, Guards & Lazy Loading',
    description:
        'Build single-page navigation structures using Angular Router, Route Guards, Resolvers, and Lazy-Loaded Routes.',
    duration: '2 weeks',
    phase: 'Phase 3: State & Concurrency',
    level: 'Intermediate',
    learningObjectives:
        'Configure routes with RouterOutlet & RouterLink, protect routes with Functional Guards (canActivate), and configure lazy loading.',
    subtopics: [
      'Angular Router setup & Routes configuration array',
      'RouterOutlet directive & RouterLink / RouterLinkActive directives',
      'Dynamic Route Parameters (ActivatedRoute, paramMap, queryParamMap)',
      'Programmatic Navigation using Router.navigate() & Router.navigateByUrl()',
      'Functional Route Guards (Angular 15+): canActivate, canDeactivate, canMatch, canActivateChild',
      'Data Pre-fetching using Route Resolvers (resolve fn)',
      'Lazy Loading Standalone Components with loadComponent: () => import(...)',
      'Lazy Loading Route Branches with loadChildren',
      'Preloading Strategies: PreloadAllModules vs Custom Preloading Strategy',
      'Handling 404 Wildcard routes ({ path: "**", component: NotFoundComponent })',
    ],
    exercises: [
      'Build a multi-section dashboard with lazy-loaded routes and a canActivate Functional Guard preventing unauthorized user access.',
      'Implement a Route Resolver that fetches user profile data before displaying the profile component.',
    ],
    resources: [
      'Angular Router Guide: https://angular.dev/guide/routing',
      'Angular Functional Guards: https://angular.dev/api/router/CanActivateFn',
    ],
  ),
  RoadmapStepModel(
    id: 8,
    title: 'HTTP Client & Interceptors',
    description:
        'Connect Angular applications to RESTful backend services using HttpClient and HttpInterceptors.',
    duration: '2 weeks',
    phase: 'Phase 4: Advanced Features',
    level: 'Intermediate to Advanced',
    learningObjectives:
        'Perform HTTP requests with HttpClient, write Functional HTTP Interceptors (withInterceptors), and attach Auth tokens.',
    subtopics: [
      'HttpClient Module setup (provideHttpClient())',
      'HTTP Requests: GET, POST, PUT, PATCH, DELETE with strong TypeScript interfaces',
      'Configuring HTTP Headers (HttpHeaders) & Query Parameters (HttpParams)',
      'Handling HTTP Response types (JSON, Blob, Text) & Full Response inspection',
      'Functional Interceptors (Angular 15+ HttpInterceptorFn) with withInterceptors()',
      'Attaching JWT Authorization Bearer tokens in outbound requests',
      'Global Error Handling Interceptor using RxJS catchError operator',
      'Handling Loading Spinners with Interceptors',
      'Progress Events for file upload & download monitoring',
      'Mocking HTTP backend in development using HttpTestingController',
    ],
    exercises: [
      'Implement a functional Auth Interceptor that automatically attaches JWT tokens to outgoing API requests and refreshes expired tokens.',
      'Build a file uploader component with HttpClient progress event monitoring.',
    ],
    resources: [
      'Angular HttpClient Guide: https://angular.dev/guide/http',
      'Angular HTTP Interceptors: https://angular.dev/guide/http/interceptors',
    ],
  ),
  RoadmapStepModel(
    id: 9,
    title: 'State Management with NgRx',
    description:
        'Manage reactive global application state using NgRx Store, Actions, Reducers, Effects, and Selectors.',
    duration: '3 weeks',
    phase: 'Phase 4: Advanced Features',
    level: 'Advanced',
    learningObjectives:
        'Understand Redux architectural pattern in Angular, create Actions/Reducers with createAction/createReducer, write Effects, and query Selectors.',
    subtopics: [
      'NgRx Architecture: Actions, Reducers, Store, Selectors, and Effects',
      'Defining Actions with createAction() and props<T>()',
      'Writing Pure Reducers with createReducer() & on() action handlers',
      'Selecting state slices with createSelector() & memoization',
      'Handling Side-Effects with NgRx Effects (@ngrx/effects) & createEffect()',
      'Connecting NgRx Store to Components via Store service (store.dispatch, store.select)',
      'NgRx Entity (@ngrx/entity) for managing normalized entity collections',
      'NgRx ComponentStore for localized component-level state management',
      'Debugging state transitions with NgRx DevTools',
      'NgRx Signals (@ngrx/signals) modern reactive state store',
    ],
    exercises: [
      'Implement a complete e-commerce cart state feature in NgRx with Actions, Reducer, Selectors, and Effects fetching remote catalog items.',
      'Normalize a complex user list state using NgRx Entity adapters.',
    ],
    resources: [
      'NgRx Official Documentation: https://ngrx.io/docs',
      'NgRx ComponentStore Guide: https://ngrx.io/guide/component-store',
    ],
  ),
  RoadmapStepModel(
    id: 10,
    title: 'Angular Signals, SSR & Performance Tuning',
    description:
        'Master Angular Signals reactivity (iOS 16+ / Angular 17+), Server-Side Rendering (Angular Universal / SSR), and production optimization.',
    duration: '3 weeks',
    phase: 'Phase 5: Production & Full-Stack',
    level: 'Advanced',
    learningObjectives:
        'Use Angular Signals (signal, computed, effect), enable Server-Side Rendering (SSR) & Hydration, and optimize Change Detection.',
    subtopics: [
      'Angular Signals Overview: Fine-grained reactivity without Zone.js',
      'Writable Signals (signal()), Computed Signals (computed()), & Effects (effect())',
      'Converting Signals to/from RxJS Observables (toSignal(), toObservable())',
      'Signal-based Component Inputs (input()) & Outputs (output())',
      'Change Detection Optimization: Default vs OnPush strategy & Zone.js detachment',
      'Server-Side Rendering (SSR) with Angular Universal / Hydration',
      'Deferrable Views (@defer, @placeholder, @loading, @error) for lazy rendering',
      'Image Optimization with NgOptimizedImage directive',
      'Bundle Size Optimization: Tree-shaking, Source Map analysis, Budgets in angular.json',
      'Unit testing Angular components with Jasmine, Karma & Vitest',
    ],
    exercises: [
      'Build a reactive dashboard using Angular Signals without using Zone.js change detection.',
      'Optimize an Angular application bundle size, lazy loading routes, and adding @defer blocks for off-screen heavy components.',
    ],
    resources: [
      'Angular Signals Guide: https://angular.dev/guide/signals',
      'Angular Deferrable Views Guide: https://angular.dev/guide/templates/defer',
      'Angular SSR & Hydration: https://angular.dev/guide/ssr',
    ],
  ),
];
