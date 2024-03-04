import UIKit
import Combine

//: # Record
//: Record는 방출할 값과 Completion 항목을 미리 지정할 수 있는 Publisher입니다.

var cancellable = Set<AnyCancellable>()

Record<Int, Never>(
    output: Array(1...3),
    completion: .finished
)
.scan(0, { $0 + $1 })
.sink { completion in
    print(completion)
} receiveValue: { value in
    print(value)
}
.store(in: &cancellable)

