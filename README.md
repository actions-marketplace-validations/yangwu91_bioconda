## Bioconda with Docker and GitHub Actions

![docker](https://img.shields.io/docker/cloud/build/yangwu91/bioconda?logo=docker&style=flat) ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/yangwu91/bioconda/Test?label=actions&logo=github)

This is the Bioconda integrated with Docker and GitHub Actions, enjoy! *N.B.*, this is **NOT** the official repository. 

### Environments

* Python=3.8
* R=4
* Built on the latest ubuntu:focal docker
* Used [the BFSU mirror](https://mirrors.bfsu.edu.cn) as default
* Pre-installed some useful applications (_i.e._ wget, vim, git _etc._)
* Pre-installed some latest bioinformatics tools:
  * samtools=1.10
  * bowtie2=2.4.1
  * bedtools=2.29.2
  * bwa=0.7.17
  * hisat2=2.2.1
  * blast=2.10.1
  * fastqc=0.11.9
  * minimap2=2.17
* Pre-installed some R packages:
  * ggplot2=3.3.2
  * edgeR=3.30.0
  * DESeq2=1.28.0

### Docker image

```bash
# To pull the image:
docker pull yangwu91/bioconda
# To use the Docker bash:
docker run -it yangwu91/bioconda
# For quick one-time use:
docker run -it -v /dev/shm:/dev/shm -v /home/user/data:/workspace yangwu91/bioconda blastn -query /workspace/query.fasta -db /workspace/db -out /workspace/out.blastn
```

### GitHub Actions

Example workflow to set up Conda with Bioconda and other channels:

```yaml
name: bioconda
  
on:
  release:
    types: [published]
  
jobs:
  bioconda:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - name: Set up bioconda and other custom channels
      uses: yangwu91/bioconda@1.0
      with:
          mirror: 'bfsu'
          channels: 'yangwu91'
          packages: 'r2g diamond'
          cmd: 'r2g --version; diamond --version'
          args: 'conda info'
```
