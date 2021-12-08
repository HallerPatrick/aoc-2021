//
//  main.swift
//  day8
//
//  Created by Patrick Haller on 08.12.21.
//

import Foundation



func getInput() -> Array<(Array<String>, Array<String>)> {
    let filename = "/Users/patrickhaller/Projects/aoc-2021/day8/input.txt"
    let contents = try! String(contentsOfFile: filename)
    let lines = contents.split(separator: "\n")
    
    var inputs: Array<(Array<String>, Array<String>)> = []
    
    for line in lines {
        let split_line = line.split(separator: "|")
        let left = split_line[0]
        let right = split_line[1]
        let left_split = left.split(separator: " ").map { String($0) }
        let right_split = right.split(separator: " ").map { String($0) }
        inputs.append((left_split, right_split))
    }
    
    return inputs
}


func part1() {
    let lines = getInput()
    
    
    var count = 0
    
    for line in lines {
        let right_side = line.1
        for stri in right_side {
            // For digits 1, 4, 7, 8 respectively
            if [2, 4, 3, 7].contains(stri.count) {
                count += 1
            }
        }
    }
    print(count)
}

func part2() {
    let lines = getInput()
    
    var total = 0
    for line in lines {
        
        // 0, 6, 9 -> len 6
        
        // 2, 3, 5 -> len 5
        
        var letter_mapping: [Int: String] = [:]
        let inputs = line.0
        
        // For all unique numbers
        for input in inputs {
            switch input.count {
            case 2:
                letter_mapping[1] = input
            case 4:
                letter_mapping[4] = input
            case 3:
                letter_mapping[7] = input
            case 7:
                letter_mapping[8] = input
            default: break
                // Do nothing
            }
        }
        
        // For all length 5
        for input in inputs {
            if input.count == 5 {
                let res = map_len_5(input: input, letter_mapping: letter_mapping)
                letter_mapping[res] = input
            }
        }
        
        // For all length 6
        for input in inputs {
            if input.count == 6 {
                let res = map_len_6(input: input, letter_mapping: letter_mapping)
                letter_mapping[res] = input
            }
        }
        let targets = line.1
        
        var string_val: [Int] = []
        // Calculate values
        for input in targets {
            for (num, chars_) in letter_mapping {
                if contains_equal(str1: chars_, str2: input) {
                    string_val.append(num)
                }
            }
        }
        let intValue = string_val.reduce(0, {$0*10 + $1})
        total = total + intValue
    }
    print(total)
}

func contains_equal(str1: String, str2: String) -> Bool {
    if str1.count != str2.count {
        return false
    }
    for char in str1 {
        if !str2.contains(char) {
            return false
        }
    }
    return true
}



func contains(str1: String, str2: String) -> Bool {
    for char in str1 {
        if !str2.contains(char) {
            return false
        }
    }
    return true
}

func contains_num(str1: String, str2: String) -> Int {
    var count = 0
    for char in str1 {
        if str2.contains(char) {
            count += 1
        }
    }
    return count
}

// 0, 6, 9
func map_len_6(input: String, letter_mapping: [Int: String]) -> Int {
    
    // Then has to be number 9
    if contains(str1: letter_mapping[4]!, str2: input) { return 9 }
    // Then has to be number 9
    if contains(str1: letter_mapping[1]!, str2: input) {
        return 0
    } else {
        return 6
    }
}

// 2, 3, 5,
func map_len_5(input: String, letter_mapping: [Int: String]) -> Int {
    // Then has to be number 3
    if contains(str1: letter_mapping[7]!, str2: input) {
        return 3
    }
    let count = contains_num(str1: letter_mapping[4]!, str2: input)
    
    if count == 2 {
        return 2
    } else {
        return 5
    }
}


// part1()
part2()

