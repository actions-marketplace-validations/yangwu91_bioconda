FROM ubuntu:focal

MAINTAINER wuyang@drwu.ga

COPY mirrors/* /tmp/
COPY entrypoint.sh /entrypoint.sh

ENV PATH="/opt/miniconda3/bin:$PATH"

RUN apt update -yy && \
    apt upgrade -yy && \
    apt install -qyy wget vim curl zip git libgl1-mesa-dev && \
    wget -qO /tmp/miniconda3.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    bash /tmp/miniconda3.sh -bfp /opt/miniconda3 && \
	conda config --add channels defaults && \
	conda config --add channels bioconda && \
	conda config --add channels conda-forge && \
	conda update -y --all && \
    conda install python=3.8 r-base=4 conda-build conda-verify numpy scipy matplotlib future tqdm requests beautifulsoup4 \
                  samtools=1.10 bowtie2=2.4.1 bedtools=2.29.2 bwa=0.7.17 hisat2=2.2.1 blast=2.10.1 fastqc=0.11.9 minimap2=2.17 \
                  r-ggplot2=3.3.2 bioconductor-edger=3.30.0 bioconductor-deseq2=1.28.0 && \
    apt autoremove -yy && \
    apt autoclean -yy && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/* /tmp/miniconda3.sh && \
    conda clean -ayq && \
    chmod +x /entrypoint.sh && \
    mkdir -p /workspace && \
    chmod 777 /workspace

WORKDIR /workspace

ENTRYPOINT ["/entrypoint.sh"]
