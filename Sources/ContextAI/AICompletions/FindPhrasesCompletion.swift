import ContextSharedModels
import SwiftAI

public struct FindPhrasesCompletion: AIStreamTask {
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
        public struct Phrase: CoSendable, Hashable {
            public let phrase: String
            public let lemma: String
            public let adja: String
            public let sense: LocaledStringDict
            public let desc: LocaledStringDict
            public let syn: String

            public init(phrase: String, lemma: String, adja: String, sense: LocaledStringDict, desc: LocaledStringDict, syn: String) {
                self.phrase = phrase
                self.lemma = lemma
                self.adja = adja
                self.sense = sense
                self.desc = desc
                self.syn = syn
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

    public func reduce(partialOutput: inout Output, chunk: Output) {
        partialOutput = chunk
    }

    public func initialOutput() -> Output {
        .init(phrases: [])
    }
}
