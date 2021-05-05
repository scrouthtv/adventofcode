package part1

import kotlin.collections.HashMap

class BagTableSearcher(private val bg: BagTable, bag : String) {

    private val toSearch : MutableMap<String, Int> = HashMap()

    init {
        toSearch[bag] = 1
    }

    private val possibleContainers : MutableSet<String> = HashSet()

    // There is a kotlin way of adding getters, however, it does not allow me to
    // cast the MutableSet to a Set.
    fun getPossibleContainers(): Set<String> {
        return possibleContainers
    }

    fun search() {
        while (toSearch.isNotEmpty()) {
            // Resolve the current element:
            val current = toSearch.iterator().next()

            // For each dependency of the current element:
            bg[current.key]?.forEach {
                possibleContainers.add(it.key)

                if (toSearch.containsKey(it.key)) toSearch[it.key] = toSearch[it.key]!! + it.value
                else toSearch[it.key] = it.value
            }

            toSearch.remove(current.key)
        }
    }

}
