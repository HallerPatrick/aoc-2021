
class BasinScanner {

    ArrayList<ArrayList<String>> matrix
    ArrayList<ArrayList<Integer>> scannedMatrix

    def readMatrix() {
        matrix = []
        new File("input.txt").eachLine { line ->
            def nums = line.split("")
            matrix.add(nums)
        }
    }

    def setupScannedMatrix() {
        // Mark every cell which was already found with 1
        scannedMatrix = []
        for (line in matrix) {
            def l = []
            for (cell in line) {
                l.add(0)
            }
            scannedMatrix.add(l)
        }
    }

    def run() {
        readMatrix()
        setupScannedMatrix()
        def basins = []
        for (Integer i = 0; i < matrix.size(); i++) {
            for (Integer j = 0; j < matrix[0].size(); j++) {
                def isLower = part1.checkAdjacentPoint(i, j, matrix)
                if (isLower) {
                    scanBasin(i, j)
                    def size = countBasin()
                    basins.add(size)
                    setupScannedMatrix()
                }
            }
        }

        basins = basins.sort().reverse()

        def prod = basins[0] * basins[1] * basins[2]
        println(prod)
    }

    def countBasin() {
        def sum = 0
        for(line in scannedMatrix) {
            for(cell in line) {
                sum += cell
            }
        }
        return sum
    }

    def scanBasin(i, j) {

        if (scannedMatrix[i][j] == 1) {
            return
        }
        if (matrix[i][j] as Integer == 9) {
            return
        }

        scannedMatrix[i][j] = 1

        // Check for top
        if (i > 0) {
            scanBasin(i - 1, j)
        }

        if (j > 0) {
            scanBasin(i, j -1)
        }

        if (i < matrix.size() - 1) {
            scanBasin(i+1, j)
        }

        if (j < matrix[i].size() -1) {
            scanBasin(i, j+1)
        }

        return 1
    }
}

def scanner = new BasinScanner()
scanner.run()