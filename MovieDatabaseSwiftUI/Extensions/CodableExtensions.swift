import Foundation

// Extension to make Dictionary Codable when keys are Ints and values are Codable
extension Dictionary: Codable where Key == Int, Value: Codable {
    public init(from decoder: Decoder) throws {
        self.init()
        
        let container = try decoder.singleValueContainer()
        let decodedDict = try container.decode([String: Value].self)
        
        for (key, value) in decodedDict {
            if let intKey = Int(key) {
                self[intKey] = value
            }
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        var stringKeyedDict = [String: Value]()
        
        for (key, value) in self {
            stringKeyedDict[String(key)] = value
        }
        
        try container.encode(stringKeyedDict)
    }
} 