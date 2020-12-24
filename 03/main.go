package main

import "fmt"
import "bufio"
import "os"

type Pos struct {
	x int
	y int
}

func (p *Pos) String() string {
	return fmt.Sprintf("[%dx%d]", p.x, p.y)
}

type Landscape struct {
	trees  []Pos
	width  int
	height int
}

func main() {
	var l Landscape = LandscapeFromFile("input")

	fmt.Printf("Hit %d trees using 3/1\n", l.Sleigh(3, 1))
	fmt.Printf("Hit %d trees using 1/1\n", l.Sleigh(1, 1))
	fmt.Printf("Hit %d trees using 5/1\n", l.Sleigh(5, 1))
	fmt.Printf("Hit %d trees using 7/1\n", l.Sleigh(7, 1))
	fmt.Printf("Hit %d trees using 1/2\n", l.Sleigh(1, 2))
}

func (l *Landscape) Sleigh(dx int, dy int) int {
	var player Pos = Pos{0, 0}

	var hits int = 0

	for player.y <= l.Height() {
		player = Pos{player.x + dx, player.y + dy}
		if l.IsTree(player) {
			hits++
		}
	}

	return hits
}

func LandscapeFromFile(path string) Landscape {
	var err error
	var f *os.File
	f, err = os.Open(path)
	if err != nil {
		panic(err)
	}

	var width int = 0
	var trees []Pos = []Pos{}
	var scanner *bufio.Scanner = bufio.NewScanner(f)
	var x, y int = 0, 0
	var line string
	for scanner.Scan() {
		line = scanner.Text()
		if len(line) > width {
			width = len(line)
		}
		for _, x = range allIndices(line, '#') {
			trees = append(trees, Pos{x, y})
		}

		y++
	}

	var l Landscape = Landscape{trees, width, y}
	return l
}

func (l *Landscape) Width() int {
	return l.width
}

func (l *Landscape) Height() int {
	return l.height
}

func (l *Landscape) IsTree(p Pos) bool {
	p = Pos{p.x % l.Width(), p.y}

	var tree Pos
	for _, tree = range l.trees {
		if tree == p {
			return true
		}
	}
	return false
}

func allIndices(s string, search rune) []int {
	var ai []int

	var i int
	var r rune
	for i, r = range s {
		if r == search {
			ai = append(ai, i)
		}
	}

	return ai
}
