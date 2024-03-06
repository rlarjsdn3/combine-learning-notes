import UIKit
import Combine

//: Scan
//: 업스트림 `Publisher`가 방출하는 모든 항목을 이전에 연산된 값과 함께 연산한 예외를 던질 수 있는 클로저가 반환하는 값으로 변환하는 Publisher입니다.

var cancellable = Set<AnyCancellable>()

enum CombineError: Error {
    case overflow
}

[1, 2, 3, 4, 5].publisher
    .tryScan(0) { last, next in
        let result = last + next
        if result > 9 { throw CombineError.overflow }
        return result
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
