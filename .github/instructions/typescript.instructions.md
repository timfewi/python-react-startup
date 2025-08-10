---
applyTo: "**/*.ts"
description: "Mandatory Typescript Development Rules"
---


Strict Mode is Non-Negotiable: Every tsconfig.json must have "strict": true enabled. This is the absolute baseline. Writing TypeScript without strict mode is like navigating without a map—pointless and dangerous.

Embrace unknown, Banish any: any is a surrender to type-safety. For a value of an unknown type, use unknown and perform explicit type-checking. This forces you to handle data safely, not just silence the compiler.

Types for Unions, Interfaces for Objects: Use type aliases for unions, intersections, or primitive aliases. Use interface to define the shape of objects and classes. Prefer interfaces for public-facing contracts to allow for declaration merging by consumers.

Let the Compiler Infer: Do not clutter your code with redundant type annotations. If a variable's type can be inferred from its value, let it be. Explicitly type function parameters and return values to define clear contracts.

Master Utility Types: Do not repeat yourself at the type level. Use built-in utility types like Partial, Pick, Omit, and Readonly to derive new types from existing ones. This is fundamental to creating maintainable and scalable type systems.

Model State with Discriminated Unions: For any entity that can exist in multiple states (e.g., loading | success | error), you must use a discriminated union. This enables exhaustive switch checks, making impossible states unrepresentable in your code.

Use as const for True Constants: For truly immutable, literal values, use as const. This provides the compiler with the most specific type possible, turning objects into read-only dictionaries of literals and arrays into readonly tuples.

ES Modules Are the Only Way: All code must be organized using ES Modules (import/export). The era of namespaces is over. This ensures a clear dependency graph and aligns with the entire modern JavaScript ecosystem.

Never Assert Non-Null with !: The non-null assertion operator (!) is a code smell that signals a flaw in your type logic. It's a manual override for the compiler's safety checks. If a value can be null or undefined, handle it explicitly with code, not with a compiler directive.

Favor readonly for Immutability: Prevent accidental side effects by defaulting to immutability. Use the readonly modifier for properties and ReadonlyArray<T> for arrays that should not be mutated.

Lint and Format Relentlessly: Enforce a single, consistent style with ESLint and Prettier. Configure them to catch potential errors and style issues before they ever become part of the codebase. A clean repository is a requirement, not a goal.

Generate Types from Schemas: When consuming an API (like GraphQL or OpenAPI), generate your types directly from the schema. Writing these types by hand is a waste of time and a guarantee they will eventually fall out of sync. Automate it.

Prefer Named Exports: Default exports are ambiguous and lead to inconsistent naming across the codebase. Always use named exports to ensure clarity and improve developer tooling and refactoring capabilities.

Guard Types with Predicates: For complex validation, create user-defined type guard functions that return a type predicate. This encapsulates validation logic and provides strong type inference within conditional blocks.

Structure Files by Feature: Organize your codebase by feature, not by function. Keep related components, types, services, and tests together in the same directory to improve locality and make the code easier to navigate and maintain.

Validate with satisfies: Use the satisfies operator to check that an expression conforms to a type without changing its inferred type. This is superior to type casting for ensuring an object meets a contract while preserving its specific literal type.

Brand Primitives for Domain Safety: For primitive types that have specific domain meaning (like UserId or Email), use branded or opaque types. This prevents illogical operations, such as adding two user IDs together, at the type level.

Handle All Promise States: Every Promise must have its rejection path handled. When working with async/await, this means using try/catch blocks. Unhandled promise rejections are silent bugs waiting to crash your application.
