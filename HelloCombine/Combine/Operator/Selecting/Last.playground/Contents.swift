import UIKit
import Combine

//: # Last
//: 업스트림 `Publisher`가 방출하는 마지막 항목만 방출하는 Publisher입니다.

var cancellable = Set<AnyCancellable>()

[1, 2, 3].publisher
    .last()
    .sink { value in
        print(value)
    }
    .store(in: &cancellable)
    
