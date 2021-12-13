import java.io.File
import kotlin.system.exitProcess

fun main() {
    var main = Main()
    main.main()
}




class Main {

    private var i: Int = 0

    private fun readInInput(): List<List<String>> {
        val file = "input.txt"
        val lines: List<List<String>> =  File(file).useLines { it.toList() }.map { it.split("-") }
        return lines
    }

    fun main() {
        val connections: List<List<String>> = readInInput()
        createGraph(connections)

    }

    private fun createGraph(connections: List<List<String>>) {
        val graph = mutableMapOf<String, MutableList<String>>()

        for (connection in connections) {

            if (graph.containsKey(connection.first())) {
                graph[connection.first()]?.add(connection.last())
            } else {
                graph[connection.first()] = mutableListOf(connection.last())
            }

            if (graph.containsKey(connection.last())) {
                graph[connection.last()]?.add(connection.first())
            } else {
                graph[connection.last()] = mutableListOf(connection.first())
            }
        }


        val paths = findAllPaths(graph, "start", "end", mutableListOf())
        println(paths.size)
    }

    private fun findAllPaths(
        graph: MutableMap<String, MutableList<String>>,
        start: String,
        end: String,
        path: MutableList<String>,
    ): MutableList<MutableList<String>> {
        path.add(start)

        if (start == end) {
            return mutableListOf(path)
        }
        val paths = mutableListOf<MutableList<String>>()
        for (node in graph[start]!!){

            this.i += 1
            if (this.i == 20) {
                break
            }

            if (nodeAllowedPart2(graph, path, node)) {
                val newPaths = findAllPaths(graph, node, end, path.toMutableList())
                for (newPath in newPaths) {
                    paths.add(newPath)
                }
            }

        }
        return paths
    }

    private fun nodeAllowed(
        graph: MutableMap<String, MutableList<String>>,
        path: MutableList<String>,
        node: String
    ): Boolean {

        val smallCaves = graph.keys.filter { it.lowercase() == it }

        val smallCavesCounter = mutableMapOf<String, Int>()

        for (n in path) {
            if (smallCaves.contains(n)) {
                if (smallCavesCounter.containsKey(n)) {
                    smallCavesCounter[n] = smallCavesCounter[n]!! + 1
                } else {
                    smallCavesCounter[n] = 1
                }
            }
        }
        if (!smallCavesCounter.containsKey(node)) {
            return true
        }
        if (smallCavesCounter[node]!! < 1) {
            return true
        }

        return false
    }


    private fun nodeAllowedPart2(
        graph: MutableMap<String, MutableList<String>>,
        path: MutableList<String>,
        node: String
    ): Boolean {

        val smallCaves = graph.keys.filter { !listOf("start", "end").contains(it) && it.lowercase() == it }

        val smallCavesCounter = mutableMapOf<String, Int>()

        for (n in path) {
            if (smallCaves.contains(n)) {
                if (smallCavesCounter.containsKey(n)) {
                    smallCavesCounter[n] = smallCavesCounter[n]!! + 1
                } else {
                    smallCavesCounter[n] = 1
                }
            }
        }

        if (node == "start") return false

        if (!smallCavesCounter.containsKey(node)) {
            return true
        }

        if (smallCavesCounter[node] == 1 && smallCavesCounter.filter { it.key != node && it.value == 2 }.isEmpty()) {
            return true
        }


        return false
    }

}