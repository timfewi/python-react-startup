---
applyTo: "**/*.tsx,**/*.jsx"
description: "Mandatory React Development Rules"
---

Functional Components Are the Standard: Use functional components exclusively. Class components are legacy technology. Functional components with hooks are more performant, easier to test, and align with modern React patterns.

Hooks Above JSX: Declare all hooks at the top of your component function, before any conditional logic or early returns. This ensures hooks are called in the same order on every render, maintaining React's internal state consistency.

Extract Custom Hooks for Logic: Complex state logic, side effects, or data fetching should be extracted into custom hooks. A component should primarily focus on rendering, not business logic. Custom hooks make logic reusable and testable in isolation.

Use TypeScript Props Interfaces: Every component must define its props using a TypeScript interface. Name it `ComponentNameProps` and export it. This provides clear contracts and enables better developer tooling.

Destructure Props Immediately: Destructure props in the function parameter to make dependencies explicit and improve readability. Use default values in destructuring rather than inside the component body.

No Inline Functions in JSX: Avoid creating functions inside render methods or JSX attributes. Either define functions outside the component (if pure) or use useCallback for functions that depend on component state or props.

useCallback and useMemo Strategically: Only use useCallback and useMemo when you have a performance problem or are passing functions/objects to optimized child components. Premature optimization creates unnecessary complexity.

Prefer Controlled Components: For form inputs, always use controlled components where React state is the single source of truth. Uncontrolled components with refs should be rare exceptions for specific performance or integration needs.

Handle Loading and Error States: Every component that fetches data must explicitly handle loading, error, and success states. Use discriminated unions for data fetching state to make impossible states unrepresentable.

Use Fragments to Avoid Wrapper Divs: When returning multiple elements, use React.Fragment or the shorthand `<>` syntax instead of unnecessary wrapper divs that pollute the DOM structure.

Key Props for Dynamic Lists: Every element in a dynamically rendered list must have a unique, stable key prop. Never use array indices as keys unless the list is truly static and will never reorder.

Lift State Up When Shared: When multiple components need the same state, lift it up to their closest common ancestor. Don't duplicate state across components or rely on prop drilling beyond 2-3 levels.

Use Context Sparingly: Context is for truly global state (theme, authentication, user preferences). Don't use Context to avoid prop drilling for component-specific data. Consider state management libraries for complex scenarios.

Separate Concerns with Custom Hooks: Business logic, API calls, and side effects belong in custom hooks, not in components. Components should be thin layers that primarily handle rendering and user interactions.

Handle Cleanup in useEffect: Every useEffect that sets up subscriptions, timers, or event listeners must return a cleanup function. Forgetting cleanup leads to memory leaks and unexpected behavior.

Minimize useEffect Dependencies: Keep useEffect dependency arrays minimal and stable. Extract primitive values from objects and use useCallback/useMemo to stabilize references when necessary.

Prefer Early Returns: Use early returns for conditional rendering instead of nested ternary operators or complex JSX expressions. This improves readability and reduces cognitive load.

Components Should Be Pure: Given the same props, a component should always render the same output. Avoid side effects in render methods and minimize dependencies on external mutable state.

Use Error Boundaries: Wrap your component trees with Error Boundaries to gracefully handle runtime errors. Every feature area should have its own Error Boundary to prevent cascading failures.

Test Component Behavior: Test components by testing their behavior from a user's perspective, not their internal implementation. Use React Testing Library and focus on what users see and interact with, not internal state.
