import UIKit
import Combine

//: # Drop
//: 업스트림 `Publisher`가 방출하는 항목을 일정 횟수 만큼 무시하는 Publisher입니다.

var cancellable = Set<AnyCancellable>()

[1, 2, 3, 4, 5].publisher
    .dropFirst(3)
    .sink { value in
        print(value)
    }
    .store(in: &cancellable)
