# Sequencing Facility Fastq-QC pipeline: Nopipe

No Pipe is an abbreviated pipeline that will just run Fastqc and allows raw fastq files upload to either Biowulf or DME. 

## Quality Control (QC):

[FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/): Perform initial quality checks on raw sequencing data to assess sequence quality, GC content, over-representation of sequences, etc.

[Fastq Screen](https://www.bioinformatics.babraham.ac.uk/projects/fastq_screen/): Screens sequencing data against a database of known contaminants, such as adapter sequences, PhiX control, and various other sources of contamination. It helps to identify and quantify the presence of these contaminants in the sequencing data.

[MultiQC](https://multiqc.info/) : Generates an interactive HTML report that provides a concise summary of the results

## Usage

### Step 1: Obtain a copy of this workflow

Clone the Repository: Clone the new repository to your local machine, choosing the directory where you want to perform data analysis. Instructions for cloning can be found [here](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository).

### Step 2: Configure workflow

Configure the workflow according to your needs via editing the `config.yaml` file in the `config/` folder. 

### Step 3: Load Load the snakemake version 8 or above 

`module load snakemake/8.4.8`

### Step 4: Create a conda environment

$NAME=my_environment_name
`conda create -n $NAME`

### Step 5: Execute the WorkflowActivate the Conda Environment:`conda activate $NAME`Install `mamba``conda install -c conda-forge mamba`Test the Configuration: Perform a dry-run to validate your setup:`snakemake --use-conda -np`Local Execution: Execute the workflow on your local machine using $N cores:`snakemake --use-conda --cores $N`Here, $N represents the number of cores you wish to allocate for the workflow.

### Step 6: Investigate results

After successful execution, HTML report with QC results will be generated. 
conda deactivate

