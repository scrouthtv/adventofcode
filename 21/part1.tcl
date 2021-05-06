#!/usr/bin/env tclsh

source inglist.tcl

set l [Inglist new]

$l addProduct [ Product new { "sqjhc" "fvjkl" } { "soy" } ]
$l addProduct [ Product new { "sqjhc" "fvjkl" "sbzzf" } { "fish" } ]
$l dump
#set p [ Product new { "sqjhc" "fvjkl" } { "soy" } ]
