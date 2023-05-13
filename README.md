# iPerfCableTest


# Version 2
 this now has 5 args, 
 eth1 eth2 threadcount mtu time 
 
 eth1 and eth2 the interface names 

threadcound should be total expected bandwidth/10 then you might need to optimise, going above the number of actual cores is not a great idea in general, and if you are using QSF's then a minimum of 4 is recomended. 

 10G = 1 
 
 40G = 4
 
 100G = 8 or 12
 
mtu is usually 1500 but can be set upto 9000 usually - see jumbo frames for more info online. not all NIC's/Networks support larger frame sizes. 
 
time - in seconds for longer or shorter testing. 
 
also added the interval of 10 for anything longer to give some feedback so you can see it's actually running. 

# Expected results with mtu at 1500

1G = 940Mb/s

10G = 9.3Gb/s

40G = 37.5 Gb/s
