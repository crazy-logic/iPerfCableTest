#/bin/bash

# Version 2
# this now has 5 args, 
# eth1 eth2 threadcount mtu time 
#
# eth1 and eth2 the interface names 
# 
# threadcound should be total expected bandwidth/10 then you might need to optimise, 
# going above the number of actual cores is not a great idea in general, 
# and if you are using QSF's then a minimum of 4 is recomended. 
# 10G = 1 
# 40G = 4
# 100G = 8 or 12
# 
# mtu is usually 1500 but can be set upto 9000 usually - see jumbo frames for more info online 
# not all NIC's/Networks support larger frame sizes. 
# 
# time - in seconds for longer or shorter testing. 
# 
# also added the interval of 10 for anything longer to give some feedback so you can see it's actually running. 
#
# Expected results with mtu at 1500
# 1G = 940Mb/s
# 10G = 9.3Gb/s
# 40G = 37.5 Gb/s


ip link set $1 mtu $4
ip link set $2 mtu $4

ip netns add ns_server
ip netns add ns_client
ip link set $1 netns ns_server
ip link set $2 netns ns_client
ip netns exec ns_server ip addr add dev $1 192.168.10.1/24
ip netns exec ns_client ip addr add dev $2 192.168.10.2/24
ip netns exec ns_server ip link set dev $1 up
ip netns exec ns_client ip link set dev $2 up

ip netns exec ns_server iperf -s &
ip netns exec ns_client iperf -c 192.168.10.1 -P $3 -t $5 -i 10

killall iperf

ip netns exec ns_client iperf -s &
ip netns exec ns_server iperf -c 192.168.10.2 -P $3 -t $5 -i 10

killall iperf

ip netns del ns_server
ip netns del ns_client 
