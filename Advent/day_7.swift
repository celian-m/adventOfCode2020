import Foundation

public struct Day7 {
    public static func sanityCheck() -> Int {
        
        let input = String.from(file: "day_7_check")
        let containers = parse(input: input)
        
        return containers.count
    }
    
    public static func sanityCheck2(_ name: String) -> Int {
        
        let input = String.from(file: "day_7_check")
        let statements = parse(input: input)
        let res = findLowerLuggage(for: name, in: statements, lvl: "*")
        return res
    }
    
    
    public static func run() -> Int {

        let input = String.from(file: "day_7")
        let statements = parse(input: input)
        
        let res = findBiggerLuggage(for: "shiny gold", stack: [], in: statements, lvl: "*")
        return res.count
    }
    
    
    public static func run2() -> Int {
        let input = String.from(file: "day_7")
        let statements = parse(input: input)
        let res = findLowerLuggage(for: "shiny gold", in: statements, lvl: "*") - 1 //Outer bag is nor counted
        return res

    }
    
    
    static func findLowerLuggage(for currentBag: String, in allStatements: [Statement], lvl: String) -> Int {
        
        //Find statement
        let statement = allStatements.first(where: {$0.name == currentBag})!
        if statement.subbags.count == 0 {
            return 1
        } else {
            return 1 + statement.subbags.map({ $0 * findLowerLuggage(for: $1, in: allStatements, lvl: lvl+"#")}).reduce(0, +)
        }

        
    }
    
    static func findBiggerLuggage(for currentBag: String, stack: Set<String>, in allStatements: [Statement], lvl: String) -> Set<String> {
        
        var result = stack
        
        if allStatements.count == 0 {
            return stack
        }
        
        for statement in allStatements.suffix(allStatements.count) {
            if result.contains(statement.name) {
                continue
            } else if statement.subbags.count == 0 {
                continue
            } else {
                statement.subbags.forEach { (_, color) in
                    if color == currentBag {
                        result.insert(statement.name)
                        let tmp = findBiggerLuggage(for: statement.name, stack: result, in: allStatements, lvl: lvl+"#")
                        tmp.forEach({result.insert($0)})
                        
                    }
                }
                
            }
        }
        
        return result
        
    }
    
    struct Statement {
        let name: String
        let subbags: [(Int, String)]
    }
    
    static func parse(input: String) -> [Statement] {
        //vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
        let pattern = #"([a-z ]+) bags contain ([0-9]+) ([a-z ]+) bags?(, ([0-9]+) ([a-z ]+) bags?)?(, ([0-9]+) ([a-z ]+) bags?)?(, ([0-9]+) ([a-z ]+) bags?)?(, ([0-9]+) ([a-z ]+) bags?)?\."#
        let regexp = try! NSRegularExpression(pattern: pattern, options: [])
        
        let emptyPattern = #"([a-z ]+) bags contain no other bags\."#
        let emptyRegexp = try! NSRegularExpression(pattern: emptyPattern, options: [])
        
        
        let statements = input
            .components(separatedBy: "\n")
            .compactMap { (line) -> Statement? in
                if let match = regexp.firstMatch(in: line,
                                                options: [],
                                                range: NSRange.init(location: 0, length: line.count)) {
                    if (match.numberOfRanges > 2) {
                        
                        var i = 3
                   
                        let bagRange = match.range(at: 1)
                        let bagColor = String((line as NSString).substring(with: bagRange))
                        
                        
                        var subbags: [(Int, String)] = []
                        while match.numberOfRanges >= i+1 {
                            let subbagRange = match.range(at: i)
                            if (subbagRange.location != NSNotFound) {
                                let subbagCount = String((line as NSString).substring(with: match.range(at: i-1)))
                                let subbagColor = String((line as NSString).substring(with: subbagRange))
                                subbags.append((Int(subbagCount) ?? 0, subbagColor))
                            }
                            i+=3
                        }
                        return Statement(name: bagColor, subbags: subbags)
                    } else {
                        return nil
                    }
                } else if let match = emptyRegexp.firstMatch(in: line,
                                                             options: [],
                                                             range: NSRange.init(location: 0, length: line.count)) {
                    let bagRange = match.range(at: 1)
                    let bagColor = String((line as NSString).substring(with: bagRange))
                    
                    return Statement(name: bagColor, subbags: [])
                    
                } else {
                    return nil
                }
            }
        
        return statements
        
     //   print(statements)
        
    }
}
