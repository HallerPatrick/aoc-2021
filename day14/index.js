const fs = require("fs")

function zip() {
    var args = [].slice.call(arguments);
    var shortest = args.length == 0 ? [] : args.reduce(function(a, b) {
        return a.length < b.length ? a : b
    });

    return shortest.map(function(_, i) {
        return args.map(function(array) {
            return array[i]
        })
    });
}

const data = fs.readFileSync("input2.txt", "utf8")

lines = data.split("\n")

template = lines[0].trim()

insertions = lines.slice(2).map((x) => x.split("->").map(s => s.trim())).filter(elem => elem.length != 1)


for (var i = 0; i < 40; i++) {
    new_template = template[0]
    zip(template.split(""), template.split("").slice(1)).forEach(
        pairs => {
            insertions.forEach(insertion => {
                if (insertion[0] === pairs.join("")) {
                    new_template += insertion[1] + pairs[1]
                }
            })
        })
    template = new_template
}

var expCounts = {};
let count = 0

for (let i = 0; i < template.length; i++) {
    let char = template[i]

    expCounts[char] = expCounts[char] + 1 || 1

    if (expCounts[char] > count) {
        maxChar = char
        count = expCounts[char]

    }
}

var highest = 0
var lowesr = 100000000000000

console.log(expCounts)

Object.entries(expCounts).map((entry) => {
    if (entry[1] > highest) {
        highest = entry[1]
    }

    if (entry[1] < lowesr) {
        lowesr = entry[1]
    }
})



console.log(highest - lowesr)
