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

const data = fs.readFileSync("input.txt", "utf8")

lines = data.split("\n")

template = lines[0].trim()

insertions = Object.fromEntries(lines.slice(2).map((x) => x.split("->").map(s => s.trim())).filter(elem => elem.length != 1))

template_count = {}
insertion_count = {}

template.split("").forEach((t) => {
    template_count[t] = 1
})

Object.entries(insertions).map((t) => {
    insertion_count[t[0]] = 1
})

for (var i = 0; i < 40; i++) {
    Object.entries(insertion_count).forEach((insertion) => {
        link = insertions[insertion[0]]
        insertion_count[insertion[0]] -= insertion[1]

        val = insertion[0][0] + link
        if (insertion_count.hasOwnProperty(val)) {
            insertion_count[val] += insertion[1]
        } else {
            insertion_count[val] = insertion[1]
        }

        val2 = link + insertion[0][1]
        if (insertion_count.hasOwnProperty(val2)) {
            insertion_count[val2] += insertion[1]
        } else {
            insertion_count[val2] = insertion[1]
        }

        if (template_count.hasOwnProperty(val2)) {
            template_count[link] += insertion[1]
        } else {
            template_count[link] = insertion[1]
        }
        // 1 + {} - "asd"

    })
}

console.log(template_count)

// var expCounts = {};
// let count = 0
//
// for (let i = 0; i < template.length; i++) {
//     let char = template[i]
//
//     expCounts[char] = expCounts[char] + 1 || 1
//
//     if (expCounts[char] > count) {
//         maxChar = char
//         count = expCounts[char]
//
//     }
// }

var highest = 0
var lowesr = 1000000000000000

// console.log(expCounts)

Object.entries(template_count).map((entry) => {
    if (entry[1] > highest) {
        highest = entry[1]
    }

    if (entry[1] < lowesr) {
        lowesr = entry[1]
    }
})


console.log(highest - lowesr)
