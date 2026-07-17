#!/bin/bash
#SBATCH --job-name=bcl2fastq_PLZF
#SBATCH --output=/shared/projects/sc_hspcs_sex_aging/atac_seq_plzf/logs/bcl2fastq_%j.log
#SBATCH --error=/shared/projects/sc_hspcs_sex_aging/atac_seq_plzf/logs/bcl2fastq_%j.err
#SBATCH --cpus-per-task=16
#SBATCH --mem=32G
#SBATCH --time=06:00:00

module load bcl2fastq/2.20.0

RUNDIR=/shared/projects/sc_hspcs_sex_aging/atac_seq_plzf
OUTDIR=${RUNDIR}/FASTQ

mkdir -p ${OUTDIR}

echo "========================================="
echo "Job ID : $SLURM_JOB_ID"
echo "Début  : $(date)"
echo "========================================="

bcl2fastq \
  --runfolder-dir ${RUNDIR} \
  --output-dir ${OUTDIR} \
  --sample-sheet ${RUNDIR}/sample_sheet_bcl.txt \
  --no-lane-splitting \
  --minimum-trimmed-read-length 20 \
  --mask-short-adapter-reads 20 \
  -r 4 -p 8 -w 4

echo "========================================="
echo "Fin    : $(date)"
echo "Fichiers produits :"
ls -lh ${OUTDIR}/*.fastq.gz
echo "========================================="
