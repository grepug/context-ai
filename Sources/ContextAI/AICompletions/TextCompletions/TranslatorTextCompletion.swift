import SwiftAI

public struct TranslatorTextCompletion: AITextStreamCompletion {
    public func promptTemplate() async throws -> String {
        promptTemplate
    }

    public typealias Output = AITextStreamCompletionOutput
    public typealias StreamChunk = AITextStreamCompletionOutput

    public var input: Input
    public var promptTemplate: String

    public init(input: Input) {
        fatalError()
    }

    public init(input: Input, promptTemplate: String) {
        self.input = input
        self.promptTemplate = promptTemplate
    }

    public static var kind: String {
        "translator"
    }

    public struct Input: AITaskInput {
        public let text: String
        public let target_language: String

        public init(text: String, target_language: String = "简体中文") {
            self.text = text
            self.target_language = target_language
        }
    }
}
