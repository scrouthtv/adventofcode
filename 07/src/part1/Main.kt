package part1

import java.io.File
import java.util.regex.Matcher
import java.util.regex.Pattern

var bt : BagTable = BagTable()

fun main() {

    File("input").forEachLine {
        val split : List<String> = it.split(" bags contain ")
        if (split.size == 2) addContents(split[0], split[1])
    }

    println(bt)

    val s = BagTableSearcher(bt, "shiny gold")
    s.search()

    println("Found shiny gold inside of ${s.getPossibleContainers().size} bags:")
    println(s.getPossibleContainers())
}

var contentPattern : Pattern = Pattern.compile("([0-9]+) ([a-z ]+) bags?")

fun addContents(container : String, contents : String) {
    if (contents == "no other bags.") return

    var m : Matcher = contentPattern.matcher(contents)

    while (m.find()) {
        bt.addContents(container, m.group(2), m.group(1).toInt())
    }
}

