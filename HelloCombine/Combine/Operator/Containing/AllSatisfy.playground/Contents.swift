import UIKit
import Combine

//: # AllSatisfy
//: 업스트림 `Publisher`가 방출하는 모든 항목이 클로저로 주어진 조건을 만족하면 Bool 타입을 방출하는 Publisher입니다.

var cancellable = Set<AnyCancellable>()

[2, 4, 6, 8, 10].publisher
    .allSatisfy { value in
        return value % 2 == 0
    }
    .sink { value in
        print(value)
    }
    .store(in: &cancellable)

[1, -1, 1, 1, 1].publisher
    .allSatisfy { value in
        return value == 1
    }
    .sink { value in
        print(value)
    }
    .store(in: &cancellable)
