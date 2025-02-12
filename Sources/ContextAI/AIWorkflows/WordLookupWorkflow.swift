import ContextSharedModels
import Foundation
import SwiftAI

public struct WordLookupWorkflow: AIStreamTask {
    public func initialOutput() -> ContextModel.ContextSegment {
        .init()
    }

    public func reduce(partialOutput: inout ContextModel.ContextSegment, chunk: ContextModel.ContextSegment) {
        partialOutput.text += chunk.text
    }

    public static var kind: String {
        "wordLookup"
    }

    public struct Input: AITaskInput {
        public let text: String
        public let token: ContextModel.TokenItem

        public init(text: String, token: ContextModel.TokenItem) {
            self.text = text
            self.token = token
        }
    }

    public typealias Output = ContextModel.ContextSegment

    public var input: Input

    public init(input: Input) {
        self.input = input
    }
}
