import UIKit
import Combine

//: # TryPrefixWhile
//: 업스트림 `Publisher`가 클로저로 주어진 조건을 만족하면 항목을 방출하는 Publisher입니다. 한 번이라도 만족하지 아니하면 이후 항목은 무시됩니다.

var cancellable = Set<AnyCancellable>()

enum CombineError: Error {
    case positive
}

[-4, -2, -6, 8, -4].publisher
    .tryPrefix { value in
        if value > 0 { throw CombineError.positive }
        return value % 2 == 0
    }
    .sink { completion in
        switch completion {
        case .finished:
            print("Finished: \(completion)")
        case let .failure(error):
            print("Failure: \(error)")
        }
    } receiveValue: { value in
        print(value)
    }
    .store(in: &cancellable)


