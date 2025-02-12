import SwiftAI

public struct TranslatorTextCompletion: AITextStreamCompletion {
    public typealias Output = AITextStreamCompletionOutput
    public typealias StreamChunk = AITextStreamCompletionOutput

    public var input: Input

    public init(input: Input) {
        self.input = input
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
