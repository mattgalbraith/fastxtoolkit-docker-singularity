################# BASE IMAGE ######################
FROM --platform=linux/amd64 mambaorg/micromamba:1.3.1-focal
# Micromamba for fast building of small conda-based containers.
# https://github.com/mamba-org/micromamba-docker
# The 'base' conda environment is automatically activated when the image is running.

################## METADATA ######################
LABEL base_image="mambaorg/micromamba:1.3.1-focal"
LABEL version="1.0.0"
LABEL software="FASTX-Toolkit"
LABEL software.version="0.0.14-10"
LABEL about.summary="The FASTX-Toolkit is a collection of command line tools for Short-Reads FASTA/FASTQ files preprocessing."
LABEL about.home="http://hannonlab.cshl.edu/fastx_toolkit/"
LABEL about.documentation="http://hannonlab.cshl.edu/fastx_toolkit/commandline.html"
LABEL about.license_file="http://hannonlab.cshl.edu/fastx_toolkit/license.html"
LABEL about.license="GNU AGPLv3+"

################## MAINTAINER ######################
MAINTAINER Matthew Galbraith <matthew.galbraith@cuanschutz.edu>

################## INSTALLATION ######################

# Copy the yaml file to your docker image and pass it to micromamba
COPY --chown=$MAMBA_USER:$MAMBA_USER env.yaml /tmp/env.yaml
RUN micromamba install -y -n base -f /tmp/env.yaml && \
    micromamba clean --all --yes