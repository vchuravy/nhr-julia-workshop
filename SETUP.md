# Setup instructions

*(This text doubles as the setup e-mail sent to registered participants.)*

Please do these steps **before** the workshop. They download about 1–2 GB, which is
much faster at home than over the shared eduroam connection in the room. It takes
about 15 minutes, most of it waiting.

## 1. Install Julia

We use **Julia 1.13**. Install it with the official installer, `juliaup`:

- **Windows:** open a terminal and run
  ```
  winget install --name Julia --id 9NJNWW8PVKMN -e -s msstore
  ```
  (or install “Julia” from the Microsoft Store).
- **macOS / Linux:** open a terminal and run
  ```
  curl -fsSL https://install.julialang.org | sh
  ```

Afterwards open a **new** terminal and type `julia`. You should see the Julia banner and a
`julia>` prompt showing version 1.13.

## 2. Install Pluto

At the `julia>` prompt, type `]` to switch to the package manager (the prompt turns blue
and reads `(@v1.13) pkg>`), then run

```
add Pluto PlutoUI PlutoTeachingTools BenchmarkTools
```

Press Backspace to return to the `julia>` prompt.

## 3. Check that it works

```julia
import Pluto
Pluto.run()
```

A browser tab with the Pluto start page should open. Paste this URL into the
“Open a notebook” box:

```
https://github.com/vchuravy/nhr-julia-workshop/blob/main/lectures/01_getting_started.jl
```

and click **Open**. The notebook should run without errors (the first time takes a
minute or two while packages are installed). Then you are all set.

## Trouble?

- The workshop page with all notebooks: https://vchuravy.dev/nhr-julia-workshop/
- If you cannot install Julia on your laptop (e.g. a managed machine), you can run the
  notebooks in your browser with GitHub Codespaces (free GitHub account needed). See the
  README of https://github.com/vchuravy/nhr-julia-workshop.
- Otherwise just come a few minutes early and we will sort it out together.
