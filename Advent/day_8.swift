import Foundation


public struct Day8Error: Error {
    let accValue: Int
}

public struct Day8 {
    
    struct Instruction: Equatable {
        let action: String
        let value: Int
        let id: UUID = UUID()
        
        
        static func ==(lhs: Instruction, rhs: Instruction) -> Bool {
            return lhs.id == rhs.id
        }
    }
    public static func sanityCheck() -> Int {
        
        let input = String.from(file: "day_8_check")
        let instructions: [Instruction] = input.components(separatedBy: "\n")
            .map({$0.components(separatedBy: " ")})
            .filter({$0.count > 1})
            .map {Instruction(action: $0[0], value: Int($0[1]) ?? 0)}
        
        do {
            let result =  try execute(instructions)
            return result
        } catch  {
            if let day8Error = error as? Day8Error {
                return day8Error.accValue
            } else {
                return -1
            }
        }
    }
    
    
    public static func sanityCheck2() -> Int {
        
        let input = String.from(file: "day_8_check")
        let instructions: [Instruction] = input.components(separatedBy: "\n")
            .map({$0.components(separatedBy: " ")})
            .filter({$0.count > 1})
            .map {Instruction(action: $0[0], value: Int($0[1]) ?? 0)}
        
        return fix(instructions)
    }
    
    public static func run2() -> Int {
        
        let input = String.from(file: "day_8")
        let instructions: [Instruction] = input.components(separatedBy: "\n")
            .map({$0.components(separatedBy: " ")})
            .filter({$0.count > 1})
            .map {Instruction(action: $0[0], value: Int($0[1]) ?? 0)}
        return fix(instructions)
    }
    
    public static func run() -> Int {
        
        let input = String.from(file: "day_8")
        
        let instructions: [Instruction] = input.components(separatedBy: "\n")
            .map({$0.components(separatedBy: " ")})
            .filter({$0.count > 1})
            .map {Instruction(action: $0[0], value: Int($0[1]) ?? 0)}
        
        do {
            let result =  try execute(instructions)
            return result
        } catch  {
            if let day8Error = error as? Day8Error {
                return day8Error.accValue
            } else {
                return -1
            }
        }
        
    }
    
    
    
    private static func fix(_ instructions: [Instruction] ) -> Int {
        for i in 0..<instructions.count {
            do {
            print("Try to fix instruction \(i) : \(instructions[i])")
            if instructions[i].action == "jmp" {
                var tmp = instructions
                let fixedInstruction = Instruction(action: "nop", value: instructions[i].value)
                tmp[i] = fixedInstruction
               
               
                let res = try execute(tmp)
                
                    print("Replaced \(instructions[i])")
                    print("Finished")
                    return res
                
            } else if instructions[i].action == "nop" {
                var tmp = instructions
                let fixedInstruction = Instruction(action: "jmp", value: instructions[i].value)
                tmp[i] = fixedInstruction
                let res = try execute(tmp)
                    print("Replaced \(instructions[i])")
                    print("Finished")
                    return res
            }
            } catch {
                continue
            }
        }
        
        return 0
    }
    
    private static func execute(_ instructions: [Instruction]) throws -> Int {
        
        var acc: Int = 0
        var alreadyPlayed: Set<UUID> = .init()
        
        var next: Instruction? = instructions[0]
        
        while next != nil {
            if (alreadyPlayed.contains(next!.id)) {
                throw Day8Error(accValue: acc)
            } else {
                alreadyPlayed.insert(next!.id)
            }
            
            switch next!.action {
            case "acc":
                acc+=next!.value
                let nextIndex = instructions.firstIndex(of: next!)! + 1
                if nextIndex >= instructions.count {
                    next = nil
                } else {
                    next = instructions[nextIndex]
                }
            case "nop":
                let nextIndex = instructions.firstIndex(of: next!)! + 1
                if nextIndex >= instructions.count {
                    next = nil
                } else {
                    next = instructions[nextIndex]
                }
            case "jmp":
                
                let nextIndex = instructions.firstIndex(of: next!)! + next!.value
                if nextIndex >= instructions.count {
                    next = nil
                } else {
                    next = instructions[nextIndex]
                }
            default:
                fatalError("Unhandled action \(next!.action)")
            }
        }
        
        return acc
        
    }
    
}
