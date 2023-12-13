import Foundation

class GameRecord {
    var start: String
    var end: String
    var input: String
    var result: Bool
    var timestamp: Date

    init(start: String, end: String, input: String, result: Bool) {
        self.start = start
        self.end = end
        self.input = input
        self.result = result
        self.timestamp = Date()
    }
}
