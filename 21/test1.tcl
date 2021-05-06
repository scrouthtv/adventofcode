#!/usr/bin/env tclsh

source inglist.tcl

set p [ Product new { "sqjhc" "fvjkl" } { "fish" "soy" } ]
$p dump

if { [ $p ca fish ] } {
	puts "yes"
} else {
	puts "no"
}
if { [ $p ca soy ] } {
	puts "yes"
} else {
	puts "no"
}
if { [ $p ca sugar ] } {
	puts "yes"
} else {
	puts "no"
}
