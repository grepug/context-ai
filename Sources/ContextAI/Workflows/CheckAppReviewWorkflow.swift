import ContextSharedModels
import Foundation
import SwiftAI

public struct CheckAppReviewWorkflow: AITask {
    public static var kind: String {
        "checkAppReview"
    }

    public var input: Input

    public init(input: Input) {
        self.input = input
    }

    public struct Input: AITaskInput {
        public let version: String
        public let build: String

        public init(version: String, build: String) {
            self.version = version
            self.build = build
        }
    }

    public struct Output: AITaskOutput {
        public var isReviewing: Bool

        public init(isReviewing: Bool) {
            self.isReviewing = isReviewing
        }
    }
}
