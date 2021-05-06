#!/usr/bin/env tclsh

source inglist.tcl

set f [ open "test1.txt" r ]
set l [Inglist new]

$l addProduct [ Product new {aadf ak} {} ]

while { [ gets $f line ] >= 0 } {
	set p [ string first "(" $line ]
	if { $p == -1 } { continue }
	set ing [ split [ string range $line 0 $p-2 ] " " ]
	set allerg [ string map { ", " "," } [ string range $line $p+10 end-1 ]  ]
	set allerg [ split $allerg "," ]
	$l addProduct [ Product new $ing $allerg ]
}

close $f

set a [ $l nextAllergen ]
puts [ $l findProducts $a ]
