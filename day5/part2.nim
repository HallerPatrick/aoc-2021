import strutils
import common

proc getDiagonalValue(line: Line): seq[Point] =
    let diffX = line.point1.x - line.point2.x
    let diffY = line.point1.y - line.point2.y

    var currentPoint = line.point1;

    var vals: seq[Point] = @[currentPoint]

    # Diff has to be the same between x1 and x2 and y1 and y2
    for i in 0..abs(diffX)-1:
        if diffX > 0:
            currentPoint.x -= 1
        else:
            currentPoint.x += 1

        if diffY > 0:
            currentPoint.y -= 1
        else:
            currentPoint.y += 1

        vals.add(currentPoint)
    return vals


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

    if line.isNotDiagonal() == false:
        return getDiagonalValue(line)

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
    lines.add(line)


var matrix = makeDiagram(maxX, maxY)

var diagram = Diagram(matrix: matrix)

for line in lines:
    diagram.insertLine(line)

let result = diagram.getNumberHot()

echo result

