import SwiftAI

public struct ParaphraseCompletion: AITextStreamCompletion {
    public typealias Output = AITextStreamCompletionOutput
    public typealias StreamChunk = AITextStreamCompletionOutput

    public var input: Input

    public init(input: Input) {
        self.input = input
    }

    public static var kind: String {
        "paraphrase"
    }

    public struct Input: AITaskInput {
        public let text: String

        public init(text: String, ) {
            self.text = text
        }
    }
}
