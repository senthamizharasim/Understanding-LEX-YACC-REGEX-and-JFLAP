## 📌 Project Overview
This repository contains solutions, transition definitions, regular expressions, and syntactic grammars. The implementation is structured into four core modules targeting finite automata, regular expressions, lexical analysis, and syntax parsing.

---

## 🛠️ Module 1: JFLAP — Automata & Formal Languages

### 1. Problem Statements
* **Part 1 (DFA):** Accepts strings over \(\Sigma = \{a, b\}\) containing an **odd number of a's AND ending with the substring "ab"**.
  \[L = \{ w \in \{a, b\}^* \mid w \text{ has an odd number of a's and } w \text{ ends in "ab"} \}\]
* **Part 2 (DPDA):** Accepts deterministic palindromes built around a single center marker c.
  \[L = \{ w c w^R \mid w \in \{a, b\}^* \}\]

### 2. Transition System Specifications
#### DFA States & Routing
* **States:** q₀ (Start), q₁, q₂ (Accept), q₃, q₄, q₅

| State | Input `a` | Input `b` |
|:---|:---|:---|
| **q₀ (Start)** | q₁ | q₀ |
| **q₁** | q₄ | q₂ |
| **q₂ (Accept)**| q₄ | q₃ |
| **q₃** | q₄ | q₃ |
| **q₄** | q₁ | q₅ |
| **q₅** | q₁ | q₀ |

#### DPDA Condensed Rules
* **States:** q₀ (Start), q₁, q₂ (Accept)
* **Stack Alphabet:** \(\{a, b, Z\}\) (where Z is the initial bottom marker)

| Current State | Input, Pop → Push Action | Next State |
|:---|:---|:---|
| q₀ | \(x \in \{a,b\}\), (any top) → push x | q₀ |
| q₀ | c, (any top) → unchanged (Z → Z, a → a, b → b) | q₁ |
| q₁ | \(x \in \{a,b\}\), x → λ (pop matched item) | q₁ |
| q₁ | λ (no input), Z → Z (stack cleared to bottom marker) | q₂ (Accept) |

### 3. Execution & Workflow inside WSL
1. Ensure OpenJDK is configured in your Ubuntu WSL instance.
2. Launch JFLAP with dynamic graphical server backends:
   ```bash
   java -jar JFLAP.jar
   ```

---
<img width="813" height="475" alt="image" src="https://github.com/user-attachments/assets/e47389de-8bd9-478a-89bc-bbf9f60c0038" />
<img width="813" height="263" alt="image" src="https://github.com/user-attachments/assets/98e276ae-63eb-45d4-b17f-356966ae359a" />
<img width="813" height="505" alt="image" src="https://github.com/user-attachments/assets/2aaea889-592d-4027-b75b-557984bc3e18" />
<img width="813" height="281" alt="image" src="https://github.com/user-attachments/assets/f705c20d-3832-4737-8243-d851a9388b55" />


## 🐍 Module 2: REGEX — Pattern Matching (Python)

### 1. Problem Descriptions
* **Program 1 (Tokenizer):** Validates strings into `FLOAT`, `INTEGER`, or `IDENTIFIER` tokens. Anything else resolves to `INVALID`.
* **Program 2 (Extractor):** Extracts strict `YYYY-MM-DD` dates and institutional academic emails (`.edu`, `.ac.in`) out of unformatted system logs.

### 2. Implementation Logic
* **`regex_prog1.py`**: Prioritizes validation checks cleanly across three structural regex rules:
  ```python
  FLOAT:      "^[+-]?\d+\.\d+$"
  INTEGER:    "^[+-]?\d+$"
  IDENTIFIER: "^[a-zA-Z_][a-zA-Z0-9_]*$"
  ```
* **`regex_prog2.py`**: Scans free-form bodies using explicit boundary checks (`\b`) to eliminate structural noise like middle-placed strings, bad year offsets, or invalid characters.

### 3. Execution
```bash
python3 regex_prog1.py
python3 regex_prog2.py
```

---
<img width="719" height="219" alt="image" src="https://github.com/user-attachments/assets/0fad22cb-61f6-4e74-b5f9-2a20bbeb303d" />
<img width="719" height="80" alt="image" src="https://github.com/user-attachments/assets/36d16538-7c12-4015-ad1c-e7b8d3d4567b" />


## 🏎️ Module 3: LEX — Lexical Analyzer (Flex)

### 1. Problem Descriptions
* **Program 1 (Counter):** Counts lines, words, and total characters while systematically detecting and clearing single-line (`//`) and block (`/* ... */`) comments.
* **Program 2 (Token Recognizer):** Classes code chunks as keywords (`if`, `else`, `while`, `int`, etc.), identifiers, operators, or numbers.

### 2. Compilation & Run Steps
```bash
# Program 1: Metrics & Comment Stripper
flex prog1.l
gcc lex.yy.c -o prog1_lex
./prog1_lex

# Program 2: C Token Classifier
flex prog2.l
gcc lex.yy.c -o prog2_lex
./prog2_lex
```
*Terminate continuous interactive stdin streams anytime with `Ctrl + D`.*

---
<img width="719" height="200" alt="image" src="https://github.com/user-attachments/assets/1be680d3-d7d7-4244-8142-d6eda6fb8831" />
<img width="563" height="661" alt="image" src="https://github.com/user-attachments/assets/09f45cb8-feb5-4ba1-973c-62487b8e18a8" />


## 📐 Module 4: YACC — Parser Generator (Bison)

### 1. Problem Descriptions
* **Program 1 (Calculator):** Validates and evaluates arithmetic statements with operators (`+`, `-`, `*`, `/`), parentheses, and unary conditions, incorporating explicit exception catch mechanics for division-by-zero errors.
* **Program 2 (Declaration Syntax Validator):** Enforces a clean multi-variable C-style sequence syntax tracker (e.g., checks declarations like `int a, b = 10;`).

### 2. Workspace Cleanup
Before switching parser binaries or regenerating source outputs inside the same tracking workspace directory, strip out stale transient files:
```bash
rm -f calc.tab.c calc.tab.h lex.yy.c calc_parser decl_parser
```

### 3. Compilation & Run Steps
```bash
# Build & run Arithmetic Expression Evaluator
bison -d calc.y
flex calc.l
gcc calc.tab.c lex.yy.c -o calc_parser
./calc_parser

# Build & run Variable Declaration Validator
bison -d decl.y
flex decl.l
gcc decl.tab.c lex.yy.c -o decl_parser
./decl_parser
```

<img width="719" height="184" alt="image" src="https://github.com/user-attachments/assets/958c1702-d3a1-467f-848e-064528b12564" />
<img width="719" height="191" alt="image" src="https://github.com/user-attachments/assets/7a0b9b6d-ca7c-46fe-b8f5-a01fd7672717" />

