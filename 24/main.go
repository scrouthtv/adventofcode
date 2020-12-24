package main

import "fmt"
import "os"
import "bufio"

var flipped map[Pos]bool = make(map[Pos]bool)

func main() {
	const path string = "input"
	var f *os.File
	var err error
	f, err = os.Open(path)
	if err != nil {
		panic(err)
	}
	defer f.Close()

	var scanner *bufio.Scanner
	scanner = bufio.NewScanner(f)
	var line string
	var p Pos
	for scanner.Scan() {
		line = scanner.Text()
		p = SeqToPos(line)
		flipTile(p)
	}

	var v bool
	var white, black int = 0, 0
	for p, v = range flipped {
		if v {
			//fmt.Println(p)
			white++
		} else {
			black++
		}
	}
	fmt.Printf("Total of %d are flipped to black, %d are still white\n",
		white, black)
}

func flipTile(p Pos) {
	var v, ok bool = flipped[p]
	if !ok {
		flipped[p] = true
	} else {
		flipped[p] = !v
	}
}

func SeqToPos(seq string) Pos {
	var p Pos = Pos{0, 0}

	var i int
	for i = 0; i < len(seq); i++ {
		switch seq[i] {
		case 'e':
			p = p.East()
		case 'w':
			p = p.West()
		case 's':
			i++
			switch seq[i] {
			case 'e':
				p = p.Southeast()
			case 'w':
				p = p.Southwest()
			}
		case 'n':
			i++
			switch seq[i] {
			case 'e':
				p = p.Northeast()
			case 'w':
				p = p.Northwest()
			}
		}
	}

	return p
}
