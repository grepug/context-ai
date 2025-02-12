import ContextSharedModels
import SwiftAI

public struct AnyAITask: AITask {
    public static var kind: String { "" }
    public var input: AnyCodable
    public typealias Output = AnyCodable

    public init(input: AnyCodable) {
        self.input = input
    }
}

extension AnyCodable: @retroactive AITaskInput {
    public var normalized: AICompletionNormalizedInput {
        params
    }
}
