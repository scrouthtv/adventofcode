package main;

public class Main1 {

	public static void main(String[] args) {

		final Game g = new Game(new Integer[] {1, 9, 3, 4, 6, 7, 2, 5, 8});
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
		System.out.println(">25468379<");
	}
}
