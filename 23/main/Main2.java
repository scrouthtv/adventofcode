package main;

import java.util.List;
import java.util.ArrayList;

public class Main2 {

	public static void main(String[] args) {

		final List<Byte> numbers = new ArrayList<Byte>();
		for (byte b : new byte[] {3, 8, 9, 1, 2, 5, 4, 6, 7})
			numbers.add(b);
		byte max = numbers.get(0);
		for (byte b : numbers)
			if (b > max) max = b;
		while (max < 1000000) {
			numbers.add(++max);
			System.out.println(max);
		}



		final Game g = new Game(new Byte[] {1, 9, 3, 4, 6, 7, 2, 5, 8});
		System.out.println("-- move 1 --");
		System.out.println(g);

		for (int i = 2; i <= 10; i++) {
			if (i == 9) Game.debug = false;
			g.play();
			if (i == 9) Game.debug = false;
			System.out.println("-- move " + i + " --");
			System.out.println(g);
		}

		System.out.println("-- final --");
		g.play();
		System.out.println(g.toString().split("\n")[0]);

		for (int i = 10; i <= 99; i++) {
			g.play();
		}
		System.out.println("");
		System.out.println("-- move 100 --");
		System.out.println(g.toString().split("\n")[0]);
		System.out.println(g.cupsStartingWith((byte) 1));
	}
}
