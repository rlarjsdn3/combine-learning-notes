import UIKit
import Combine

//: # CombineLatest
//:  업스트림 `Pubilsher`와 결합한 `Publisher`가 마지막으로 방출한 항목을 하나로 묶어 방출하는 Publisher입니다. 각 Publisher가 최소 하나의 항목을 방출하기 전까지 결합된 항목을 방출하지 않습니다.

var cancellable = Set<AnyCancellable>()

let subject1 = PassthroughSubject<Int, Never>()
let subject2 = PassthroughSubject<Int, Never>()

subject1
    .combineLatest(subject2) { first, second in
        return first * second
    }
    .sink { value in
        print(value)
    }
    .store(in: &cancellable)

subject1.send(1)
subject1.send(2)
subject2.send(2)
subject1.send(9)
subject1.send(3)
subject2.send(12)
subject1.send(13)

subject1.send(completion: .finished)
subject2.send(completion: .finished)
