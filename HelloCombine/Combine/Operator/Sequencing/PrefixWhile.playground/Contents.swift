import UIKit
import Combine

//: # PrefixWhile
//: 업스트림 `Publisher`가 클로저로 주어진 조건을 만족하면 항목을 방출하는 Publisher입니다. 한 번이라도 만족하지 아니하면 이후 항목은 무시됩니다.

var cancellable = Set<AnyCancellable>()

[2, 4, 1, 2, 3].publisher
    .prefix { value in
        return value % 2 == 0
    }
    .sink { value in
        print(value)
    }
    .store(in: &cancellable)

