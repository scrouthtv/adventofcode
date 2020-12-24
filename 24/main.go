package main

import "fmt"
import "os"
import "bufio"

var room Room = make(map[Pos]bool)

func main() {
	const path string = "input"
	var f *os.File
	var err error
	f, err = os.Open(path)
	if err != nil {
		panic(err)
	}

	var scanner *bufio.Scanner
	scanner = bufio.NewScanner(f)
	var line string
	var p Pos
	for scanner.Scan() {
		line = scanner.Text()
		p = SeqToPos(line)
		flipTile(p)
	}
	f.Close()

	fmt.Println(room.String())

	var i int
	for i = 1; i <= 100; i++ {
		room = room.TickOnce()
		if i <= 10 || i%10 == 0 {
			fmt.Printf("Day %d: %s\n", i, room.String())
		}
	}
}

func flipTile(p Pos) {
	var v, ok bool = room[p]
	if !ok {
		room[p] = true
	} else {
		room[p] = !v
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
