# Kappa

This language is inspired from $\kappa$-calculus

**Kappa ($\kappa$)** is an experimental programming language designed to explore a functional paradigm completely free of runtime closures. While traditional functional languages rely on the $\lambda$-calculus, Kappa shifts the foundational mathematics to **Contextually Complete Categories**, turning functions into pure structural data pipelines.

---

## Why Kappa? (vs. Traditional Lambda Calculus)

In standard functional programming ($\lambda$-calculus), functions are *first-class values*. They can be passed around, returned, and dynamically generated. While incredibly flexible, this forces the runtime engine to manage **closures**, allocating memory on the heap to couple code with its execution environment.

Kappa takes a fundamentally different path by treating functions as first-order structural rules rather than data values. Because functions cannot be passed around as dynamic objects, the language achieves entirely closure-free execution with zero environment tracking.

Furthermore, by eliminating variables during the compilation step, Kappa code naturally desugars into point-free categorical combinators like composition and products. Instead of a traditional sequential instruction stack, the program operates like a hardware dataflow graph, rendering it uniquely optimized for direct silicon compilation (such as FPGAs or ASICs) and massively parallel processing while ensuring entirely deterministic, compile-time verifiable memory footprints.

---

## From Pseudo-Code to Categorical Math

To see how Kappa works in practice, we can trace how a simple multi-argument mathematical pipeline written in high-level pseudo-code is desugared by the compiler into pure, variable-free categorical math.

### 1. High-Level Pseudo-Code

In the frontend of the language, developers write clean, human-readable code utilizing standard variables:

```
process := <fst ; <snd, fst ; snd> ; mult, snd> ; add
```

### 2. The Type Geometry

Because $\kappa$-calculus completely lacks higher-order functions and Currying, multi-argument functions cannot be written as $A\to B\to C\to D$. Instead, all inputs are packed into a single, structured tuple tree.

By convention, arguments are bundled into a right-imbalanced binary tree structure starting from the terminal unit object ($1$). The true type signature of our `process` function is:

$$\text{process} : ((1 \times\text{Int})\times\text{Int})\times\text{Int}\to \text{Int}$$

### 3. Categorical Pipeline Mapping

Kappa code maps 1:1 to a directed acyclic dataflow graph. Let's deconstruct exactly how the process combinator chain routes a nested incoming tuple tree (((1, x), y), z) without using variable names:

1. **Splitting the Main Context**: The outer fanout < ... , snd> splits the incoming data into two tracks:

    - The **Right Track** (`snd`) extracts the rightmost element ($z$).
    - The **Left Track** (`fst ; <...> ; mult`) drills into the left pair. `((1, x), y)` to compute the product.

2. **Isolating the Factors**: Inside the left track, `<snd, fst ; snd>` splits the sub-pair:
    
    - `snd` extracts $y$.
    - `fst ; snd` steps left into `(1, x)` and extracts $x$.

3. **Execution & Assembly**: The extracted $y$ and $x$ are paired, run through `mult`, and the result is paired with the waiting $z$ from the right track. Finally, `; add` collapses the whole structure down into a single integer output.

### 4. Tracing Execution via term-rewriting

If we pass the numbers $3$, $4$, and $5$ into our function, the input structure is $\langle \langle \langle !, 3 \rangle, 4 \rangle, 5 \rangle$. We evaluate the compiled math term by applying the input to the right side of our composition chain:

$$\left(\text{add} \cdot \langle \text{mult} \cdot \langle \pi_2 \cdot \pi_1, \, \pi_2 \rangle \cdot \pi_1, \,\, \pi_2 \rangle\right) \cdot \langle \langle \langle !, 3 \rangle, 4 \rangle, 5 \rangle$$

By executing $\kappa$-reduction rules, the tuple structure seamlessly distributes across the pairing operators:

- **Right Track Evaluation**: $\pi_2 \cdot \langle \langle \langle !, 3 \rangle, 4 \rangle, 5 \rangle \implies 5$
- **Left Track Evaluation**: $\pi_1 \cdot \langle \langle \langle !, 3 \rangle, 4 \rangle, 5 \rangle \implies \langle \langle !, 3 \rangle, 4 \rangle$
- **Multiplication Branch**: $\langle \pi_2 \cdot \pi_1, \, \pi_2 \rangle \cdot \langle \langle !, 3 \rangle, 4 \rangle \implies \langle 3, 4 \rangle \xrightarrow{\text{mult}} 12$
- **Final Assembly**: $\text{add} \cdot \langle 12, 5 \rangle \implies 17$

The computation resolves purely by routing data tokens through structural hardware tracks. No variables were looked up in a heap, no environments were dynamically allocated, and no closures were created.
