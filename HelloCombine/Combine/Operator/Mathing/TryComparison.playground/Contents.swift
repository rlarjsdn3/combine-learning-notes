import UIKit
import Combine

//: # TryComparison
//: 다른 `Publisher`가 방출한 새로운 항목이 이전에 방출한 항목보다 증가하는 순서에 있을 때만(비교 결과가 만족할 때만) 항목을 방출하는 Publisher입니다.

var cancellable = Set<AnyCancellable>()

enum CombineError: Error {
    case overflow
}

// ① 비교 로직 직접 구현-큰 값만 방출하는 방법

[3, 0, 9, 6, 5].publisher
    .tryMax { num1, num2 in
        if num1.isZero { throw CombineError.overflow }
        return num1 > num2
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

// ② 비교 로직 직접 구현-작은 값만 방출하는 방법

[3, 0, 9, 6, 11].publisher
    .tryMin { num1, num2 in
        if num1 > 10 { throw CombineError.overflow }
        return num1 > num2
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
