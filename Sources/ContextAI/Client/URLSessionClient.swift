import EventSource
import Foundation
import SwiftAI

public struct URLSessionClient {
    let baseURL: URL
    let accessToken: String

    public init(baseURL: URL, accessToken: String) {
        self.baseURL = baseURL
        self.accessToken = accessToken
    }

    func makeURLRequest(key: String) -> URLRequest {
        let url =
            baseURL
            .appendingPathComponent("prompt")
            .appendingPathComponent(key)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        return request
    }

    public func stream<P: LLMPrompt>(prompt: P) -> AsyncThrowingStream<P.Output, Error> {
        let request = makeURLRequest(key: prompt.key)
        let (newStream, continuation) = AsyncThrowingStream<P.Output, Error>.makeStream()
        let stream = EventSourceClient(request: request).stream

        Task {
            do {
                for try await chunk in stream {
                    let output = try P.Output.fromString(chunk)
                    continuation.yield(output)
                }

                continuation.finish()
            } catch {
                continuation.finish(throwing: error)
            }
        }

        return newStream
    }

    public func request<P: LLMPrompt>(prompt: P) async throws -> P.Output {
        let request = makeURLRequest(key: prompt.key)
        let (data, _) = try await URLSession.shared.data(for: request)
        return try P.Output.fromData(data)
    }
}
