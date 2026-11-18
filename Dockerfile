# syntax=docker/dockerfile:1
# Image for running the workshop notebooks without a local Julia install
# (GitHub Codespaces via .devcontainer, or `docker run`; see README).
# Built and published by .github/workflows/DockerPublish.yml.
FROM julia:1.13

# Install git, for use within Codespaces
RUN /bin/sh -c 'export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get install -y git \
    && apt-get --purge autoremove -y \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/*'

# Docker doesn't allow conditionally setting environment variables, so we keep
# an external script and source it every time we need it.
COPY julia_cpu_target.sh /julia_cpu_target.sh

RUN julia --color=yes -e 'using InteractiveUtils; versioninfo()'

# Preinstall the packages used across the notebooks into the default
# environment, so that Pluto's per-notebook environments resolve from the
# local depot instead of downloading and precompiling on first open.
# Keep this list in sync with the packages the notebooks use.
RUN mkdir -p /root/.julia/environments/v1.13
COPY Project.toml /root/.julia/environments/v1.13/Project.toml
RUN . /julia_cpu_target.sh && julia --color=yes -e 'using Pkg; Pkg.add([ \
        "BenchmarkTools", \
        "CairoMakie", \
        "ChunkSplitters", \
        "KernelAbstractions", \
        "OhMyThreads", \
        "Pluto", \
        "PlutoTeachingTools", \
        "PlutoUI", \
        "ProfileCanvas", \
        "ThreadPinning", \
    ]); Pkg.precompile()'

# Copy notebooks
COPY lectures /root/workshop/lectures
COPY exercises /root/workshop/exercises
WORKDIR /root/workshop
