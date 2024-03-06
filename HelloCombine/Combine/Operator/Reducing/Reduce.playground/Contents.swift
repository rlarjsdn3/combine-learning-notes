import UIKit
import Combine

//: # Reduce
//: 업스트림 `Publisher`가 방출하는 모든 항목을 이전에 연산된 값과 함께 연산한 클러저가 반환하는 최종 값으로 변환하는 Publisher입니다.

var cancellable = Set<AnyCancellable>()

[1, 2, 3, 4, 5].publisher
    .reduce(0) { last, next in
        return last + next
    }
    .sink { value in
        print(value)
    }
    .store(in: &cancellable)