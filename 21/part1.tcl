#!/usr/bin/env tclsh

source inglist.tcl

set f [ open "input" r ]
set l [Inglist new]

while { [ gets $f line ] >= 0 } {
	set p [ string first "(" $line ]
	if { $p == -1 } { continue }
	set ing [ split [ string range $line 0 $p-2 ] " " ]
	set allerg [ string map { ", " "," } [ string range $line $p+10 end-1 ]  ]
	set allerg [ split $allerg "," ]
	$l addProduct [ Product new $ing $allerg ]
}

close $f

while { [ $l hasAllergen ] } {
	set a [ $l nextAllergen ]
	set ps [ $l findProducts $a ]

	set common [ $l findCommonIngredient $ps ]
	if { [ expr [ llength $common ] > 1 ] } {
		puts "Couldn't uniquely identify ingredient for $a"
		puts "candidates: $common"
		exit 1
	}

	set ing [ lindex $common 0 ]
	$l removeIngredientAllergenPair $ing $a
	puts "--"
}
puts "clean ingredients: [ $l countIngredientAppearances ]"
