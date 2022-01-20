# This container includes the dependencies for inference. It does not include R.

FROM pytorch/pytorch:1.5.1-cuda10.1-cudnn7-runtime
ARG DEBIAN_FRONTEND="noninteractive"

RUN conda install --yes --quiet --freeze-installed \
        opencv \
        pandas \
        scikit-image \
        scipy \
    && conda clean --all --yes --quiet

# Install openslide and openslide-python.
RUN apt-get update -qq \
    && apt-get install --yes --quiet --no-install-recommends \
        libopenslide0 \
        gcc \
    && python -m pip install --no-cache-dir \
            https://github.com/openslide/openslide-python/tarball/fc14e86577a6f1be3d6b1118d839f1e2d70a0197 \
    && apt-get autoremove --yes --quiet \
        gcc \
    && rm -rf /var/lib/apt/lists/*

# TODO: is r required?

# conda config --append channels conda-forge
# conda config --set channel_priority strict
# conda install mamba
# mamba install --freeze-installed r-base=4.0.1 r-spatstat
# TODO: add scripts that run pre-trained models on whole-slide images.
