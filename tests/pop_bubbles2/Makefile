SHELL=/bin/bash -euo pipefail

# Test pop bubbles with a multiple samples, multiple input files

CTXDIR=../..
CTX=$(CTXDIR)/bin/mccortex31
K=21

SEQS=sample1.fa sample2.fa clean2.fa
GRAPHS=sample1.ctx sample2.ctx popped.ctx truth.ctx

all: popped.ctx truth.ctx check

sample1.fa:
	( echo CCTAGGGTGCAGTCAATTGCCAACGGTCGGGAGATAACTTCTCCAAACCAGGTTCATGACAGCCAACCAA; \
		echo CCTAGGGTGCAGTCAATTGCCAACGGTCGGGAGATAACTTCTCCAAACCAGGTTCATGACAGCCAACCAA; ) > $@

sample2.fa:
	( echo CCTAGGGTGCAGTCAATTGCCAACGGTCGGGAcATAACTTCTCCAAACCAGGTTCATGACAGCCAACCAA; ) > $@

clean2.fa:
	( echo CCTAGGGTGCAGTCAATTGCCAACGGTCGGGA; \
		echo ATAACTTCTCCAAACCAGGTTCATGACAGCCAACCAA; ) > $@

truth.ctx: sample1.ctx sample2.ctx clean2.fa
	$(CTX) build -k $(K) -s clean2 -1 clean2.fa - | $(CTX) join -o $@ 0:sample1.ctx 1:-

%.ctx: %.fa
	$(CTX) build -k $(K) --sample $* --seq $< $@

popped.ctx: sample1.ctx sample2.ctx
	$(CTX) popbubbles --out $@ $^

check: popped.ctx truth.ctx
	diff -q <($(CTX) view -q -k popped.ctx | sort) <($(CTX) view -q -k truth.ctx | sort) && \
	echo "Kmers match."


clean:
	rm -rf $(SEQS) $(GRAPHS)

.PHONY: all clean check
