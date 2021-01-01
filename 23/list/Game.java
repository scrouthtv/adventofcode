package list;

import java.util.ArrayList;
import java.util.List;

public class Game {
	private CircleLinkedList<Integer> cups;
	private CircleLinkedList.Node<Integer> current;
	
	private final int PICKSIZE = 3;
	
	public Game(int[] initial) {
		List<Integer> iL = new ArrayList<>();
		for (int i = 0; i < initial.length; i++)
			iL.add(initial[i]);
		
		cups = new CircleLinkedList<>(iL);
		current = cups.head();
	}
	
	public Game(List<Integer> initial) {
		cups = new CircleLinkedList<>(initial);
		current = cups.head();
	}
	
	public CircleLinkedList.Node<Integer> current() {
		return current;
	}
	
	public CircleLinkedList.Node<Integer> integerNode(int n) {
		return cups.get(n);
	}
	
	public void play() {
		CircleLinkedList.Node<Integer> insertion = currentDestination();
		CircleLinkedList.Node<Integer>[] slice = selectPickup();
		cups.move(slice[0], slice[PICKSIZE - 1], insertion);
		current = current.getNext();
	}
	
	public CircleLinkedList.Node<Integer> currentDestination() {
		int destcup = current.getCup() - 1;
		if (destcup == 0) destcup = cups.length();
		CircleLinkedList.Node<Integer> destnode = cups.get(destcup);
		
		while (isInPickup(destnode)) {
			destcup--;
			if (destcup == 0) destcup = cups.length();
			destnode = cups.get(destcup);
		}
		
		return destnode;
	}
	
	private boolean isInPickup(CircleLinkedList.Node<Integer> mynode) {
		CircleLinkedList.Node<Integer> n = current.getNext();
		
		for (int i = 0; i < PICKSIZE; i++) {
			if (mynode == n) return true;
			n = n.getNext();
		}
		
		return false;
	}
	
	public CircleLinkedList.Node<Integer>[] selectPickup() {
		CircleLinkedList.Node<Integer>[] pickup = new CircleLinkedList.Node[PICKSIZE];
		
		CircleLinkedList.Node<Integer> n = current.getNext();
		
		for (int i = 0; i < PICKSIZE; i++) {
			pickup[i] = n;
			n = n.getNext();
		}
		
		return pickup;
	}
	
	@Override
	public String toString() {
		StringBuilder out = new StringBuilder();
		out.append("cups: ");
		
		CircleLinkedList.Node<Integer> i = cups.head();
		
		do {
			if (i == current) out.append(String.format("(%d) ", i.getCup()));
			else out.append(String.format(" %d  ", i.getCup()));
			i = i.getNext();
		} while (i != cups.head());
		
		out.append("\npick up: ");
		for (CircleLinkedList.Node<Integer> node : selectPickup())
			out.append(node.getCup() + ", ");
		out.delete(out.length() - 2, out.length()); // remove the trailing comma
		
		out.append("\ndestination: ");
		out.append(currentDestination().getCup() + "\n");
		
		return out.toString();
	}
}
