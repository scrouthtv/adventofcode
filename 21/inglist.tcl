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

	method ci { ingredient } {
		my variable i
		return [ lsearch -exact $i $ingredient ]
	}

	method ca { allergen } {
		my variable a
		return [ lsearch -not -exact $a $allergen ]
	}

}
