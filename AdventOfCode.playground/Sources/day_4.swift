import Foundation

public struct Day4 {
    
    struct Passport {
        let byr: String
        let iyr: String
        let eyr: String
        let hgt: String
        let hcl: String
        let ecl: String
        let pid: String
        let cid: String?
    }
    
    
    public static func run() -> Int {
        let input = String.from(file: "day_4")
        let passList = passports(from: input)
        let result = passList.count
        return result
        
    }
    
    static func passports(from input: String) -> [Passport] {
        return input.components(separatedBy: "\n\n")
            .compactMap { (allPassFields) -> Passport? in
                let line = allPassFields.replacingOccurrences(of: "\n", with: " ")
                let fields = line.components(separatedBy: " ")
                
                var byr: String?
                var iyr: String?
                var eyr: String?
                var hgt: String?
                var hcl: String?
                var ecl: String?
                var pid: String?
                var cid: String?
                fields.forEach { (raw)  in
                    let comps = raw.components(separatedBy: ":")
                    if comps.count == 2 {
                        let (key, value) = (comps[0], comps[1])
                        
                        switch key {
                        case "byr":
                            byr = value
                        case "iyr":
                            iyr = value
                        case "eyr":
                            eyr = value
                        case "hgt":
                            hgt = value
                        case "hcl":
                            hcl = value
                        case "ecl":
                            ecl = value
                        case "pid":
                            pid = value
                        case "cid":
                            cid = value
                        default:
                            print("Unknown \(key)")
                        }
                    }
                }
                
                if let byr = byr,
                   let iyr = iyr,
                   let eyr = eyr,
                   let hgt = hgt,
                   let hcl = hcl,
                   let ecl = ecl,
                   let pid = pid {
                    return Passport(byr: byr, iyr: iyr, eyr: eyr, hgt: hgt, hcl: hcl, ecl: ecl, pid: pid, cid: cid)
                } else {
//                    print("Incorrect")
//                    print(line)
//                    print("---")
                    return nil
                }
                
                
            }
    }
    
    public static func run2() -> Int {
        let input = String.from(file: "day_4")
        let passList = passports(from: input)
            .filter { passport -> Bool in
            //byr
                
                guard let intbyr = Int(passport.byr),
                      intbyr >= 1920 && intbyr <= 2002 else {  return false }
                guard let intIyr = Int(passport.iyr),
                      intIyr >= 2010 && intIyr <= 2020 else {  return false }
                guard let eyr = Int(passport.eyr),
                      eyr >= 2020 && eyr <= 2030 else { return false }
                
                if  passport.hgt.matchValue("^([0-9]{2,3})(cm|in)$", at: 2) == "cm" {
                    guard let intStr = passport.hgt.matchValue("^([0-9]{2,3})(cm|in)$", at: 1),
                          let intValue = Int(intStr),
                          intValue <= 193 && intValue >= 150 else {  return false }
                } else if  passport.hgt.matchValue("^([0-9]{2,3})(cm|in)$", at: 2) == "in" {
                    guard let intStr = passport.hgt.matchValue("^([0-9]{2,3})(cm|in)$", at: 1),
                          let intValue = Int(intStr),
                          intValue <= 76 && intValue >= 59 else { return false }
                } else { return false }
                
        
                //hcl
                guard passport.hcl.matches("#[0-9a-f]{6,6}") else { return false }
                guard passport.ecl.matches("^(amb|blu|brn|gry|grn|hzl|oth)$") else { return false }
                guard passport.pid.matches("^[0-9]{9,9}$") else { return false }
            return true
        }
        let result = passList.count
        return result
    }
}
