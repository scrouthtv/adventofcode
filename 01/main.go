package main

import "os"
import "bufio"
import "fmt"
import "strconv"
import "sort"

func main() {
	var f *os.File
	var err error
	f, err = os.Open("input")
	if err != nil {
		panic(err)
	}
	var scanner *bufio.Scanner = bufio.NewScanner(f)

	var num int
	var numbers []int = []int{}
	for scanner.Scan() {
		num, err = strconv.Atoi(scanner.Text())
		if err == nil {
			numbers = append(numbers, num)
		} else {
			fmt.Println(err)
		}
	}

	fmt.Println(FindTwoSummands(numbers, 2020))

}

func FindTwoSummands(numbers []int, sum int) (int, int, int) {
	sort.Slice(numbers, func(i int, j int) bool {
		return numbers[i] < numbers[j]
	})

	// assume there are no negative numbers, so we can
	// discard all numbers that are bigger than the sum we want:
	var j int = len(numbers) - 1
	for numbers[j] > sum {
		j--
	}
	numbers = numbers[:j+1]

	var i, k int
	for i = 0; i < len(numbers); i++ {
		for j = len(numbers) - 1; j >= i; j-- {
			for k = 0; k < len(numbers); k++ {
				if numbers[i]+numbers[j]+numbers[k] == sum {
					return numbers[i], numbers[j], numbers[k]
				}
				// break if [i]+[j]+[k] > sum
			}
		}
	}

	return -1, -1, -1
}
