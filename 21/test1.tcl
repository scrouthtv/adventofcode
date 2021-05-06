#!/usr/bin/env tclsh

source inglist.tcl

set p [ Product new { "sqjhc" "fvjkl" } { "soy" } ]
$p dump
if { [ $p ca soy ] } {
	puts "yes"
} else {
	puts "no"
}
