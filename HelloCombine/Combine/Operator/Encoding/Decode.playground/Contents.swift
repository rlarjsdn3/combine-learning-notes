import UIKit
import Combine

//: # Decode
//: 업스트림 `Pubilsher`가 방출하는 항목을 디코딩(JSON→구조체)해주는 Publisher입니다.

var cancellable = Set<AnyCancellable>()

struct Article: Codable {
    let title: String
    let author: String
    let pubDate: Date
}

let dataPublisher = PassthroughSubject<Data, Never>()
dataPublisher
    .decode(type: Article.self, decoder: JSONDecoder())
    .sink { completion in
        switch completion {
        case .finished:
            print("Finished: \(completion)")
        case let .failure(error):
            print("Failure: \(error)")
        }
    } receiveValue: { value in
        print("value: \(value)")
    }
    .store(in: &cancellable)

dataPublisher.send(Data("{\"pubDate\":1574273638.575666, \"title\" : \"My First Article\", \"author\" : \"Gita Kumar\" }".utf8))

