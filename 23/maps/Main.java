package maps;

public class Main {
	public static void main(String[] args) {
		final Game g = new maps.Game(new int[]{3, 8, 9, 1, 2, 5, 4, 6, 7});
		
		for (int i = 0; i <= 1; i++) {
			System.out.println("-- move 1 --");
			System.out.println(g);
			g.play();
		}
		
		System.out.println("-- final --");
		System.out.println(g.toString().split("\n")[0]);
	}
}
