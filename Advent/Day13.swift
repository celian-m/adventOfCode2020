//
//  Day13.swfit.swift
//  Advent
//
//  Created by Célian MOUTAFIS on 13/12/2020.
//

import Foundation

public struct Day13: Day {
    public static func sanityCheck2() -> Int {
        let input = String.from(file: "day_13_check").components(separatedBy: "\n")
        let _ids = input[1].components(separatedBy: ",").enumerated()
            .filter({$0.element != "x"})
            .compactMap { offset, element -> (Int, Int)? in
                if let intValue = Int(element) {
                    return (intValue, offset)
                }
                return nil
            }

        return findCommonDeparture(in: _ids)
    }
    
    public static func run() -> Int {
        let input = String.from(file: "day_13").components(separatedBy: "\n")
        let time = Int(input[0])!
        let ids = input[1].components(separatedBy: ",").filter({$0 != "x"}).compactMap({Int($0)})
        return findFirstDeparture(in: ids, at: time)
    }
    
    public static func run2() -> Int {
        let input = String.from(file: "day_13").components(separatedBy: "\n")
        let _ids = input[1].components(separatedBy: ",").enumerated()
            .compactMap { offset, element -> (Int, Int)? in
                if let intValue = Int(element) {
                    return (intValue, offset)
                }
                return nil
            }
        return findCommonDeparture(in: _ids)

    }
    
    public static func sanityCheck() -> Int {
        let input = String.from(file: "day_13_check").components(separatedBy: "\n")
        let time = Int(input[0])!
        let ids = input[1].components(separatedBy: ",").filter({$0 != "x"}).compactMap({Int($0)})
        return findFirstDeparture(in: ids, at: time)
    }
    
    
    
    static func findCommonDeparture(in list: [(id: Int, offset: Int)]) -> Int {
        
        let pgcm = list.map { $0.id }.reduce(1, *)
      
        let result = list.map { elem -> Int in
            let ni = elem.id
            let Ni = pgcm / ni
            
            
            //Avoid to hase an offset greater than the bus Id
            let ni_normlalized = (ni - elem.offset) % ni
            
            if ni_normlalized == 0 {
                return 0
            }
            var x = 0
            while (x*Ni)  % elem.id != 1 {
                x += 1
            }
            
            return ni_normlalized * x * Ni
            
        }
        
        return result.reduce(0, +) % pgcm
    }
    
    static func findFirstDeparture(in ids: [Int], at: Int) -> Int {
        
        let nextDepartures = ids
            .map({ (ceil(Double(at)/Double($0)) * Double($0), $0) })
        
        let firstDeparture : (Double, Int) = nextDepartures
            .sorted(by: { left, right -> Bool in
                return left.0 < right.0
            })
            .first!
        
        return Int(firstDeparture.0)//(Int(firstDeparture.0) - at) * firstDeparture.1
    }
}
