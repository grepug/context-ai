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

        public enum Source: String, AITaskInput {
            case epub
            case pdf
            case web
            case manualInput
        }

        public let texts: [String]
        public let source: Source

        public init(text: String, source: Source) {
            self.texts = [text]
            self.source = source
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
