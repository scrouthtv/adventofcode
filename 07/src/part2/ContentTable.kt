package part2

class ContentTable {

    // maps bag to each container where it could be in and the amount
    private val table : MutableMap<String, Map<String, Int>> = HashMap()

    fun setContents(container : String, contents : Map<String, Int>) {
        table[container] = contents
    }

    override fun toString(): String {
        val sb : StringBuilder = StringBuilder()

        for (entry in table) {
            sb.append("${entry.key} contains\n")
            for (container in entry.value)
                sb.append(" - ${container.value}x ${container.key}\n")
        }

        return sb.toString()
    }

    operator fun get(key: String): Map<String, Int>? {
        return table[key]
    }

    fun bagHasContents(bag: String) : Boolean {
        return table[bag]?.isNotEmpty() ?: false
    }
}