package main

import "testing"
import "strings"
import "math/rand"
import "time"

func TestBasicMovements(t *testing.T) {
	testSeq("nwwswee", Pos{0, 0}, t)
	testSeq("esew", Pos{0, -1}, t)
	testSeq("esewnw", Pos{0, 0}, t)
}

func testSeq(seq string, expected Pos, t *testing.T) bool {
	var got Pos = SeqToPos(seq)
	if got != expected {
		t.Errorf("Fail: Sequence %s should be %s, got %s instead", seq,
			expected, got.String())
		return false
	}
	t.Logf("Success for %s", seq)
	return true
}

func TestNullingSeq(t *testing.T) {
	testSeq(genNullingSeq(3), Pos{0, 0}, t)
	testSeq(genNullingSeq(3), Pos{0, 0}, t)
	testSeq(genNullingSeq(5), Pos{0, 0}, t)
	testSeq(genNullingSeq(5), Pos{0, 0}, t)
	testSeq(genNullingSeq(8), Pos{0, 0}, t)
	testSeq(genNullingSeq(8), Pos{0, 0}, t)
}

var moves []string = []string{"w", "e", "nw", "ne", "sw", "se"}

// A sequence that corresponds to [0, 0], e. g. cancels itself:
func genNullingSeq(n int) string {
	rand.Seed(time.Now().UnixNano())
	var there []string
	var back []string
	var i, r int
	for i = 0; i < n; i++ {
		r = rand.Intn(len(moves))
		there = append(there, moves[r])
		back = append(back, invertMove(moves[r]))
	}

	var roundtrip []string = append(there, back...)

	rand.Shuffle(len(roundtrip), func(i int, j int) {
		roundtrip[i], roundtrip[j] = roundtrip[j], roundtrip[i]
	})

	return strings.Join(roundtrip, "")
}

func TestInverter(t *testing.T) {
	testInvert("nwnese", "seswnw", t)
}

func testInvert(seq string, inv string, t *testing.T) bool {
	var got string = invertMove(seq)
	if got != inv {
		t.Errorf("Fail: %s should be inverted to %s, got %s instead",
			seq, inv, got)
		return false
	}
	return true
}

func invertMove(move string) string {
	move = strings.Replace(move, "n", "x", -1)
	move = strings.Replace(move, "s", "n", -1)
	move = strings.Replace(move, "x", "s", -1)
	move = strings.Replace(move, "e", "x", -1)
	move = strings.Replace(move, "w", "e", -1)
	move = strings.Replace(move, "x", "w", -1)
	return move
}
