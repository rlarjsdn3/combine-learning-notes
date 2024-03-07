import UIKit
import Combine

//: # TryContainsWhere
//: 업스트림 `Publisher`가 클로저로 주어진 조건을 만족하는 항목을 한 번이라도 방출하면 Bool 타입의 항목을 방출하는 Publisher입니다.

var cancellable = Set<AnyCancellable>()

enum CombineError: Error {
    case overflow
}

let arrayPublisher = [16, 32, 64, 128, 256].publisher
arrayPublisher
    .tryContains { value in
        if value > Int8.max { throw CombineError.overflow }
        return value == 256
    }
    .sink { completion in
        switch completion {
        case .finished:
            print("Fininshed: \(completion)")
        case let .failure(error):
            print("Failure: \(error)")
        }
    } receiveValue: { value in
        print(value)
    }
    .store(in: &cancellable)

