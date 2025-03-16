import ContextSharedModels
import Foundation
import SwiftAI

public struct FetchFulltextSuggestionWorkflow: AITask {
    public static var kind: String {
        "fulltextSuggestion"
    }

    public var input: Input

    public init(input: Input) {
        self.input = input
    }

    public struct Input: AITaskInput {
        public init() {}
    }

    public struct Output: AITaskOutput {
        public var items: [FulltextSuggestedResourceItem]

        public init(items: [FulltextSuggestedResourceItem]) {
            self.items = items
        }
    }
}
