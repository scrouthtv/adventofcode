package main

import "fmt"
import "os"
import "bufio"

var flipped map[Pos]bool = make(map[Pos]bool)

func main() {
	fmt.Println("nwwswee:", SeqToPos("nwwswee"))
	fmt.Println("esew:", SeqToPos("esew"))
	fmt.Println("esewnw:", SeqToPos("esewnw"))
	os.Exit(0)
	const path string = "in1.txt"
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
		fmt.Println(p)
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
