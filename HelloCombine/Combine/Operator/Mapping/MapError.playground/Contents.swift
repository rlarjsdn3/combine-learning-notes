import UIKit
import Combine

//: MapError
//: 업스트림 `Publisher`가 방출하는 에러가 담긴 항목을 특정 예외로 변환하는 Publisher입니다.

var cancellable = Set<AnyCancellable>()

enum CombineError: Error {
    case null
    case anotherNull
}

enum AnotherCombineError: Error {
    case anotherNull
}

[1, 2, nil, 4, nil].publisher
    .tryMap { value -> Int in
        guard let value = value else {
            throw CombineError.null
        }
        return value
    }
    .mapError { _ in return CombineError.anotherNull }
    .sink { completion in
        switch completion {
        case .finished:
            print("Completion: \(completion)")
        case let .failure(error):
            print("Error: \(error)")
        }
    } receiveValue: { value in
        print(value)
    }

