//
//  Day12.swift
//  Advent
//
//  Created by Célian MOUTAFIS on 12/12/2020.
//

import Foundation

struct Day12: Day {
    
    
    enum Instruction {
        case north(Int)
        case south(Int)
        case east(Int)
        case west(Int)
        
        case left(Int)
        case right(Int)
        case front(Int)
        
        static func from(_ string: String) -> Instruction? {
            let order = string.prefix(1)
            guard let count = Int(string.suffix(string.count-1)) else { return nil}
            
            switch order {
            case "N":
                return .north(count)
            case "S":
                return .south(count)
            case "E":
                return .east(count)
            case "W":
                return .west(count)
                
            case "L":
                return .left(count)
            case "R":
                return .right(count)
            case "F":
                return .front(count)
            default:
               return nil
            }
        }
    }
    static func sanityCheck() -> Int {
        let inputs = String.from(file: "day_12_check").components(separatedBy: "\n")
            .filter({$0.count > 0})
            .compactMap({Instruction.from($0)})
        
        let res = navigate(following: inputs)
        return res
    }
    
    static func navigate(following: [Instruction]) -> Int {
        let res = following.reduce((direction: "E", north:0, east: 0)) { (current, instruction) -> (String, Int, Int) in
            
            let (currentDirection, currentNorth, currentEast) = current
            
            switch instruction {
            case .front(let distance):
                let coeffsN = ["N": 1, "S": -1, "E": 0, "W": 0]
                let coeffsE = ["N": 0, "S": 0, "E": 1, "W": -1]
                let north = currentNorth + distance * coeffsN[currentDirection]!
                let east = currentEast + distance * coeffsE[currentDirection]!
                return (currentDirection, north, east)
                
            case .left(let degrees):
                let directions = ["N", "E", "S", "W"]
                let angle = degrees / 90
                let start = directions.firstIndex(of: currentDirection)!
                let newDirection = directions[(start-angle+4)%4]
                return (newDirection, currentNorth, currentEast)
            case .right(let degrees):
                let directions = ["N", "E", "S", "W"]
                let angle = degrees / 90
                let start = directions.firstIndex(of: currentDirection)!
                let newDirection = directions[(start+angle)%4]
                return (newDirection, currentNorth, currentEast)
                
            case .east(let disance):
                return (currentDirection, currentNorth, currentEast+disance)
            case .west(let disance):
                return (currentDirection, currentNorth, currentEast-disance)
            case .north(let disance):
                return (currentDirection, currentNorth+disance, currentEast)
            case .south(let disance):
                return (currentDirection, currentNorth-disance, currentEast)
            }
        }
        
        return abs(res.1) + abs(res.2)
    }
    
    static func navigate2(following: [Instruction]) -> Int {
        let initial : (String, Int, Int, Int, Int) = (direction: "E", north:0, east: 0, 1, 10)
        let res = following.reduce(initial) { (current, instruction) -> (String, Int, Int, Int, Int) in
            
            let (currentDirection, currentNorth, currentEast, waupointNorth, waypointEast) = current

            switch instruction {
            case .front(let distance):
                return (currentDirection, currentNorth + distance*waupointNorth, currentEast + distance*waypointEast, waupointNorth, waypointEast)
                
            case .left(let degrees):
                let angle =  (((360-degrees) / 90) % 4)
                switch angle {
                case 0:
                    return (currentDirection, currentNorth, currentEast, waupointNorth, waypointEast)
                case 1:
                    return (currentDirection, currentNorth, currentEast,  -waypointEast, waupointNorth )
                case 2:
                    return (currentDirection, currentNorth, currentEast,  -waupointNorth,  -waypointEast )
                case 3:
                    return (currentDirection, currentNorth, currentEast,  waypointEast, -waupointNorth )
                default:
                    fatalError()
                }
            case .right(let degrees):
                let angle = (degrees / 90) % 4
                switch angle {
                case 0:
                    return (currentDirection, currentNorth, currentEast, waupointNorth, waypointEast)
                case 1:
                    return (currentDirection, currentNorth, currentEast,  -waypointEast, waupointNorth )
                case 2:
                    return (currentDirection, currentNorth, currentEast,  -waupointNorth,  -waypointEast )
                case 3:
                    return (currentDirection, currentNorth, currentEast,  waypointEast, -waupointNorth )
                default:
                    fatalError()
                }
                
            case .east(let distance):
                return (currentDirection, currentNorth, currentEast, waupointNorth, waypointEast+(distance))
            case .west(let distance):
                return (currentDirection, currentNorth, currentEast, waupointNorth, waypointEast-(distance))
            case .north(let distance):
                return (currentDirection, currentNorth, currentEast, waupointNorth+(distance), waypointEast)
            case .south(let distance):
                return (currentDirection, currentNorth, currentEast, waupointNorth-(distance), waypointEast)
            }
        }
        
        
        return Int(abs(res.1) + abs(res.2))
    }
    
    
    
    static func sanityCheck2() -> Int {
        let inputs = String.from(file: "day_12_check").components(separatedBy: "\n")
            .filter({$0.count > 0})
            .compactMap({Instruction.from($0)})
        
        let res = navigate2(following: inputs)
        return res
    }
    
    static func run() -> Int {
        let inputs = String.from(file: "day_12").components(separatedBy: "\n")
            .filter({$0.count > 0})
            .compactMap({Instruction.from($0)})
        
        let res = navigate(following: inputs)
        return res
    }
    
    static func run2() -> Int {
        let inputs = String.from(file: "day_12").components(separatedBy: "\n")
            .filter({$0.count > 0})
            .compactMap({Instruction.from($0)})
        
        let res = navigate2(following: inputs)
        return res
    }
    
    
}
