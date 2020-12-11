import Foundation


fileprivate var results: Int = 0

public struct Day10: Day {
    public static func sanityCheck() -> Int {
        let input = String.from(file: "day_10_check").components(separatedBy: "\n")
        let adapters = input.compactMap({ Int($0) })
        return -1 //chainAdapters(adapters) ?? -1
    }
    
    
    
    static func chainAdapters(_ adapters: [Int]) -> (Int, Int, Int) {
        let sorted = [0] + adapters.sorted()
        
        var differenceOf1: Int = 0
        var differenceOf2: Int = 0
        var differenceOf3: Int = 1
        
        for i in 0...sorted.count-2 {
            let diff = sorted[i+1] - sorted[i]
            switch diff {
            case 1:
                differenceOf1+=1
            case 2:
                differenceOf2+=1
            case 3:
                differenceOf3+=1
            default:
                break
            }
        }
        
       // print([differenceOf1, differenceOf2, differenceOf3])
        return (differenceOf1, differenceOf2, differenceOf3)
    }
    
    
    static func findArrangements(in list: [Int], path: [Int], log: String = "+") -> Int {
        let sorted =  list.sorted()
       
        
        var listOfDifferences = [Int]()
        _ = sorted.reduce(0) { (lastJolt, jolt) -> Int in
            listOfDifferences.append(jolt - lastJolt)
            return jolt
        }
        
        /*
         
         ab
         ba
         
         abc
         acb
         bac
         cab
         
         abcd
         abdc
         acbd
         cabd
         badc
         cbad
         dbca
         
         */
        
        let arrangementCountForConsecutiveOnes =
            [2 : 2, // 2 consecutive ones have 2 possible arrangements
             3 : 4, // 3 consecutive ones have 4 possible arrangements
             4 : 7] // 4 consecutive ones have 7 possible arrangements

        var consectuiveOnesCount = [Int:Int]()
        var consecutiveOnes = 0

        listOfDifferences.forEach { (diff) in
            if diff == 1{
                consecutiveOnes += 1
            } else {
                if consecutiveOnes > 1 {
                    consectuiveOnesCount[consecutiveOnes, default: 0] += 1
                }
                consecutiveOnes = 0
            }
        }

        let arragmentsCount = pow(Decimal(arrangementCountForConsecutiveOnes[2] ?? 0)
                                  ,consectuiveOnesCount[2] ?? 0)
            * pow(Decimal(arrangementCountForConsecutiveOnes[3] ?? 0),
                  consectuiveOnesCount[3] ?? 0)
            * pow(Decimal(arrangementCountForConsecutiveOnes[4] ?? 0),
                  consectuiveOnesCount[4] ?? 0)
       
        
        return Int(truncating: NSDecimalNumber(decimal: arragmentsCount))
            
    }
    

    
    public static func sanityCheck2() -> Int {
        let input = String.from(file: "day_10_check").components(separatedBy: "\n")
        let adapters = [0] + input.compactMap({ Int($0) }) + [49+3]
        results = 0
        findArrangements(in: adapters, path: [])
        print(chainAdapters(adapters))
        return results
    }
    
    
    
    static func test(list: [Int]) -> Int {
        return -1
    }
    
    public static func run() -> Int {
        let input = String.from(file: "day_10").components(separatedBy: "\n")
        let adapters = input.compactMap({ Int($0) })
        return -1 //chainAdapters(adapters) ?? -1
    }
    
    public static func run2() -> Int {
        let input = String.from(file: "day_10").components(separatedBy: "\n")
        let inputs = input.compactMap({ Int($0) })
        print(inputs.count)
        print(Set(inputs).count)
        print("MAX : \(inputs.sorted().last!)")
        
        let adapters = [0] + inputs + [inputs.sorted().last!+3]
        print(chainAdapters(adapters))
        return findArrangements(in: adapters, path: [])
    }
    
    
}
