# The FANCOM (Filter ANd CO-assemble Metagenomes) pipeline

This pipeline automates the task of cleaning and co-assembling raw, paired-end metagenomic sequences. This is currently custom built for use with [SLURM](https://slurm.schedmd.com/) on the [Talapas computing cluster](https://hpcf.uoregon.edu/) at the University of Oregon. Quality filtering and filtering of Human DNA are performed using FastQC, bowtie2, andtrimmomatic wrapped in [KneadData](https://bitbucket.org/biobakery/kneaddata/wiki/Home). Co-assembly of cleaned reads is performed with [MEGAHIT](https://github.com/voutcn/megahit).

## Launching
Use `scp` to transfer these files from your local machine over to the directory containing your raw sequence files on Talapas. Then submit the job to SLURM using `sbatch`. For me that looks like

```bash
cd fancom
scp -r fancom* username@talapas-ln1.uoregon.edu:path/to/your/sequences
```

```bash
sbatch fancom_batch.srun
```

You can check the status of your job, and any error messages using

```bash
cat fancom.out
cat fancom.err
```