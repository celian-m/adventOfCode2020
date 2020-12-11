import Foundation

public struct Day6 {
    
    
    
    
    public static func run() -> Int {
        let input = String.from(file: "day_6")
        let groupsAnswers = input.components(separatedBy: "\n\n")
        let groupAnswersCounts = mapGroups(groupsAnswers)
        let result = groupAnswersCounts.reduce(0,+)
        return result
    }
    
    public static func run2() -> Int {
        let input = String.from(file: "day_6")
        let groupsAnswers = input.components(separatedBy: "\n\n")
        let groupAnswersCounts = mapGroups2(groupsAnswers)
        let result = groupAnswersCounts.reduce(0,+)
        return result
    }
    
    static func mapGroups(_ inputs: [String]) -> [Int] {
        return inputs.map { input -> Int in
            var distinctAnswers = Set<String>()
            input.replacingOccurrences(of: "\n", with: "")
                .forEach { char in
                    distinctAnswers.insert(String(char))
                }
            
            return distinctAnswers.count
        }
    }
    
    static func mapGroups2(_ inputs: [String]) -> [Int] {
        return inputs
            .map { input -> Int in
                var allAnswers = Set(input.replacingOccurrences(of: "\n", with: "")
                                        .flatMap({String($0)}))
                input.components(separatedBy: "\n")
                    .filter({$0.count > 0})
                    .forEach { (singleAnswers) in
                        
                        let filtered = allAnswers.filter { (char) -> Bool in
                            if !singleAnswers.contains(char) {
                                return false
                            } else {
                                return true
                            }
                        }
                        allAnswers = Set(filtered)
                    }
                
                return allAnswers.count
            }
        
    }
}
