import UIKit
import Combine

//: # Empty
//: Empty는 아무런 항목을 방출하지 않고, 곧바로 Completion 항목을 방출하는 Publisher입니다.

var cancellable = Set<AnyCancellable>()

[1, 2, nil, 3, nil, 5].publisher
    .flatMap { value -> AnyPublisher<Int, Never> in
        guard let value = value else {
            return Empty().eraseToAnyPublisher()
        }
        return Just(value).eraseToAnyPublisher()
    }
    .sink { value in
        print(value)
    }
    .store(in: &cancellable)


