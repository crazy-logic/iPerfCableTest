#/bin/bash

#echo $1 

#echo $2 

#echo Thanks 
ip netns add ns_server
ip netns add ns_client
ip link set $1 netns ns_server
ip link set $2 netns ns_client
ip netns exec ns_server ip addr add dev $1 192.168.10.1/24
ip netns exec ns_client ip addr add dev $2 192.168.10.2/24
ip netns exec ns_server ip link set dev $1 up
ip netns exec ns_client ip link set dev $2 up

ip netns exec ns_server iperf -s &
ip netns exec ns_client iperf -c 192.168.10.1

killall iperf

ip netns exec ns_client iperf -s &
ip netns exec ns_server iperf -c 192.168.10.2

killall iperf

ip netns del ns_server
ip netns del ns_client
