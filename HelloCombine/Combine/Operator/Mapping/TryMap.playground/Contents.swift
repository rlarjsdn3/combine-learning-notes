import UIKit
import Combine

//: TryMap
//: 업스트림 `Publisher`가 방출하는 모든 항목을 주어진 예외를 던질 수 있는 클로저가 반환하는 값으로 변환하는 Publisher입니다.

var cancellable = Set<AnyCancellable>()

enum CombineError: Error {
    case null
}

[1, 2, nil, 4, nil].publisher
    .tryMap { value -> Int in
        guard let value = value else {
            throw CombineError.null
        }
        return value
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

