package part2

import java.io.File
import java.util.regex.Matcher
import java.util.regex.Pattern

var ct : ContentTable = ContentTable()

fun main() {

    File("input").forEachLine {
        val split : List<String> = it.split(" bags contain ")
        if (split.size == 2)
            ct.setContents(split[0], parseContents(split[1]))
    }

    var s = ContentSearcher(ct, "shiny gold")
    s.search()

    println("shiny gold contains ${s.getContents()} bags")

}

var contentPattern : Pattern = Pattern.compile("([0-9]+) ([a-z ]+) bags?")

fun parseContents(contents : String) : Map<String, Int> {
    if (contents == "no other bags.") return HashMap()

    val m : Matcher = contentPattern.matcher(contents)
    val map = HashMap<String, Int>()

    while (m.find())
        map[m.group(2)] = m.group(1).toInt()

    return map
}

