import common
import strutils


proc getLinesValues(line: Line): seq[Point] =
    var vals: seq[Point] = @[]
    var xMin, xMax: int
    var yMin, yMax: int

    if line.point1.x > line.point2.x:
        xMin = line.point2.x
        xMax = line.point1.x
    else:
        xMin = line.point1.x
        xMax = line.point2.x


    if line.point1.y > line.point2.y:
        yMin = line.point2.y
        yMax = line.point1.y
    else:
        yMin = line.point1.y
        yMax = line.point2.y

    for x in xMin..xMax:
        for y in yMin..yMax:
            let p = Point(x: x, y: y)
            vals.add(p)
    return vals

method insertLine(dia: var common.Diagram, line: Line) =
    let points = getLinesValues(line)
    for point in points:
        dia.matrix[point.x][point.y] += 1


var lines: seq[Line] = @[]

var maxX = 0
var maxY = 0
for line in readlines():
    let coordinates = line.split("->")

    let point1 = parseCoordinatesToPoint(coordinates[0])
    if point1.x > maxX:
        maxX = point1.x
    if point1.y > maxY:
        maxY = point1.y

    let point2 = parseCoordinatesToPoint(coordinates[1])
    if point2.x > maxX:
        maxX = point1.x

    if point2.y > maxY:
        maxY = point1.y

    let line = Line(point1: point1, point2: point2)

    # Only use horizontal and vertical lines
    if line.isNotDiagonal():
        lines.add(line)


var matrix = makeDiagram(maxX, maxY)

var diagram = Diagram(matrix: matrix)

for line in lines:
    diagram.insertLine(line)

let result = diagram.getNumberHot()

echo result

