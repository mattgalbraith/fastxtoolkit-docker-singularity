[![Docker Image CI](https://github.com/mattgalbraith/fastxtoolkit-docker-singularity/actions/workflows/docker-image.yml/badge.svg)](https://github.com/mattgalbraith/fastxtoolkit-docker-singularity/actions/workflows/docker-image.yml)

# fastxtoolkit-docker-singularity

## Build Docker container for FASTX Toolkit and (optionally) convert to Apptainer/Singularity.  

The FASTX-Toolkit is a collection of command line tools for Short-Reads FASTA/FASTQ files preprocessing.
http://hannonlab.cshl.edu/fastx_toolkit/index.html    
  
#### Requirements:  
Install within image using micromamba  
https://github.com/mamba-org/micromamba-docker  

  
## Build docker container:  

### 1. For FASTX Toolkit installation instructions:  
http://hannonlab.cshl.edu/fastx_toolkit/download.html  
https://bioconda.github.io/recipes/fastx_toolkit/README.html  


### 2. Build the Docker Image

#### To build image from the command line:  
``` bash
# Assumes current working directory is the top-level fastxtoolkit-docker-singularity directory
docker build -t fastxtoolkit:0.0.14 . # tag should match software version
```
* Can do this on [Google shell](https://shell.cloud.google.com)

#### To test this tool from the command line:
``` bash
docker run --rm -it fastxtoolkit:0.0.14 fastx_uncollapser -h
docker run --rm -it fastxtoolkit:0.0.14 fastx_barcode_splitter.pl -h
```

## Optional: Conversion of Docker image to Singularity  

### 3. Build a Docker image to run Singularity  
(skip if this image is already on your system)  
https://github.com/mattgalbraith/singularity-docker

### 4. Save Docker image as tar and convert to sif (using singularity run from Docker container)  
``` bash
docker images
docker save <Image_ID> -o fastxtoolkit0.0.14-docker.tar && gzip fastxtoolkit0.0.14-docker.tar # = IMAGE_ID of <tool> image
docker run -v "$PWD":/data --rm -it singularity:1.1.5 bash -c "singularity build /data/fastxtoolkit0.0.14.sif docker-archive:///data/fastxtoolkit0.0.14-docker.tar.gz"
```
NB: On Apple M1/M2 machines ensure Singularity image is built with x86_64 architecture or sif may get built with arm64  

Next, transfer the fastxtoolkit0.0.14.sif file to the system on which you want to run FASTX Toolkit from the Singularity container  

### 5. Test singularity container on (HPC) system with Singularity/Apptainer available  
``` bash
# set up path to the Singularity container
FASTXTOOLKIT_SIF=path/to/fastxtoolkit0.0.14.sif

# Test that FASTX Toolkit can run from Singularity container
singularity run $FASTXTOOLKIT_SIF fastx_uncollapser -h # depending on system/version, singularity may be called apptainer
singularity run $FASTXTOOLKIT_SIF fastx_barcode_splitter.pl -h
```