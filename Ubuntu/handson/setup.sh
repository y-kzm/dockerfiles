echo "----------------------------"
echo "Run:        " $0		# スクリプト名
echo "Type:       " $1    # buld or del
echo "----------------------------"

if [ $1 = "build" ]; then
    echo ">> Build <<"

    # netns 生成
    echo "  create netns."
    ip netns add R1
    ip netns add R2
    ip netns add R3
    ip netns add R4
    ip netns add R5
    ip netns add R6
    ip netns add R7
    ip netns add R8

    # Peer 生成
    echo "  create peer."
    ip link add R1-net0 type veth peer name R2-net1
    ip link set R1-net0 netns R1
    ip link set R2-net1 netns R2
    ip link add R2-net0 type veth peer name R3-net0
    ip link set R2-net0 netns R2
    ip link set R3-net0 netns R3
    ip link add R3-net1 type veth peer name R4-net0
    ip link set R3-net1 netns R3
    ip link set R4-net0 netns R4
    ip link add R3-net2 type veth peer name R6-net0
    ip link set R3-net2 netns R3
    ip link set R6-net0 netns R6
    ip link add R3-net3 type veth peer name R7-net0
    ip link set R3-net3 netns R3
    ip link set R7-net0 netns R7
    ip link add R3-net4 type veth peer name R8-net0
    ip link set R3-net4 netns R3
    ip link set R8-net0 netns R8
    ip link add R4-net1 type veth peer name R5-net0
    ip link set R4-net1 netns R4
    ip link set R5-net0 netns R5

    # address 付与
    echo "  give address."
    ip netns exec R1 ip -6 addr add  cafe:1::1/64 dev R1-net0
    ip netns exec R2 ip -6 addr add  cafe:1::2/64 dev R2-net1
    ip netns exec R2 ip -6 addr add  cafe:2::2/64 dev R2-net0
    ip netns exec R3 ip -6 addr add  cafe:2::3/64 dev R3-net0
    ip netns exec R3 ip -6 addr add  cafe:3::3/64 dev R3-net1
    ip netns exec R4 ip -6 addr add  cafe:3::4/64 dev R4-net0
    ip netns exec R4 ip -6 addr add  cafe:4::4/64 dev R4-net1
    ip netns exec R5 ip -6 addr add  cafe:4::5/64 dev R5-net0
    ip netns exec R3 ip -6 addr add  cafe:5::3/64 dev R3-net2
    ip netns exec R6 ip -6 addr add  cafe:5::6/64 dev R6-net0
    ip netns exec R3 ip -6 addr add  cafe:6::3/64 dev R3-net3
    ip netns exec R7 ip -6 addr add  cafe:6::7/64 dev R7-net0
    ip netns exec R3 ip -6 addr add  cafe:7::3/64 dev R3-net4
    ip netns exec R8 ip -6 addr add  cafe:7::8/64 dev R8-net0

    ip netns exec R1 ip -6 addr add  fc00:1::/64 dev lo
    ip netns exec R2 ip -6 addr add  fc00:2::/64 dev lo
    ip netns exec R3 ip -6 addr add  fc00:3::/64 dev lo
    ip netns exec R4 ip -6 addr add  fc00:4::/64 dev lo
    ip netns exec R5 ip -6 addr add  fc00:5::/64 dev lo
    ip netns exec R6 ip -6 addr add  fc00:6::/64 dev lo
    ip netns exec R7 ip -6 addr add  fc00:7::/64 dev lo
    ip netns exec R8 ip -6 addr add  fc00:8::/64 dev lo

    # interface up
    echo "  interface up."
    ip netns exec R1 ip link set R1-net0 up
    ip netns exec R2 ip link set R2-net1 up
    ip netns exec R2 ip link set R2-net0 up
    ip netns exec R3 ip link set R3-net0 up
    ip netns exec R3 ip link set R3-net1 up
    ip netns exec R4 ip link set R4-net0 up
    ip netns exec R4 ip link set R4-net1 up
    ip netns exec R5 ip link set R5-net0 up
    ip netns exec R3 ip link set R3-net2 up
    ip netns exec R6 ip link set R6-net0 up
    ip netns exec R3 ip link set R3-net3 up
    ip netns exec R7 ip link set R7-net0 up
    ip netns exec R3 ip link set R3-net4 up
    ip netns exec R8 ip link set R8-net0 up
    ip netns exec R1 ip link set lo up    
    ip netns exec R2 ip link set lo up    
    ip netns exec R3 ip link set lo up    
    ip netns exec R4 ip link set lo up    
    ip netns exec R5 ip link set lo up    
    ip netns exec R6 ip link set lo up    
    ip netns exec R7 ip link set lo up    
    ip netns exec R8 ip link set lo up    

    # router 
    echo "  ipv6 forwarding enable."
    ip netns exec R1 sysctl net.ipv6.conf.all.forwarding=1
    ip netns exec R2 sysctl net.ipv6.conf.all.forwarding=1
    ip netns exec R3 sysctl net.ipv6.conf.all.forwarding=1
    ip netns exec R4 sysctl net.ipv6.conf.all.forwarding=1
    ip netns exec R5 sysctl net.ipv6.conf.all.forwarding=1
    ip netns exec R6 sysctl net.ipv6.conf.all.forwarding=1
    ip netns exec R7 sysctl net.ipv6.conf.all.forwarding=1
    ip netns exec R8 sysctl net.ipv6.conf.all.forwarding=1

    # route 設定
    # R1
    echo "  R1 route."
    ip netns exec R1 ip -6 route add cafe:2::/64 via cafe:1::2
    ip netns exec R1 ip -6 route add cafe:3::/64 via cafe:1::2
    ip netns exec R1 ip -6 route add cafe:4::/64 via cafe:1::2
    ip netns exec R1 ip -6 route add cafe:5::/64 via cafe:1::2
    ip netns exec R1 ip -6 route add cafe:6::/64 via cafe:1::2
    ip netns exec R1 ip -6 route add cafe:7::/64 via cafe:1::2
    ip netns exec R1 ip -6 route add fc00:2::/64 via cafe:1::2
    ip netns exec R1 ip -6 route add fc00:3::/64 via cafe:1::2
    ip netns exec R1 ip -6 route add fc00:4::/64 via cafe:1::2
    ip netns exec R1 ip -6 route add fc00:5::/64 via cafe:1::2
    ip netns exec R1 ip -6 route add fc00:6::/64 via cafe:1::2
    ip netns exec R1 ip -6 route add fc00:7::/64 via cafe:1::2
    ip netns exec R1 ip -6 route add fc00:8::/64 via cafe:1::2
    # R2
    echo "  R2 route."
    ip netns exec R2 ip -6 route add cafe:3::/64 via cafe:2::3
    ip netns exec R2 ip -6 route add cafe:4::/64 via cafe:2::3
    ip netns exec R2 ip -6 route add cafe:5::/64 via cafe:2::3
    ip netns exec R2 ip -6 route add cafe:6::/64 via cafe:2::3
    ip netns exec R2 ip -6 route add cafe:7::/64 via cafe:2::3
    ip netns exec R2 ip -6 route add fc00:1::/64 via cafe:1::1
    ip netns exec R2 ip -6 route add fc00:3::/64 via cafe:2::3
    ip netns exec R2 ip -6 route add fc00:4::/64 via cafe:2::3
    ip netns exec R2 ip -6 route add fc00:5::/64 via cafe:2::3
    ip netns exec R2 ip -6 route add fc00:6::/64 via cafe:2::3
    ip netns exec R2 ip -6 route add fc00:7::/64 via cafe:2::3
    ip netns exec R2 ip -6 route add fc00:8::/64 via cafe:2::3
    # ip netns exec R2 ip -6 route add default via cafe:2::3
    # R3
    echo "  R3 route."
    ip netns exec R3 ip -6 route add cafe:1::/64 via cafe:2::2
    ip netns exec R3 ip -6 route add cafe:4::/64 via cafe:3::4
    ip netns exec R3 ip -6 route add fc00:1::/64 via cafe:2::2
    ip netns exec R3 ip -6 route add fc00:2::/64 via cafe:2::2
    ip netns exec R3 ip -6 route add fc00:4::/64 via cafe:3::4
    ip netns exec R3 ip -6 route add fc00:5::/64 via cafe:3::4
    ip netns exec R3 ip -6 route add fc00:6::/64 via cafe:5::6
    ip netns exec R3 ip -6 route add fc00:7::/64 via cafe:6::7
    ip netns exec R3 ip -6 route add fc00:8::/64 via cafe:7::8
    # R4
    echo "  R4 route."
    ip netns exec R4 ip -6 route add cafe:1::/64 via cafe:3::3
    ip netns exec R4 ip -6 route add cafe:2::/64 via cafe:3::3
    ip netns exec R4 ip -6 route add cafe:5::/64 via cafe:3::3
    ip netns exec R4 ip -6 route add cafe:6::/64 via cafe:3::3
    ip netns exec R4 ip -6 route add cafe:7::/64 via cafe:3::3
    ip netns exec R4 ip -6 route add fc00:1::/64 via cafe:3::3
    ip netns exec R4 ip -6 route add fc00:2::/64 via cafe:3::3
    ip netns exec R4 ip -6 route add fc00:3::/64 via cafe:3::3
    ip netns exec R4 ip -6 route add fc00:5::/64 via cafe:4::5
    ip netns exec R4 ip -6 route add fc00:6::/64 via cafe:3::3
    ip netns exec R4 ip -6 route add fc00:7::/64 via cafe:3::3
    ip netns exec R4 ip -6 route add fc00:8::/64 via cafe:3::3
    # R5 
    echo "  R5 route."
    ip netns exec R5 ip -6 route add cafe:1::/64 via cafe:4::4
    ip netns exec R5 ip -6 route add cafe:2::/64 via cafe:4::4
    ip netns exec R5 ip -6 route add cafe:3::/64 via cafe:4::4
    ip netns exec R5 ip -6 route add cafe:5::/64 via cafe:4::4
    ip netns exec R5 ip -6 route add cafe:6::/64 via cafe:4::4
    ip netns exec R5 ip -6 route add cafe:7::/64 via cafe:4::4
    ip netns exec R5 ip -6 route add fc00:1::/64 via cafe:4::4
    ip netns exec R5 ip -6 route add fc00:2::/64 via cafe:4::4
    ip netns exec R5 ip -6 route add fc00:3::/64 via cafe:4::4
    ip netns exec R5 ip -6 route add fc00:4::/64 via cafe:4::4
    ip netns exec R5 ip -6 route add fc00:6::/64 via cafe:4::4
    ip netns exec R5 ip -6 route add fc00:7::/64 via cafe:4::4
    ip netns exec R5 ip -6 route add fc00:8::/64 via cafe:4::4
    # R6 
    echo "  R6 route."
    ip netns exec R6 ip -6 route add cafe:1::/64 via cafe:5::3
    ip netns exec R6 ip -6 route add cafe:2::/64 via cafe:5::3
    ip netns exec R6 ip -6 route add cafe:3::/64 via cafe:5::3
    ip netns exec R6 ip -6 route add cafe:4::/64 via cafe:5::3
    ip netns exec R6 ip -6 route add cafe:5::/64 via cafe:5::3
    ip netns exec R6 ip -6 route add cafe:7::/64 via cafe:5::3
    ip netns exec R6 ip -6 route add cafe:8::/64 via cafe:5::3
    ip netns exec R6 ip -6 route add fc00:1::/64 via cafe:5::3
    ip netns exec R6 ip -6 route add fc00:2::/64 via cafe:5::3
    ip netns exec R6 ip -6 route add fc00:3::/64 via cafe:5::3
    ip netns exec R6 ip -6 route add fc00:4::/64 via cafe:5::3
    ip netns exec R6 ip -6 route add fc00:5::/64 via cafe:5::3
    ip netns exec R6 ip -6 route add fc00:7::/64 via cafe:5::3
    ip netns exec R6 ip -6 route add fc00:8::/64 via cafe:5::3
    # R7 
    echo "  R7 route."
    ip netns exec R7 ip -6 route add cafe:1::/64 via cafe:6::3
    ip netns exec R7 ip -6 route add cafe:2::/64 via cafe:6::3
    ip netns exec R7 ip -6 route add cafe:3::/64 via cafe:6::3
    ip netns exec R7 ip -6 route add cafe:4::/64 via cafe:6::3
    ip netns exec R7 ip -6 route add cafe:5::/64 via cafe:6::3
    ip netns exec R7 ip -6 route add cafe:6::/64 via cafe:6::3
    ip netns exec R7 ip -6 route add cafe:8::/64 via cafe:6::3
    ip netns exec R7 ip -6 route add fc00:1::/64 via cafe:6::3
    ip netns exec R7 ip -6 route add fc00:2::/64 via cafe:6::3
    ip netns exec R7 ip -6 route add fc00:3::/64 via cafe:6::3
    ip netns exec R7 ip -6 route add fc00:4::/64 via cafe:6::3
    ip netns exec R7 ip -6 route add fc00:5::/64 via cafe:6::3
    ip netns exec R7 ip -6 route add fc00:6::/64 via cafe:6::3
    ip netns exec R7 ip -6 route add fc00:8::/64 via cafe:6::3
    # R8
    echo "  R8 route."
    ip netns exec R8 ip -6 route add cafe:1::/64 via cafe:7::3
    ip netns exec R8 ip -6 route add cafe:2::/64 via cafe:7::3
    ip netns exec R8 ip -6 route add cafe:3::/64 via cafe:7::3
    ip netns exec R8 ip -6 route add cafe:4::/64 via cafe:7::3
    ip netns exec R8 ip -6 route add cafe:5::/64 via cafe:7::3
    ip netns exec R8 ip -6 route add cafe:6::/64 via cafe:7::3
    ip netns exec R8 ip -6 route add cafe:7::/64 via cafe:7::3
    ip netns exec R8 ip -6 route add fc00:1::/64 via cafe:7::3
    ip netns exec R8 ip -6 route add fc00:2::/64 via cafe:7::3
    ip netns exec R8 ip -6 route add fc00:3::/64 via cafe:7::3
    ip netns exec R8 ip -6 route add fc00:4::/64 via cafe:7::3
    ip netns exec R8 ip -6 route add fc00:5::/64 via cafe:7::3
    ip netns exec R8 ip -6 route add fc00:6::/64 via cafe:7::3
    ip netns exec R8 ip -6 route add fc00:7::/64 via cafe:7::3

elif [ $1 = "srv6" ]; then
    echo ">> Setting SRv6 <<"
    ip netns exec R2 sysctl net.ipv6.conf.all.disable_ipv6=0
    ip netns exec R2 sysctl net.ipv6.conf.all.seg6_enabled=1
    ip netns exec R2 sysctl net.ipv6.conf.default.forwarding=1
    ip netns exec R2 sysctl net.ipv6.conf.default.disable_ipv6=0
    ip netns exec R2 sysctl net.ipv6.conf.default.seg6_enabled=1
    ip netns exec R2 sysctl net.ipv6.conf.R2-net0.seg6_enabled=1
    ip netns exec R2 sysctl net.ipv6.conf.R2-net1.seg6_enabled=1
    
    ip netns exec R3 sysctl net.ipv6.conf.all.disable_ipv6=0
    ip netns exec R3 sysctl net.ipv6.conf.all.seg6_enabled=1
    ip netns exec R3 sysctl net.ipv6.conf.default.forwarding=1
    ip netns exec R3 sysctl net.ipv6.conf.default.disable_ipv6=0
    ip netns exec R3 sysctl net.ipv6.conf.default.seg6_enabled=1
    ip netns exec R3 sysctl net.ipv6.conf.R3-net0.seg6_enabled=1
    ip netns exec R3 sysctl net.ipv6.conf.R3-net1.seg6_enabled=1

    ip netns exec R4 sysctl net.ipv6.conf.all.disable_ipv6=0
    ip netns exec R4 sysctl net.ipv6.conf.all.seg6_enabled=1
    ip netns exec R4 sysctl net.ipv6.conf.default.forwarding=1
    ip netns exec R4 sysctl net.ipv6.conf.default.disable_ipv6=0
    ip netns exec R4 sysctl net.ipv6.conf.default.seg6_enabled=1
    ip netns exec R4 sysctl net.ipv6.conf.R4-net0.seg6_enabled=1
    ip netns exec R4 sysctl net.ipv6.conf.R4-net1.seg6_enabled=1

    ip netns exec R6 sysctl net.ipv6.conf.all.disable_ipv6=0
    ip netns exec R6 sysctl net.ipv6.conf.all.seg6_enabled=1
    ip netns exec R6 sysctl net.ipv6.conf.default.forwarding=1
    ip netns exec R6 sysctl net.ipv6.conf.default.disable_ipv6=0
    ip netns exec R6 sysctl net.ipv6.conf.default.seg6_enabled=1
    ip netns exec R6 sysctl net.ipv6.conf.R6-net0.seg6_enabled=1

    ip netns exec R7 sysctl net.ipv6.conf.all.disable_ipv6=0
    ip netns exec R7 sysctl net.ipv6.conf.all.seg6_enabled=1
    ip netns exec R7 sysctl net.ipv6.conf.default.forwarding=1
    ip netns exec R7 sysctl net.ipv6.conf.default.disable_ipv6=0
    ip netns exec R7 sysctl net.ipv6.conf.default.seg6_enabled=1
    ip netns exec R7 sysctl net.ipv6.conf.R7-net0.seg6_enabled=1

    ip netns exec R8 sysctl net.ipv6.conf.all.disable_ipv6=0
    ip netns exec R8 sysctl net.ipv6.conf.all.seg6_enabled=1
    ip netns exec R8 sysctl net.ipv6.conf.default.forwarding=1
    ip netns exec R8 sysctl net.ipv6.conf.default.disable_ipv6=0
    ip netns exec R8 sysctl net.ipv6.conf.default.seg6_enabled=1
    ip netns exec R8 sysctl net.ipv6.conf.R8-net0.seg6_enabled=1

    ip netns exec R2 ip route add cafe:4::5 encap seg6 mode encap segs fc00:6::1,fc00:7::1,fc00:4::1 dev R2-net0
    ip netns exec R4 ip route add fc00:4::1/128 encap seg6local action End.DX6 nh6 cafe:4::5 dev R4-net0
    ip netns exec R6 ip route add fc00:6::1/128 encap seg6local action End dev R6-net0
    ip netns exec R7 ip route add fc00:7::1/128 encap seg6local action End dev R7-net0
    ip netns exec R8 ip route add fc00:8::1/128 encap seg6local action End dev R8-net0

elif [ $1 = "del" ]; then
    echo ">> Delete <<"
    ip -all netns delete

elif [ $1 = "p2p" ]; then
    echo ">> Test p2p <<"
    ip netns exec R1 ping -c2 cafe:1::2
    ip netns exec R2 ping -c2 cafe:1::1
    ip netns exec R2 ping -c2 cafe:2::3
    ip netns exec R3 ping -c2 cafe:2::2
    ip netns exec R3 ping -c2 cafe:3::4
    ip netns exec R4 ping -c2 cafe:3::3
    ip netns exec R4 ping -c2 cafe:4::5
    ip netns exec R5 ping -c2 cafe:4::4
    ip netns exec R3 ping -c2 cafe:5::6
    ip netns exec R6 ping -c2 cafe:5::3
    ip netns exec R3 ping -c2 cafe:6::7
    ip netns exec R7 ping -c2 cafe:6::3
    ip netns exec R3 ping -c2 cafe:7::8
    ip netns exec R8 ping -c2 cafe:7::3

elif [ $1 = "remote" ]; then
    echo ">> Test Remote <<"
    ip netns exec R1 ping -c2 cafe:2::3
    ip netns exec R1 ping -c2 cafe:3::4
    ip netns exec R1 ping -c2 cafe:4::5
    ip netns exec R1 ping -c2 cafe:5::6
    ip netns exec R1 ping -c2 cafe:6::7
    ip netns exec R1 ping -c2 cafe:7::8
    ip netns exec R5 ping -c2 cafe:1::1
    ip netns exec R5 ping -c2 cafe:2::2
    ip netns exec R5 ping -c2 cafe:3::3
    ip netns exec R5 ping -c2 cafe:5::6
    ip netns exec R5 ping -c2 cafe:6::7
    ip netns exec R5 ping -c2 cafe:7::8

else 
    echo ">> Argment Error <<"
fi



















