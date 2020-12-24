package main

import "fmt"

type Room map[Pos]bool

func (r *Room) Corners() (Pos, Pos) {
	var minx, miny, maxx, maxy int
	var p Pos
	for p, _ = range *r {
		if p.x < minx {
			minx = p.x
		} else if p.x > maxx {
			maxx = p.x
		}
		if p.y < miny {
			miny = p.y
		} else if p.y > maxy {
			maxy = p.y
		}
	}
	return Pos{maxx, maxy}, Pos{minx, miny}
}

func (r *Room) String() string {
	var v bool
	var white, black int = 0, 0
	for _, v = range room {
		if v {
			white++
		} else {
			black++
		}
	}
	//nw, se := r.Corners()
	//fmt.Printf("nw: %s, se: %s\n", nw, se)
	return fmt.Sprintf("Total of %d are flipped to black, %d are still white",
		white, black)
}

func (r *Room) TickOnce() Room {
	var next Room = make(map[Pos]bool)
	var p Pos
	var adjBlacks, adjWhites []Pos
	var contains bool
	for _, p = range r.Blacks() {
		_, contains = next[p]
		if contains {
			continue
		}
		adjBlacks = r.FilterBlacks(p.Adjacents(), true)
		if len(adjBlacks) == 0 || len(adjBlacks) > 2 {
			// p should be white
			next[p] = false
		} else {
			// p should be black
			next[p] = true
		}

		// check for adjacent white tiles as only these are possible
		// candidates for turning black:
		if len(adjBlacks) < 5 {
			adjWhites = r.FilterBlacks(p.Adjacents(), false)
			var wp Pos
			for _, wp = range adjWhites {
				_, contains = next[wp]
				if contains {
					continue
				}
				adjBlacks = r.FilterBlacks(wp.Adjacents(), true)
				if len(adjBlacks) == 2 {
					// wp should be black
					next[wp] = true
				}
			}
		}
	}
	return next
}

// Returns all pos in ps that have the same value as should
// black = true
func (r *Room) FilterBlacks(ps []Pos, should bool) []Pos {
	var p Pos
	var filter []Pos
	for _, p = range ps {
		if (*r)[p] == should {
			filter = append(filter, p)
		}
	}
	return filter
}

func (r *Room) Blacks() []Pos {
	var v bool
	var p Pos
	var blacks []Pos
	for p, v = range room {
		if v {
			blacks = append(blacks, p)
		}
	}
	return blacks
}
