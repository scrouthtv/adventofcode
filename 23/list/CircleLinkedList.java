package list;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CircleLinkedList<T> {
	private Node head;
	
	private final Map<T, Node<T>> nodes = new HashMap<>();
	
	public CircleLinkedList(List<T> initial) {
		for (T t : initial)
			add(t);
	}
	
	/**
	 * Moves the sublist defined by [start, end] after `after`.
	 * @param start the first element of the sublist
	 * @param end the last element of the sublist
	 * @param after the element after which the sublist should be inserted
	 */
	public void move(Node<T> start, Node<T> end, Node<T> after) {
		start.prev.next = end.next;
		end.next.prev = start.prev;
		
		final Node<T> before = after.next;
		after.next = start;
		before.prev = end;
		start.prev = after;
		end.next = before;
	}
	
	public Node<T> head() {
		return head;
	}
	
	public int length() {
		return nodes.size();
	}
	
	/**
	 * Adds the specified t at the end of the list.
	 * @param t
	 */
	public void add(T t) {
		if (head == null) {
			final Node<T> newhead = new Node<>(t, null, null);
			newhead.next = newhead;
			newhead.prev = newhead;
			head = newhead;
			nodes.put(t, head);
			return;
		}
		
		final Node<T> oldtail = head.prev;
		final Node<T> newtail = new Node(t, head, oldtail);
		oldtail.next = newtail;
		head.prev = newtail;
		nodes.put(t, newtail);
	}
	
	public Node<T> get(T t) {
		return nodes.get(t);
	}
	
	@Override
	public String toString() {
		StringBuilder out = new StringBuilder();
		Node i = head;
		do {
			out.append(String.format("%d ", i.cup));
		} while (i != head);
		return out.toString();
	}
	
	public static class Node<T> {
		private T cup;
		private Node<T> next;
		private Node<T> prev;
		
		private Node(T value, Node<T> next, Node<T> prev) {
			this.cup = value;
			this.next = next;
			this.prev = prev;
		}
		
		public Node<T> getPrev() {
			return prev;
		}
		
		public Node<T> getNext() {
			return next;
		}
		
		public T getCup() {
			return cup;
		}
		
		public void setCup(final T cup) {
			this.cup = cup;
		}
	}
}
