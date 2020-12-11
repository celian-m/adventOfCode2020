import Foundation

public struct Day5 {
        
    
    
    public static func sanityCheck() {
        /*
         BFFFBBFRRR: row 70, column 7, seat ID 567.
         FFFBBBFRRR: row 14, column 7, seat ID 119.
         BBFFBBFRLL: row 102, column 4, seat ID 820.
         */
        let qualification = qualify("FBFBBFFRLR", debug: true)
       assert(qualification == (44, 5, 357), "Sanity Check failed. Expected (44, 5, 567), found \(qualification)")
    }
    
    /**
     All range is from 0 to 127
     */
    static func qualify(_ pass: String, debug: Bool = false) -> (row: Int, column: Int, id: Int) {
        
        var minRow = 0
        var maxRow = 127
        
        var minColumn = 0
        var maxColumn = 7
        
        if (debug) {
            print("Rows \(minRow) through \(maxRow)")
        }
        pass.forEach { (char) in
            if (char == "F") {
                maxRow = minRow + Int(floor(Double(maxRow - minRow)/2))
            } else if (char == "B") {
                minRow += Int(ceil(Double(maxRow-minRow)/2))
            } else if (char == "L") {
                maxColumn = minColumn + Int(floor(Double(maxColumn - minColumn)/2))
            } else if (char == "R") {
                minColumn += Int(ceil(Double(maxColumn-minColumn)/2))
            }
            if (debug) {
                print("\(String(char)) - Rows \(minRow) through \(maxRow)")
                print("\(String(char)) - Column \(minColumn) through \(maxColumn)")
                print("--")
            }
        }
        
        return (minRow, minColumn, minRow*8+minColumn)
    }
    
    public static func run() -> Int {
        let input = String.from(file: "day_5")
        let boardList = input.components(separatedBy: "\n")
        let ids = boardList
            .map ({qualify($0)})
            .map ({$0.2})
        
        let maxId = ids.reduce(0, {old, new -> Int in return max(old, new)})
        print(maxId)
        
        return maxId
    }
    
    
    public static func run2() {
        let input = String.from(file: "day_5")
        let boardList = input.components(separatedBy: "\n")
        let ids = boardList
            .map ({qualify($0)})
            .map ({$0.2})
            .sorted(by: { $0 < $1 })
        
        for i in 0..<(ids.count-2) {
            if (ids[i+1] - ids[i] != 1) && ids[i] != 0 {
                print("Missing Id between \(ids[i]) and \(ids[i+1])")
            }
        }
    }
}
