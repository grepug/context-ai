import SwiftAI

public enum TextCompletionKey: String, Hashable, Sendable {
    case translator
    case studyNotes
    case thesaurus
    case memorizingHelper
    case collocations
    case usages
}

extension TextCompletionKey {
    public func makeTaskForClient(input: AICompletionNormalizedInput) -> AIStaticTextCompletion<AICompletionNormalizedInput> {
        .init(
            key: rawValue,
            input: input,
            // for client, we don't need to provide the static template
            staticTemplate: ""
        )
    }
}
