import ContextSharedModels
import SwiftAI

public struct SelectSenseCompletion: AITask {
    public var key: String {
        "selectSense"
    }

    public struct Input: AITaskInput {
        public let text: String
        public let word: String
        public let langs: String
        public let adja: String
        public let sense: String

        public init(text: String, word: String, langs: [CTLocale] = [.en, .zh_Hans], adja: String, sense: String) {
            self.text = text
            self.word = word
            self.langs = langs.map { $0.rawValue }.joined(separator: ",")
            self.adja = adja
            self.sense = sense
        }
    }

    public enum Output: AITaskOutput {
        case aiSense(LocaledStringDict)
        case index(Int)
    }

    public var input: Input

    public init(input: Input) {
        self.input = input
    }
}
