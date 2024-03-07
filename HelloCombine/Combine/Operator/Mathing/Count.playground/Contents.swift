import UIKit
import Combine

//: # Count
//: 업스트림 `Publisher`가 방출하는 모든 항목의 개수 값을 방출하는 Publisher를 입니다.

var cancellable = Set<AnyCancellable>()

[2, 1, 4, 5, 3].publisher
    .count()
    .sink { value in
        print(value)
    }
    .store(in: &cancellable)
