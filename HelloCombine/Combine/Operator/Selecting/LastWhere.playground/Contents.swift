import UIKit
import Combine

//: # LastWhere
//: 업스트림 `Publisher`가 클로저로 주어진 조건을 만족하는 마지막 항목만 방출하는 Publisher입니다.

var cancellable = Set<AnyCancellable>()

[1, 2, 3, 4, 5].publisher
    .last { value in
        return value % 2 == 0
    }
    .sink { value in
        print(value)
    }
    .store(in: &cancellable)
    

