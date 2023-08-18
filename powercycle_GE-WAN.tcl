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

######## turn off all outlets including DSLAM (5) and excluding WAN switch (8) #######

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
# Select Start a Control Command
	send "1\r"	

	expect "> "
	sleep 1	
# Input Outlet Number
	send "1\r"
	expect "> "
	sleep 1	
# 1=turn on, 2=turn off, 3=reboot
	send "2\r"		

	expect "> "
	sleep 1	
# Input yes to execute
	send "yes\r"
	sleep 1	

        expect "> "
        sleep 1

	puts "powerCycle_GE-WAN.tcl: outlet 1 turned OFF."

# Select Start a Control Command
        send "1\r"

        expect "> "
        sleep 1
# Input Outlet Number (8=GE-WAN switch)
        send "2\r"

        expect "> "
        sleep 1
# 1=turn on, 2=turn off, 3=reboot
        send "2\r"

        expect "> "
        sleep 1
# Input yes to execute
        send "yes\r"

        expect "> "
        sleep 1

        puts "powerCycle_GE-WAN.tcl: outlet 2 turned OFF."


# Select Start a Control Command
        send "1\r"

        expect "> "
        sleep 1
# Input Outlet Number (8=GE-WAN switch)
        send "3\r"

        expect "> "
        sleep 1
# 1=turn on, 2=turn off, 3=reboot
        send "2\r"

        expect "> "
        sleep 1
# Input yes to execute
        send "yes\r"

        expect "> "
        sleep 1

        puts "powerCycle_GE-WAN.tcl: outlet 3 turned OFF."


# Select Start a Control Command
        send "1\r"

        expect "> "
        sleep 1
# Input Outlet Number (8=GE-WAN switch)
        send "4\r"

        expect "> "
        sleep 1
# 1=turn on, 2=turn off, 3=reboot
        send "2\r"

        expect "> "
        sleep 1
# Input yes to execute
        send "yes\r"

        expect "> "
        sleep 1

        puts "powerCycle_GE-WAN.tcl: outlet 4 turned OFF."


# Select Start a Control Command
        send "1\r"

        expect "> "
        sleep 1
# Input Outlet Number (8=GE-WAN switch)
        send "5\r"

        expect "> "
        sleep 1
# 1=turn on, 2=turn off, 3=reboot
        send "2\r"

        expect "> "
        sleep 1
# Input yes to execute
        send "yes\r"

        expect "> "
        sleep 1

        puts "powerCycle_GE-WAN.tcl: outlet 5 turned OFF."


# Select Start a Control Command
        send "1\r"

        expect "> "
        sleep 1
# Input Outlet Number (8=GE-WAN switch)
        send "6\r"

        expect "> "
        sleep 1
# 1=turn on, 2=turn off, 3=reboot
        send "2\r"

        expect "> "
        sleep 1
# Input yes to execute
        send "yes\r"

        expect "> "
        sleep 1

        puts "powerCycle_GE-WAN.tcl: outlet 6 turned OFF."


# Select Start a Control Command
        send "1\r"

        expect "> "
        sleep 1
# Input Outlet Number (8=GE-WAN switch)
        send "7\r"

        expect "> "
        sleep 1
# 1=turn on, 2=turn off, 3=reboot
        send "2\r"

        expect "> "
        sleep 1
# Input yes to execute
        send "yes\r"

        expect "> "
        sleep 1

        puts "powerCycle_GE-WAN.tcl: outlet 7 turned OFF."


####### TURN ON SWITCH AND DUT ########

	
# Select Start a Control Command
	send "1\r"	

	expect "> "
	sleep 1	
# Input Outlet Number (8=GE-WAN switch)
	send "8\r"

	expect "> "
	sleep 1	
# 1=turn on, 2=turn off, 3=reboot
	send "1\r"		

	expect "> "
	sleep 1	
# Input yes to execute
	send "yes\r"

        expect "> "
        sleep 1

	puts "powerCycle_GE-WAN.tcl: outlet 8 (WAN Switch) turned ON."

# Select Start a Control Command
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

        expect "> "
        sleep 1

	puts "powerCycle_GE-WAN.tcl: outlet $outlet REBOOTED"

	send "<ESC>\r"
	sleep 1	
	send "<ESC>\r"
	sleep 1	
# Logout
	send "4"

	sleep 1	
	exit
     }
     "Unable to connect to remote host" {
	puts "powerCycle_GE-WAN.tcl failure: unable to connect to the remote host."            
	exit
     }
     timeout {
      puts "powerCycle_GE-WAN.tcl failure: connection timed out."  
      exit 
   }
}
