import UIKit
import Combine

//: # TryDropWhile
//: 업스트림 `Publisher`가 클로저로 주어진 조건을 만족하면 방출하는 항목을 무시하는 Publisher입니다. 한 번이라도 만족하지 아니하면 이후 항목을 계속 방출합니다.

var cancellable = Set<AnyCancellable>()

enum CombineError: Error {
    case negative
}

[2, 4, 1, -2, 3].publisher
    .tryDrop { value in
        if value < 0 { throw CombineError.negative }
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

// 한 가지 주의해야 할 점은 클로저가 주어진 조건을 한 번이라도 만족하지 아니하면 에러 방출 여부와 상관없이 모든 항목을 방출합니다. 에러가 담긴 항목을 방출해 스트림을 중단하고 싶다면 클로저가 주어진 조건을 만족하지 아니하기 전에 에러가 담긴 항목을 방출해야 합니다.
