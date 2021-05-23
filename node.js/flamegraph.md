perf record -F 99 -p 182497 -g -- sleep 60
perf record -F 99 -p 26340 -g -- sleep 30

perf record -F99 -p `pgrep -n node` -g -- sleep 30
perf record -F99 -e cycles:u -p `pgrep -n node` -g -- sleep 30

perf record -F99 -e cycles:u -p `ps -ef | grep "perf" | grep -v grep | awk '{print $2}'` -g -- sleep 30

chown root /tmp/perf-`pgrep -n node`.map
chown root /tmp/perf-`ps -ef | grep "perf" | grep -v grep | awk '{print $2}'`.map
chown root perf.out
chown root perf.data

perf script > perf.out

perf script | egrep -v "( __libc_start| LazyCompile | v8::internal::| Builtin:| Stub:| LoadIC:|\[unknown\]| LoadPolymorphicIC:)" | sed 's/ LazyCompile:[*~]\?/ /' > perf.out

perf script > perf.stacks

sz -bye perf.out

stackvis perf < perfs.out > flamegraph.htm

./stackcollapse-perf.pl --kernel < ./perf.out | ./flamegraph.pl --color=js --hash > perf.svg

node --perf-basic-prof
