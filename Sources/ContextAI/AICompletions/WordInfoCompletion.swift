import ContextSharedModels
import SwiftAI

public struct WordInfoCompletion: AITask {
    public var key: String {
        "wordInfo"
    }

    public struct Input: AITaskInput {
        public let text: String
        public let word: String
        public let langs: String
        public let adja: String

        public init(text: String, word: String, langs: [CTLocale] = [.en, .zh_Hans], adja: String) {
            self.text = text
            self.word = word
            self.langs = langs.map { $0.rawValue }.joined(separator: ",")
            self.adja = adja
        }
    }

    public struct Output: AITaskOutput {
        public let synonym: String
        public let desc: LocaledStringDict

        public init(synonym: String, desc: LocaledStringDict) {
            self.synonym = synonym
            self.desc = desc
        }
    }

    public let input: Input

    public init(input: Input) {
        self.input = input
    }
}
