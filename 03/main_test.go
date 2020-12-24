package main

import "testing"

func TestIsTree(t *testing.T) {
	var l Landscape = LandscapeFromFile("input1.txt")
	testIsTree(&l, Pos{0, 0}, false, t)
	testIsTree(&l, Pos{2, 0}, true, t)
	testIsTree(&l, Pos{0, 1}, true, t)
	testIsTree(&l, Pos{11, 0}, false, t)
	testIsTree(&l, Pos{13, 0}, true, t)
	testIsTree(&l, Pos{10, 10}, true, t)
}

func testIsTree(l *Landscape, p Pos, expected bool, t *testing.T) {
	var should bool = l.IsTree(p)
	if should != expected {
		t.Errorf("IsTree() should be %t for %s, it isn't\n",
			expected, p.String())
		t.Logf("Landscape is:\n01234567890123456789\n%s\n", l.String())
	}
	t.Logf("Success for %s", p.String())
}

func TestArbitrarySlice(t *testing.T) {
	var s []string
	for len(s) <= 5 {
		s = append(s, "")
	}
	s[5] = "asdf"
	s = append(s, "qwertz")

	t.Log(s)

	/*var i int
	var v string
	for i, v = range s {
		t.Logf("%d => %s", i, v)
	}*/
}

func setRuneUsingRuneArray(s string, i int, r rune) string {
	var arr []rune = []rune(s)
	arr[i] = r
	return string(arr)
}

func BenchmarkArbitraryStringRuneArray(b *testing.B) {
	var start string = "erwihsaiuwreohgsd"
	var end string
	var idx int = 5
	var r rune = 'q'
	for i := 0; i < b.N; i++ {
		end = setRuneUsingRuneArray(start, idx, r)
	}
	_ = end
}

func BenchmarkArbitraryStringSubstring(b *testing.B) {
	var start string = "erwihsaiuwreohgsd"
	var end string
	var idx int = 5
	var r rune = 'q'
	for i := 0; i < b.N; i++ {
		end = setRuneUsingSubstring(start, idx, r)
	}
	_ = end
}

func TestArbitraryStringSubstring(t *testing.T) {
	t.Logf("Replacing #%d in %s with %c: %s", 2, "asdf", 'q',
		setRuneUsingSubstring("asdf", 2, 'q'))
}
