import UIKit
import Combine

//: # SwitchToLatest
//: 업스트림 `Publisher`가 최근에 방출한 항목을 새로운 Publisher로 변환해 항목을 방출하는 Publisher입니다. 앞서 만들어진 Publisher는 더 이상 항목을 방출하지 않습니다.

var cancellable = Set<AnyCancellable>()

struct Todo: Codable {
    var id: Int
    var title: String
}

var todosPublisher = PassthroughSubject<Int, URLError>()

todosPublisher
    .map { page -> URLSession.DataTaskPublisher in
        let url = URL(string:"https://jsonplaceholder.typicode.com/users/\(page)/todos")!
        return URLSession.shared.dataTaskPublisher(for: url)
    }
    .switchToLatest()
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

for index in 1...5 {
    DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(index/10)) {
        todosPublisher.send(index)
    }
}

//: RxSwift와 유사한 개념: FlatMapLatest
