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

array set known_allergenes {}

while { [ $l hasAllergen ] } {
	set a [ $l nextAllergen ]
	set ps [ $l findProducts $a ]

	set common [ $l findCommonIngredient $ps ]
	if { [ expr [ llength $common ] == 1 ] } {
		set ing [ lindex $common 0 ]
		puts "Uniquely identified ingredient for $a: $ing"
		$l removeIngredientAllergenPair $ing $a
		set known_allergenes($ing) $a
	}

}

puts "clean ingredients: [ $l countIngredientAppearances ]"
set dangmap [ lsort -stride 2 -index 1 [ array get known_allergenes ] ]

set canolist ""
foreach { k v } $dangmap {
	append canolist $k ","
}
set canolist [ string range $canolist 0 end-1 ]
puts $canolist
