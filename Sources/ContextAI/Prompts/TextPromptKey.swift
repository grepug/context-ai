import SwiftAI

public enum TextPromptKey: String, Hashable, Sendable {
    case translator
    case studyNotes
    case thesaurus
    case memorizingHelper
    case collocations
    case usages
}

extension TextPromptKey {
    var template: String {
        switch self {
        case .collocations: PromptTemplates.collocations
        case .translator: PromptTemplates.translator
        case .studyNotes: PromptTemplates.studyNotes
        case .thesaurus: PromptTemplates.thesaurus
        case .memorizingHelper: PromptTemplates.memorizingHelper
        case .usages: PromptTemplates.usages
        }
    }

    func prompt(input: AICompletionNormalizedInput) -> AIStaticTextCompletion<AICompletionNormalizedInput> {
        .init(
            key: rawValue,
            input: input,
            staticTemplate: template
        )
    }
}
