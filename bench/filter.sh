#!/bin/bash
export LC_ALL=C
SORTF='-t , -k1 -s --parallel=2'
BENCHS='bench.{rcm,mmd}'
for f in $(eval echo $BENCHS)
do
    awk -SF, '{if(NR > 2 && $2 == 0) print $0}' $f | sort -t, -k1 -s > ${f}.only-success
done
join -j 1 -t , $(eval echo ${BENCHS}.only-success)  | sort -h -r -t, -k5 -s > PCx.comparison
awk -SF, '
BEGIN {print "Nome,L,C,NNZ-RCM,IT-RCM,T-RCM,NNZ-MGM,IT-MGM,T-MGM"}
{printf "%s,%s,%s,%.2e,%s,%.1e,%.2e,%s,%.1e\n", $1, $3, $4, $7, $14, $15, $21, $28, $29}' PCx.comparison > PCx.sbpo
head -n 46 PCx.sbpo > PCx.sbpo46

# Analise: Envelope
awk -SF, '
BEGIN {m = 0; i = 0; media = 0; nmedia = 0}
{if (NR > 2 && $4 < $7) m = m + 1}
{if (NR > 2 && $4 == $7) i = i + 1}
{if (NR > 2 && $4 > $7) {media = media + ($4 - $7) / $7; nmedia = nmedia + 1}}
END {printf "NNZ-RCM < NNZ-MMD: %d\n", m; printf "NNZ-RCM = NNZ-MMD: %d\n", i;
printf "NNZ-RCM ~ NNZ-MMD * %f\n", media / nmedia }' PCx.sbpo
# Analise: Iterações
awk -SF, '
BEGIN {m = 0; i = 0}
{if (NR > 2 && $5 < $8) m = m + 1}
{if (NR > 2 && $5 == $8) i = i + 1}
END {printf "IT-RCM < IT-MMD: %d\n", m; printf "IT-RCM = IT-MMD: %d\n", i}' PCx.sbpo
# Analise: Tempo
awk -SF, '
BEGIN {m = 0; i = 0}
{if (NR > 2 && $6 < $9) m = m + 1}
{if (NR > 2 && $6 == $9) i = i + 1}
END {printf "T-RCM < T-MMD: %d\n", m; printf "T-RCM = T-MMD: %d\n", i}' PCx.sbpo
