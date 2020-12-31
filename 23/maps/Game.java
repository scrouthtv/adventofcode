package maps;

import javax.swing.*;
import java.util.Map;
import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;

public class Game {
	// this maps cup -> position
	private Map<Integer, Integer> cups = new HashMap<>();
	
	/**
	 * The current cup
	 */
	private int currentCup;
	
	public Game(List<Integer> start) {
		for (int i = 0; i < start.size(); i++)
			cups.put(start.get(i), i);
		currentCup = start.get(0);
	}
	
	public Game(int[] start) {
		for (int i = 0; i < start.length; i++)
			cups.put(start[i], i);
		currentCup = start[0];
	}
	
	private static final int PICKSIZE = 3;
	
	public void play() {
		if (true)
			throw new RuntimeException("buggy implementation, does not work");
		final int insertCup = currentDestination();
		
		final int[] slice = selectPickup();
		final int insertPos = cups.get(insertCup); // the position after which the slice should be inserted
		final int slicestartPos = cups.get(slice[0]); // the first position to be moved
		final int sliceendPos = cups.get(slice[PICKSIZE - 1]); // the last position to be moved
		
		Map<Integer, Integer> newcups = new HashMap<Integer, Integer>(cups.size());
		
		if (sliceendPos > slicestartPos) {
			// non-wrapping slice
			for (Map.Entry<Integer, Integer> entry : cups.entrySet()) {
				if (entry.getValue() >= slicestartPos && entry.getValue() <= sliceendPos) {
					if (slicestartPos < insertPos)
						newcups.put(entry.getKey(), insertPos + entry.getValue() - slicestartPos);
					else
						newcups.put(entry.getKey(), insertPos + entry.getValue() - slicestartPos);
				} else if (entry.getValue() > insertPos && entry.getValue() > sliceendPos)
					continue;
				else if (entry.getValue() <= insertPos && entry.getValue() < slicestartPos)
					continue;
				else if (entry.getValue() <= insertPos && entry.getValue() > sliceendPos)
					newcups.put(entry.getKey(), entry.getValue() - PICKSIZE);
				else if (entry.getValue() > insertPos && entry.getValue() < slicestartPos)
					newcups.put(entry.getKey(), entry.getValue() + PICKSIZE);
				else throw new RuntimeException("found no target for #" + entry.getValue());
			}
		} else {
			// wrapping slice, e. g. it begins close to the circles "end" and ends close after the
			// circles "start"
			final int leftPortion = sliceendPos + 1;
			final int rightPortion = PICKSIZE - leftPortion;
			for (Map.Entry<Integer, Integer> entry : cups.entrySet()) {
				if (entry.getValue() <= sliceendPos)
					newcups.put(entry.getKey(), insertPos + entry.getValue() + rightPortion + 1);
				else if (entry.getValue() >= slicestartPos)
					newcups.put(entry.getKey(), entry.getValue() - slicestartPos + insertPos + 1);
				else if (entry.getValue() <= insertPos)
					newcups.put(entry.getKey(), entry.getValue() - leftPortion);
				else if (entry.getValue() > insertPos)
					newcups.put(entry.getKey(), entry.getValue() - leftPortion + PICKSIZE);
				else throw new RuntimeException("found no target for #" + entry.getValue());
			}
		}
		
		cups = newcups;
		
		// TODO advance current
	}
	
	/**
	 * Returns the cup numbers at the specified position(s).
	 * For every cup that was not found, 0 is inserted.
	 */
	private int[] postocups(int... pos) {
		int found = 0;
		int[] cups = new int[pos.length];
		
		for (Map.Entry<Integer, Integer> cup : this.cups.entrySet()) {
			for (int i = 0; i < pos.length; i++)
				if (pos[i] == cup.getValue()) {
					cups[i] = cup.getKey();
					if (++found == pos.length)
						return pos;
				}
		}
		return pos;
	}
	
	/**
	 * Selects the destination cup.
	 * @return the cup number, *not* it's position
	 */
	private int currentDestination() {
		final int currentPos = cups.get(currentCup);
		int destinationCup = currentCup;
		int destinationPos, distance;
		
		do {
			destinationCup--;
			if (destinationCup == 0) destinationCup += cups.size();
			destinationPos = cups.get(destinationCup);
			if (destinationPos < currentPos) distance = cups.size() - currentPos + destinationPos;
			else distance = destinationPos - currentPos;
		} while (distance <= PICKSIZE);
		
		return destinationCup;
	}
	
	/**
	 * Selects the cups which should be picked up
	 * @return an array of the cup numbers, *not* their position
	 */
	private int[] selectPickup() {
		int[] pickup = new int[PICKSIZE];
		List<Map.Entry<Integer, Integer>> list = new ArrayList<>(cups.entrySet());
		list.sort(Map.Entry.comparingByValue());
		
		final int currentPosition = cups.get(currentCup);
		
		for (Map.Entry<Integer, Integer> entry : list)
			if (entry.getValue() > currentPosition & entry.getValue() <= currentPosition + PICKSIZE)
				pickup[entry.getValue() - currentPosition - 1] = entry.getKey();
			return pickup;
	}
	
	@Override
	public String toString() {
		StringBuilder out = new StringBuilder();
		List<Map.Entry<Integer, Integer>> list = new ArrayList<>(cups.entrySet());
		list.sort(Map.Entry.comparingByValue());
		
		System.out.println(cups == null);
		System.out.println(cups);
		System.out.println(currentCup);
		int currentPosition = cups.get(currentCup);
		System.out.println(currentPosition);
		
		for (Map.Entry<Integer, Integer> entry : list)
			if (entry.getValue() == currentPosition)
				out.append(String.format("(%d) ", entry.getKey()));
			else
				out.append(String.format(" %d  ", entry.getKey()));
			
		int[] pickup = selectPickup();
		out.append(String.format("\npick up: %d, %d, %d\n", pickup[0], pickup[1], pickup[2]));
		
		out.append(String.format("destination: %d\n", currentDestination()));
		
		return out.toString();
	}
}