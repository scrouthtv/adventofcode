package part2

import kotlin.collections.HashMap

class ContentSearcher(private val contentTable: ContentTable, bag : String) {

    private val toSearch : MutableMap<String, Int> = HashMap()

    init {
        toSearch[bag] = 1
    }

    private var contents : Int = 0

    fun getContents(): Int {
        return contents
    }

    fun search() {
        while (toSearch.isNotEmpty()) {
            // Resolve the current element:
            val current = toSearch.iterator().next()

            contentTable[current.key]!!.forEach {
                if (toSearch.containsKey(it.key))
                    toSearch[it.key] = toSearch[it.key]!! + current.value * it.value
                else toSearch[it.key] = current.value * it.value

                contents += current.value * it.value
            }

            toSearch.remove(current.key)
        }
    }

}
