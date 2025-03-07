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
        public let text: String

        public init(text: String) {
            self.text = text
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
