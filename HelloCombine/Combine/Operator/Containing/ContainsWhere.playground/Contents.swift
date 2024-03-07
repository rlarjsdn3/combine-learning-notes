import UIKit
import Combine

//: # ContainsWhere
//: 업스트림 `Publisher`가 클로저로 주어진 조건을 만족하는 항목을 한 번이라도 방출하면 Bool 타입의 항목을 방출하는 Publisher입니다.

var cancellable = Set<AnyCancellable>()

let arrayPublisher = [1, 2, 3, 4, 5].publisher
arrayPublisher
    .contains { value in
        return value > 2
    }
    .sink { value in
        print(value)
    }
    .store(in: &cancellable)

arrayPublisher
    .contains { value in
        return value == -1
    }
    .sink { value in
        print(value)
    }
    .store(in: &cancellable)
