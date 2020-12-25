package main

import "math/big"
import "fmt"
import "time"

var INTZERO *big.Int = big.NewInt(0)
var INTONE *big.Int = big.NewInt(1)
var INTMINUSONE *big.Int = big.NewInt(-1)

func main() {
	//var subject *big.Int = big.NewInt(7)
	//var cardsecret *big.Int = big.NewInt(8)
	//var doorsecret *big.Int = big.NewInt(11)
	/*fmt.Printf("Card's public number: %d\n",
		GenPublicKey(subject, cardsecret))
	fmt.Printf("Door's public number: %d\n",
	GenPublicKey(subject, doorsecret))*/
	/*fmt.Printf("Card's loop number: %d\n",
		BruteSecret(subject, big.NewInt(335121)))
	fmt.Printf("Door's loop number: %d\n",
	BruteSecret(subject, big.NewInt(363891)))*/
	/*secrets := BruteMulti(subject,
		[]*big.Int{
			big.NewInt(335121), big.NewInt(363891),
		})
	var i int
	var v *big.Int
	for i, v = range secrets {
		fmt.Printf("Secret for device %d: %d (%d's loop size)\n", i, v, i)
	}*/
	// Card: loop size: 8156519, public: 335121
	// Door: loop size: 5062092, public: 363891

	fmt.Printf("Card's encryption key: %d\n",
		GenPublicKey(big.NewInt(363891), big.NewInt(8156519)))
	fmt.Printf("Door's encryption key: %d\n",
		GenPublicKey(big.NewInt(335121), big.NewInt(5062092)))
}

var divisor *big.Int = big.NewInt(20201227)

func GenPublicKey(subject *big.Int, secret *big.Int) *big.Int {
	var i *big.Int
	var value *big.Int = big.NewInt(1)
	for i = big.NewInt(0); i.Cmp(secret) == -1; i.Add(i, INTONE) {
		value.Mul(value, subject)
		value.Mod(value, divisor)
	}
	return value
}

// Returns -1 for all that weren't found
func BruteMulti(subject *big.Int, publics []*big.Int) []*big.Int {
	var i *big.Int = big.NewInt(0)
	var mypublic *big.Int = big.NewInt(1)
	var pi int
	var public *big.Int

	var missing int = len(publics)

	var secrets []*big.Int = make([]*big.Int, len(publics))
	for pi = 0; pi < len(publics); pi++ {
		secrets[pi] = big.NewInt(-1)
	}

	var end time.Time = time.Now().Add(time.Minute)

	for time.Now().Before(end) {
		for pi, public = range publics {
			if mypublic.Cmp(public) == 0 && secrets[pi].Cmp(INTMINUSONE) == 0 {
				fmt.Printf("Found secret for device %d: %d\n", pi, i)
				secrets[pi].Add(i, INTZERO)
				missing--
			}
		}
		if missing <= 0 {
			return secrets
		}

		mypublic.Mul(mypublic, subject)
		mypublic.Mod(mypublic, divisor)
		i.Add(i, INTONE)
	}
	return secrets
}
