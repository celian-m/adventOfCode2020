import Foundation
import PlaygroundSupport

public extension String {
    subscript(idx: Int) -> String {
        if idx >= self.count {
            fatalError("Out of bound exception. \(idx) is greatear than \(self.count)")
        }
        return String(self[index(startIndex, offsetBy: idx)])
    }
    
    
    static func from(file: String) -> String {
        guard let path = Bundle.main.path(forResource: file, ofType: "txt"),
        let data = FileManager.default.contents(atPath: path), let string = String(data: data, encoding: .utf8) else {
            fatalError("Can not get json data")
        }
        return string
    }
    
    func matches(_ pattern: String) -> Bool {
        let regexp = try! NSRegularExpression.init(pattern: pattern, options: [])
        let matches = regexp.numberOfMatches(in: self, options: [], range: .init(location: 0, length: self.count))
        return matches > 0
    }
    
    func matchValue(_ pattern: String, at: Int) -> String? {
        let regexp = try! NSRegularExpression.init(pattern: pattern, options: [])
        let match = regexp.firstMatch(in: self, options: [], range: .init(location: 0, length: self.count))
        if let match = match,
           match.numberOfRanges >= at {
            let range = match.range(at: at)
           return String((self as NSString).substring(with: range))
        }
        
        return nil
    }
}


