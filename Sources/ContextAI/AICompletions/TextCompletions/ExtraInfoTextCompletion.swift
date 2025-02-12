import ContextSharedModels
import SwiftAI

public struct ExtraInfoTextCompletion: AITextStreamCompletion {
    public typealias Output = AITextStreamCompletionOutput

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

    public init(input: Input) {
        fatalError("Not implemented")
    }

    public enum Key: String {
        case extraInfo
        case studyNotes
        case thesaurus
        case memorizingHelper
        case collocations
        case usages
    }

    public var input: Input
    public var key: String
    public var promptTemplate: String

    public init(key: Key, input: Input, promptTemplate: String) {
        self.key = key.rawValue
        self.input = input
        self.promptTemplate = promptTemplate
    }

    public init?(key: String, input: Input, promptTemplate: String) {
        guard let key = Key(rawValue: key) else {
            return nil
        }

        self.key = key.rawValue
        self.input = input
        self.promptTemplate = promptTemplate
    }

    public static var kind: String {
        "extraInfo"
    }

    public func makeOutput(chunk: String, accumulatedString: inout String) -> (output: Output?, shouldStop: Bool) {
        accumulatedString += chunk
        return (Output(text: chunk), false)
    }

    public func makeOutput(string: String) -> Output {
        Output(text: string)
    }

    public var startSymbol: String? {
        "^^"
    }

    public var endSymbol: String? {
        "$$"
    }

    public func promptTemplate() async throws -> String {
        promptTemplate
    }
}
