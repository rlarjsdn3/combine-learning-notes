import UIKit
import Combine

//: # FlatMap
//: 업스트림 `Publisher`에서 방출하는 모든 항목을 새로운 Publisher로 변환해 항목을 방출하는 Publisher입니다. 동시에 구독할 수 있는 최대 Publisher 수를 지정해야 합니다.

var cancellable = Set<AnyCancellable>()

struct Todo: Codable {
    var id: Int
    var title: String
}

var todosPublisher = PassthroughSubject<Int, URLError>()

todosPublisher
    .flatMap { page -> URLSession.DataTaskPublisher in
        let url = URL(string:"https://jsonplaceholder.typicode.com/users/\(page)/todos")!
        return URLSession.shared.dataTaskPublisher(for: url)
    }
    .sink(
        receiveCompletion: { completion in
            switch completion {
            case .finished:
                print("Finished: \(completion)")
            case let .failure(error):
                print("Failure: \(error)")
            }
        },
        receiveValue: { (data, response) in
            let httpResponse = response as? HTTPURLResponse
            guard let statusCode = httpResponse?.statusCode,
                  (200..<300) ~= statusCode else {
                print("Bad Request")
                return
            }
            print(String(data: data, encoding: .utf8)!)
        }
    )
    .store(in: &cancellable)

todosPublisher.send(1)
todosPublisher.send(2)
todosPublisher.send(3)
todosPublisher.send(completion: .finished)

//: RxSwift와 유사한 개념: FlatMap
