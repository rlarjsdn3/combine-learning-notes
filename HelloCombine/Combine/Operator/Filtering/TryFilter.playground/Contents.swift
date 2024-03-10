import UIKit
import Combine

//: # TryFilter
//: 업스트림 `Publisher`가 방출하는 항목 중 클로저(조건)에 만족하는 항목만 재방출하는 Publisher입니다.

var cancellable = Set<AnyCancellable>()

enum CombineError: Error {
    case overflow
}

Array(1...100).publisher
    .tryFilter { value in
        if value > 50 { throw CombineError.overflow }
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

//: RxSwift와 유사한 개념: Filter
