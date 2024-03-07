import UIKit
import Combine

//: # Contains
//: 업스트림 `Publisher`가 한 번이라도 특정한 항목을 방출하면 Bool 타입의 항목을 방출하는 Publisher입니다.

var cancellable = Set<AnyCancellable>()

let arrayPublisher = [1, 2, 3, 4, 5].publisher
arrayPublisher
    .contains(5)
    .sink { value in
        print(value)
    }
    .store(in: &cancellable)

arrayPublisher
    .contains(-1)
    .sink { value in
        print(value)
    }
    .store(in: &cancellable)

