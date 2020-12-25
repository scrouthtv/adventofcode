package main

import "testing"
import "math/big"

func TestWHAT(t *testing.T) {
	var arr []*big.Int = []*big.Int{
		big.NewInt(18),
		big.NewInt(12),
		big.NewInt(7),
		big.NewInt(1),
		big.NewInt(9),
		big.NewInt(9),
		big.NewInt(6),
		big.NewInt(11),
	}

	t.Log(arr)

	arr[5] = big.NewInt(16)
	t.Log(arr)

	var i *big.Int = big.NewInt(67)
	arr[3].Set(i)
	t.Log(arr)

	i.Add(i, INTONE)
	arr[4].Set(i)
	t.Log(arr)
}

func TestBigIntArray(t *testing.T) {
	var i *big.Int = big.NewInt(0)
	var pi int
	var publics []*big.Int = []*big.Int{
		big.NewInt(18),
		big.NewInt(12),
		big.NewInt(7),
		big.NewInt(1),
		big.NewInt(9),
		big.NewInt(9),
		big.NewInt(6),
		big.NewInt(11),
	}
	var public *big.Int

	var secrets []*big.Int = make([]*big.Int, len(publics))
	for pi = 0; pi < len(publics); pi++ {
		secrets[pi] = big.NewInt(-1)
	}

	for i = big.NewInt(0); i.Cmp(big.NewInt(20)) < 0; i.Add(i, INTONE) {
		t.Logf("Run #%d", i)
		t.Log(secrets)
		for pi, public = range publics {
			if i.Cmp(public) == 0 && secrets[pi].Cmp(INTMINUSONE) == 0 {
				t.Logf("Found secret for device %d: %d\n", pi, i)
				secrets[pi].Set(i)
				t.Log(secrets)
			}
		}
	}
}
