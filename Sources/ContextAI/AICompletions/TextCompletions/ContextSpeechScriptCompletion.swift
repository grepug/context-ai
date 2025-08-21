import ContextSharedModels
import SwiftAI

public struct ContextSpeechScriptCompletion: AITextStreamCompletion {
    public typealias Output = AITextStreamCompletionOutput
    public typealias StreamChunk = AITextStreamCompletionOutput

    public struct Input: AITaskInput {
        public let text: String
        public let terms: String

        public init(text: String, terms: [String]) {
            self.text = text
            self.terms = terms.joined(separator: ",")
        }
    }

    public enum Variant: AITaskInput {
        case zh_Hans
        case en

        var suffix: String {
            switch self {
            case .zh_Hans: ""
            case .en: "_en"
            }
        }
    }

    public init(input: Input, variant: Variant = .zh_Hans) {
        self.input = input
        self.variant = variant
    }

    public init(input: Input) {
        self.input = input
        self.variant = .zh_Hans
    }

    public var input: Input
    public var variant: Variant

    public static var kind: String {
        "contextSpeechScript"
    }

    public var path: String {
        "contextSpeechScript\(variant.suffix)"
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
