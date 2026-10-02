#!/usr/bin/expect
# powerCycle_GE-WAN.tcl script for CyberPower PDU15SWHVIEC8FNET
# shutdown all DUT
# turn on DUT and GE-WAN switch
#set outlet [ lindex $argv 1 ]

set outlet [lindex $argv 0]

set url "http://192.168.88.185/ALLOFF"

set result [exec curl -sS $url]

puts "URL: $url"
puts "Result:"
puts $result

