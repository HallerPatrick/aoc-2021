
def matrix = []

new File("input.txt").eachLine { line ->
    def nums = line.split("")
    matrix.add(nums)
}


def sum = 0

for (Integer i = 0; i < matrix.size(); i++) {
    for (Integer j = 0; j < matrix[0].size(); j++) {
        def isLower = checkAdjacentPoint(i, j, matrix)
        if (isLower) {
            def num = matrix[i][j] as Integer + 1
            println(num - 1)
            print(i)
            print(", ")
            println(j)
            sum +=  num
        }
    }
}

println(sum)

public static def checkAdjacentPoint(Integer i, Integer j, ArrayList<ArrayList<Integer>> matrix) {
    def currentPoint = matrix[i][j]

    // Check naively for adjacent cells
    if (j > 0) {
       if (currentPoint >= matrix[i][j-1]) {
           return false
       }
    }

    if (j < matrix[i].size() - 1) {
        if (currentPoint >= matrix[i][j+1]) {
            return false
        }
    }

    if (i > 0) {
        if (currentPoint >= matrix[i -1][j]) {
            return false
        }
    }

    if (i < matrix.size() - 1) {
        if (currentPoint >= matrix[i+1][j]) {
            return false
        }
    }
    return true
}
