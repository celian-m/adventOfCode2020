import Foundation

public extension String {
    subscript(idx: Int) -> String {
        if idx >= self.count {
            fatalError("Out of bound exception. \(idx) is greatear than \(self.count)")
        }
        return String(self[index(startIndex, offsetBy: idx)])
    }
}
