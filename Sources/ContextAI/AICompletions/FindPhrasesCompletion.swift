import ContextSharedModels
import SwiftAI

public struct FindPhrasesCompletion: AITask {
    public static var kind: String {
        "findPhrases"
    }

    public struct Input: AITaskInput {
        public let text: String
        public let langs: String

        public init(text: String, langs: [CTLocale] = [.en, .zh_Hans]) {
            self.text = text
            self.langs = langs.map { $0.name }.joined(separator: ",")
        }
    }

    public struct Output: AITaskOutput {
        public struct Phrase: CoSendable {
            public let phrase: String
            public let lemma: String
            public let adja: String
            public let sense: LocaledStringDict
            public let desc: String

            public init(phrase: String, lemma: String, adja: String, sense: LocaledStringDict, desc: String) {
                self.phrase = phrase
                self.lemma = lemma
                self.adja = adja
                self.sense = sense
                self.desc = desc
            }
        }

        public let phrases: [Phrase]

        public init(phrases: [Phrase]) {
            self.phrases = phrases
        }
    }

    public var input: Input

    public init(input: Input) {
        self.input = input
    }
}
