import ContextSharedModels
import Foundation
import SwiftAI

public struct CheckAppReviewWorkflow: AITask {
    public static var kind: String {
        "checkAppReview"
    }

    public var input: Input

    public init(input: Input = .init()) {
        self.input = input
    }

    public struct Input: AITaskInput {
        public init() {}
    }

    public struct Output: AITaskOutput {
        public var isReviewing: Bool

        public init(isReviewing: Bool) {
            self.isReviewing = isReviewing
        }
    }
}
