from snakemake.utils import validate
import pandas as pd
import yaml

##### load config and sample sheets #####
configfile: "config/config.yaml"

rule fastqc:
    input: R1 = rawdir + "/" + "{sample}_R1_001.fastq", R2 = rawdir + "/" + "{sample}_R2_001.fastq"
    output: "Sample_{sample}/{sample}_R1_001_fastqc.html"
    params: prefix = "Sample_{sample}/"
    log: "logs/{sample}_fastqc.log"
    conda: "/workflow/rules/envs/fastqc.yaml"
    threads: 16
    resources: mem_mb=config['medium']['mem'], time=config['medium']['time']#,partition=config['medium']['partition']
    shell:  "fastqc -o {params.prefix} --noextract -k 5 -t {threads} -f fastq {input.R1} {input.R2}"

rule fastqscreen:
    input: R1 = rawdir + "/" + "{sample}_R1_001.fastq", R2 = rawdir + "/" + "{sample}_R2_001.fastq"
    output: one = "Sample_{sample}/{sample}_R1_001_screen.png", two = "Sample_{sample}/{sample}_R2_001_screen.png"
    params: prefix = "Sample_{sample}/" , conf = config['fastqscreen']
    conda: "/workflow/rules/envs/fastqscreen.yaml"
    threads: 16
    resources: mem_mb=config['medium']['mem'], time=config['medium']['time']#, partition=config['medium']['partition']
    shell: "fastq_screen --outdir {params.prefix} --threads {threads} --nohits --subset 0  --conf {params.conf} --aligner bowtie2 {input.R1} {input.R2}"i

rule multiqc:
    input: expand("Sample_{sample}/{sample}_R1_001_fastqc.html", sample=samples), expand("Sample_{sample}/{sample}_R1_001_screen.png", sample=samples), expand("Sample_{sample}/{sample}_R2_001_screen.png", sample=samples)
    output: "multiqc.html"
    conda: "/workflow/rules/envs/multiqc.yaml"
    resources: mem_mb=config['medium']['mem'], time=config['medium']['time']#,partition=config['medium']['partition']
    threads: 16
    shell: "multiqc -f ./ -n {output}"
