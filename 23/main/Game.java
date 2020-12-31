package main;

import java.util.List;

public class Game {
	public static boolean debug = false;

	private Cycle<Integer> numbers;

	private int current;

	public Game(Integer[] numbers) {
		this.numbers = new Cycle<Integer>(numbers);
		current = 0;
	}

	public Game(List<Integer> numbers) {
		this.numbers = new Cycle<Integer>(numbers);
		current = 0;
	}

	private static final int PICKSIZE = 3;

	@SuppressWarnings("unchecked")
	public void play() {
		final int slicestart = current + 1;
		final int sliceend = current + 1 + PICKSIZE; 
		int insertion = currentDestination();

		final int oldlen = numbers.length();

		if (debug) {
			System.out.println("Destination: #" + insertion
					+ " (" + numbers.ktov(insertion) + ")");
		}

		Cycle<Integer> slice = numbers.slice(slicestart, sliceend);

		if (debug)
			System.out.println(numbers.toString());
		if (insertion >= sliceend) insertion -= PICKSIZE - 1;
		else insertion += 1;
		if (sliceend > numbers.length()) 
			insertion -= sliceend - numbers.length();
		for (int i = 0; i < PICKSIZE; i++) {
			if (debug) {
				System.out.println("i = " + i + ", slicestart = " + slicestart);
				System.out.println("oldlen = " + oldlen + ", numbers.length() = " + numbers.length());
			}
			if (slicestart > numbers.length()) {
				numbers.remove(0);
			} else {
				numbers.remove(slicestart);
			}
			if (debug) {
				System.out.println(numbers);
			}
		}
		if (debug)
			System.out.println("After deletion: " + numbers.toString());

		List<Cycle<Integer>> outer = numbers.split(insertion);

		if (debug) {
			System.out.println("Going to merge " + slice.toString());
			System.out.println(" into " + outer.get(0).toString() 
					+ " - " + outer.get(1).toString());
			System.out.println("");
		}

		this.numbers = new Cycle<Integer>(outer.get(0), slice, outer.get(1));
		
		current++;
		if (current > insertion) {
			// have to move PICKSIZE cups to the end so the output is the same
			numbers.moveToTheEnd(PICKSIZE);
		}
		if (sliceend > numbers.length()) {
			numbers.moveToTheEnd(numbers.length() + numbers.length() - sliceend);
		}
		if (current >= numbers.length()) current -= numbers.length();
	}

	private int currentDestination() {
		int destV = (int) (numbers.ktov(current) - 1);
		if (destV <= 0) destV += numbers.length();
		int destination = numbers.vtok(destV);

		while (numbers.distance(current, destination) <= PICKSIZE) {
			destV = (int) (destV - 1);
			if (destV <= 0) destV += numbers.length();
			destination = numbers.vtok(destV);
		}

		return destination;
	}

	private int max() {
		int max = numbers.ktov(0);
		for (int i = 1; i < numbers.length(); i++)
			if (numbers.ktov(i) > max)
				max = numbers.ktov(i);
		return max;
	}

	public String cupsStartingWith(int value) {
		StringBuilder out = new StringBuilder();
		for (int i = numbers.vtok(value);
				i < numbers.vtok(value) + numbers.length(); i++)
			out.append(String.format("%d", numbers.ktov(i)));
		return out.toString();
	}

	public String cupsStartingWith(int value, int amount) {
		StringBuilder out = new StringBuilder();
		int offset = numbers.vtok(value);
		for (int i = offset;
				i < offset + amount; i++)
			out.append(String.format("%d ", numbers.ktov(i)));
		return out.toString();
	}

	@Override
	public String toString() {
		StringBuilder out = new StringBuilder();
		for (int i = 0; i < numbers.length(); i++)
			if (i == current)
				out.append(String.format("(%d)", numbers.ktov(i)));
			else
				out.append(String.format(" %d ", numbers.ktov(i)));

		out.append(String.format("\npick up: %d, %d, %d\n",
					numbers.ktov(current + 1),
					numbers.ktov(current + 2), 
					numbers.ktov(current + 3)));
		out.append(String.format("destination: %d\n",
				numbers.ktov(currentDestination())));
		return out.toString();
	}
}
