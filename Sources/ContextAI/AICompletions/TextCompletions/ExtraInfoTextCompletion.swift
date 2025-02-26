import ContextSharedModels
import SwiftAI

public struct ExtraInfoTextCompletion: AITextStreamCompletion {
    public typealias Output = AITextStreamCompletionOutput
    public typealias StreamChunk = AITextStreamCompletionOutput

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
        case thesaurus
        case memorizingHelper
        case collocations
        case usages
    }

    public var input: Input
    public var key: String

    public init(key: Key, input: Input) {
        self.key = key.rawValue
        self.input = input
    }

    public static var kind: String {
        "extraInfo"
    }

    public func makeOutput(chunk: String, cache: inout String) -> (output: Output?, shouldStop: Bool) {
        cache += chunk
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
}
