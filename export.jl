# Export all Pluto notebooks in this repository to a static site.
#
# Used by .github/workflows/ExportPluto.yml; can also be run locally to preview the site:
#
#     julia --project=. -e 'using Pkg; Pkg.instantiate(); include("export.jl")'
#
# and then serve the repository root, e.g. `python3 -m http.server`.
import PlutoSliderServer

PlutoSliderServer.github_action(".";
    Export_cache_dir = "pluto_state_cache",
    Export_baked_notebookfile = false,
    Export_baked_state = false,
    # Index page uses frontmatter (title, description, tags, order) and
    # the collections defined in `pluto_export_configuration.json`.
    Export_create_pluto_featured_index = true,
)
