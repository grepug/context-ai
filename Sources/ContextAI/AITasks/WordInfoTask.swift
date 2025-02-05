import ContextSharedModels
import SwiftAI

public struct WordInfoTask: AITask {
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
    }

    public let input: Input

    public init(input: Input) {
        self.input = input
    }

    public func template() async throws -> String {
        PromptTemplates.wordInfo
    }

    public func transform(chunk: String, accumulatedString: inout String) -> (output: Output?, shouldStop: Bool) {
        accumulatedString += chunk

        let reg = #/(.*?)(\^\^|$)/#

        guard let match = accumulatedString.firstMatch(of: reg) else {
            return (nil, false)
        }

        let items = String(match.output.1)
            .split(separator: "#;;;")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }

        guard items.count >= 2 else {
            return (nil, false)
        }

        let synonym = items[0]
        let descString = items[1]

        if !descString.isEmpty && accumulatedString.contains("^^") {
            let desc = makeMultipleLocales(descString)

            return (Output(synonym: synonym, desc: desc), true)
        }

        return (nil, false)
    }

    public func transform(finalText text: String) -> Output {
        fatalError("Not implemented")
    }
}
