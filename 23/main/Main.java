package main;

import java.util.List;

public class Main {

	public static void main(String[] args) {
		//testMerge();
		//testSplit();

		final Game g = new Game(new Byte[] {3, 8, 9, 1, 2, 5, 4, 6, 7});
		System.out.println("-- move 1 --");
		System.out.println(g);

		for (int i = 2; i <= 10; i++) {
			if (i == 10) Game.debug = false;
			g.play();
			if (i == 10) Game.debug = false;
			System.out.println("-- move " + i + " --");
			System.out.println(g);
		}

		System.out.println("-- final --");
		System.out.println(g.toString().split("\n")[0]);
	}

	public static void testMerge() {
		System.out.println(" -- starting merge --");
		Cycle<String> a = new Cycle<String>(new String[] 
				{"a", "b", "c", "d"});
		Cycle<String> b = new Cycle<String>(new String[] 
				{"d"});
		Cycle<String> c = new Cycle<String>(new String[] 
				{"q", "q"});
		Cycle<String> d = new Cycle<String>(new String[] 
				{"a", "c", "d"});

		@SuppressWarnings("unchecked")
		final Cycle<String> merge = new Cycle<>(a, b, c, d);

		System.out.println(merge);
		System.out.println(" -- should be --");
		System.out.println("[ a b c d d q q a c d ]");
		System.out.println(" -- ending merge --");
	}

	public static void testSplit() {
		System.out.println(" -- starting split --");
		final Cycle<String> full = new Cycle<>(new String[]
				{"a", "b", "c", "d", "e", "f", "g", "h", "i", "j"});
		final List<Cycle<String>> splits = full.split(1, 7, 5);

		for (Cycle<String> c : splits)
			System.out.println(c);

		System.out.println(" -- should be --");
		System.out.println("[ a ]");
		System.out.println("[ b c d e ]");
		System.out.println("[ f g ]");
		System.out.println("[ h i j ]");
		System.out.println(" -- ending split --");
	}

}
