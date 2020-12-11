import Foundation

public struct Day9: Day {
    public static func sanityCheck() -> Int {
        let input = String.from(file: "day_9_check")
        let numbers = input.components(separatedBy:"\n").compactMap { Int($0) }
        return findFirstNonMatching(preamble: 5, in: numbers)
    }
    
    private static func findFirstNonMatching(preamble: Int, in list: [Int]) -> Int {
        
        for i in preamble..<list.count {
            let target: Int = list[i]
          //  print("Search parents for \(target)")
            let ancestors: [Int] = Array(list[i-preamble..<i])
          //  print("+ Ancestors are: \(ancestors)")
            var matchings: (Int, Int)?
            
            for j in 0..<ancestors.count-1 {
                if matchings != nil { break }
                for k in j..<ancestors.count {
                    if (ancestors[j] + ancestors[k] == target) {
                       // print("* \(ancestors[j]) + \(ancestors[k]) == \(target)")
                        matchings = (ancestors[j], ancestors[k])
                        break
                    } else {
                      //  print("+ \(ancestors[j]) + \(ancestors[k]) != \(target)")
                    }
                }
            }
            
            if matchings == nil {
                return target
            }
            
        }
        return 0
    }
    
    public static func sanityCheck2() -> Int {
        let input = String.from(file: "day_9_check")
        let numbers = input.components(separatedBy:"\n").compactMap { Int($0) }
        let nonMatching = findFirstNonMatching(preamble: 5, in: numbers)
        
        
        return findContiguousParents(of: nonMatching, in: numbers)
    }
    
    private static func findContiguousParents(of nonMatching: Int, in _list: [Int]) -> Int {
        guard let nonMatchingIndex = _list.firstIndex(of: nonMatching), nonMatching != NSNotFound else {
            print("Index not found"); return -1 }
        let list = _list.prefix(nonMatchingIndex)
        
        
        
        for left in 0..<list.count-1 {
            for right in left..<list.count {
                let ancestors = list[left...right]
                let sum = ancestors.reduce(0, +)
                
             //  print(ancestors.map({String($0)}).joined(separator: "+")+" = \(sum)")
                if sum == nonMatching {
                    print(ancestors.map({String($0)}).joined(separator: "+")+" = \(sum)")
                    return (ancestors.min()! + ancestors.max()!)
                } else if (sum > nonMatching) {
                    break
                }
            }
        }
        
//        var index = 0
//
//        while index < list.count {
//            print("Index : \(index)")
//            for i in 0..<(list.count - index - 1) {
//                let allSum = list[index+i..<list.count]
//                let allSumValue = allSum.reduce(0, +)
//               // print("+ Sum \(allSumValue) of \(allSum.count) elements")
//                if allSumValue == nonMatching {
//                    print("FOUND \(allSum) = \(nonMatching)")
//                    return (allSum.min()! + allSum.max()!)
//                }
//            }
//            index += 1
//        }
        
        return -1
        
    }
    
    
    
    public static func run() -> Int {
        let input = String.from(file: "day_9")
        let numbers = input.components(separatedBy:"\n").compactMap { Int($0) }
        return findFirstNonMatching(preamble: 25, in: numbers)
    }
    
    public static func run2() -> Int {
        let input = String.from(file: "day_9")
        let numbers = input.components(separatedBy:"\n").compactMap { Int($0) }
        let nonMatching = findFirstNonMatching(preamble: 25, in: numbers)
        
        
        return findContiguousParents(of: nonMatching, in: numbers)
    }
    
    
    
}
