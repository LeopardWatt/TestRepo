#!bin/bash
(for i in{1..20}; do touch $1.txt && head -c 2048 /dev/random > $i.txt;done) || echo "error found"