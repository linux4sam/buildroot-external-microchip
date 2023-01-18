#!/bin/sh

iface="lan1"
mirro_port="lan1"
taprio_stat=001944

if [ $1 = "1" ]; then
	tc qdisc add dev $iface root handle 1: mqprio \
		num_tc 8 \
		map 0 1 2 3 4 5 6 7 \
		queues 1@0 1@1 1@2 1@3 1@4 1@5 1@6 1@7 \
		hw 0
elif [ $1 = "2" ]; then
	tc qdisc replace dev $iface parent 1:1 handle 11 cbs idleslope 10000 sendslope -90000 locredit 0x0606 hicredit 0x606 offload 1
        tc qdisc replace dev $iface parent 1:2 handle 22 cbs idleslope 20000 sendslope -80000 locredit 0x0606 hicredit 0x606 offload 1
        tc qdisc replace dev $iface parent 1:3 handle 33 cbs idleslope 30000 sendslope -70000 locredit 0x0606 hicredit 0x606 offload 1
        tc qdisc replace dev $iface parent 1:4 handle 44 cbs idleslope 40000 sendslope -60000 locredit 0x0606 hicredit 0x606 offload 1
        tc qdisc replace dev $iface parent 1:5 handle 55 cbs idleslope 50000 sendslope -50000 locredit 0x0606 hicredit 0x606 offload 1
        tc qdisc replace dev $iface parent 1:6 handle 66 cbs idleslope 60000 sendslope -40000 locredit 0x0606 hicredit 0x606 offload 1
        tc qdisc replace dev $iface parent 1:7 handle 77 cbs idleslope 70000 sendslope -30000 locredit 0x0606 hicredit 0x606 offload 1
        tc qdisc replace dev $iface parent 1:8 handle 88 cbs idleslope 80000 sendslope -20000 locredit 0x0606 hicredit 0x606 offload 1
elif [ $1 = "3" ]; then
	tc qdisc show
elif [ $1 = "4" ]; then
	tc qdisc del dev $iface root
elif [ $1 = "5" ]; then
	ip link set dev br0 type bridge vlan_filtering 1
	bridge vlan add dev br0 self vid 5 pvid untagged
	bridge vlan add dev $iface vid 5 pvid untagged
	bridge vlan show
elif [ $1 == "6" ]; then
	tc qdisc add dev $iface root handle 100: taprio \
		num_tc 8 \
		map 0 1 2 3 4 5 6 7 \
		queues 1@0 1@1 1@2 1@3 1@4 1@5 1@6 1@7 \
		base-time 192453000000000\
		sched-entry S 81 20000000 \
		sched-entry S 40 20000000 \
		sched-entry S 20 20000000 \
		sched-entry S 81 2000 \
		flags 0x2
	sleep 2
	cat -n /sys/kernel/debug/regmap/spi1.3-16/registers | grep $taprio_stat
elif [ $1 == "7" ]; then
	mount -t debugfs none /sys/kernel/debug
elif [ $1 == "8" ]; then
	cat -n /sys/kernel/debug/regmap/spi1.3-16/registers | grep $taprio_stat
elif [ $1 == "9" ]; then
	tc qdisc del dev $iface root
	echo -n '$taprio_stat 0xC000' > /sys/kernel/debug/regmap/spi1.3-16/registers
	cat -n /sys/kernel/debug/regmap/spi1.3-16/registers | grep $taprio_stat
elif [ $1 == "10" ]; then
	phc_ctl /dev/ptp0 get
elif [ $1 == "11" ]; then
	tc qdisc add dev $iface handle ffff: ingress
	tc filter add dev $iface parent ffff: protocol all u32 match u32 0 0 action mirred egress mirror dev lan2
	#port mirroring
elif [ $1 == "12" ]; then
	tc qdisc add dev $iface clsact
	tc filter add dev $iface ingress matchall skip_sw action mirred egress mirror dev $mirror_port
	tc filter add dev $iface egress matchall skip_sw action mirred egress mirror dev $mirror_port
	#vlan port
elif [ $1 == "13" ]; then
	ip link add link $iface name $iface.5 type vlan id 5 egress-qos-map 1:1 2:2 3:3 4:4 5:5 6:6 7:7
	ip link set dev iface.5 up
elif [ $1 == "14" ]; then
	mount -t debugfs none /sys/kernel/debug
	tc qdisc add dev $iface root handle 100: taprio \
		num_tc 8 \
		map 0 1 2 3 4 5 6 7 \
		queues 1@0 1@1 1@2 1@3 1@4 1@5 1@6 1@7 \
		base-time 192453000000000\
		sched-entry S 03 20000000 \
		sched-entry S 03 20000000 \
		flags 0x2
	sleep 2
	cat -n /sys/kernel/debug/regmap/spi1.3-16/registers | grep $taprio_stat
elif [ $1 == "15" ]; then
	echo -n '0x1900 '$2 > /sys/kernel/debug/regmap/spi1.3-32/registers
	cat -n /sys/kernel/debug/regmap/spi1.3-8/registers | grep 001920
fi
