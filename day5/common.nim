import strutils

proc readLines*(): seq[string] =
    let file = open("input.txt")
    defer: file.close()
    var line: string
    var lines: seq[string] = @[]
    while file.readLine(line):
        lines.add(line)
    return lines


type
    Point* = object
        x*: int
        y*: int
type
    Line* = object
        point1*: Point
        point2*: Point

method isNotDiagonal*(this: Line): bool =
    return this.point1.x == this.point2.x or this.point1.y == this.point2.y

type
    Diagram* = object
        matrix*: seq[seq[int]]

method getNumberHot*(this: Diagram): int =
    var total = 0
    for row in this.matrix:
        for cell in row:
            if cell > 1:
                total += 1
    return total



proc makeDiagram*(x: int, y: int): seq[seq[int]] =
    var matrix: seq[seq[int]] = @[]
    for row in 0..x+2:
        var r: seq[int] = @[]
        for col in 0..y+2:
            r.add(0)
        matrix.add(r)
    return matrix

proc parseCoordinatesToPoint*(coordStr: string): Point =
    let coords = coordStr.split(",")
    return Point(x: parseInt(strip(coords[0])), y: parseInt(strip(coords[1])))
