import UIKit
import Combine

//: # ReplaceNil
//: 업스트림 `Publisher`가 방출한 nil 항목을 다른 대체 항목으로 바꿔주는 Publisher입니다.

var cancellable = Set<AnyCancellable>()

[1, nil, 3].publisher
    .replaceNil(with: 2)
    .compactMap { value in
        return value
    }
    .sink { value in
        print(value)
    }
    .store(in: &cancellable)
