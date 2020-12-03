import Foundation

public struct Day3 {
    
    private static func runSlope(x: Int, y: Int) -> Int {
        
        let rows : [String] = day3Input.components(separatedBy: "\n")
        let width = 31
        var treeCount = 0
        var currentXPos = 0
        var currentYpos = 0

        
        while currentYpos < rows.count - 1 {
            currentXPos = (currentXPos + x) % width
            currentYpos += y
            
            let row = rows[currentYpos]
            let square = row[currentXPos % width]
            
            if square == "#" {
                treeCount += 1
            }
            
        }
        
        print("Found \(treeCount)")
        return treeCount
        
    }
    public static func run() {
       print(runSlope(x: 3, y: 1))
    }

    public static func run2() {
        let slop1Tress = runSlope(x: 1, y: 1)
        let slop2Tress = runSlope(x: 3, y: 1)
        let slop3Tress = runSlope(x: 5, y: 1)
        let slop4Tress = runSlope(x: 7, y: 1)
        let slop5Tress = runSlope(x: 1, y: 2)
        
        print([slop1Tress, slop2Tress, slop3Tress, slop4Tress, slop5Tress]
                .map { "\($0)"}.joined(separator: " * ")
                + " = \([slop1Tress, slop2Tress, slop3Tress, slop4Tress, slop5Tress].reduce(1, *))")
        print()
    }
}
