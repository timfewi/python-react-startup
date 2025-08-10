---
applyTo: "**/*.tsx,**/*.jsx"
description: "Mandatory React Hooks Development Rules"
---

useState for Simple State: Use useState for primitive values and simple objects. Always prefer multiple useState calls over a single complex state object to enable granular updates and better performance.

useEffect with Proper Dependencies: Every useEffect must have a complete and accurate dependency array. Missing dependencies cause stale closures; unnecessary dependencies cause excessive re-renders. Use ESLint exhaustive-deps rule to enforce this.

Custom Hooks for Reusable Logic: Extract any stateful logic that could be reused into custom hooks. Custom hooks must start with 'use' and can call other hooks. This promotes reusability and separation of concerns.

useCallback for Stable Function References: Only use useCallback when passing functions to optimized child components or when the function is a dependency in other hooks. Don't useCallback every function—it's often unnecessary overhead.

useMemo for Expensive Calculations: Use useMemo only for computationally expensive operations or when creating objects/arrays that are dependencies for other hooks. Avoid premature optimization with useMemo for simple calculations.

useRef for Persistent Values: Use useRef for values that persist across renders but don't trigger re-renders when changed. Common uses: DOM element references, timers, previous values, and mutable instance variables.

useContext with Provider Pattern: When using useContext, always pair it with a custom hook that provides the context value and throws an error if used outside the provider. This ensures type safety and better error messages.

useReducer for Complex State Logic: When state updates depend on previous state or involve multiple sub-values, prefer useReducer over useState. Use discriminated unions for action types to ensure type safety.

useLayoutEffect for DOM Measurements: Use useLayoutEffect only when you need to measure DOM elements or perform synchronous mutations before the browser paints. For most side effects, useEffect is the correct choice.

Cleanup Functions Are Mandatory: Every useEffect that sets up subscriptions, timers, event listeners, or async operations must return a cleanup function. This prevents memory leaks and race conditions.

Handle Async Operations Safely: Never use async functions directly in useEffect. Instead, declare async functions inside useEffect or use immediately invoked function expressions (IIFE).

Avoid Hooks in Loops or Conditions: Hooks must always be called in the same order on every render. Never call hooks inside loops, conditions, or nested functions. This is fundamental to React's hook system.

Stable References with useCallback: When creating functions that are dependencies for other hooks or props for memoized components, wrap them in useCallback with proper dependencies to maintain referential stability.

useImperativeHandle Sparingly: Only use useImperativeHandle when you need to expose imperative APIs from functional components. This should be rare and typically only for library components or specific integration needs.

Extract Business Logic to Custom Hooks: Components should primarily handle rendering. Move data fetching, form validation, state management, and business logic into custom hooks for better testability and reusability.

Dependency Array Optimization: Use primitive values and stable references in dependency arrays. Extract primitive values from objects and use useCallback/useMemo to stabilize object/function references when necessary.

State Initialization with Functions: For expensive initial state calculations, pass a function to useState instead of the value directly. This ensures the calculation only runs once during component initialization.

Multiple useState vs useReducer: Use multiple useState calls for independent state variables. Use useReducer when state variables are related and updates are complex or interdependent.

Custom Hook Testing: Test custom hooks in isolation using React Testing Library's renderHook utility. This ensures hook logic is correct independent of any specific component implementation.

Hook Return Conventions: Custom hooks should return objects for multiple values (enabling destructuring with custom names) or tuples for closely related pairs (like [value, setValue]).

Avoid State Synchronization: Don't use useEffect to synchronize state between components. Instead, lift state up to a common ancestor or use a state management solution for complex scenarios.

useDebugValue for Custom Hooks: Add useDebugValue to custom hooks to provide meaningful labels in React DevTools. This improves debugging experience during development.

Conditional Hook Execution: When you need conditional behavior, put the condition inside the hook implementation, not around the hook call. The hook must always be called, but its internal logic can be conditional.

State Batching Awareness: React automatically batches multiple setState calls in event handlers. In async operations or timeouts, use ReactDOM.unstable_batchedUpdates if you need to batch updates manually.

Hook Composition Patterns: Compose complex behavior by combining multiple simple custom hooks rather than creating monolithic hooks. This promotes reusability and easier testing.
