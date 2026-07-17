#!/bin/bash
#SBATCH --job-name=nfcore_atacseq
#SBATCH -p long
#SBATCH --cpus-per-task=16
#SBATCH --mem=120G
#SBATCH --time=72:00:00
#SBATCH --output=nfcore_atacseq_%j.log
#SBATCH --error=nfcore_atacseq_%j.err

module purge
module load nextflow/24.10.4
module load singularity

export NXF_HOME=/shared/projects/sc_hspcs_sex_aging/atac_seq_plzf/.nextflow
export NXF_WORK=/shared/projects/sc_hspcs_sex_aging/atac_seq_plzf/work
export NXF_TEMP=/shared/projects/sc_hspcs_sex_aging/atac_seq_plzf/tmp
export TMPDIR=$NXF_TEMP

export SINGULARITY_CACHEDIR=/shared/projects/sc_hspcs_sex_aging/atac_seq_plzf/singularity_cache

mkdir -p $NXF_HOME $NXF_WORK $NXF_TEMP $SINGULARITY_CACHEDIR

nextflow run nf-core/atacseq -r 2.1.2 \
  -profile singularity \
  --input samplesheet_atacseq.csv \
  --outdir results_atacseq \
  --genome mm10 \
  --read_length 50 \
  --max_cpus 16 \
  --max_memory '110.GB' \
  --max_time '72.h' \
  -work-dir $NXF_WORK \
  -resume
