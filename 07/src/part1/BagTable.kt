package part1

class BagTable {

    // maps bag to each container where it could be in and the amount
    private val table : MutableMap<String, MutableMap<String, Int>> = HashMap()

    fun addContents(container : String, contents : String, amount : Int) {
        if (!table.containsKey(contents)) table[contents] = HashMap()

        table[contents]!![container] = amount
    }

    override fun toString(): String {
        val sb : StringBuilder = StringBuilder()

        for (entry in table) {
            sb.append("${entry.key} is in\n")
            for (container in entry.value)
                sb.append(" - ${container.value}x ${container.key}\n")
        }

        return sb.toString()
    }

    operator fun get(key: String): Map<String, Int>? {
        return table[key]
    }
}