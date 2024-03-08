import UIKit
import Combine

//: # Encode
//: 업스트림 `Pubilsher`가 방출하는 항목을 인코딩(구조체→JSON)해주는 Publisher입니다.

var cancellable = Set<AnyCancellable>()

struct Article: Codable {
    let title: String
    let author: String
    let pubDate: Date
}

let dataPublisher = PassthroughSubject<Article, Never>()
dataPublisher
    .encode(encoder: JSONEncoder())
    .sink { completion in
        switch completion {
        case .finished:
            print("Finished: \(completion)")
        case let .failure(error):
            print("Failure: \(error)")
        }
    } receiveValue: { value in
        guard let stringRepresentation = String(data: value, encoding: .utf8) else { return }
        print("Data received \(value) string representation: \(stringRepresentation)")
    }
    .store(in: &cancellable)

dataPublisher.send(Article(title: "나는 왜 너가 아니고 나인가", author: "시애틀 추장 외(류시화 엮음)", pubDate: Date()))
