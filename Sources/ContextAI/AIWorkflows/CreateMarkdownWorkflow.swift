import ContextSharedModels
import Foundation
import SwiftAI

public struct CreateMarkdownWorkflow: AIStreamTask {
    public func initialOutput() -> Output {
        .init(markdown: "")
    }

    public func reduce(partialOutput: inout Output, chunk: Output) {
        partialOutput.markdown += chunk.markdown
    }

    public static var kind: String {
        "createMarkdown"
    }

    public struct Input: AITaskInput {
        public enum Bool: Int, AITaskInput {
            case `true`
            case `false`
        }

        public let texts: [String]
        public let disableAI: Bool

        public init(text: String, disableAI: Swift.Bool = false) {
            self.texts = [text]
            self.disableAI = disableAI ? .true : .false
        }

        public init(texts: [String], disableAI: Swift.Bool = false) {
            self.texts = texts
            self.disableAI = disableAI ? .true : .false
        }
    }

    public struct Output: AITaskOutput {
        public var markdown: String

        public init(markdown: String) {
            self.markdown = markdown
        }
    }

    public var input: Input

    public init(input: Input) {
        self.input = input
    }
}
