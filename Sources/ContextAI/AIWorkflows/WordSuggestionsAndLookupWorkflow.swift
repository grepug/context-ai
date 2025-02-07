import ContextSharedModels
import Foundation
import SwiftAI

public struct WordSuggestionsAndLookupWorkflow: AITask {
    public var key: String {
        "wordSuggestionAndLookup"
    }

    public struct Input: AITaskInput {
        public let text: String
        public let langs: [CTLocale]

        public init(text: String, langs: [CTLocale] = [.en, .zh_Hans]) {
            self.text = text
            self.langs = langs
        }
    }

    public typealias StreamChunk = Output

    public struct Output: AITaskOutput {
        public var suggestedItems: [UUID: ContextModel.ContextSegment]
        public var recurringItems: [UUID: ContextModel.ContextSegment]

        public init(suggestedItems: [UUID: ContextModel.ContextSegment] = [:], recurringItems: [UUID: ContextModel.ContextSegment] = [:]) {
            self.suggestedItems = suggestedItems
            self.recurringItems = recurringItems
        }
    }

    public var input: Input

    public func assembleOutput(chunks: [StreamChunk]) -> Output {
        chunks.reduce(into: .init()) { result, chunk in
            result.suggestedItems.merge(chunk.suggestedItems) { $1 }
            result.recurringItems.merge(chunk.recurringItems) { $1 }
        }
    }

    public init(input: Input) {
        self.input = input
    }
}
