# phylogenomics-Xanthomonas-1


This repository contains supporting files for the phylogenetic tree presented in this preprint: https://doi.org/10.1099/acmi.0.000532.v1.
The tree is also available for view, download and editing at https://itol.embl.de/export/14417314677481871680274619.

(Previous version: https://itol.embl.de/tree/14417323151194831652118997)

```
### Get this repo
git clone https://github.com/davidjstudholme/phylogenomics-Xanthomonas-1.git

### Download NCBI Datasets command line tools
curl -o datasets 'https://ftp.ncbi.nlm.nih.gov/pub/datasets/command-line/v1/linux-amd64/datasets'
chmod u+x datasets 

### Create genomes directory and download genome assemblies 
mkdir genomes
cd genomes

ln -s ../phylogenomics-Xanthomonas-1/xanthomonas_assm_accs.txt .
ln -s ../datasets .
./datasets download genome accession --inputfile xanthomonas_assm_accs.txt  --exclude-gff3 --exclude-protein --exclude-rna --exclude-genomic-cds --filename xanthomonas_genome_assemblies.zip

unzip xanthomonas_genome_assemblies.zip
ln -s ncbi_dataset/data/GCA_*/GCA_*.fna .
ls *.fna
perl ../phylogenomics-Xanthomonas-1/rename_files.pl  ../phylogenomics-Xanthomonas-1/genomes.txt

cd -

### Set-up the ref/ directory
mkdir ref
cd ref
ln -s ../genomes/X._campestris_pv._campestris_ATCC_33913_T_PT.fasta .
cd -

### Set-up the workdir/ directory
mkdir workdir
cd workdir
ln -s ../genomes/*.contig .
cd -

### Run PhaME
### Shakya, M., Ahmed, S.A., Davenport, K.W. et al. 
### Standardized phylogenetic and molecular evolutionary analysis applied to species across the microbial tree of life. 
### Sci Rep 10, 1723 (2020). 
### https://doi.org/10.1038/s41598-020-58356-1

screen
conda activate phame_env
cp phylogenomics-Xanthomonas-1/phame.ctl .
phame ./phame.ctl


screen
conda activate fastani_env
fastANI --ql query_list.txt --rl ref_list.txt -o all-versus-all.fastANI.out -t 6 --visualize --matrix



```



