import scala.io.Source
import scala.util.control.Breaks.break

object Main extends App {

  var matrix: List[List[Int]] = List()
  var maskedMatrix: List[List[Int]] = List()

  main()

  def makeMarkedMatrix(m: List[List[Int]]): List[List[Int]] = {
    var mm = List[List[Int]]()
    for (row <- m) {
      var r = List[Int]()
      for (c <- row) {
        r = r :+ 0
      }
      mm = mm :+ r
    }
    mm
  }

  def readInput(): Unit = {
    matrix = List[List[Int]]()
    val filename = "input2.txt"
    for (line <- Source.fromFile(filename).getLines) {
      var row = List[Int]()
      for (cell <- line) {
        row = row :+ cell.asDigit
      }
      matrix = matrix :+ row
    }
  }

  def main(): Unit = {

    readInput()

    var sum = 0
    // For every timestep (For part2 switch out 100 to something big (min. 1000)
    for (a <- 1 to 100) {
      maskedMatrix = makeMarkedMatrix(matrix)
      var flashes = 0

      // First increase energy level of ALL octupuses!
      for (i <- matrix.indices) {
        for (j <- matrix(i).indices) {
          // Increment power level of current octopus
          incCell(i, j)
        }
      }

      // Then let them flash
      for (i <- matrix.indices) {
        for (j <- matrix(i).indices) {
          val currentLevel = matrix(i)(j)
          if (currentLevel > 9) {
            flash(i, j)
          }
        }
      }

      // Reset flashed octopuses
      for (i <- matrix.indices) {
        for (j <- matrix(i).indices) {
          val currentLevel = maskedMatrix(i)(j)
          if (currentLevel >= 1) {
            flashes += 1
            resetCell(i, j)
          }
        }
      }

       // For part 2
      if (flashes == 100){
        println(a)
      }

      sum += flashes

    }

    println(sum)
  }

  def incCell(i: Int, j: Int): Unit = {
    val newVal = matrix(i)(j) + 1
    var row = matrix(i)
    row = row.updated(j, newVal)
    matrix = matrix.updated(i, row)
  }

  def resetCell(i: Int, j: Int): Unit = {
    var row = matrix(i)
    row = row.updated(j, 0)
    matrix = matrix.updated(i, row)
  }

  def incMarkedCell(i: Int, j: Int) : Unit= {
    val newVal = maskedMatrix(i)(j) + 1
    var row = maskedMatrix(i)
    row = row.updated(j, newVal)
    maskedMatrix = maskedMatrix.updated(i, row)
  }

  def incCellForFlash(i: Int, j: Int): Unit = {
    try {
      incCell(i, j)
    } catch {
      // Out of bound octopus
      case _: IndexOutOfBoundsException => return
    }

    if (matrix(i)(j) > 9 && maskedMatrix(i)(j) == 0) {
      flash(i, j)
    }
  }

  def flash(i: Int, j: Int):Unit = {
    // Dont flash if already
    if (maskedMatrix(i)(j) >= 1) {
      return
    }

    incMarkedCell(i, j)

    incCellForFlash(i - 1, j - 1)
    incCellForFlash(i - 1, j)
    incCellForFlash(i, j - 1)
    incCellForFlash(i - 1, j + 1)
    incCellForFlash(i + 1, j - 1)
    incCellForFlash(i, j + 1)
    incCellForFlash(i + 1, j)
    incCellForFlash(i + 1, j + 1)


  }
}

