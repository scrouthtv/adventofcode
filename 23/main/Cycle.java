package main;

import java.util.Arrays;
import java.util.List;
import java.util.ArrayList;

public class Cycle<T> implements Cloneable {
	private List<T> x;

	public Cycle(T[] x) {
		this.x = new ArrayList<T>();
		for (T t : x)
			this.x.add(t);
	}

	public Cycle(List<T> x) {
		this.x = x;
	}

	@SuppressWarnings("unchecked")
	public Cycle(Cycle<T>... parts) {

		int tlen = 0;
		for (Cycle<T> p : parts)
			tlen += p.length();

		List<T> target = new ArrayList<>();

		for (Cycle<T> c : parts)
			for (int j = 0; j < c.length(); j++)
				target.add(c.ktov(j));

		this.x = target;
	}

	public Cycle(int length) {
		x = new ArrayList<>(length);
	}

	public Cycle<T> slice(int from, int to) {
		from = from % length();
		to = to % length();
		Cycle<T> slice = new Cycle<T>(0);
		if (to >= from) {
			for (int i = from; i < to; i++)
				slice.x.add(x.get(i));
		} else {
			for (int i = from; i < to + length(); i++)
				slice.x.add(ktov(i));
		}
		return slice;
	}

	/**
	 * This moves amount elements to the end of the list.
	 */
	public void moveToTheEnd(int amount) {
		T tmp;
		for (int i = 0; i < amount; i++) {
			tmp = ktov(0);
			remove(0);
			add(tmp);
		}
	}

	public void remove(int i) {
		x.remove(i % length());
	}

	public void add(T t) {
		x.add(t);
	}

	/**
	 * Splits this cycle into multiple cycles
	 */
	public List<Cycle<T>> split(int... pos) {
		Arrays.sort(pos);

		//Cycle<T>[] split = new Cycle<T>[pos.length];
		List<Cycle<T>> splits = new ArrayList<Cycle<T>>();

		int i = 0;
		int t = 0;
		int start;
		for (int stop : pos) {
			Cycle<T> split;
			split = new Cycle<T>(0);
			for (; i < stop; i++)
				split.x.add(x.get(i));
			splits.add(split);
			t++;
		}
		Cycle<T> split = new Cycle<T>(0);
		for (; i < length(); i++)
			split.x.add(x.get(i));
		splits.add(split);

		return splits;
	}

	public int length() {
		return x.size();
	}

	/**
	 * Returns the distance between two points on the circle.
	 * a being the start, and b the destination
	 */
	public int distance(int a, int b) {
		if (a < b)
			return b - a;
		else
			return length() + b - a;
	}

	public int vtok(T v) {
		for (int i = 0; i < x.size(); i++)
			if (x.get(i) == v)
				return i;
		return -1;
	}

	public T ktov(int k) {
		return x.get(k % x.size());
	}

	public void set(int k, T v) {
		x.set(k, v);
	}

	public Cycle<T> clone() {
		return new Cycle<T>(x);
	}

	public String toString() {
		StringBuilder out = new StringBuilder("[ ");
		for (T t : x) {
			out.append(t);
			out.append(" ");
		}
		out.append("]");
		return out.toString();
	}
}
