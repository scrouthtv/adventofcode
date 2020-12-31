package main;

import java.util.List;
import java.util.ArrayList;

public class Main2 {

	public static void main(String[] args) {

		final List<Integer> numbers = new ArrayList<Integer>();
		for (int b : new int[] {3, 8, 9, 1, 2, 5, 4, 6, 7})
			numbers.add(b);
		int max = numbers.get(0);
		for (int b : numbers)
			if (b > max) max = b;
		while (max < 1000000) {
			numbers.add(++max);
		}

		System.out.println("Initialization done");

		final Game g = new Game(numbers);

		for (int i = 2; i <= 10000000; i++) {
			if ((i % 1000) == 0)
				System.out.println(" - move " + i);
			g.play();
		}

		System.out.println(g.cupsStartingWith(1, 2));
	}
}
