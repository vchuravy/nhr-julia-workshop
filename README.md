# Introduction to Julia — NHR Süd-West

Material for the hands-on workshop **“Introduction to Julia: Fast, productive scientific computing”**,
organised by Saarland University as part of [NHR Süd-West](https://hpc.uni-saarland.de/workshops/intro-to-julia-26).

- **When:** Tuesday, 8 December 2026, 13:00–17:00 (CET)
- **Where:** Saarland University, building E1 1, room 407
- **Instructor:** [Valentin Churavy](https://vchuravy.dev)

To find prerendered notebooks go to **https://vchuravy.dev/nhr-julia-workshop/**.

## Schedule

| Time        | Session                                   | Notebook |
|-------------|-------------------------------------------|----------|
| 13:00–13:20 | Getting started: why Julia, installation, REPL, packages & environments | [`lectures/01_getting_started.jl`](lectures/01_getting_started.jl) |
| 13:20–13:45 | Language fundamentals                     | [`lectures/02_fundamentals.jl`](lectures/02_fundamentals.jl) |
| 13:45–14:05 | *Exercise*                                 | [`exercises/ex02_fundamentals.jl`](exercises/ex02_fundamentals.jl) |
| 14:05–14:25 | Multiple dispatch                         | [`lectures/03_multiple_dispatch.jl`](lectures/03_multiple_dispatch.jl) |
| 14:25–14:40 | *Exercise*                                 | [`exercises/ex03_multiple_dispatch.jl`](exercises/ex03_multiple_dispatch.jl) |
| 14:40–14:55 | ☕ Break                                   | |
| 14:55–15:30 | Writing fast code                         | [`lectures/04_fast_code.jl`](lectures/04_fast_code.jl) |
| 15:30–15:55 | *Exercise*                                 | [`exercises/ex04_fast_code.jl`](exercises/ex04_fast_code.jl) |
| 15:55–16:35 | Towards HPC: threads, GPUs, MPI           | [`lectures/05_towards_hpc.jl`](lectures/05_towards_hpc.jl) |
| 16:35–16:50 | *Exercise*                                 | [`exercises/ex05_parallel.jl`](exercises/ex05_parallel.jl) |
| 16:50–17:00 | Wrap-up and where to go next              | |

## Setup

Please install Julia and Pluto **before** the workshop. See [SETUP.md](SETUP.md).

Then start Pluto:

```julia
import Pluto
Pluto.run()
```

and open a notebook from this repository, either by downloading it or by pasting its GitHub URL
into the “Open a notebook” box. Each notebook contains its own package environment; Pluto installs
the packages automatically the first time you open it.

<details>
<summary>Can't install Julia on your laptop? Run in the browser with GitHub Codespaces or Docker.</summary>

### GitHub Codespaces

Go to the [Codespaces page of this repository](https://github.com/vchuravy/nhr-julia-workshop/codespaces),
click “Create codespace on main”, and wait for the terminal to show

```
┌ Info:
└ Go to http://localhost:1234/ in your browser to start writing ~ have fun!
```

Then open the “Ports” tab, right-click “Pluto server (1234)” and choose “Open in browser”.
The notebooks are in `/root/workshop`.

> [!NOTE]
> The free Codespaces machines are small, so parallel speed-ups in the last session will be limited.

### Docker

```sh
docker run -p 1234:1234 -ti ghcr.io/vchuravy/nhr-julia-workshop:main \
    julia -e 'using Pluto; Pluto.run(; host="0.0.0.0", port=1234)'
```

and open the URL that is printed (replace `0.0.0.0` by `localhost` if it does not connect).
The notebooks are in `/root/workshop`.

The `.devcontainer` and Docker setup are adapted from the
[deRSE25 Julia workshop](https://github.com/JuliaHPC/deRSE25-workshop).
</details>

## Further resources

- [Julia documentation](https://docs.julialang.org/) and [Modern Julia Workflows](https://modernjuliaworkflows.org/)
- [Julia Discourse](https://discourse.julialang.org/) for questions
- [Julia on HPC clusters](https://juliahpc.github.io/) notes
- [Research Software Engineering with Julia](https://vchuravy.dev/rse-course/) — a full course that goes deeper into everything covered today
- The fortnightly [Julia HPC community calls](https://julialang.org/community/#events)

## For contributors

- Notebooks live in `lectures/` and `exercises/`. Their frontmatter (`title`, `description`,
  `tags`, `order`) drives the index page; collections are defined in
  [`pluto_export_configuration.json`](pluto_export_configuration.json).
- Check that every cell runs: `julia --project=. tools/run_notebook.jl lectures/*.jl exercises/*.jl`
  (CI does this on every PR, see `.github/workflows/CheckNotebooks.yml`).
- Preview the site locally: `julia --project=. -e 'using Pkg; Pkg.instantiate(); include("export.jl")'`,
  then `python3 -m http.server` and open <http://localhost:8000>.
- Pushing to `main` builds and deploys the site (`.github/workflows/ExportPluto.yml`).
  In the repository settings, set *Pages → Source* to **GitHub Actions**.
- See [PLAN.md](PLAN.md) for the teaching plan and where each piece of material comes from.

## License

The code portions are under the MIT license, and the non-code portions under a
Creative Commons CC-BY-SA 4.0 license.
