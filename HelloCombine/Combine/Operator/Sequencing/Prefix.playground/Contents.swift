import UIKit
import Combine

//: # Prefix
//: 업스트림 `Publisher`가 방출하는 항목을 일정 횟수 만큼만 받는 Publisher입니다.

var cancellable = Set<AnyCancellable>()

[1, 2, 3, 4, 5].publisher
    .prefix(3)
    .sink { value in
        print(value)
    }
    .store(in: &cancellable)
