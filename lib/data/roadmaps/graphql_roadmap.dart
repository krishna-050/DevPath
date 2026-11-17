import 'package:dev_path/models/roadmap_step_model.dart';

final List<RoadmapStepModel> graphqlRoadmapSteps = [
  RoadmapStepModel(
    id: 1,
    title: 'GraphQL Foundations & SDL',
    description:
        'Understand GraphQL core concepts, over-fetching vs under-fetching in REST, and Schema Definition Language (SDL).',
    duration: '1-2 weeks',
    phase: 'Phase 1: GraphQL Core',
    level: 'Beginner to Intermediate',
    learningObjectives:
        'Compare GraphQL vs REST APIs, write Schema Definition Language (SDL) types, fields, and understand single endpoint routing.',
    subtopics: [
      'What is GraphQL? Declarative data fetching vs REST endpoint over-fetching / under-fetching',
      'Single endpoint architecture (/graphql) vs Multiple REST resource URIs',
      'GraphQL Schema Definition Language (SDL) syntax',
      'GraphQL Scalar Types: Int, Float, String, Boolean, ID',
      'Object Types, Fields, and Field Non-Nullability (! modifier)',
      'List Type Modifier ([Type]) and nested non-null arrays ([Type!]!)',
      'Root Operation Types: Query, Mutation, Subscription',
      'GraphQL Playground, GraphiQL, & Apollo Sandbox IDEs',
      'Enum Types (enum Role { ADMIN, USER })',
      'Input Object Types (input CreateUserInput { ... }) for payload bundling',
    ],
    exercises: [
      'Write a GraphQL SDL schema for a Blog application defining User, Post, and Comment types with relationships.',
      'Explore and execute GraphQL queries on GitHub\'s public GraphQL API using Apollo Sandbox.',
    ],
    resources: [
      'GraphQL Official Documentation: https://graphql.org/learn/',
      'GraphQL Specification: https://spec.graphql.org/',
      'Apollo Sandbox Explorer: https://studio.apollographql.com/sandbox',
    ],
  ),
  RoadmapStepModel(
    id: 2,
    title: 'Executing Queries, Mutations & Aliases',
    description:
        'Master GraphQL client operation syntax: Queries, Arguments, Aliases, Fragments, and Mutations.',
    duration: '2 weeks',
    phase: 'Phase 1: GraphQL Core',
    level: 'Intermediate',
    learningObjectives:
        'Construct Queries with parameters, pass dynamic Variables, use Aliases to fetch duplicate fields, and write Fragments for reusability.',
    subtopics: [
      'Constructing GraphQL Queries: Selecting specific requested fields',
      'Passing Arguments to query fields (e.g. user(id: "123"))',
      'GraphQL Variables: Defining operational parameters (\$id: ID!) and variable JSON maps',
      'Field Aliases (firstUser: user(id: 1), secondUser: user(id: 2))',
      'GraphQL Fragments (fragment UserFields on User) for modular field selection',
      'Inline Fragments (... on AdminUser) & Type Conditions',
      'Directives: @include(if: Boolean) and @skip(if: Boolean) conditional field fetching',
      'Constructing Mutations: Creating, Updating, and Deleting server data',
      'Mutation Payload Response pattern (returning mutated object in response)',
      'Handling GraphQL Errors array response (errors: [{ message, locations, path }])',
    ],
    exercises: [
      'Write a GraphQL query using Fragments and Directives to conditionally fetch user profile details based on a boolean variable.',
      'Construct a CreateProduct mutation with dynamic input variables returning created product ID and title.',
    ],
    resources: [
      'GraphQL Queries and Mutations Guide: https://graphql.org/learn/queries/',
      'Apollo GraphQL Client Queries: https://www.apollographql.com/docs/react/data/queries/',
    ],
  ),
  RoadmapStepModel(
    id: 3,
    title: 'Apollo Server & Resolvers Development',
    description:
        'Build a production GraphQL server using Apollo Server, Node.js, and write field Resolver functions.',
    duration: '2-3 weeks',
    phase: 'Phase 2: Server Development',
    level: 'Intermediate',
    learningObjectives:
        'Instantiate Apollo Server, write field Resolver functions (parent, args, context, info), and connect data sources.',
    subtopics: [
      'Apollo Server architecture & Node.js integration (@apollo/server)',
      'Type Definitions (typeDefs with gqltag) & Resolver Maps',
      'The 4 Resolver Arguments: parent (root), args, context, info',
      'Query Resolvers: Fetching data from databases or external APIs',
      'Mutation Resolvers: Processing updates and returning updated state',
      'Field-level Resolvers for dynamic relationship resolution (Post.author, User.posts)',
      'GraphQL Context object (contextValue): Request scoped state (Auth tokens, Database instances)',
      'Apollo Server Standalone Server vs Express middleware integration (expressMiddleware)',
      'Handling Error states with GraphQLError (e.g. BAD_USER_INPUT, UNAUTHENTICATED)',
      'Formatting error responses with formatError hook',
    ],
    exercises: [
      'Build an Apollo Server web service with Node.js and Express exposing User and Post query/mutation resolvers.',
      'Implement field-level resolvers to resolve relational database joins between Author and Books.',
    ],
    resources: [
      'Apollo Server Official Docs: https://www.apollographql.com/docs/apollo-server/',
      'Apollo Server Express Integration: https://www.apollographql.com/docs/apollo-server/api/express-middleware',
    ],
  ),
  RoadmapStepModel(
    id: 4,
    title: 'Solving N+1 Problem with DataLoader',
    description:
        'Optimize GraphQL server database queries and eliminate the N+1 query problem using DataLoader batching and caching.',
    duration: '2 weeks',
    phase: 'Phase 2: Server Development',
    level: 'Intermediate to Advanced',
    learningObjectives:
        'Understand how nested field resolvers cause N+1 database queries, implement DataLoader batching, and cache request-level keys.',
    subtopics: [
      'Understanding the N+1 Query Problem in GraphQL nested field resolvers',
      'Analyzing database log queries during deeply nested field selections',
      'DataLoader concept: Batching and Caching per-request data loading',
      'How DataLoader Batching works: Event loop tick deferral and combined key arrays',
      'Creating DataLoader instances in request Context (preventing cross-request cache leaks)',
      'Batch loading functions: Accepting array of keys and returning array of values in matching order',
      'DataLoader Caching: In-memory request caching and cache keys',
      'Clearing and prime DataLoader caches on mutation updates',
      'Using DataLoader with SQL databases (Knex, Prisma, TypeORM) & MongoDB',
      'Benchmarking SQL query count before and after DataLoader implementation',
    ],
    exercises: [
      'Demonstrate N+1 database query generation on a Posts -> Author relationship and resolve it completely using DataLoader batching.',
      'Build a batch user loader function that accepts an array of User IDs and executes a single SQL `SELECT * FROM users WHERE id IN (...)` query.',
    ],
    resources: [
      'DataLoader Official Repository: https://github.com/graphql/dataloader',
      'Solving N+1 in GraphQL Guide: https://www.apollographql.com/blog/backend/simplifying-data-fetching-its-time-to-use-dataloader/',
    ],
  ),
  RoadmapStepModel(
    id: 5,
    title: 'GraphQL Real-Time Subscriptions (WebSockets)',
    description:
        'Implement real-time GraphQL Subscriptions over WebSocket connections using graphql-ws and PubSub.',
    duration: '2 weeks',
    phase: 'Phase 3: Advanced Server',
    level: 'Advanced',
    learningObjectives:
        'Configure WebSocket subscription server (graphql-ws), trigger PubSub event emissions, and subscribe from client apps.',
    subtopics: [
      'GraphQL Subscriptions concept: Persistent WebSockets vs Request-Response HTTP',
      'When to use Subscriptions vs Polling vs Webhooks',
      'Subscription Server setup with graphql-ws & ws WebSocket library',
      'Using PubSub for event publishing (pubsub.publish) & listening (pubsub.asyncIterator)',
      'Filtering Subscriptions using withFilter helper (e.g. notify specific user IDs only)',
      'Subscription resolvers: subscribe vs resolve function configuration',
      'Production PubSub engines: Redis PubSub (graphql-redis-subscriptions) for multi-node clusters',
      'Authentication over WebSockets: ConnectionParams during connection_init',
      'Handling WebSocket connection dropouts & automatic client reconnection',
      'Testing Subscriptions in Apollo Studio / Postman',
    ],
    exercises: [
      'Build a real-time live chat room application using GraphQL Subscriptions with message creation triggers.',
      'Configure Redis PubSub backend for scaling GraphQL subscriptions across multiple server instances.',
    ],
    resources: [
      'Apollo Server Subscriptions Guide: https://www.apollographql.com/docs/apollo-server/data/subscriptions/',
      'graphql-ws Protocol Repository: https://github.com/enisdenjo/graphql-ws',
    ],
  ),
  RoadmapStepModel(
    id: 6,
    title: 'Apollo Client Integration in Frontend Apps',
    description:
        'Connect React/Vue/Mobile frontend applications to GraphQL APIs using Apollo Client, useQuery, useMutation, and InMemoryCache.',
    duration: '2-3 weeks',
    phase: 'Phase 3: Advanced Server',
    level: 'Intermediate to Advanced',
    learningObjectives:
        'Instantiate ApolloClient, execute queries/mutations with hooks (useQuery, useMutation), and update InMemoryCache.',
    subtopics: [
      'Apollo Client architecture: HttpLink, InMemoryCache, & ApolloProvider',
      'Executing Queries with useQuery hook: loading, error, data, refetch, networkStatus',
      'Query Policies: fetchPolicy (cache-first, network-only, cache-and-network, no-cache)',
      'Executing Mutations with useMutation hook',
      'Updating Apollo InMemoryCache after Mutations: update function & cache.modify() / cache.writeQuery()',
      'Optimistic Response UI updates before server confirmation',
      'Pagination in Apollo Client: Offset-based vs Cursor-based pagination (fetchMore & fieldPolicies merge)',
      'Code Generation (GraphQL Code Generator / @graphql-codegen) for TypeScript types and custom hooks',
      'Handling Global GraphQL & Network errors with Apollo Link Error',
      'Persisted Queries (Automatic Persisted Queries - APQ) for bandwidth optimization',
    ],
    exercises: [
      'Build a React app using Apollo Client that queries a list of items and performs Optimistic UI updates on item creation.',
      'Configure GraphQL Code Generator to automatically generate typed React hooks from GraphQL .graphql files.',
    ],
    resources: [
      'Apollo Client React Documentation: https://www.apollographql.com/docs/react/',
      'GraphQL Code Generator: https://the-guild.dev/graphql/codegen',
    ],
  ),
  RoadmapStepModel(
    id: 7,
    title: 'GraphQL Security, Auth & Rate Limiting',
    description:
        'Secure GraphQL APIs against Denial of Service (DoS) attacks, query depth abuses, and enforce authentication/authorization.',
    duration: '2 weeks',
    phase: 'Phase 4: Security & Microservices',
    level: 'Advanced',
    learningObjectives:
        'Enforce JWT authentication in Context, implement field-level Directive authorization, and prevent DoS with Query Depth Limiting & Cost Analysis.',
    subtopics: [
      'GraphQL Security Vulnerabilities: Deeply nested recursive queries, expensive field computations, introspection leaks',
      'Authentication in GraphQL: Extracting JWT Bearer tokens in Context creation',
      'Role-Based Access Control (RBAC) in Resolvers vs Schema Directives (@auth, @hasRole)',
      'Field-level Authorization (restricting access to specific sensitive fields e.g. salary, ssn)',
      'Query Depth Limiting (graphql-depth-limit) to block circular deeply nested queries',
      'Query Complexity / Cost Analysis (graphql-query-complexity) calculating point score per query',
      'Disabling Introspection queries in production environments',
      'Automatic Persisted Queries (APQ) & Safelisting / Whitelisting query hashes',
      'Rate Limiting GraphQL operations per IP address or API key',
      'CORS configuration & sanitizing input parameters against injection',
    ],
    exercises: [
      'Configure query depth limiting in Apollo Server to reject queries nested deeper than 5 levels.',
      'Implement an @auth schema directive in Apollo Server restricting field access based on user role.',
    ],
    resources: [
      'OWASP GraphQL Cheat Sheet: https://cheatsheetseries.owasp.org/cheatsheets/GraphQL_Cheat_Sheet.html',
      'Apollo Server Security Docs: https://www.apollographql.com/docs/apollo-server/security/security/',
    ],
  ),
  RoadmapStepModel(
    id: 8,
    title: 'Schema Federation & Microservices (Apollo Federation)',
    description:
        'Combine multiple sub-graph microservices into a unified supergraph API using Apollo Federation 2.',
    duration: '3 weeks',
    phase: 'Phase 4: Security & Microservices',
    level: 'Advanced',
    learningObjectives:
        'Build Subgraphs with @key entity directives, route queries with Rover CLI & Apollo Router, and share types across microservices.',
    subtopics: [
      'Monolithic Schema vs Federated Supergraph Microservices architecture',
      'Apollo Federation 2 Architecture: Subgraphs, Router / Gateway, & Schema Registry',
      'Defining Federated Entities with @key(fields: "id") directive',
      'Extending types across subgraphs: Entity representation & reference resolvers (__resolveReference)',
      'Sharing fields with @shareable directive & overriding with @override',
      'Executing federated query composition using Rover CLI (rover supergraph compose)',
      'High-performance Rust-based Apollo Router execution',
      'Federated Schema Migration strategies & contract schemas',
      'Distributed Tracing across subgraphs using OpenTelemetry & Apollo Studio',
      'Error propagation and fallback strategies in federated subgraphs',
    ],
    exercises: [
      'Create two federated Apollo Subgraphs (Users Subgraph & Orders Subgraph) and compose them into a unified Supergraph using Apollo Router.',
      'Extend a User entity in the Orders Subgraph to add an orders field resolved via entity reference resolvers.',
    ],
    resources: [
      'Apollo Federation 2 Documentation: https://www.apollographql.com/docs/federation/',
      'Rover CLI Tool Docs: https://www.apollographql.com/docs/rover/',
    ],
  ),
  RoadmapStepModel(
    id: 9,
    title: 'GraphQL Schema Design Patterns & Best Practices',
    description:
        'Master GraphQL Schema design patterns: Cursor-based Pagination (Relay Connections), Node Interface, and Custom Scalars.',
    duration: '2 weeks',
    phase: 'Phase 5: Production & Best Practices',
    level: 'Advanced',
    learningObjectives:
        'Implement Relay Cursor Connections Specification (edges, node, pageInfo), custom Date/JSON Scalars, and polymorphic interfaces.',
    subtopics: [
      'GraphQL Schema Design Best Practices: Naming conventions, nullability design',
      'Cursor-based Pagination Specification (Relay Connections Specification)',
      'Understanding Connection fields: edges, node, pageInfo (hasNextPage, endCursor)',
      'Relay Global Object Identification: Node Interface (interface Node { id: ID! })',
      'Polymorphism in GraphQL: Union Types (union SearchResult = User | Post) & Interfaces',
      'Creating Custom Scalars (GraphQLDate, GraphQLJSON, EmailAddress) with graphql-scalars',
      'Designing Mutation Payloads: UserCreatePayload { user, errors } instead of returning bare objects',
      'Deprecating Fields with @deprecated(reason: "...") directive',
      'Versioning GraphQL Schemas without breaking changes',
      'Schema documentation & markdown descriptions (""" comments """) in SDL',
    ],
    exercises: [
      'Implement Relay-style Cursor-based pagination on a list query returning pageInfo (startCursor, endCursor, hasNextPage).',
      'Design a custom EmailScalar that validates email string formats before resolver execution.',
    ],
    resources: [
      'GraphQL Cursor Connections Specification: https://relay.dev/graphql/connections.htm',
      'GraphQL Custom Scalars Guide: https://www.apollographql.com/docs/apollo-server/schema/custom-scalars/',
    ],
  ),
  RoadmapStepModel(
    id: 10,
    title: 'GraphQL Performance Optimization & Production Deployment',
    description:
        'Optimize GraphQL server performance, HTTP caching, CDN integration, and deploy Apollo Server to production.',
    duration: '2 weeks',
    phase: 'Phase 5: Production & Best Practices',
    level: 'Advanced',
    learningObjectives:
        'Implement Response Caching with @cacheControl directives, set up CDN caching with APQ, and deploy Apollo Server to cloud.',
    subtopics: [
      'GraphQL Caching Strategies: Client-side cache vs Gateway cache vs Field-level cache',
      'Response Caching with @cacheControl(maxAge: 60) directive',
      'CDNs and GraphQL Caching using Automatic Persisted Queries (APQ) GET requests',
      'HTTP Cache-Control header calculation by Apollo Server based on field maxAge',
      'Monitoring GraphQL Metrics: Request duration, field execution time, error rates',
      'Apollo Studio Schema Checks & Schema Change CI/CD linting with Rover',
      'Containerizing Apollo Server / Router with Docker',
      'Deploying GraphQL Gateway to AWS ECS, Kubernetes, or Serverless (AWS Lambda / Vercel)',
      'Graceful Shutdown & Health Checks (/health endpoint)',
      'Production Checklist for GraphQL APIs',
    ],
    exercises: [
      'Configure Automatic Persisted Queries (APQ) and setup NGINX / Cloudflare CDN caching for GET query requests.',
      'Set up Rover CI/CD schema validation in GitHub Actions preventing breaking schema changes.',
    ],
    resources: [
      'Apollo Server Performance & Caching: https://www.apollographql.com/docs/apollo-server/performance/caching/',
      'Apollo Studio Schema Registry & Checks: https://www.apollographql.com/docs/studio/schema-checks/',
    ],
  ),
];
