package main

import "strings"

func (l *Landscape) String() string {
	var lines []string
	var p Pos

	var i int
	var alldots string
	for i = 0; i < l.Width(); i++ {
		alldots += "."
	}

	for _, p = range (*l).trees {
		for len(lines) <= p.y {
			lines = append(lines, alldots)
		}
		lines[p.y] = setRuneUsingSubstring(lines[p.y], p.x, '#')
	}

	return strings.Join(lines, "\n")
}

func setRuneUsingSubstring(s string, i int, r rune) string {
	return s[:i] + string(r) + s[i+1:]
}
