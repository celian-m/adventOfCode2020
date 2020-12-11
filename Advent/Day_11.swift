//
//  Day_11.swift
//  Advent
//
//  Created by Célian MOUTAFIS on 11/12/2020.
//

import Foundation
extension Array where Element == String  {
    func elemAt(_ y: Int, _ x: Int) -> String {
        if (y >= 0 && y < self.count && x >= 0 && self[y].count > x) {
            return String(self[y][x])
        }
        return "."
    }
}


struct Day11 : Day {
    static func sanityCheck() -> Int {
        let input = String.from(file: "day_11_check").components(separatedBy: "\n").filter { $0.count > 0}
        let stabilized = computeUntilStability(input: input)
        let freeSets = stabilized.map({$0.map({$0 == "#" ? 1 : 0}).reduce(0, +)}).reduce(0, +)
        return freeSets
    }
    
    static func computeUntilStability(input: [String]) -> [String] {
        var hasChanges = true
        var count : Int = 0
        let padding = String(repeating: ".", count: input[0].count + 2)
        var padded = [padding] + input.map({ "." + $0 + "." }) + [padding]
        while hasChanges {
            print("Round \(count)")
            let (res, changes) = compute(input: padded)
            padded = res
            hasChanges = changes
            count += 1
        }
        
        return padded
    }
    static func compute(input: [String]) -> ([String], Bool) {
        
        let width = input[0].count
        let height = input.count
        var hasChanges: Bool = false
        var result: [String] = []
        var newLine = ""
        
        for h in 0..<height {
            newLine = ""
            for w in 0..<width {
                //    print("Line \(h) - Column \(w)")
                var char = String(input[h][w])
                if char == "." {
                    //Do nothing
                } else if char == "L" {
                    let next = input[h-1][w-1] + input[h-1][w] + input[h-1][w+1]
                        + input[h][w-1] + input[h][w+1]
                        + input[h+1][w-1] + input[h+1][w]+input[h+1][w+1]
                    if !next.contains("#") {
                        hasChanges = true
                        char = "#"
                    }
                } else { //# case
                    let next = input[h-1][w-1] + input[h-1][w] + input[h-1][w+1]
                        + input[h][w-1] + input[h][w+1]
                        + input[h+1][w-1] + input[h+1][w]+input[h+1][w+1]
                    if next.filter({ $0 == "#"}).count >= 4 {
                        hasChanges = true
                        char = "L"
                    }
                    
                }
                newLine.append(char)
            }
            result.append(newLine)
        }
        
        return (result, hasChanges)
    }
    
    static func sanityCheck2() -> Int {
        let input = String.from(file: "day_11_check").components(separatedBy: "\n").filter { $0.count > 0}
        let stabilized = computeUntilStability2(input: input)
        let freeSets = stabilized.map({$0.map({$0 == "#" ? 1 : 0}).reduce(0, +)}).reduce(0, +)
        stabilized.forEach({print($0)})
        return freeSets
    }
    
    static func run() -> Int {
        let input = String.from(file: "day_11").components(separatedBy: "\n").filter { $0.count > 0}
        let stabilized = computeUntilStability(input: input)
        let freeSets = stabilized.map({$0.map({$0 == "#" ? 1 : 0}).reduce(0, +)}).reduce(0, +)
        return freeSets
    }
    
    static func run2() -> Int {
        let input = String.from(file: "day_11").components(separatedBy: "\n").filter { $0.count > 0}
        let stabilized = computeUntilStability2(input: input)
        let freeSets = stabilized.map({$0.map({$0 == "#" ? 1 : 0}).reduce(0, +)}).reduce(0, +)
        return freeSets
    }
    
    
    static func computeUntilStability2(input: [String]) -> [String] {
        var hasChanges = true
        var count : Int = 0
        let padding = String(repeating: ".", count: input[0].count + 2)
        var padded = [padding] + input.map({ "." + $0 + "." }) + [padding]
        //     padded = padded.map { $0.replacingOccurrences(of: "L", with: "#")}
        while hasChanges {
            
            let (res, changes) = compute2(input: padded)
            padded = res
            
            hasChanges = changes
            count += 1
        }
        
        return padded
    }
    static func compute2(input: [String]) -> ([String], Bool) {
        
        let width = input[0].count
        let height = input.count
        var hasChanges: Bool = false
        var result: [String] = []
        var newLine = ""
        
        for h in 0..<height {
            newLine = ""
            for w in 0..<width {
                //    print("Line \(h) - Column \(w)")
                var char = String(input[h][w])
                if char == "." {
                    //Do nothing
                } else if char == "L" {
                    let nextDash = findAdjacents(at: (h,w), in: input)
                    if nextDash == 0 {
                        hasChanges = true
                        char = "#"
                    }
                } else { //# case
                    let nextDash = findAdjacents(at: (h,w), in: input)
                    
                    if nextDash >= 5 {
                        hasChanges = true
                        char = "L"
                    }
                    
                }
                newLine.append(char)
            }
            result.append(newLine)
        }
        
        return (result, hasChanges)
    }
    
    
    static func findAdjacents(at: (Int, Int), in list: [String], depth: Int) -> Int {
        
        let (y,x) = at
        let directions: [(Int, Int)] = [
            (1,0),
            (1,1),
            (0,1),
            (-1,1),
            (-1,0),
            (-1,-1),
            (0,-1),
            (1,-1)]
        
        let adjacents = directions.map { (dy, dx) -> String in
            for i in 1..<list[0].count {
                let newVal = list.elemAt(y + i*dy, x + i*dx)
                if newVal != "." {
                    return newVal
                }
            }
            return "."
        }
        return adjacents.filter({$0 == "#"}).count
    }
}
