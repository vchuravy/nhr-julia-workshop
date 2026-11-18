# Run Pluto notebooks headlessly and report cells that errored.
#
# Usage (from the repository root):
#
#     julia --project=. tools/run_notebook.jl lectures/01_getting_started.jl [more notebooks...]
#
# Exit code 0 if every cell of every notebook ran without error, 1 otherwise.
# Note: running a notebook re-saves it, so package changes (auto-installed
# packages, updated manifests) are written back to the file.

if isempty(ARGS)
    println(stderr, "Usage: julia --project=. tools/run_notebook.jl <notebook.jl>...")
    exit(2)
end

import Pkg
Pkg.instantiate()
import Pluto

session = Pluto.ServerSession()

failed = String[]
for path in ARGS
    path = abspath(path)
    println("Running notebook: ", relpath(path))
    nb = Pluto.load_notebook(Pluto.tamepath(path))
    Pluto.update_save_run!(session, nb, nb.cells; run_async = false, prerender_text = true)

    errors = [(c.cell_id, c.output.body) for c in nb.cells if c.errored]
    if isempty(errors)
        println("  ✓ no errors")
    else
        push!(failed, relpath(path))
        println("  ✗ $(length(errors)) cell(s) had errors:")
        for (id, body) in errors
            println("    Cell $id:")
            println("      ", body)
        end
    end
    Pluto.SessionActions.shutdown(session, nb; keep_in_session = false, async = false)
end

if !isempty(failed)
    println("\nNotebooks with errors:\n  ", join(failed, "\n  "))
    exit(1)
end
