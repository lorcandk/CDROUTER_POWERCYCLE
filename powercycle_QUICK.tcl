#!/usr/bin/expect
# powerCycle_GE-WAN.tcl script for CyberPower PDU15SWHVIEC8FNET
# shutdown all DUT
# turn on DUT and GE-WAN switch
set address [ lindex $argv 0 ]
set outlet [ lindex $argv 1 ]
set user [ lindex $argv 2 ]
set password [ lindex $argv 3 ]

set timeout 20

if { $outlet <= 0 || $outlet > 8 } {
   puts "powerCycle_GE-WAN.tcl failure: selected power outlet index was $outlet; must be between 1 and 8."
   exit
}

spawn telnet "$address"
expect "Login Name:"
send "$user\r";
sleep 1
expect "Login_Pass:"
send "$password\r";

# Reboot DUT only

expect {	
	"> " {
	sleep 1	
# Select Device Manager
	send "1\r"

	expect "> "
	sleep 1	
# Select Outlet Control
	send "2\r"

	expect "> "
	sleep 1	

### Select Start a Control Command
        send "1\r"

        expect "> "
        sleep 1
# Input Outlet Number (8=GE-WAN switch)
        send "$outlet\r"

        expect "> "
        sleep 1
# 1=turn on, 2=turn off, 3=reboot
        send "3\r"

        expect "> "
        sleep 1
# Input yes to execute
        send "yes\r"

	sleep 1	

	puts "powerCycle_QUICK.tcl: outlet $outlet REBOOTED"

	send "<ESC>\r"
	sleep 1	
	send "<ESC>\r"
	sleep 1	
# Logout
	send "4"

	exit
     }
     "Unable to connect to remote host" {
	puts "powerCycle_QUICK.tcl failure: unable to connect to the remote host."            
	exit
     }
     timeout {
      puts "powerCycle_QUICK.tcl failure: connection timed out."  
      exit 
   }
}
