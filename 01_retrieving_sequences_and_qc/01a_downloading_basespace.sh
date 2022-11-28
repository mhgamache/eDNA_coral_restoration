## three positional arguments specifying 1) a run ID; 2) the output directory; 3) email address to alert of job starts, failures, and completions
## run IDs can be found via 'bs list run' after loading loadhub.apps/basespace/april.2021

runid=$1
outdir=$2
email=$3

mkdir -p ${outdir}

cat <<EOF > ${outdir}/downlaod_basespace.sbatch
#!/bin/bash
#SBATCH --qos=rra
#SBATCH --partition=rra
#SBATCH --time=6-00:00:00
#SBATCH --mem=60G
#SBATCH --job-name=download_basespace
#SBATCH --output=${outdir}/download_basespace.log
#SBATCH --mail-type=ALL
#SBATCH --mail-user=${email}

module purge
module load hub.apps/basespace/april.2021

bs --version

bs download run -i ${runid} -o ${outdir}

EOF

if $autorun; then

sbatch ${outdir}/download_basespace.sbatch

fi
