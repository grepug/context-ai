import ContextSharedModels
import SwiftAI

public struct SelectSensePrompt: AITask {
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

    public let input: Input

    public func template() async throws -> String {
        PromptTemplates.selectSense
    }

    public func transform(chunk: String, accumulatedString: inout String) -> (output: Output?, shouldStop: Bool) {
        accumulatedString += chunk

        if let match = accumulatedString.firstMatch(of: #/\^(.+?)\^/#) {
            let index = Int(match.output.1)

            if index != 0 {
                return (index.map { .index($0) }, true)
            }
        }

        if let match = accumulatedString.firstMatch(of: #/\%(.+?)\%/#) {
            return (.aiSense(makeMultipleLocales(String(match.output.1))), true)
        }

        return (nil, false)

    }

    public func transform(finalText text: String) -> Output {
        fatalError("Not implemented")
    }
}

func makeMultipleLocales(_ str: String) -> LocaledStringDict {
    let items = str.split(separator: "||").map { $0.trimmingCharacters(in: .whitespaces) }

    return items.reduce(into: [:]) { (acc, el) in
        guard let match = el.firstMatch(of: #/(.+?):\s?(.+?)$/#) else {
            return
        }

        let locale = CTLocale(String(match.output.1))
        let content = String(match.output.2)

        if let locale {
            acc[locale] = content
        }
    }
}
