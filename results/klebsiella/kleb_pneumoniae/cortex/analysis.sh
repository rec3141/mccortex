#!/bin/bash

set -eou pipefail
set -o xtrace

CTXDIR=../../../../

REF=../ref/GCF_000016305.1_ASM1630v1_genomic.fna.gz
MUMMER=../mummer/ref_qry.good.nodupes.vcf.gz
TRUTH=../truth/CAV1016.fa
MAPPING_TEST=$CTXDIR/scripts/analysis/mapping-vars-test.sh
MUMMER_ISEC=$CTXDIR/scripts/analysis/mummer-vcf-isec.sh

vcf=cortex.k31.k61.vcf.gz
name=cortex.k31.k61

mkdir -p mapping_truth mummer_isec

$MAPPING_TEST $vcf $REF $TRUTH \
              mapping_truth/$name.fa \
              mapping_truth/$name.sam >& $name.mapping.log
$MUMMER_ISEC $MUMMER $vcf mummer_isec/$name >& $name.isec.log
