package require TclOO
namespace import oo::*
catch {Inglist destroy} ;# no repeated sourcing
catch {Product destroy}

class create Inglist {

	constructor {} {
		# my references the instance:
		my variable plist
		set plist [ list ]
	}

	method addProduct { product } {
		# "import" variable
		my variable plist
		lappend plist $product
	}

	method dump {} {
		my variable plist
		foreach product $plist {
			$product dump
		}
	}

	# Searches for all products which contain this allergen:
	method findProducts { allergen } {
		my variable plist
		set s [ list ]

		foreach product $plist {
			if { [ $p ca $allergen ] } {
				lappend $s $p
			}
		}

		puts $s
	}

	method nextAllergen {} {
		my variable plist
		foreach p $plist {
			if { [ $p hasAllergens ] } { 
				return [ $p firstAllergen ]
			}
		}
	}
	
}

class create Product {

	constructor { ingredients knownAllergenes } {
		my variable i a
		set i $ingredients
		set a $knownAllergenes
	}

	method dump {} {
		my variable i a
		puts "$i ($a)"
	}

	method firstAllergen {} {
		my variable a
		return [ lindex $a 0 ]
	}

	method hasAllergens {} {
		my variable a
		return [ llength $a ]
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
