import UIKit
import Combine

//: # ReplaceEmpty
//: 업스트림 `Publisher`가 방출한 비어있는 항목을 다른 대체 항목으로 바꿔주는 Publisher입니다.

var cancellable = Set<AnyCancellable>()

[].publisher
    .replaceEmpty(with: -1)
    .sink { value in
        print(value)
    }
    .store(in: &cancellable)
