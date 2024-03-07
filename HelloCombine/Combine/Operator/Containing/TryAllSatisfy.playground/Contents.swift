import UIKit
import Combine

//: # TryAllSatisfy
//: 업스트림 `Publisher`가 방출하는 모든 항목이 클로저로 주어진 조건을 만족하면 Bool 타입을 방출하는 Publisher입니다.

var cancellable = Set<AnyCancellable>()

enum CombineError: Error {
    case multipledBy3
}

[2, 4, 6, 8, 10].publisher
    .tryAllSatisfy { value in
        if value % 3 == 0 { throw CombineError.multipledBy3 }
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


