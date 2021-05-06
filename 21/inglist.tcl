package require TclOO
package require Tcl 8.0
package require struct::set
namespace import oo::*
catch {Inglist destroy} ;# no repeated sourcing
catch {Product destroy}

class create Inglist {

	constructor {} {
		# my references the instance:
		my variable plist alist ai
		set plist [ list ]
		set alist [ list ]
		set ai -1
	}

	method addProduct { product } {
		# "import" variable:
		my variable plist alist
		lappend plist $product

		foreach i [ $product getAllergenes ] {
			if { [ expr [ lsearch -exact $alist $i ] eq -1 ] } {
				lappend alist $i
			}
		}
	}

	method dump {} {
		my variable plist alist
		foreach product $plist {
			$product dump
		}
		puts "Allergenes: $alist"
	}

	# Searches for all products which contain this allergen,
	# collects each poduct's ingredients
	method findProducts { allergen } {
		my variable plist
		set s [ list ]

		foreach p $plist {
			if { [ $p ca $allergen ] } {
				lappend s [ $p getIngredients ]
			}
		}

		return $s
	}

	method findCommonIngredient { products } {
		set candidates [ lindex $products 0 ]
		for { set i 1 } { $i < [ llength $products ] } { incr i } {
			set candidates [ ::struct::set intersect $candidates [ lindex $products $i ] ]
		}

		return $candidates
	}

	method removeIngredientAllergenPair { i a } {
		my variable plist alist
		foreach p $plist {
			$p removeIngredient $i
			$p removeAllergen $a
		}

		# Remove allergen from alist:
		set idx [ lsearch  -exact $alist $a ]
		set alist [ lreplace $alist $idx $idx ]
	}

	method hasAllergen {} {
		my variable plist
		foreach p $plist {
			if { [ $p hasAllergens ] } {
				return true
			}
		}

		return false
	}

	method nextAllergen {} {
		my variable alist ai
		incr ai
		if { [ expr $ai >= [ llength $alist ] ] } {
			set ai 0
		}
		return [ lindex $alist $ai  ]
	}

	method countIngredientAppearances {} {
		my variable plist
		set app 0
		foreach p $plist {
			set app [ expr $app + [ llength [ $p getIngredients ] ] ]
		}
		return $app
	}

}

class create Product {

	constructor { ingredients knownAllergenes } {
		my variable i a
		set i $ingredients
		set a $knownAllergenes
	}

	method removeIngredient { ingredient } {
		my variable i
		set idx [ lsearch  -exact $i $ingredient ]
		set i [ lreplace $i $idx $idx ]
	}

	method removeAllergen { allergen } {
		my variable a
		set idx [ lsearch -exact $a $allergen ]
		set a [ lreplace $a $idx $idx ]
	}

	method dump {} {
		my variable i a
		puts "$i ($a)"
	}

	method hasAllergens {} {
		my variable a
		return [ llength $a ]
	}

	method getIngredients {} {
		my variable i
		return $i
	}

	method getAllergenes {} {
		my variable a
		return $a
	}

	# Contains ingredient?
	method ci { ingredient } {
		my variable i
		return [ expr [ lsearch -exact $i $ingredient ] != -1 ]
	}

	# Contains allergen?
	method ca { allergen } {
		my variable a
		return [ expr [ lsearch -exact $a $allergen ] != -1 ]
	}

}
