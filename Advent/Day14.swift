//
//  day_14.swift
//  Advent
//
//  Created by Célian MOUTAFIS on 14/12/2020.
//

import Foundation

extension String {
    func frontPadding(toLength length: Int, withPad pad: String, startingAt index: Int) -> String {
        return String(String(self.reversed()).padding(toLength: length, withPad: pad, startingAt: index).reversed())
    }
    
//    subscript(idx: Int) -> String {
//        if idx >= self.count {
//            fatalError("Out of bound exception. \(idx) is greatear than \(self.count)")
//        }
//        return String(self[index(startIndex, offsetBy: idx)])
//    }
}


struct Day14 : Day {
    
    enum Component {
        case mask(String)
        case instruction(address: Int, value: Int)
    }
    
    static func sanityCheck() -> Int {
        let input = String.from(file: "day_14_check").components(separatedBy: "\n").filter({$0.count>0})
        return execute(lines: input)
    }
    
    static func execute(lines: [String]) -> Int {
        let comps = parse(lines: lines)
        
        var mask: String = ""
        var stack : [Int: Int] = [:]
        comps.forEach { (comp) in
            switch comp {
            case .mask(let _mask):
                mask = _mask
            case .instruction(address: let address, value: let value):
               
                let binaryValue = String(value, radix: 2).frontPadding(toLength: mask.count, withPad: "0", startingAt: 0)
                print(binaryValue)
                print(mask)
                
                var res: [Character] = []
                for i in 0..<binaryValue.count {
                    let index = binaryValue.index(binaryValue.startIndex, offsetBy: i)
                    if mask[i] == "1" || mask[i] == "0" {
                        res.append(mask[index])
                    }else{
                        res.append(binaryValue[index])
                    }
                }
                
                let finalBinary = String(res)
                let intBinary = Int(finalBinary, radix: 2)!
                stack[address] =  intBinary
                
                break
            }
        }
        
        return stack.map{$0.value}.reduce(0, +)
    }
    
    
    static func execute2(lines: [String]) -> Int {
        let comps = parse(lines: lines)
        
        var mask: String = ""
        var stack : [Int: Int] = [:]
        comps.forEach { (comp) in
            switch comp {
            case .mask(let _mask):
                mask = _mask
            case .instruction(address: let address, value: let value):
               
                let binaryAdress = String(address, radix: 2).frontPadding(toLength: mask.count, withPad: "0", startingAt: 0)
                print(binaryAdress)
                print(mask)
                
                var res: [Character] = []
                for i in 0..<binaryAdress.count {
                    let index = binaryAdress.index(binaryAdress.startIndex, offsetBy: i)
                    if mask[i] == "0" {
                        res.append(binaryAdress[index])
                    }else if mask[i] == "1" {
                        res.append("1")
                    } else {
                        res.append("X")
                    }
                }
                
                let finalBinary = String(res)
                let solutions = floatingBinary(finalBinary)
                
                for solution in solutions {
                    stack[solution] = value
                }
                
                
                break
            }
        }
        
        return stack.map{$0.value}.reduce(0, +)
    }
    
    
    static func floatingBinary(_ binary: String) -> [Int] {
        let xCount = binary.filter({$0 == "X"}).count
        
        
        let possibilities =  Int(pow(2, Double(xCount)))
        
        var result: [Int] = []
        for i in 0..<possibilities {
            let _binaryOption = String(i, radix: 2).frontPadding(toLength: xCount, withPad: "0", startingAt: 0)
           var j = 0
            var solution: [String] = []
            binary.forEach { (char) in
                if char == "X" {
                    let replacmeent = _binaryOption[_binaryOption.index(_binaryOption.startIndex, offsetBy: j)]
                    solution.append(String(replacmeent))
                    j+=1
                } else {
                    solution.append(String(char))
                }
            }
            
            result.append(Int(solution.joined(), radix: 2)!)
            
            
        }
        return result
    }
    
    static func parse(lines: [String]) -> [Component] {
        
        let maskPattern = "mask = ([01X]+)"
        let memPattern = #"mem\[([0-9]+)\] = ([0-9]+)"#
        
        let maskReg = try! NSRegularExpression(pattern: maskPattern, options: [])
        let memReg = try! NSRegularExpression(pattern: memPattern, options: [])
        return lines.compactMap { (line) -> Component? in
            
            if let match = maskReg.firstMatch(in: line, options: [], range: NSRange(location: 0, length: line.count)) {
                let mask = (line as NSString).substring(with: match.range(at: 1))
                return .mask(mask)
            } else if let match = memReg.firstMatch(in: line, options: [], range: NSRange(location: 0, length: line.count))  {
                let memory = (line as NSString).substring(with: match.range(at: 1))
                let val = (line as NSString).substring(with: match.range(at: 2))
                
                if let intMem = Int(memory), let intVal = Int(val) {
                    return .instruction(address: intMem, value: intVal)
                }
            }
            
            
           return nil
        }
    }
    
    static func sanityCheck2() -> Int {
        let input = String.from(file: "day_14_check2").components(separatedBy: "\n").filter({$0.count>0})
        return execute2(lines: input)
    }
    
    static func run() -> Int {
        let input = String.from(file: "day_14").components(separatedBy: "\n").filter({$0.count>0})
        return execute(lines: input)
    }
    
    static func run2() -> Int {
        let input = String.from(file: "day_14").components(separatedBy: "\n").filter({$0.count>0})
        return execute2(lines: input)
    }
    
    
}
