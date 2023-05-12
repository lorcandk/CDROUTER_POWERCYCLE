#!/usr/bin/expect
# powerCycle.tcl script for CyberPower PDU15SWHVIEC8FNET

set address [ lindex $argv 0 ]
set outlet [ lindex $argv 1 ]
set user [ lindex $argv 2 ]
set password [ lindex $argv 3 ]

set timeout 20

if { $outlet <= 0 || $outlet > 8 } {
   puts "powerCycle.tcl failure: selected power outlet index was $outlet; must be between 1 and 8."
   exit
}

spawn telnet "$address"
expect "Login Name:"
send "$user\r";
sleep 1
expect "Login_Pass:"
send "$password\r";

expect {
        "> " {
        sleep 1
# Select Device Manager
        send 1\r

        expect "> "
        sleep 1
# Select Outlet Control
        send 2\r

        expect "> "
        sleep 1
# Select Start a Control Command
        send 1\r

        expect "> "
        sleep 1
# Input Outlet Number
        send $outlet
        send \r

        expect "> "
        sleep 1
# 1=turn on, 2=turn off, 3=reboot
        send 3\r

        expect "> "
        sleep 1
# Input yes to execute
        send yes\r
        sleep 1
        send "<ESC>\r"
        sleep 1
        send "<ESC>\r"
        sleep 1
# Logout
        send "4"

        puts "powerCycle.tcl success: outlet $outlet on host $address successfully power cycled."

        exit
     }
     "Unable to connect to remote host" {
        puts "powerCycle.tcl failure: unable to connect to the remote host."
        exit
     }
     timeout {
      puts "powerCycle.tcl failure: connection timed out."
      exit
   }
}
