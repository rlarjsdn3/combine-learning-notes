import UIKit
import Combine

//: # TryFirstWhere
//: 업스트림 `Publisher`가 클로저로 주어진 조건을 만족하는 첫 번째 항목만 방출하는 Publisher입니다.

var cancellable = Set<AnyCancellable>()

enum CombineError: Error {
    case negative
}

[-1, 2, 3].publisher
    .tryFirst { value in
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
    
