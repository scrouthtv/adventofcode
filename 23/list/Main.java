package list;

import java.math.BigInteger;
import java.util.Arrays;
import java.util.stream.IntStream;
import java.util.stream.Stream;

public class Main {
	
	public static void main(String[] args) {
		pt1();
		pt2();
	}
	
	private static void test1() {
		final Game g = new Game(new int[] {3, 8, 9, 1, 2, 5, 4,6, 7});
		
		for (int i = 1; i <= 10; i++) {
			System.out.println("-- move " + i + " --");
			System.out.println(g);
			g.play();
		}
		
		System.out.println("-- final --");
		System.out.println(g.toString().split("\n")[0]);
	}
	
	private static void pt1() {
		final Game g = new Game(new int[] {1, 9, 3, 4, 6, 7, 2, 5, 8});
		
		for (int i = 0; i < 100; i++) g.play();
		
		System.out.println("-- final --");
		System.out.println(g.toString().split("\n")[0]);
	}
	
	private static void pt2() {
		final int[] firsts = new int[] {1, 9, 3, 4, 6, 7, 2, 5, 8};
		
		System.out.println(IntStream.concat(Arrays.stream(firsts), IntStream.range(firsts.length + 1, 1000001)).toArray().length);
		//System.out.println(IntStream.concat(Arrays.stream(firsts), IntStream.range(firsts.length + 1, 1000001)).toArray());
		
		final Game game = new Game(IntStream.concat(Arrays.stream(firsts), IntStream.range(firsts.length + 1, 1000001)).toArray());
		
		for (int i = 0; i < 9999998; i++) game.play();
		
		for (int i = 0; i < 5; i++) {
			System.out.println("-- final --");
			System.out.println("Answer: " + pt02answer(game.current()));
			game.play();
		}
	}
	
	private static BigInteger pt02answer(CircleLinkedList.Node<Integer> current) {
		BigInteger a = BigInteger.valueOf(current.getNext().getCup());
		BigInteger b = BigInteger.valueOf(current.getNext().getCup());
		return a.multiply(b);
	}
}
