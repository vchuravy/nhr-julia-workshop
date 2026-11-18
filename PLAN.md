# Workshop plan — Introduction to Julia (NHR Süd-West, 8 Dec 2026)

## Constraints (from the [event page](https://hpc.uni-saarland.de/workshops/intro-to-julia-26))

- **4 hours**, 13:00–17:00, in person (Saarland University, E1 1, room 407), English.
- Audience: researchers and students who write simulation / data-analysis / numerical code.
  **Basic programming experience in any language; no Julia knowledge required.**
- Participants bring **their own laptop** (eduroam). No cluster accounts. Setup instructions are e-mailed beforehand.
- Advertised topics, which the five lecture notebooks map onto one-to-one:
  1. Getting started: installing Julia, the REPL, packages and environments
  2. Language fundamentals: types, functions, arrays, control flow
  3. Multiple dispatch: Julia's core paradigm and composable, reusable code
  4. Writing fast code: type stability, benchmarking, profiling
  5. Towards HPC: a first look at multithreading, distributed computing, and GPUs

Consequences for the material:

- 4 h is short. That means about 2 h 15 min of presentation, 1 h 20 min of exercises, a 15 min break, and 10 min of wrap-up.
  Every lecture block is cut down from longer existing material; **cut rather than rush**.
- Laptops only: no GPUs can be assumed, so GPU content runs on the KernelAbstractions **CPU backend**
  (and on Metal for Mac users). MPI cannot run inside Pluto, so it is a **demo/show-only** section.
- Exercises must be self-checking (PlutoTeachingTools `correct()` / `keep_working()`),
  because a single instructor cannot help 20+ people one at a time.

## Schedule

| Time        | Min | Block | Notebook |
|-------------|----:|-------|----------|
| 13:00–13:20 | 20 | L1 Getting started | `lectures/01_getting_started.jl` |
| 13:20–13:45 | 25 | L2 Language fundamentals | `lectures/02_fundamentals.jl` |
| 13:45–14:05 | 20 | E2 exercise | `exercises/ex02_fundamentals.jl` |
| 14:05–14:25 | 20 | L3 Multiple dispatch | `lectures/03_multiple_dispatch.jl` |
| 14:25–14:40 | 15 | E3 exercise | `exercises/ex03_multiple_dispatch.jl` |
| 14:40–14:55 | 15 | Break (also: catch-up on setup problems) | |
| 14:55–15:30 | 35 | L4 Writing fast code | `lectures/04_fast_code.jl` |
| 15:30–15:55 | 25 | E4 exercise | `exercises/ex04_fast_code.jl` |
| 15:55–16:35 | 40 | L5 Towards HPC | `lectures/05_towards_hpc.jl` |
| 16:35–16:50 | 15 | E5 exercise | `exercises/ex05_parallel.jl` |
| 16:50–17:00 | 10 | Wrap-up, where to go next (end of L5) | |

Setup trouble is expected in the first block. L1 is short and demo-driven so stragglers can still follow
on the static page while they install.

## Source map — what to port into each notebook

Paths are relative to `~/src`. "rse" = `rse-course/src` (2026 edition, Julia 1.12, PlutoTeachingTools,
already self-checking exercises). Prefer rse material when there are several versions: it is the newest and
already follows the conventions in `rse-course/CLAUDE.md`.

### L1 Getting started (20 min)
| Section | Source |
|---|---|
| Why Julia? / two-language problem / Julia now | `deRSE25-workshop/introduction/intro.jl` (Why Julia, 2-language problem, Julia now); `vchuravy.github.io/talks/2026-09-11-lecture_illinois.jl` (What's Julia, Why Julia, high/low-level mixing). Take **3–4 slides max**. |
| Installing with juliaup, the REPL modes (`?`, `]`, `;`) | `deRSE25-workshop/introduction/intro.jl` "Getting started with Julia"; `vchuravy.github.io/talks/summer_of_rse.jl` "Getting started" |
| Packages and environments (Project/Manifest, `]activate`, `]add`) | rse `mod2_github_reproducibility/github_and_package_manager.jl` (Pkg.jl, Project.toml, Manifest.toml, Compatibility: just the Pkg half, **not** Git/GitHub); `deRSE25-workshop/introduction/intro.jl` "Package manager and reproducibility" / Yggdrasil (one slide: binaries included) |
| Working with Pluto | `MPE24/Introduction.jl` "Using Pluto" |

### L2 Language fundamentals (25 min)
| Section | Source |
|---|---|
| Variables, basic types, strings, Unicode | rse `mod1_introduction/julia_introduction.jl` (Basic Syntax, Arithmetic, Strings, Unicode identifiers) |
| Functions (short form, anonymous, kwargs) | rse `julia_introduction.jl` "Functions", "Positional and Keyword Arguments" |
| Control flow | rse `julia_introduction.jl` (loops/conditionals); add a small Newton-method example from `vchuravy.github.io/talks/summer_of_rse.jl` "The Newton method in 1D" |
| Arrays, broadcasting, comprehensions | rse `julia_introduction.jl` "Arrays and Linear Algebra", "broadcasting", "Higher-order function" |
| Structs | rse `mod1_introduction/types.jl` (struct vs mutable struct, keep it brief; parametric types move to L3) |

**E2** ← rse `exercises/exercise_1_functions_unicode.jl` (circle area, quadratic, *estimate π*) and
`exercise_3_broadcasting.jl` (parts 1–3). Drop the Unicode `linear_combo` part if short on time.

### L3 Multiple dispatch (20 min)
| Section | Source |
|---|---|
| Functions vs methods, `methods`, `@which` | rse `julia_introduction.jl` "Multiple Dispatch" |
| Type hierarchy, abstract types | rse `types.jl` "Julia's Type Hierarchy", "Connecting Types to Multiple Dispatch" |
| Rock–paper–scissors crash course | `vchuravy.github.io/talks/summer_of_rse.jl` / `A_random_walk_through_Julia_2023-10-12.jl` "Crash course on multiple dispatch 🪨📜✂️" |
| Parametric types | rse `types.jl` "Parametric (Generic) Types" |
| Composability (generic code + custom number types, e.g. Unitful / Measurements through a generic function) | `vchuravy.github.io/talks/summer_of_rse.jl` (uses Measurements, Unitful, StochasticRounding); `2026_03_06-SIAM-PP.jl` "Composable infrastructure" / "Magic of Julia" |

**E3** ← rse `exercises/exercise_2_multiple_dispatch.jl` (inspecting dispatch, abstract types, rock–paper–scissors)
and `exercise_4_structs.jl` part 2 (parametric `Point{T}`) + part 3 (custom `show`, bonus).

### L4 Writing fast code (35 min)
| Section | Source |
|---|---|
| How Julia runs your code (JIT, type inference, specialization; one diagram, `@code_typed` / `@code_llvm`) | `vchuravy.github.io/talks/2025_07_23-delving_into_julia.jl` "Type inference", "Interpretation vs JIT vs JAOT vs AOT" (newest version of `Making_Dynamic_Programs_Run_Fast.jl`); `julia-performance/2-JuliaCompiler.pdf` for figures |
| Benchmarking with BenchmarkTools, caveats of micro-benchmarks | `vchuravy.github.io/talks/2026-09-11-lecture_illinois.jl` "Benchmarking" (newest); rse `mod1_introduction/performance_engineering.jl` "Benchmarking" |
| Going fast nowhere (counting example, constant folding, `@code_llvm`) | `vchuravy.github.io/talks/2026-09-11-lecture_illinois.jl` "Going fast nowhere" (newest); older copies: `deRSE25-workshop/introduction/Going_fast_nowhere.jl`, `vchuravy.github.io/talks/Going_fast_nowhere.jl`, `julia-performance/3 - Going fast nowhere.ipynb` |
| Type stability, `@code_warntype`, globals | rse `exercises/exercise_11_type_stability.jl` motivating example; `julia-performance/5 - Jet & Cthulhu .ipynb` (mention JET/Cthulhu in one slide only) |
| Allocations & memory layout (column-major) | rse `performance_engineering.jl` "Memory layout of Objects", "Example: Matrix addition" |
| Profiling (`@profview` / ProfileCanvas, allocation profiler) | rse `performance_engineering.jl` "Profiling", "Allocation profiler"; `2026-09-11-lecture_illinois.jl` "Profiling"; `julia-performance/4 - Profiling.ipynb` for the workflow narrative |
| Performance checklist | new, one slide, linking to the Performance Tips in the manual |

**E4** ← rse `exercises/exercise_11_type_stability.jl` (my_sum, Newton sqrt) as core,
`exercise_13_memory_layout.jl` part 1 as bonus. (`exercise_12_performance_annotations.jl` is out of scope for beginners.)

### L5 Towards HPC (40 min)
| Section | Source |
|---|---|
| Why parallelism, Amdahl, strong/weak scaling (2 slides) | rse `mod1_introduction/parallelism.jl` "Why do we need parallelism", "Notions of scalability" |
| Tasks, `@spawn`, `@threads`, threaded map/reduction, OhMyThreads | `deRSE25-workshop/multithreading/julia-multithreading.jl` (core of this section, made with Mosè Giordano); rse `mod3_parallelism/shared-memory.jl` "Julia tasks", "Parallel-loops" |
| Data races, atomics, false sharing | rse `shared-memory.jl` "Race-conditions", "Atomics & Locks" (keep short: a single race demo) |
| GPUs & KernelAbstractions (CPU backend on laptops) | rse `mod3_parallelism/accelerated.jl` "Vendor-agnostic kernel programming", "Computing π"; `vchuravy.github.io/talks/2026_03_06-SIAM-PP.jl` (same, talk version); `deRSE25-workshop/kernelabstractions/multi-backend.jl` (backend selection logic for CI vs. laptops) |
| Distributed computing with MPI.jl (show only) | rse `mod3_parallelism/distributed.jl` (two-sided, halo exchange, collectives: as code, not run); rse `exercises/exercise_18_mpi.md` (configuring system MPI with MPIPreferences); `julia-on-ookami/mpi` |
| Julia on an HPC cluster (1–2 slides: juliaup vs modules, `JULIA_DEPOT_PATH`, Slurm, ThreadPinning) | `deRSE25-workshop/multithreading/start_notebook.sh` (Pluto on a compute node + SSH tunnel); https://juliahpc.github.io/; `julia-on-ookami/performance` |
| Where to go next | README "Further resources"; rse-course as the follow-up |

**E5** ← rse `exercises/exercise_16_shmem_parallel.jl` "Parallel PI" (core) and
`exercise_6_multithreading.jl` part 2 "multi-threaded map" (`tmap`, chunked); bonus: AXPY kernel from
`exercise_7_accelerated.jl` part 1 on the CPU backend.

### Considered and left out (time)
- Automatic differentiation / Enzyme (`vchuravy.github.io/talks/2026_06_18-NHR.jl`, rse mod4, `MPE24/Enzyme/enzyme_tut.jl`):
  a good **bonus notebook** if there is time to prepare it (tag `bonus`, add a "Bonus" collection to
  `pluto_export_configuration.json`).
- Git/GitHub, debugging, numerical reproducibility (rse mod2): point to the rse-course.
- Compiler internals beyond one diagram (`2025_07_23-delving_into_julia.jl`, `Concurrency.jl`).

## Porting checklist (per notebook)

1. Copy cells from the source notebook (open both in Pluto, or merge the text files). Keep the skeleton's
   frontmatter, `using PlutoUI, PlutoTeachingTools`, TOC and `ChooseDisplayMode()` cells.
2. Fold the code of markdown and "slide" cells so the exported page reads like slides.
3. Pin packages under Julia 1.13 (Pluto updates the embedded manifest on first run; or
   `rse-course/tools/update_notebook_packages.jl`).
4. Exercises: follow the checker-cell rules in `rse-course/CLAUDE.md` (wrap student calls in `try`/`catch`,
   guard demo cells with `@isdefined`, so headless runs have no errors). Unsolved exercises must still run cleanly.
5. Run `julia --project=. tools/run_notebook.jl <notebook>`; it must exit 0. CI enforces this.
6. If new packages are used, add them to the preinstall list in the `Dockerfile` (and to SETUP.md if they
   are big, e.g. CairoMakie, so participants download them at home).
7. Time the lecture out loud. If it runs over the slot, cut content rather than speeding up.

## Infrastructure (done)

- `lectures/`, `exercises/`: notebook skeletons with frontmatter and section headers; all run cleanly under Julia 1.13.4.
- `export.jl` + `pluto_export_configuration.json`: PlutoSliderServer static export with a featured index
  (collections "Lectures" / "Exercises", ordered by frontmatter `order`).
- `.github/workflows/ExportPluto.yml`: builds and deploys to GitHub Pages on push to `main`
  (based on deRSE25; adds MPE24's `pluto_state_cache` so unchanged notebooks are not re-run).
- `.github/workflows/CheckNotebooks.yml`: runs every notebook on PRs/pushes and fails on any errored cell.
- `.github/workflows/DockerPublish.yml`, `Dockerfile`, `julia_cpu_target.sh`, `.devcontainer/`: prebuilt
  image for Codespaces / Docker as a fallback for participants who cannot install Julia (from deRSE25).
- `tools/run_notebook.jl`: headless validator (adapted from rse-course).
- `SETUP.md`: setup instructions, written to be pasted into the participant e-mail.

## Timeline

| By | What |
|---|---|
| Fri 20 Nov | Create GitHub repo, set Pages source to "GitHub Actions", push, check the first deploy and the Docker image. |
| Wed 25 Nov | Port L1–L3 and E2–E3. |
| Mon 30 Nov | **Send setup e-mail** (SETUP.md) to registered participants. |
| Wed 2 Dec  | Port L4–L5 and E4–E5; update Dockerfile package list. |
| Fri 4 Dec  | Full dry run on a clean machine (ideally Windows + macOS), timing each block; test a Codespace. |
| Sun 6 Dec  | Registration closes; send a reminder e-mail with the site link. Freeze content and tag `v2026.12`. |
| Tue 8 Dec  | Workshop. Bring a USB stick with juliaup installers as an offline fallback for eduroam problems. |

## Open decisions

- **Repository location:** README/SETUP/devcontainer assume `github.com/vchuravy/nhr-julia-workshop`,
  served at `https://vchuravy.dev/nhr-julia-workshop/`. If it goes under `JuliaHPC` (like deRSE25), update
  these three files.
- **Julia version:** pinned to 1.13 (current `release` channel, which is what juliaup installs for participants).
  Re-check a week before. If 1.14 is released by then, either bump or tell participants to `juliaup add 1.13`.
- **Plotting:** CairoMakie makes the notebooks nicer but is a large download and slow to load on first use.
  Use it only where a plot really helps (scaling plots in L5), or switch to a lighter option.
- **Bonus AD notebook:** yes/no, see "Considered and left out".
