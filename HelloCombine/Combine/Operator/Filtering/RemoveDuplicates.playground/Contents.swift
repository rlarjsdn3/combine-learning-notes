import UIKit
import Combine

//: # RemoveDuplicates
//: 업스트림 `Publisher`가 이전에 방출된 항목과 동일하지 않은 항목만 방출하는 Publisher입니다.

var cancellable = Set<AnyCancellable>()

// ① 일반적인 코드
[1, 2, 3, 3, 1, 2, 1, 1, 2, 3].publisher
    .removeDuplicates()
    .sink { value in
        print(value)
    }
    .store(in: &cancellable)

// ② predicate 클로저를 이용한 코드
struct Size {
    var width: Double
    var height: Double
}

let publisher = [
    Size(width: 250, height: 250),
    Size(width: 250, height: 500),
    Size(width: 500, height: 100),
    Size(width: 250, height: 750),
    Size(width: 750, height: 250)
].publisher
publisher
    .removeDuplicates { size1, size2 in
        return size1.width == size2.width
    }
    .sink { value in
        print(value)
    }
    .store(in: &cancellable)
