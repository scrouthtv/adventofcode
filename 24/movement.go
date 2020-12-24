package main

import "fmt"

// position relative to the reference tile
type Pos struct {
	x int
	y int
}

func (p Pos) Adjacents() []Pos {
	return []Pos{
		p.East(), p.West(),
		p.Southeast(), p.Southwest(),
		p.Northeast(), p.Northwest(),
	}
}

func (p Pos) String() string {
	return fmt.Sprintf("[%dx%d]", p.x, p.y)
}

func (p Pos) East() Pos {
	return Pos{p.x + 1, p.y}
}

func (p Pos) West() Pos {
	return Pos{p.x - 1, p.y}
}

func (p Pos) Southeast() Pos {
	if p.y%2 == 0 {
		return Pos{p.x, p.y - 1}
	} else {
		return Pos{p.x + 1, p.y - 1}
	}
}

func (p Pos) Southwest() Pos {
	if p.y%2 == 0 {
		return Pos{p.x - 1, p.y - 1}
	} else {
		return Pos{p.x, p.y - 1}
	}
}

func (p Pos) Northeast() Pos {
	if p.y%2 == 0 {
		return Pos{p.x, p.y + 1}
	} else {
		return Pos{p.x + 1, p.y + 1}
	}
}

func (p Pos) Northwest() Pos {
	if p.y%2 == 0 {
		return Pos{p.x - 1, p.y + 1}
	} else {
		return Pos{p.x, p.y + 1}
	}
}
