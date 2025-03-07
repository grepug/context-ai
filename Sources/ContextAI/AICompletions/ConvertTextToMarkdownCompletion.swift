import ContextSharedModels
import SwiftAI

public struct ConvertTextToMarkdownCompletion: AIStreamTask {
    public static var kind: String {
        "convertTextToMarkdown"
    }

    public struct Input: AITaskInput {
        public let text: String

        public init(text: String) {
            self.text = text
        }
    }

    public struct Output: AITaskOutput {
        public let markdown: String

        public init(markdown: String) {
            self.markdown = markdown
        }
    }

    public var input: Input

    public init(input: Input) {
        self.input = input
    }

    public func reduce(partialOutput: inout Output, chunk: Output) {
        partialOutput = Output(markdown: partialOutput.markdown + chunk.markdown)
    }

    public func initialOutput() -> Output {
        .init(markdown: "")
    }
}
